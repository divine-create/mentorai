import { NextResponse } from 'next/server';
import { db } from '@/lib/db';
import { requireAuth, handleApiError } from '@/lib/api-utils';

export async function POST(request: Request) {
  try {
    const userAuth = await requireAuth();
    const { moduleId } = await request.json();

    if (!moduleId) {
      return NextResponse.json({ error: 'Missing moduleId' }, { status: 400 });
    }

    const result = await db.query(
      `INSERT INTO sessions (user_id, module_id)
       VALUES ($1, $2) RETURNING id`,
      [userAuth.id, moduleId]
    );

    return NextResponse.json({ sessionId: result.rows[0].id });
  } catch (err) {
    return handleApiError(err);
  }
}
