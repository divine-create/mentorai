import { NextResponse } from 'next/server';
import { db } from '@/lib/db';
import { requireAuth, handleApiError } from '@/lib/api-utils';

export async function GET() {
  try {
    const userAuth = await requireAuth();

    const result = await db.query(
      `SELECT s.id, s.summary_text, s.started_at, s.ended_at, m.title AS module_title
       FROM sessions s
       LEFT JOIN modules m ON m.id = s.module_id
       WHERE s.user_id = $1 AND s.ended_at IS NOT NULL
       ORDER BY s.ended_at DESC LIMIT 1`,
      [userAuth.id]
    );

    return NextResponse.json(result.rows[0] ?? null);
  } catch (err) {
    return handleApiError(err);
  }
}
