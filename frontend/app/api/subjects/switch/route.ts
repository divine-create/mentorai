import { NextResponse } from 'next/server';
import { db } from '@/lib/db';
import { requireAuth, handleApiError } from '@/lib/api-utils';

export async function POST(request: Request) {
  try {
    const user = await requireAuth();
    const { subjectId } = await request.json();

    if (!subjectId || typeof subjectId !== 'string') {
      return NextResponse.json({ error: 'subjectId is required and must be a string' }, { status: 400 });
    }

    const subjectCheck = await db.query(
      `SELECT id, is_available FROM subjects WHERE id = $1`,
      [subjectId]
    );

    if (subjectCheck.rows.length === 0) {
      return NextResponse.json({ error: 'Subject not found' }, { status: 404 });
    }
    if (!subjectCheck.rows[0].is_available) {
      return NextResponse.json({ error: 'This subject is not currently available.' }, { status: 403 });
    }

    await db.query(
      `INSERT INTO learner_profiles (user_id, active_subject_id)
       VALUES ($1, $2)
       ON CONFLICT (user_id) DO UPDATE SET active_subject_id = $2`,
      [user.id, subjectId]
    );

    const firstModule = await db.query(
      `SELECT id FROM modules WHERE subject_id = $1 ORDER BY order_index LIMIT 1`,
      [subjectId]
    );

    if (firstModule.rows[0]) {
      await db.query(
        `INSERT INTO module_mastery (user_id, module_id, unlocked)
         VALUES ($1, $2, true)
         ON CONFLICT (user_id, module_id) DO UPDATE SET unlocked = true`,
        [user.id, firstModule.rows[0].id]
      );

      const resume = await db.query(
        `SELECT m.id FROM modules m
           JOIN module_mastery mm ON mm.module_id = m.id AND mm.user_id = $1
          WHERE m.subject_id = $2 AND mm.unlocked = true
          ORDER BY m.order_index DESC LIMIT 1`,
        [user.id, subjectId]
      );
      const resumeModuleId = resume.rows[0]?.id ?? firstModule.rows[0].id;
      await db.query(
        `UPDATE learner_profiles SET current_module_id = $2 WHERE user_id = $1`,
        [user.id, resumeModuleId]
      );
    }

    return NextResponse.json({ success: true, message: 'Subject switched successfully' });
  } catch (err) {
    return handleApiError(err);
  }
}
