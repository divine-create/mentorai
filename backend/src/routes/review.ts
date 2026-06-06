// ─── Spaced-repetition review ─────────────────────────────────────────────────
// Surfaces concepts that are due for review and grades the learner's recall.
// Review outcomes update concept_progress + reschedule via SM-2 (services/review),
// but are intentionally kept OUT of quiz_attempts so a shaky review never lowers
// a module's formal mastery score — review reinforces, the assessment grades.

import { Router } from 'express';
import { db } from '../db/pool';
import { requireAuth, AuthRequest } from '../middleware/auth';
import { requireFields, requireString, requireNumber, sendValidationErrors } from '../middleware/validate';
import { getDueConcepts, recordReview } from '../services/review';
import { gradeAnswer } from '../services/grading';
import { getUserModelId } from './models';

const router = Router();

// Question types we use for quick recall checks (coding is excluded — too heavy
// for a review card).
const REVIEW_TYPES = ['multiple_choice', 'short_answer', 'explanation'];
const QUESTIONS_PER_CONCEPT = 3;
const MAX_CONCEPTS = 8;

// GET /api/review/due — due concepts, each with a few recall questions (answers
// withheld). The client walks them one concept at a time.
router.get('/due', requireAuth, async (req: AuthRequest, res) => {
  try {
    const due = await getDueConcepts(req.userId!, MAX_CONCEPTS);
    const concepts = [];
    for (const c of due) {
      const { rows: questions } = await db.query(
        `SELECT id, type, difficulty, prompt, options
         FROM questions
         WHERE concept_id = $1 AND type = ANY($2)
         ORDER BY random()
         LIMIT $3`,
        [c.conceptId, REVIEW_TYPES, QUESTIONS_PER_CONCEPT]
      );
      // Only offer concepts we can actually quiz on.
      if (questions.length > 0) concepts.push({ ...c, questions });
    }
    res.json({ concepts, dueCount: due.length });
  } catch (err) {
    console.error('review/due error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// POST /api/review/grade — grade one concept's review answers and reschedule.
// Body: { conceptId, answers: [{ questionId, answer }] }
router.post('/grade', requireAuth, async (req: AuthRequest, res) => {
  const { conceptId, answers } = req.body as {
    conceptId: number;
    answers: { questionId: string; answer: string }[];
  };

  const missing = requireFields(req.body, ['conceptId', 'answers']);
  if (missing) { res.status(400).json({ error: missing }); return; }
  if (sendValidationErrors(res, [requireNumber(conceptId, 'conceptId')])) return;
  if (!Array.isArray(answers) || answers.length === 0) {
    res.status(400).json({ error: 'answers must be a non-empty array' });
    return;
  }
  for (let i = 0; i < answers.length; i++) {
    if (sendValidationErrors(res, [
      requireString(answers[i]?.questionId, `answers[${i}].questionId`),
      requireString(answers[i]?.answer, `answers[${i}].answer`),
    ])) return;
  }

  try {
    const modelId = await getUserModelId(req.userId!);
    const ids = answers.map((a) => a.questionId);
    const { rows: qRows } = await db.query(
      `SELECT id, type, prompt, correct_answer FROM questions WHERE id = ANY($1) AND concept_id = $2`,
      [ids, conceptId]
    );
    const byId = new Map(qRows.map((q) => [q.id, q]));

    const results = [];
    let correctCount = 0;
    for (const a of answers) {
      const q = byId.get(a.questionId);
      if (!q) { results.push({ questionId: a.questionId, correct: false, feedback: 'Question not found.' }); continue; }
      const graded = await gradeAnswer({
        question: { type: q.type, prompt: q.prompt, correct_answer: q.correct_answer },
        answer: a.answer,
        modelId,
      });
      if (graded.correct) correctCount++;
      results.push({ questionId: a.questionId, correct: graded.correct, feedback: graded.feedback });
    }

    const total = answers.length;
    await recordReview(req.userId!, conceptId, correctCount, total);

    res.json({ correct: correctCount, total, results });
  } catch (err) {
    console.error('review/grade error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

export default router;
