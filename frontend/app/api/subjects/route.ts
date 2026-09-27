import { NextResponse } from 'next/server';
import { db } from '@/lib/db';
import { requireAuth, handleApiError } from '@/lib/api-utils';

export async function GET() {
  try {
    await requireAuth();
    const result = await db.query(
      `SELECT id, name, slug, description, icon, order_index, practice_kind, mastery_weights
       FROM subjects
       WHERE is_available = true
       ORDER BY order_index`
    );
    return NextResponse.json(result.rows);
  } catch (err) {
    return handleApiError(err);
  }
}
