import { NextResponse } from 'next/server';
import { requireAuth, handleApiError } from '@/lib/api-utils';
import { computeMastery } from '@/lib/services/mastery';

export async function GET(request: Request, { params }: { params: Promise<{ moduleId: string }> }) {
  try {
    const userAuth = await requireAuth();
    const { moduleId } = await params;

    const breakdown = await computeMastery(userAuth.id, Number(moduleId));
    return NextResponse.json(breakdown);
  } catch (err) {
    return handleApiError(err);
  }
}
