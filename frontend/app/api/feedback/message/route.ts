import { NextResponse } from 'next/server';
import { db } from '@/lib/db';
import { requireAuth, handleApiError } from '@/lib/api-utils';

function clip(val: unknown, max: number): string | null {
  if (typeof val !== 'string') return null;
  const t = val.trim();
  return t ? t.slice(0, max) : null;
}

export async function POST(request: Request) {
  try {
    const userAuth = await requireAuth();
    const { sessionId, moduleId, kind, rating, comment, excerpt, messageIndex } = await request.json();

    if (!kind || !rating) return NextResponse.json({ error: 'Missing kind or rating' }, { status: 400 });

    await db.query(
      `INSERT INTO message_feedback
         (user_id, session_id, module_id, kind, rating, comment, excerpt, message_index)
       VALUES ($1, $2, $3, $4, $5, $6, $7, $8)`,
      [
        userAuth.id,
        sessionId ?? null,
        typeof moduleId === 'number' ? moduleId : null,
        kind,
        rating,
        clip(comment, 2000),
        clip(excerpt, 1000),
        typeof messageIndex === 'number' ? messageIndex : null,
      ]
    );
    return NextResponse.json({ ok: true });
  } catch (err) {
    return handleApiError(err);
  }
}
