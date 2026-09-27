import { NextResponse } from 'next/server';
import { db } from '@/lib/db';
import { requireAuth, handleApiError } from '@/lib/api-utils';
// import { isFreeLimitReached } from '@/lib/middleware/tier'; // To be implemented later

export async function POST(request: Request) {
  try {
    const userAuth = await requireAuth();
    const { moduleId } = await request.json();

    if (!moduleId) {
      return NextResponse.json({ error: 'Missing moduleId' }, { status: 400 });
    }

    /*
    const tierCheck = await isFreeLimitReached(userAuth.id);
    if (tierCheck.reached) {
      return NextResponse.json({ error: 'Tier limit reached', ...tierCheck }, { status: 403 });
    }
    */

    const subjectResult = await db.query(
      \SELECT subject_id FROM modules WHERE id = \\,
      [moduleId]
    );

    const result = await db.query(
      \INSERT INTO sessions (user_id, module_id, subject_id)
       VALUES (\, \, \) RETURNING id\,
      [userAuth.id, moduleId, subjectResult.rows[0]?.subject_id || null]
    );

    return NextResponse.json({ sessionId: result.rows[0].id });
  } catch (err) {
    return handleApiError(err);
  }
}
