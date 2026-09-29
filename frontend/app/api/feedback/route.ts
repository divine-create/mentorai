import { NextResponse } from 'next/server';
import { db } from '@/lib/db';
import { requireAuth, handleApiError } from '@/lib/api-utils';

const FEEDBACK_KINDS = ['chat', 'hint', 'solution'] as const;
const RATINGS = ['up', 'down'] as const;
const NPS_COOLDOWN_DAYS = 30;
const NPS_MIN_SESSIONS = 3;

function clip(val: unknown, max: number): string | null {
  if (typeof val !== 'string') return null;
  const t = val.trim();
  return t ? t.slice(0, max) : null;
}

export async function POST(request: Request) {
  return NextResponse.json({ error: 'Use specific sub-routes' }, { status: 404 });
}
