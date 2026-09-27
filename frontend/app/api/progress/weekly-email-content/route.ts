import { NextResponse } from 'next/server';
import { db } from '@/lib/db';
import { requireAuth, handleApiError } from '@/lib/api-utils';
import { createChat } from '@/lib/services/llm';

export async function GET() {
  try {
    const userAuth = await requireAuth();

    const summaryRes = await db.query(
      `SELECT u.name,
              lp.streak_days, lp.overall_mastery,
              m.title AS current_module,
              (SELECT COUNT(*) FROM sessions s WHERE s.user_id = u.id AND s.started_at >= NOW() - INTERVAL '7 days') AS sessions_this_week,
              (SELECT COUNT(*) FROM module_mastery mm WHERE mm.user_id = u.id AND mm.mastery_score >= 80) AS modules_completed
       FROM users u
       LEFT JOIN learner_profiles lp ON lp.user_id = u.id
       LEFT JOIN modules m ON m.id = lp.current_module_id
       WHERE u.id = $1`,
      [userAuth.id]
    );
    const row = summaryRes.rows[0];

    const modelId = 'claude-sonnet'; // TODO: fetch from user profile

    const text = await createChat({
      modelId,
      maxTokens: 200,
      messages: [{
        role: 'user',
        content: `Write a warm, encouraging 2-sentence weekly progress summary for ${row?.name ?? 'a learner'} who:
- Completed ${row?.sessions_this_week ?? 0} sessions this week
- Has a ${row?.streak_days ?? 0}-day streak
- Is ${row?.overall_mastery ?? 0}% through their overall mastery
- Is currently studying: ${row?.current_module ?? 'Python Fundamentals'}
End with one forward-looking hook for next week.`,
      }],
    });

    return NextResponse.json({ summary: text, data: row });
  } catch (err) {
    return handleApiError(err);
  }
}
