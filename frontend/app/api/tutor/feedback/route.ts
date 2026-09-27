import { NextResponse } from 'next/server';
import { db } from '@/lib/db';
import { requireAuth, handleApiError } from '@/lib/api-utils';
import { recordWrongAnswer, recordCorrectAnswer, setCurrentConcept } from '@/lib/services/adaptation';

export async function POST(request: Request) {
  try {
    const userAuth = await requireAuth();
    const { sessionId, outcome, concept, chosen } = await request.json();

    if (!sessionId || !outcome) {
      return NextResponse.json({ error: 'Missing sessionId or outcome' }, { status: 400 });
    }

    if (concept) await setCurrentConcept(sessionId, concept);
    
    const hint = outcome === 'correct'
      ? await recordCorrectAnswer(sessionId)
      : await recordWrongAnswer(sessionId);

    try {
      const sessRow = await db.query(
        `SELECT module_id FROM sessions WHERE id = $1`,
        [sessionId]
      );
      const moduleId = sessRow.rows[0]?.module_id;
      if (moduleId != null) {
        await db.query(
          `INSERT INTO inline_quiz_attempts (user_id, session_id, module_id, is_correct, chosen)
           VALUES ($1, $2, $3, $4, $5)`,
          [userAuth.id, sessionId, moduleId, outcome === 'correct', chosen ?? null]
        );
      }
    } catch (err) {
      console.error('tutor/feedback inline-quiz record failed:', err);
    }

    return NextResponse.json({ adaptationHint: hint });
  } catch (err) {
    return handleApiError(err);
  }
}
