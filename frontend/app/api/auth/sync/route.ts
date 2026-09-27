import { NextResponse } from 'next/server';
import { db } from '@/lib/db';
import { requireAuth, handleApiError } from '@/lib/api-utils';

export async function POST(request: Request) {
  try {
    const userAuth = await requireAuth();
    const body = await request.json();
    const { name, email, goal, experience, startingModule } = body;

    if (!email) {
      return NextResponse.json({ error: 'Missing email' }, { status: 400 });
    }

    const result = await db.query(
      \INSERT INTO users (id, email, name, goal, experience)
       VALUES (\, \, \, \, \)
       ON CONFLICT (id) DO UPDATE SET
         name = COALESCE(EXCLUDED.name, users.name),
         goal = COALESCE(EXCLUDED.goal, users.goal),
         experience = COALESCE(EXCLUDED.experience, users.experience),
         updated_at = NOW()
       RETURNING id, subscription_status, goal\,
      [userAuth.id, email, name ?? null, goal ?? null, experience ?? null]
    );

    const user = result.rows[0];

    const defaultSubject = await db.query(
      \SELECT id FROM subjects
       WHERE is_available = true
       ORDER BY (slug = 'python-native') DESC, order_index ASC
       LIMIT 1\
    );
    const defaultSubjectId = defaultSubject.rows[0]?.id ?? null;

    await db.query(
      \INSERT INTO learner_profiles (user_id, current_module_id, active_subject_id)
       VALUES (\, \, \)
       ON CONFLICT (user_id) DO UPDATE SET
         current_module_id = COALESCE(\, learner_profiles.current_module_id),
         active_subject_id = COALESCE(learner_profiles.active_subject_id, \)\,
      [userAuth.id, startingModule ?? null, defaultSubjectId]
    );

    const modulesToUnlock = Array.from(new Set([1, startingModule ?? 1]));
    for (const modId of modulesToUnlock) {
      await db.query(
        \INSERT INTO module_mastery (user_id, module_id, unlocked)
         VALUES (\, \, true)
         ON CONFLICT (user_id, module_id) DO UPDATE SET unlocked = true\,
        [userAuth.id, modId]
      );
    }

    return NextResponse.json({ user, experience, startingModule });
  } catch (err) {
    return handleApiError(err);
  }
}
