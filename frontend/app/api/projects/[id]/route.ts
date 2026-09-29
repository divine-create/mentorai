import { NextResponse } from 'next/server';
import { db } from '@/lib/db';
import { requireAuth, handleApiError } from '@/lib/api-utils';

export async function GET(request: Request, { params }: { params: Promise<{ id: string }> }) {
  try {
    const userAuth = await requireAuth();
    const { id } = await params;

    const projResult = await db.query(
      `SELECT id, subject_id, slug, title, brief, starter, acceptance_criteria, order_index
       FROM projects WHERE id = $1`,
      [id]
    );
    const project = projResult.rows[0];
    if (!project) { return NextResponse.json({ error: 'Project not found' }, { status: 404 }); }

    const subResult = await db.query(
      `SELECT content, passed, feedback, criteria_results, created_at
       FROM project_submissions
       WHERE project_id = $1 AND user_id = $2
       ORDER BY created_at DESC LIMIT 1`,
      [id, userAuth.id]
    );
    return NextResponse.json({ project, submission: subResult.rows[0] ?? null });
  } catch (err) {
    return handleApiError(err);
  }
}
