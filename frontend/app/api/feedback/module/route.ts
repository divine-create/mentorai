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
    const { moduleId, difficulty, clarity, helpfulness, comment } = await request.json();

    if (!moduleId) return NextResponse.json({ error: 'Missing moduleId' }, { status: 400 });

    const inRange = (v: unknown) => v === undefined || v === null || (typeof v === 'number' && Number.isInteger(v) && v >= 1 && v <= 5);
    if (![difficulty, clarity, helpfulness].every(inRange)) {
      return NextResponse.json({ error: 'Ratings must be integers from 1 to 5' }, { status: 400 });
    }

    await db.query(
      `INSERT INTO module_feedback
         (user_id, module_id, difficulty, clarity, helpfulness, comment)
       VALUES ($1, $2, $3, $4, $5, $6)
       ON CONFLICT (user_id, module_id) DO UPDATE SET
         difficulty  = EXCLUDED.difficulty,
         clarity     = EXCLUDED.clarity,
         helpfulness = EXCLUDED.helpfulness,
         comment     = EXCLUDED.comment`,
      [userAuth.id, moduleId, difficulty ?? null, clarity ?? null, helpfulness ?? null, clip(comment, 2000)]
    );
    return NextResponse.json({ ok: true });
  } catch (err) {
    return handleApiError(err);
  }
}
