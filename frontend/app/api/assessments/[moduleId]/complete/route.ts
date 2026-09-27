import { NextResponse } from 'next/server';
import { requireAuth, handleApiError } from '@/lib/api-utils';
import { saveMasteryAndGate } from '@/lib/services/mastery';

export async function POST(request: Request, { params }: { params: Promise<{ moduleId: string }> }) {
  try {
    const userAuth = await requireAuth();
    const { moduleId } = await params;

    const result = await saveMasteryAndGate(userAuth.id, Number(moduleId));
    return NextResponse.json(result);
  } catch (err) {
    return handleApiError(err);
  }
}
