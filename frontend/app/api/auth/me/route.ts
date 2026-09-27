import { NextResponse } from 'next/server';
import { db } from '@/lib/db';
import { requireAuth, handleApiError } from '@/lib/api-utils';

export async function GET() {
  try {
    const userAuth = await requireAuth();
    const result = await db.query(
      `SELECT u.id, u.email, u.name, u.subscription_status, u.goal,
              lp.current_module_id, lp.overall_mastery, lp.streak_days
       FROM users u
       LEFT JOIN learner_profiles lp ON lp.user_id = u.id
       WHERE u.id = $1`,
      [userAuth.id]
    );
    if (!result.rows[0]) {
      return NextResponse.json({ error: 'User not found' }, { status: 404 });
    }
    return NextResponse.json(result.rows[0]);
  } catch (err) {
    return handleApiError(err);
  }
}
