import { NextResponse } from 'next/server';
import { db } from '@/lib/db';
import { requireAuth, handleApiError } from '@/lib/api-utils';

export async function GET() {
  try {
    const userAuth = await requireAuth();

    const profileResult = await db.query(
      \SELECT current_module_id, overall_mastery, streak_days, last_session_at, active_subject_id
       FROM learner_profiles WHERE user_id = \\,
      [userAuth.id]
    );

    const profile = profileResult.rows[0];
    const activeSubjectId = profile?.active_subject_id;

    if (!activeSubjectId) {
      return NextResponse.json({
        modules: [],
        profile: profile ?? null,
        subject: null,
      });
    }

    const subjectResult = await db.query(
      \SELECT id, name, slug, description, icon, order_index, practice_kind, mastery_weights
       FROM subjects WHERE id = \\,
      [activeSubjectId]
    );

    const subject = subjectResult.rows[0] ?? null;

    const result = await db.query(
      \SELECT
         m.id, m.slug, m.title, m.description, m.order_index,
         m.estimated_hours_min, m.estimated_hours_max,
         COALESCE(mm.mastery_score, 0)  AS mastery_score,
         COALESCE(mm.attempts, 0)       AS attempts,
         COALESCE(mm.unlocked, false)   AS unlocked,
         mm.last_assessed_at
       FROM modules m
       LEFT JOIN module_mastery mm
         ON mm.module_id = m.id AND mm.user_id = \
       WHERE m.subject_id = \ AND m.published = true
       ORDER BY m.order_index\,
      [userAuth.id, activeSubjectId]
    );

    return NextResponse.json({
      modules: result.rows,
      profile: profile ?? null,
      subject: subject,
    });
  } catch (err) {
    return handleApiError(err);
  }
}
