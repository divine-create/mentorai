import { Router } from 'express';
import { db } from '../db/pool';
import { requireAuth, AuthRequest } from '../middleware/auth';
import { requireFields, requireString, sendValidationErrors } from '../middleware/validate';
import { computeMastery, saveMasteryAndGate } from '../services/mastery';
import { getUserModelId } from './models';
import { gradeAnswer } from '../services/grading';

const router = Router();

// GET /api/assessments/:moduleId/questions
// Returns questions for a module, ordered by difficulty.
router.get('/:moduleId/questions', requireAuth, async (req: AuthRequest, res) => {
  try {
    const result = await db.query(
      `SELECT id, type, difficulty, prompt, options, test_cases, starter_code
       FROM questions WHERE module_id = $1
       ORDER BY CASE difficulty WHEN 'foundational' THEN 1 WHEN 'applied' THEN 2 ELSE 3 END`,
      [req.params.moduleId]
    );
    res.json(result.rows);
  } catch {
    res.status(500).json({ error: 'Internal server error' });
  }
});

// POST /api/assessments/submit
// Evaluates a single answer. Returns { correct, feedback, nextDifficulty }.
router.post('/submit', requireAuth, async (req: AuthRequest, res) => {
  const { questionId, answer, sessionId } = req.body as {
    questionId: string;
    answer: string;
    sessionId?: string;
  };

  // --- Validation ---
  const missing = requireFields(req.body, ['questionId', 'answer']);
  if (missing) { res.status(400).json({ error: missing }); return; }
  if (sendValidationErrors(res, [
    requireString(questionId, 'questionId'),
    requireString(answer, 'answer'),
  ])) return;
  if (sessionId !== undefined && sendValidationErrors(res, [requireString(sessionId, 'sessionId')])) return;

  try {
    const qResult = await db.query(
      `SELECT type, prompt, correct_answer, options, difficulty FROM questions WHERE id = $1`,
      [questionId]
    );
    const q = qResult.rows[0];
    if (!q) { res.status(404).json({ error: 'Question not found' }); return; }

    // For coding questions the frontend runs Pyodide test cases and sends results.
    const { testResults } = req.body as {
      testResults?: { passed: boolean; expected?: string; actual?: string }[];
    };

    const graded = await gradeAnswer({
      question: { type: q.type, prompt: q.prompt, correct_answer: q.correct_answer },
      answer,
      modelId: await getUserModelId(req.userId!),
      testResults,
    });
    const isCorrect = graded.correct;
    const feedback = graded.feedback;

    // first_try: TRUE when this is the learner's first-ever attempt at this
    // question — a stronger mastery signal than eventual-correct.
    const priorRes = await db.query(
      `SELECT 1 FROM quiz_attempts WHERE user_id = $1 AND question_id = $2 LIMIT 1`,
      [req.userId, questionId]
    );
    const firstTry = priorRes.rows.length === 0;

    // Persist attempt with optional code field for coding questions
    const code = req.body.code ?? null;
    await db.query(
      `INSERT INTO quiz_attempts (user_id, question_id, session_id, answer, is_correct, code, first_try)
       VALUES ($1, $2, $3, $4, $5, $6, $7)`,
      [req.userId, questionId, sessionId ?? null, answer, isCorrect, code, firstTry]
    );

    // Adaptive difficulty: determine next difficulty level
    const difficultyMap: Record<string, string> = {
      foundational: 'applied',
      applied: 'advanced',
      advanced: 'advanced',
    };
    const nextDifficulty = isCorrect ? difficultyMap[q.difficulty] : q.difficulty;

    // Check if learner has 2 wrong in a row (needs tutor intervention)
    const recentResult = await db.query<{ is_correct: boolean }>(
      `SELECT is_correct FROM quiz_attempts
       WHERE user_id = $1 AND session_id = $2
       ORDER BY created_at DESC LIMIT 2`,
      [req.userId, sessionId ?? null]
    );
    const needsTutor = recentResult.rows.length >= 2 &&
      recentResult.rows.every((r) => !r.is_correct);

    res.json({ correct: isCorrect, feedback, nextDifficulty, needsTutor });
  } catch (err) {
    console.error('assessment/submit error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// GET /api/assessments/:moduleId/mastery — current composite score
router.get('/:moduleId/mastery', requireAuth, async (req: AuthRequest, res) => {
  try {
    const breakdown = await computeMastery(req.userId!, Number(req.params.moduleId));
    res.json(breakdown);
  } catch {
    res.status(500).json({ error: 'Internal server error' });
  }
});

// POST /api/assessments/:moduleId/complete — finalise, gate, unlock next
router.post('/:moduleId/complete', requireAuth, async (req: AuthRequest, res) => {
  try {
    const result = await saveMasteryAndGate(req.userId!, Number(req.params.moduleId));
    res.json(result);
  } catch {
    res.status(500).json({ error: 'Internal server error' });
  }
});

export default router;
