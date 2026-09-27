import { NextResponse } from 'next/server';
import { db } from '@/lib/db';
import { requireAuth, handleApiError } from '@/lib/api-utils';
import { createChat } from '@/lib/services/llm';
import { waitUntil } from '@vercel/functions';

export async function POST(request: Request, context: { params: Promise<{ id: string }> }) {
  try {
    const userAuth = await requireAuth();
    const { id } = await context.params;

    const msgResult = await db.query(
      `SELECT role, content FROM messages WHERE session_id = $1 ORDER BY created_at`,
      [id]
    );

    const messages = msgResult.rows;
    if (messages.length === 0) {
      await db.query(`UPDATE sessions SET ended_at = NOW() WHERE id = $1`, [id]);
      return NextResponse.json({ summary: null });
    }

    const sessionResult = await db.query(`SELECT module_id FROM sessions WHERE id = $1`, [id]);
    const moduleId = sessionResult.rows[0]?.module_id;

    const transcript = messages.map((m: any) => `${m.role}: ${m.content}`).join('\n\n');

    // Run this in the background using waitUntil so the user doesn't wait for LLM
    waitUntil((async () => {
      try {
        const modelId = 'claude-sonnet'; // TODO
        const summary = await createChat({
          modelId,
          maxTokens: 300,
          messages: [{
            role: 'user',
            content: `Summarise this tutoring session in 2-3 sentences. Include: concepts covered, learner's understanding level, and what to focus on next.\n\n${transcript}`,
          }],
        });

        await db.query(
          `UPDATE sessions SET ended_at = NOW(), summary_text = $1 WHERE id = $2`,
          [summary, id]
        );

        await db.query(
          `UPDATE learner_profiles SET
             streak_days = CASE
               WHEN last_session_at::date = CURRENT_DATE THEN streak_days
               WHEN last_session_at::date = CURRENT_DATE - 1 THEN streak_days + 1
               ELSE 1
             END,
             last_session_at = NOW(),
             current_module_id = COALESCE($1::int, current_module_id),
             updated_at = NOW()
           WHERE user_id = $2`,
          [moduleId ?? null, userAuth.id]
        );
      } catch (err) {
        console.error('Background session close failed:', err);
      }
    })());

    return NextResponse.json({ status: 'closing' });
  } catch (err) {
    return handleApiError(err);
  }
}
