import { NextResponse } from 'next/server';
import { db } from '@/lib/db';
import { requireAuth, handleApiError } from '@/lib/api-utils';
import { gradeAnswer } from '@/lib/services/grading';

export async function POST(request: Request) {
  try {
    const userAuth = await requireAuth();
    const { questionId, answer, sessionId, testResults, code } = await request.json();

    if (!questionId || !answer) {
      return NextResponse.json({ error: 'Missing questionId or answer' }, { status: 400 });
    }

    const qResult = await db.query(
      `SELECT type, prompt, correct_answer, options, difficulty FROM questions WHERE id = $1`,
      [questionId]
    );
    const q = qResult.rows[0];
    if (!q) return NextResponse.json({ error: 'Question not found' }, { status: 404 });

    // TODO: Implement getUserModelId correctly or default
    const modelId = 'claude-sonnet';

    const graded = await gradeAnswer({
      question: { type: q.type, prompt: q.prompt, correct_answer: q.correct_answer },
      answer,
      modelId,
      testResults,
    });
    const isCorrect = graded.correct;
    const feedback = graded.feedback;

    const priorRes = await db.query(
      `SELECT 1 FROM quiz_attempts WHERE user_id = $1 AND question_id = $2 LIMIT 1`,
      [userAuth.id, questionId]
    );
    const firstTry = priorRes.rows.length === 0;

    await db.query(
      `INSERT INTO quiz_attempts (user_id, question_id, session_id, answer, is_correct, code, first_try)
       VALUES ($1, $2, $3, $4, $5, $6, $7)`,
      [userAuth.id, questionId, sessionId ?? null, answer, isCorrect, code ?? null, firstTry]
    );

    const difficultyMap: Record<string, string> = {
      foundational: 'applied',
      applied: 'advanced',
      advanced: 'advanced',
    };
    const nextDifficulty = isCorrect ? difficultyMap[q.difficulty] : q.difficulty;

    const recentResult = await db.query(
      `SELECT is_correct FROM quiz_attempts
       WHERE user_id = $1 AND session_id = $2
       ORDER BY created_at DESC LIMIT 2`,
      [userAuth.id, sessionId ?? null]
    );
    const needsTutor = recentResult.rows.length >= 2 &&
      recentResult.rows.every((r: any) => !r.is_correct);

    return NextResponse.json({ correct: isCorrect, feedback, nextDifficulty, needsTutor });
  } catch (err) {
    return handleApiError(err);
  }
}
