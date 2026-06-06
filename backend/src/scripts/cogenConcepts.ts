// ─── Concept co-generation: teaching briefs + aligned assessment questions ─────
//
// For each concept in a subject (default: the Python full course, `python-native`)
// this script makes ONE LLM call that co-generates, from a single spec:
//   • a compact teaching BRIEF the live tutor grounds in (key points, one canonical
//     worked example, a misconception to preempt, a suggested exercise), and
//   • that concept's ASSESSMENT QUESTIONS, each tagged with the concept.
// Generating both from the same spec means what's taught and what's assessed can't
// drift — the root cause of the "assessed on untaught material" bug.
//
// It then scores each question's groundedness against the brief, and writes the
// results transactionally per module: briefs are upserted, and the module's old
// questions are REPLACED with the new concept-aligned set (so every question has a
// concept_id and the assessment stays coherent).
//
// Run:  npx ts-node src/scripts/cogenConcepts.ts [flags]
// Flags:
//   --subject <slug>   subject to process            (default: python-native)
//   --module  <slug>   only this module (re-gen one)  (default: all modules)
//   --model   <id>     model id to generate with      (default: app setting)
//   --dry-run          print everything, write nothing
//
// Idempotent: re-running regenerates briefs/questions for the targeted scope.

import { db } from '../db/pool';
import { createChat } from '../services/llm';
import { embed, cosineSim } from '../services/embeddings';
import { getSettings } from '../services/settings';

// ── CLI args ──────────────────────────────────────────────────────────────────
function arg(name: string): string | undefined {
  const i = process.argv.indexOf(`--${name}`);
  return i !== -1 && i + 1 < process.argv.length ? process.argv[i + 1] : undefined;
}
const SUBJECT_SLUG = arg('subject') || 'python-native';
const ONLY_MODULE = arg('module');
const MODEL_OVERRIDE = arg('model');
const DRY_RUN = process.argv.includes('--dry-run');

// ── Types ───────────────────────────────────────────────────────────────────
interface SubjectRow { id: number; name: string; practice_kind: string }
interface ModuleRow { id: number; slug: string; title: string; description: string | null }
interface ConceptRow { id: number; title: string; description: string | null; order_index: number }

interface Brief {
  key_points: string[];
  worked_example: string | null;
  misconception: string | null;
  exercise: string | null;
}

type Difficulty = 'foundational' | 'applied' | 'advanced';
interface GenQuestion {
  type: 'multiple_choice' | 'short_answer' | 'explanation' | 'coding';
  difficulty: Difficulty;
  prompt: string;
  options: { label: string; text: string }[] | null;
  correct_answer: string | null;
  test_cases: { input: string; expected_output: string }[] | null;
  starter_code: string | null;
}

interface ConceptResult { conceptId: number; title: string; brief: Brief; questions: GenQuestion[] }

const DIFFS: Difficulty[] = ['foundational', 'applied', 'advanced'];

// ── Prompt ──────────────────────────────────────────────────────────────────
function buildPrompt(
  subjectName: string,
  practiceKind: string,
  module: ModuleRow,
  concept: ConceptRow,
  siblingConcepts: ConceptRow[]
): string {
  const isCode = practiceKind === 'code';
  const syllabus = siblingConcepts.map((c, i) => `${i + 1}. ${c.title}`).join('\n');

  const codingNote = isCode
    ? `\nThis is a hands-on Python course with an in-browser Pyodide runner. A coding question is graded by running the learner's program and comparing its EXACT trimmed stdout to each test case's expected_output. So coding questions MUST follow these rules:
- The program's output must be fully DETERMINISTIC and exactly predictable. If the natural task for this concept relies on randomness, simulation, timing, plotting/figures, or anything without a single fixed printed result, DO NOT write a coding question — use multiple_choice, short_answer, or explanation instead. (For a random task, you can still ask a coding-style question as short_answer, e.g. "what function call…".)
- The program runs ONCE and is NOT interactive: input() returns an empty string. Use hardcoded values, variables, or function parameters — never input().
- "starter_code" is a scaffold the learner edits in place (a few lines with a TODO/comment), NEVER a hello-world placeholder and NEVER the full solution.
- "test_cases" is an array of {"input": "", "expected_output": "<the exact text the correct program prints>"}. The "input" field is STDIN for the program (leave it "" — this course is non-interactive); NEVER put Python code in "input". Provide 1–2 simple, deterministic test cases.`
    : '';

  return `You are designing a single concept of "${module.title}" in the ${subjectName} course.
The concept to design is: "${concept.title}"${concept.description ? ` — ${concept.description}` : ''}.

For context, the full ordered list of concepts in this module is:
${syllabus}
Design ONLY the concept named "${concept.title}". Do not cover the other concepts (they are taught separately); assume earlier concepts are already known.${codingNote}

Produce TWO things that are tightly aligned with each other:
1. A compact TEACHING BRIEF the tutor will teach from.
2. 1–2 ASSESSMENT QUESTIONS that test exactly what the brief teaches — nothing beyond it.

Rules:
- Questions must be answerable from the brief alone. Span difficulty (foundational → applied → advanced) across the set.
- Prefer "multiple_choice" (exactly 4 options) and "short_answer"; include one "explanation" question when the concept is conceptual.${isCode ? ' Include one "coding" question when the concept lends itself to hands-on practice.' : ''}
- Phrase questions as standalone — never refer to "the brief", "the text", or "the lesson".

Reply with ONLY valid JSON, no prose outside it:
{
  "brief": {
    "key_points": ["3 to 6 concise must-teach points"],
    "worked_example": "one canonical example the tutor should walk through",
    "misconception": "one common misunderstanding to preempt",
    "exercise": "a short hands-on exercise prompt for this concept"
  },
  "questions": [
    {"type":"multiple_choice","difficulty":"foundational","prompt":"...","options":["...","...","...","..."],"answer":0},
    {"type":"short_answer","difficulty":"applied","prompt":"...","correct_answer":"..."},
    {"type":"explanation","difficulty":"advanced","prompt":"...","correct_answer":"the key points a strong answer should contain"}${
      isCode ? `,\n    {"type":"coding","difficulty":"applied","prompt":"...","starter_code":"# ...\\n","test_cases":[{"input":"","expected_output":"..."}]}` : ''
    }
  ]
}`;
}

// ── Parse + validate the model's JSON ─────────────────────────────────────────
function parseResult(raw: string, allowCoding: boolean): { brief: Brief; questions: GenQuestion[] } | null {
  // Strip markdown code fences some models wrap JSON in, then extract the object.
  const cleaned = raw.replace(/```(?:json)?/gi, '').trim();
  let parsed: any;
  try {
    parsed = JSON.parse(cleaned.match(/\{[\s\S]*\}/)?.[0] ?? '{}');
  } catch {
    return null;
  }

  const b = parsed.brief ?? {};
  const brief: Brief = {
    key_points: Array.isArray(b.key_points)
      ? b.key_points.filter((p: unknown) => typeof p === 'string' && (p as string).trim()).map((p: string) => p.trim()).slice(0, 8)
      : [],
    worked_example: typeof b.worked_example === 'string' && b.worked_example.trim() ? b.worked_example.trim() : null,
    misconception: typeof b.misconception === 'string' && b.misconception.trim() ? b.misconception.trim() : null,
    exercise: typeof b.exercise === 'string' && b.exercise.trim() ? b.exercise.trim() : null,
  };
  if (brief.key_points.length === 0) return null;

  const arr: any[] = Array.isArray(parsed.questions) ? parsed.questions : [];
  const questions: GenQuestion[] = [];
  for (const q of arr) {
    const type = q?.type;
    const prompt = typeof q?.prompt === 'string' ? q.prompt.trim() : '';
    if (!prompt) continue;
    const difficulty: Difficulty = DIFFS.includes(q?.difficulty) ? q.difficulty : 'applied';

    if (type === 'multiple_choice') {
      const opts = Array.isArray(q.options)
        ? q.options.filter((o: unknown) => typeof o === 'string' && (o as string).trim()).slice(0, 6)
        : [];
      if (opts.length < 2) continue;
      const ansIdx = Number.isInteger(q.answer) && q.answer >= 0 && q.answer < opts.length ? q.answer : 0;
      const options = opts.map((t: string, i: number) => ({ label: String.fromCharCode(65 + i), text: t.trim() }));
      questions.push({ type, difficulty, prompt, options, correct_answer: options[ansIdx].text, test_cases: null, starter_code: null });
    } else if (type === 'short_answer' || type === 'explanation') {
      const ca = typeof q.correct_answer === 'string' ? q.correct_answer.trim() : '';
      questions.push({ type, difficulty, prompt, options: null, correct_answer: ca || null, test_cases: null, starter_code: null });
    } else if (type === 'coding' && allowCoding) {
      const tcs = Array.isArray(q.test_cases)
        ? q.test_cases
            .filter((t: any) => t && typeof t.expected_output === 'string')
            .map((t: any) => ({ input: typeof t.input === 'string' ? t.input : '', expected_output: String(t.expected_output) }))
            .slice(0, 5)
        : [];
      if (tcs.length === 0) continue; // a coding question is ungradeable without test cases
      // Guard against the model misusing "input" as a code field (it's stdin):
      // a test case whose input contains Python code makes the question unrunnable.
      const inputLooksLikeCode = tcs.some((t: { input: string; expected_output: string }) => /\b(def|import|print|for|while|return)\b|=/.test(t.input));
      if (inputLooksLikeCode) continue; // drop this malformed coding question; other Qs for the concept still stand
      const starter = typeof q.starter_code === 'string' && q.starter_code.trim() ? q.starter_code : '# Write your solution here\n';
      // Coding questions are graded by EXACT stdout match, but the generator can't
      // run code — so for nondeterministic tasks (randomness, plotting, libraries,
      // clocks) its predicted expected_output is a guess and would mark correct
      // solutions wrong. Only keep coding questions whose output is deterministic.
      const NONDETERMINISTIC = /\b(random|seed|matplotlib|numpy|np\.|plt\.|time|datetime|uuid|input\s*\()/i;
      const haystack = `${prompt}\n${starter}\n${tcs.map((t: { input: string; expected_output: string }) => t.expected_output).join('\n')}`;
      if (NONDETERMINISTIC.test(haystack)) continue; // use a non-coding question for this concept instead
      // A coding question graded by exact stdout but expecting NO output is almost
      // always degenerate (e.g. "define but don't call it") — a reasonable solution
      // that prints would be wrongly failed. Drop it.
      if (tcs.every((t: { input: string; expected_output: string }) => t.expected_output.trim() === '')) continue;
      questions.push({ type: 'coding', difficulty, prompt, options: null, correct_answer: null, test_cases: tcs, starter_code: starter });
    }
  }

  if (questions.length === 0) return null;
  return { brief, questions };
}

// Text used to score how well a question is grounded in its brief.
function briefText(b: Brief): string {
  return [b.key_points.join(' '), b.worked_example, b.misconception].filter(Boolean).join(' ');
}

async function generateConcept(
  modelId: string,
  subject: SubjectRow,
  module: ModuleRow,
  concept: ConceptRow,
  siblings: ConceptRow[]
): Promise<{ brief: Brief; questions: GenQuestion[] } | null> {
  const prompt = buildPrompt(subject.name, subject.practice_kind, module, concept, siblings);
  // One retry: models occasionally emit prose-wrapped or truncated JSON.
  for (let attempt = 0; attempt < 2; attempt++) {
    const raw = await createChat({ modelId, maxTokens: 3000, feature: 'concept-cogen', messages: [{ role: 'user', content: prompt }] });
    const parsed = parseResult(raw, subject.practice_kind === 'code');
    if (parsed) return parsed;
  }
  return null;
}

// ── Persist one module's briefs + questions atomically ────────────────────────
async function writeModule(moduleId: number, modelId: string, results: ConceptResult[]): Promise<void> {
  const client = await db.connect();
  try {
    await client.query('BEGIN');

    for (const r of results) {
      await client.query(
        `INSERT INTO concept_briefs (concept_id, key_points, worked_example, misconception, exercise, model)
         VALUES ($1, $2, $3, $4, $5, $6)
         ON CONFLICT (concept_id) DO UPDATE SET
           key_points = EXCLUDED.key_points,
           worked_example = EXCLUDED.worked_example,
           misconception = EXCLUDED.misconception,
           exercise = EXCLUDED.exercise,
           model = EXCLUDED.model`,
        [r.conceptId, JSON.stringify(r.brief.key_points), r.brief.worked_example, r.brief.misconception, r.brief.exercise, modelId]
      );
    }

    // Replace the module's question bank with the new concept-aligned set.
    await client.query(`DELETE FROM questions WHERE module_id = $1`, [moduleId]);

    for (const r of results) {
      const briefVec = await safeEmbed(briefText(r.brief));
      for (const q of r.questions) {
        let groundedness: number | null = null;
        if (briefVec) {
          const qVec = await safeEmbed(`${q.prompt} ${q.correct_answer ?? ''}`);
          if (qVec) groundedness = cosineSim(qVec, briefVec);
        }
        await client.query(
          `INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, starter_code, groundedness)
           VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)`,
          [
            moduleId,
            r.conceptId,
            q.type,
            q.difficulty,
            q.prompt,
            q.options ? JSON.stringify(q.options) : null,
            q.correct_answer,
            q.test_cases ? JSON.stringify(q.test_cases) : null,
            q.starter_code,
            groundedness,
          ]
        );
      }
    }

    await client.query('COMMIT');
  } catch (err) {
    await client.query('ROLLBACK');
    throw err;
  } finally {
    client.release();
  }
}

async function safeEmbed(text: string): Promise<number[] | null> {
  try {
    return await embed(text);
  } catch {
    return null; // scoring is best-effort
  }
}

// ── Main ──────────────────────────────────────────────────────────────────────
async function main() {
  const modelId = MODEL_OVERRIDE || (await getSettings()).defaultModel;

  const subjRes = await db.query<SubjectRow>(
    `SELECT id, name, practice_kind FROM subjects WHERE slug = $1`,
    [SUBJECT_SLUG]
  );
  const subject = subjRes.rows[0];
  if (!subject) throw new Error(`Subject not found: ${SUBJECT_SLUG}`);

  const modRes = await db.query<ModuleRow>(
    `SELECT id, slug, title, description FROM modules
     WHERE subject_id = $1 ${ONLY_MODULE ? 'AND slug = $2' : ''}
     ORDER BY order_index`,
    ONLY_MODULE ? [subject.id, ONLY_MODULE] : [subject.id]
  );
  if (modRes.rows.length === 0) throw new Error(`No modules found for ${SUBJECT_SLUG}${ONLY_MODULE ? ` / ${ONLY_MODULE}` : ''}`);

  console.log(`\n▶ Co-generating concept briefs + questions`);
  console.log(`  subject=${SUBJECT_SLUG} (id ${subject.id}, practice=${subject.practice_kind})`);
  console.log(`  model=${modelId}  modules=${modRes.rows.length}  ${DRY_RUN ? '[DRY RUN — no writes]' : ''}\n`);

  let totalQ = 0;
  for (const module of modRes.rows) {
    const conceptRes = await db.query<ConceptRow>(
      `SELECT id, title, description, order_index FROM concepts WHERE module_id = $1 ORDER BY order_index`,
      [module.id]
    );
    const concepts = conceptRes.rows;
    if (concepts.length === 0) {
      console.log(`  • ${module.slug}: no concepts — skipped`);
      continue;
    }

    const results: ConceptResult[] = [];
    for (const concept of concepts) {
      try {
        const gen = await generateConcept(modelId, subject, module, concept, concepts);
        if (!gen) {
          console.log(`    ⚠ ${module.slug} / "${concept.title}": generation produced nothing usable — skipped`);
          continue;
        }
        results.push({ conceptId: concept.id, title: concept.title, brief: gen.brief, questions: gen.questions });
      } catch (err) {
        console.log(`    ⚠ ${module.slug} / "${concept.title}": ${(err as Error).message}`);
      }
    }

    if (results.length === 0) {
      console.log(`  • ${module.slug}: nothing generated — left unchanged`);
      continue;
    }

    const counts: Record<string, number> = {};
    let qn = 0;
    for (const r of results) for (const q of r.questions) { counts[q.type] = (counts[q.type] || 0) + 1; qn++; }
    totalQ += qn;

    if (DRY_RUN) {
      console.log(`\n── ${module.slug} — ${module.title} (${results.length}/${concepts.length} concepts, ${qn} questions) ──`);
      for (const r of results) {
        console.log(`  ◇ ${r.title}`);
        console.log(`    key_points: ${r.brief.key_points.join(' | ')}`);
        if (r.brief.worked_example) console.log(`    example: ${r.brief.worked_example.slice(0, 120)}`);
        if (r.brief.misconception) console.log(`    misconception: ${r.brief.misconception.slice(0, 120)}`);
        for (const q of r.questions) console.log(`    - [${q.type}/${q.difficulty}] ${q.prompt.slice(0, 100)}`);
      }
    } else {
      await writeModule(module.id, modelId, results);
      const summary = Object.entries(counts).map(([t, n]) => `${t}:${n}`).join(' ');
      console.log(`  ✓ ${module.slug}: ${results.length}/${concepts.length} concepts, ${qn} questions (${summary})`);
    }
  }

  console.log(`\n${DRY_RUN ? 'Would generate' : 'Generated'} ${totalQ} questions total.${DRY_RUN ? ' (dry run — nothing written)' : ''}\n`);
  await db.end();
}

main().catch((err) => {
  console.error('cogenConcepts failed:', err);
  process.exit(1);
});
