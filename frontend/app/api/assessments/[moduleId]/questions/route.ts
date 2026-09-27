import { NextResponse } from 'next/server';
import { db } from '@/lib/db';
import { requireAuth, handleApiError } from '@/lib/api-utils';

export async function GET(request: Request, { params }: { params: Promise<{ moduleId: string }> }) {
  try {
    await requireAuth();
    const { moduleId } = await params;

    const result = await db.query(
      `SELECT id, type, difficulty, prompt, options, test_cases, starter_code
       FROM questions WHERE module_id = $1
       ORDER BY CASE difficulty WHEN 'foundational' THEN 1 WHEN 'applied' THEN 2 ELSE 3 END`,
      [moduleId]
    );
    return NextResponse.json(result.rows);
  } catch (err) {
    return handleApiError(err);
  }
}
