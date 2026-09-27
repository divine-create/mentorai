import { NextResponse } from 'next/server';
import { db } from '@/lib/db';
import { requireAuth, handleApiError } from '@/lib/api-utils';

export async function GET() {
  try {
    const user = await requireAuth();
    
    const result = await db.query(
      `SELECT s.id, s.slug, s.name, s.description, s.icon, s.order_index, s.practice_kind,
              COUNT(DISTINCT m.id)                                       AS total_modules,
              COUNT(DISTINCT m.id) FILTER (WHERE mm.mastery_score >= 80) AS completed_modules,
              COALESCE(ROUND(AVG(mm.mastery_score) FILTER (WHERE mm.id IS NOT NULL)), 0) AS avg_mastery,
              (COUNT(mm.id) > 0 OR COUNT(sess.id) > 0)                   AS started,
              (s.id = lp.active_subject_id)                             AS active
       FROM subjects s
       LEFT JOIN modules m          ON m.subject_id = s.id AND m.published = true
       LEFT JOIN module_mastery mm  ON mm.module_id = m.id AND mm.user_id = $1
       LEFT JOIN sessions sess      ON sess.module_id = m.id AND sess.user_id = $1
       LEFT JOIN learner_profiles lp ON lp.user_id = $1
       WHERE s.is_available = true
       GROUP BY s.id, lp.active_subject_id
       ORDER BY s.order_index`,
      [user.id]
    );

    const subjects = result.rows.map((r: any) => {
      const total = Number(r.total_modules);
      const completed = Number(r.completed_modules);
      return {
        id: r.id,
        slug: r.slug,
        name: r.name,
        description: r.description,
        icon: r.icon,
        practice_kind: r.practice_kind,
        total_modules: total,
        completed_modules: completed,
        avg_mastery: Number(r.avg_mastery),
        progress_pct: total > 0 ? Math.round((completed / total) * 100) : 0,
        started: r.started,
        active: r.active,
      };
    });

    return NextResponse.json(subjects);
  } catch (err) {
    return handleApiError(err);
  }
}
