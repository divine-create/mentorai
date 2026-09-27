import { NextResponse } from 'next/server';
import { db } from '@/lib/db';
import { requireAuth, handleApiError } from '@/lib/api-utils';

export async function GET(request: Request, context: { params: Promise<{ subjectId: string }> }) {
  try {
    await requireAuth();
    const { subjectId } = await context.params;

    const subjectResult = await db.query(
      `SELECT id, name, slug, description, icon, order_index, practice_kind, mastery_weights
       FROM subjects
       WHERE id = $1`,
      [subjectId]
    );

    if (subjectResult.rows.length === 0) {
      return NextResponse.json({ error: 'Subject not found' }, { status: 404 });
    }

    const modulesResult = await db.query(
      `SELECT id, title, slug, description, order_index
       FROM modules
       WHERE subject_id = $1
       ORDER BY order_index`,
      [subjectId]
    );

    return NextResponse.json({
      ...subjectResult.rows[0],
      modules: modulesResult.rows,
    });
  } catch (err) {
    return handleApiError(err);
  }
}
