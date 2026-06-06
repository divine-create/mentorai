import { db } from '../db/pool';
import { applyAssessmentConcepts } from './review';

const WEIGHTS = {
  finalAssessment: 0.40,
  codingUnaided:   0.30,
  explanation:     0.20,
  inSession:       0.10,
};

const MASTERY_THRESHOLD = 80;

export interface MasteryBreakdown {
  finalAssessment: number;
  codingUnaided: number;
  explanation: number;
  inSession: number;
  composite: number;
  passed: boolean;
}

export async function computeMastery(userId: string, moduleId: number): Promise<MasteryBreakdown> {
  // 1. Final assessment score — difficulty-weighted % over the LATEST attempt per
  // question. Using the latest attempt (not every attempt ever) stops the score
  // from being inflated by repeated retries; weighting by difficulty means
  // nailing advanced questions counts for more than foundational ones.
  const assessResult = await db.query<{ weight_total: string; weight_correct: string }>(
    `WITH latest AS (
       SELECT DISTINCT ON (qa.question_id) qa.question_id, qa.is_correct, q.difficulty
       FROM quiz_attempts qa
       JOIN questions q ON q.id = qa.question_id
       WHERE qa.user_id = $1 AND q.module_id = $2
       ORDER BY qa.question_id, qa.created_at DESC
     )
     SELECT
       COALESCE(SUM(w), 0)                          AS weight_total,
       COALESCE(SUM(w) FILTER (WHERE is_correct), 0) AS weight_correct
     FROM (
       SELECT is_correct,
              CASE difficulty WHEN 'foundational' THEN 1 WHEN 'applied' THEN 2 ELSE 3 END AS w
       FROM latest
     ) weighted`,
    [userId, moduleId]
  );
  const weightTotal = Number(assessResult.rows[0]?.weight_total ?? 0);
  const weightCorrect = Number(assessResult.rows[0]?.weight_correct ?? 0);
  const finalAssessment = weightTotal > 0 ? (weightCorrect / weightTotal) * 100 : 0;

  // 2. Coding unaided — % of coding attempts with no hint/solution used
  const codingResult = await db.query<{ unaided: number; total: number }>(
    `SELECT
       COUNT(*) FILTER (WHERE NOT hint_used AND NOT solution_revealed) AS unaided,
       COUNT(*) AS total
     FROM quiz_attempts qa
     JOIN questions q ON q.id = qa.question_id
     WHERE qa.user_id = $1 AND q.module_id = $2 AND q.type = 'coding'`,
    [userId, moduleId]
  );
  const codingRow = codingResult.rows[0];
  const codingUnaided = Number(codingRow.total) > 0
    ? (Number(codingRow.unaided) / Number(codingRow.total)) * 100
    : 0;

  // 3. Explanation quality — % of explanation questions marked correct
  const explResult = await db.query<{ correct: number; total: number }>(
    `SELECT
       COUNT(*) FILTER (WHERE qa.is_correct) AS correct,
       COUNT(*) AS total
     FROM quiz_attempts qa
     JOIN questions q ON q.id = qa.question_id
     WHERE qa.user_id = $1 AND q.module_id = $2 AND q.type = 'explanation'`,
    [userId, moduleId]
  );
  const explRow = explResult.rows[0];
  const explanation = Number(explRow.total) > 0
    ? (Number(explRow.correct) / Number(explRow.total)) * 100
    : 0;

  // 4. In-session comprehension — % correct on the tutor's inline [[QUIZ]] checks
  // answered live in chat (recorded in inline_quiz_attempts, not quiz_attempts,
  // because they're generated on the fly and have no `questions` row). This lets
  // the conversational experience count toward mastery.
  const inSessionResult = await db.query<{ correct: number; total: number }>(
    `SELECT
       COUNT(*) FILTER (WHERE is_correct) AS correct,
       COUNT(*) AS total
     FROM inline_quiz_attempts
     WHERE user_id = $1 AND module_id = $2`,
    [userId, moduleId]
  );
  const inSessionRow = inSessionResult.rows[0];
  const inSessionTotal = Number(inSessionRow.total);
  const inSession = inSessionTotal > 0
    ? (Number(inSessionRow.correct) / inSessionTotal) * 100
    : 0;

  // Which question types does this module actually contain? Components whose
  // underlying type is structurally absent (e.g. a non-coding subject has no
  // 'coding' questions) are dropped and their weight is redistributed over the
  // present components — otherwise such a module could never reach the pass
  // threshold. Python modules have all types, so their scoring is unchanged.
  const typeResult = await db.query<{ type: string; n: string }>(
    `SELECT type, COUNT(*) AS n FROM questions WHERE module_id = $1 GROUP BY type`,
    [moduleId]
  );
  const has = (types: string[]) => typeResult.rows.some((r) => types.includes(r.type) && Number(r.n) > 0);
  const hasAny = typeResult.rows.length > 0;

  const components = [
    { score: finalAssessment, weight: WEIGHTS.finalAssessment, present: hasAny },
    { score: codingUnaided,   weight: WEIGHTS.codingUnaided,   present: has(['coding']) },
    { score: explanation,     weight: WEIGHTS.explanation,     present: has(['explanation']) },
    // Only count in-session comprehension once the learner has actually answered
    // inline quizzes — otherwise its weight redistributes to the other
    // components, so a learner who never used in-chat quizzes is never penalized.
    { score: inSession,       weight: WEIGHTS.inSession,       present: inSessionTotal > 0 },
  ].filter((c) => c.present);

  const weightSum = components.reduce((s, c) => s + c.weight, 0) || 1;
  const composite = components.reduce((s, c) => s + c.score * c.weight, 0) / weightSum;

  return {
    finalAssessment: Math.round(finalAssessment),
    codingUnaided:   Math.round(codingUnaided),
    explanation:     Math.round(explanation),
    inSession:       Math.round(inSession),
    composite:       Math.round(composite),
    passed:          composite >= MASTERY_THRESHOLD,
  };
}

// Persist mastery score and unlock next module if passed
export async function saveMasteryAndGate(userId: string, moduleId: number): Promise<{ passed: boolean; nextModuleId: number | null; nextModuleSlug: string | null; nextModuleTitle: string | null }> {
  const breakdown = await computeMastery(userId, moduleId);

  // Fold each covered concept's performance into per-concept mastery + the
  // spaced-repetition schedule. Best-effort: never block gating on it.
  await applyAssessmentConcepts(userId, moduleId).catch((err) =>
    console.error('applyAssessmentConcepts failed:', (err as Error).message)
  );

  await db.query(
    `INSERT INTO module_mastery (user_id, module_id, mastery_score, attempts, last_assessed_at)
     VALUES ($1, $2, $3, 1, NOW())
     ON CONFLICT (user_id, module_id) DO UPDATE SET
       mastery_score = $3,
       attempts = module_mastery.attempts + 1,
       last_assessed_at = NOW()`,
    [userId, moduleId, breakdown.composite]
  );

  // Update overall mastery on learner profile
  await db.query(
    `UPDATE learner_profiles SET
       overall_mastery = (
         SELECT AVG(mastery_score) FROM module_mastery WHERE user_id = $1
       ),
       updated_at = NOW()
     WHERE user_id = $1`,
    [userId]
  );

  let nextModuleId: number | null = null;

  let nextModuleSlug: string | null = null;
  let nextModuleTitle: string | null = null;

  if (breakdown.passed) {
    // Unlock the next module IN THE SAME SUBJECT. order_index is per-subject, so
    // the lookup must be scoped by subject_id — otherwise order_index+1 matches a
    // module in every subject and picks an arbitrary one.
    const nextResult = await db.query<{ id: number; slug: string; title: string }>(
      `SELECT id, slug, title FROM modules
       WHERE subject_id = (SELECT subject_id FROM modules WHERE id = $1)
         AND order_index = (SELECT order_index + 1 FROM modules WHERE id = $1)`,
      [moduleId]
    );
    if (nextResult.rows[0]) {
      nextModuleId = nextResult.rows[0].id;
      nextModuleSlug = nextResult.rows[0].slug;
      nextModuleTitle = nextResult.rows[0].title;
      await db.query(
        `INSERT INTO module_mastery (user_id, module_id, unlocked)
         VALUES ($1, $2, true)
         ON CONFLICT (user_id, module_id) DO UPDATE SET unlocked = true`,
        [userId, nextModuleId]
      );
      await db.query(
        `UPDATE learner_profiles SET current_module_id = $1 WHERE user_id = $2`,
        [nextModuleId, userId]
      );
    }
  }

  return { passed: breakdown.passed, nextModuleId, nextModuleSlug, nextModuleTitle };
}
