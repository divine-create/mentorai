import { NextResponse } from 'next/server';
import { db } from '@/lib/db';
import { requireAuth, handleApiError } from '@/lib/api-utils';

export async function GET() {
  try {
    const userAuth = await requireAuth();

    const profile = await db.query<{ active_subject_id: number }>(
      `SELECT active_subject_id FROM learner_profiles WHERE user_id = $1`,
      [userAuth.id]
    );
    const subjectId = profile.rows[0]?.active_subject_id;
    if (!subjectId) { return NextResponse.json({ projects: [] }); }

    const result = await db.query(
      `SELECT p.id, p.slug, p.title, p.order_index,
              COALESCE(ls.passed, false) AS passed,
              ls.created_at AS last_submitted_at
       FROM projects p
       LEFT JOIN LATERAL (
         SELECT passed, created_at FROM project_submissions
         WHERE project_id = p.id AND user_id = $1
         ORDER BY created_at DESC LIMIT 1
       ) ls ON true
       WHERE p.subject_id = $2
       ORDER BY p.order_index`,
      [userAuth.id, subjectId]
    );
    return NextResponse.json({ projects: result.rows });
  } catch (err) {
    return handleApiError(err);
  }
}
