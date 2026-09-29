// ─── Concept mastery + spaced repetition (SM-2) ───────────────────────────────
// Tracks mastery at the *concept* level (finer than module_mastery) and schedules
// concepts for review using a lightweight SM-2 scheme. Two things feed it:
//   • passing/attempting a module's Final Assessment (applyAssessmentConcepts),
//     where the assessment itself counts as a review of each concept it covers;
//   • answering review items on the /review surface (recordReview).
// Reviewing a concept pushes its next due date out; lapsing pulls it back in.

import { db } from '../db';

const DAY_MS = 86_400_000;

export interface Sm2State {
  ease: number;
  interval_days: number;
  reps: number;
  lapses: number;
}

// Pure SM-2 step. `quality` is 0..5 (>=3 is a pass).
export function applySm2(prev: Sm2State, quality: number): Sm2State & { intervalDays: number } {
  let { ease, reps, lapses } = prev;
  let interval: number;

  if (quality < 3) {
    // Lapse: relearn from a 1-day interval, bump the lapse counter.
    reps = 0;
    lapses += 1;
    interval = 1;
  } else {
    reps += 1;
    if (reps === 1) interval = 1;
    else if (reps === 2) interval = 6;
    else interval = Math.round(prev.interval_days * ease);
    if (interval < 1) interval = 1;
  }

  // Standard SM-2 ease update, floored at 1.3.
  ease = Math.max(1.3, ease + (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02)));

  return { ease: Number(ease.toFixed(3)), interval_days: interval, reps, lapses, intervalDays: interval };
}

// Map a correctness ratio (0..1) to an SM-2 quality grade (0..5).
export function ratioToQuality(ratio: number): number {
  if (ratio >= 0.9) return 5;
  if (ratio >= 0.75) return 4;
  if (ratio >= 0.6) return 3;
  if (ratio >= 0.4) return 2;
  if (ratio >= 0.2) return 1;
  return 0;
}

async function loadState(userId: string, conceptId: number): Promise<(Sm2State & { mastery: number }) | null> {
  const { rows } = await db.query<{ ease: number; interval_days: number; reps: number; lapses: number; mastery: string }>(
    `SELECT ease, interval_days, reps, lapses, mastery FROM concept_progress WHERE user_id = $1 AND concept_id = $2`,
    [userId, conceptId]
  );
  if (!rows[0]) return null;
  return {
    ease: Number(rows[0].ease),
    interval_days: Number(rows[0].interval_days),
    reps: rows[0].reps,
    lapses: rows[0].lapses,
    mastery: Number(rows[0].mastery),
  };
}

/**
 * Record a single concept outcome and advance its schedule. `mastery` is blended
 * toward the latest performance so it tracks the learner over time rather than
 * snapping. Returns nothing — best-effort, callers shouldn't block on it.
 */
export async function recordConceptOutcome(opts: {
  userId: string;
  conceptId: number;
  moduleId?: number | null;
  ratio: number;          // 0..1 correctness on this outcome
  attempts: number;       // how many items this outcome covered
  correct: number;        // how many were correct
  weight?: number;        // blend weight for mastery (0..1); default 0.6 toward new
}): Promise<void> {
  const { userId, conceptId, moduleId = null, ratio, attempts, correct, weight = 0.6 } = opts;
  const quality = ratioToQuality(ratio);

  const prev = await loadState(userId, conceptId);
  const base: Sm2State = prev ?? { ease: 2.5, interval_days: 0, reps: 0, lapses: 0 };
  const next = applySm2(base, quality);
  const dueAt = new Date(Date.now() + next.interval_days * DAY_MS);

  // Rolling mastery: first time we just take the ratio; afterwards blend.
  const newMasteryPct = ratio * 100;
  const mastery = prev ? prev.mastery * (1 - weight) + newMasteryPct * weight : newMasteryPct;

  await db.query(
    `INSERT INTO concept_progress
       (user_id, concept_id, module_id, mastery, attempts, correct,
        ease, interval_days, reps, lapses, due_at, last_reviewed_at)
     VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, NOW())
     ON CONFLICT (user_id, concept_id) DO UPDATE SET
       module_id        = COALESCE($3, concept_progress.module_id),
       mastery          = $4,
       attempts         = concept_progress.attempts + $5,
       correct          = concept_progress.correct + $6,
       ease             = $7,
       interval_days    = $8,
       reps             = $9,
       lapses           = $10,
       due_at           = $11,
       last_reviewed_at = NOW()`,
    [userId, conceptId, moduleId, Math.round(mastery * 100) / 100, attempts, correct,
     next.ease, next.interval_days, next.reps, next.lapses, dueAt]
  ).catch((err) => console.error('recordConceptOutcome failed:', (err as Error).message));
}

/**
 * After a module assessment, fold each covered concept's latest-attempt
 * performance into concept_progress + its review schedule. The assessment counts
 * as a review, so concepts the learner did well on get pushed out and shaky ones
 * come due sooner.
 */
export async function applyAssessmentConcepts(userId: string, moduleId: number): Promise<void> {
  // Latest attempt per question, grouped by concept.
  const { rows } = await db.query<{ concept_id: number; total: string; correct: string }>(
    `WITH latest AS (
       SELECT DISTINCT ON (qa.question_id) qa.question_id, qa.is_correct, q.concept_id
       FROM quiz_attempts qa
       JOIN questions q ON q.id = qa.question_id
       WHERE qa.user_id = $1 AND q.module_id = $2 AND q.concept_id IS NOT NULL
       ORDER BY qa.question_id, qa.created_at DESC
     )
     SELECT concept_id,
            COUNT(*) AS total,
            COUNT(*) FILTER (WHERE is_correct) AS correct
     FROM latest GROUP BY concept_id`,
    [userId, moduleId]
  );

  for (const r of rows) {
    const total = Number(r.total);
    const correct = Number(r.correct);
    if (total === 0) continue;
    await recordConceptOutcome({
      userId,
      conceptId: r.concept_id,
      moduleId,
      ratio: correct / total,
      attempts: total,
      correct,
      // The assessment is authoritative for a module, so weight it heavily.
      weight: 0.8,
    });
  }
}

export interface DueConcept {
  conceptId: number;
  title: string;
  description: string | null;
  moduleId: number | null;
  moduleSlug: string | null;
  moduleTitle: string | null;
  mastery: number;
  dueAt: string | null;
}

/** Concepts currently due for review for a learner (most overdue first). */
export async function getDueConcepts(userId: string, limit = 20): Promise<DueConcept[]> {
  const { rows } = await db.query(
    `SELECT cp.concept_id, c.title, c.description, cp.module_id,
            m.slug AS module_slug, m.title AS module_title,
            cp.mastery, cp.due_at
     FROM concept_progress cp
     JOIN concepts c ON c.id = cp.concept_id
     LEFT JOIN modules m ON m.id = cp.module_id
     WHERE cp.user_id = $1 AND cp.due_at IS NOT NULL AND cp.due_at <= NOW()
     ORDER BY cp.due_at ASC
     LIMIT $2`,
    [userId, limit]
  );
  return rows.map((r: any) => ({
    conceptId: r.concept_id,
    title: r.title,
    description: r.description,
    moduleId: r.module_id,
    moduleSlug: r.module_slug,
    moduleTitle: r.module_title,
    mastery: Math.round(Number(r.mastery)),
    dueAt: r.due_at ? new Date(r.due_at).toISOString() : null,
  }));
}

/** Count of due review concepts, scoped to the learner's active subject. */
export async function countDueConcepts(userId: string): Promise<number> {
  const { rows } = await db.query<{ n: string }>(
    `SELECT COUNT(*) AS n
     FROM concept_progress cp
     LEFT JOIN modules m ON m.id = cp.module_id
     WHERE cp.user_id = $1
       AND cp.due_at IS NOT NULL AND cp.due_at <= NOW()
       AND (
         m.subject_id IS NULL
         OR m.subject_id = (SELECT active_subject_id FROM learner_profiles WHERE user_id = $1)
       )`,
    [userId]
  );
  return Number(rows[0]?.n ?? 0);
}

/** Record a review outcome for one concept from the /review surface. */
export async function recordReview(userId: string, conceptId: number, correct: number, total: number): Promise<void> {
  const ratio = total > 0 ? correct / total : 0;
  await recordConceptOutcome({ userId, conceptId, ratio, attempts: total, correct, weight: 0.6 });
}
