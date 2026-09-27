import { createClient } from '@/lib/supabase/server';
import { NextResponse } from 'next/server';

export async function requireAuth() {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) {
    throw new Error('Unauthorized');
  }
  return user;
}

export function handleApiError(err: unknown) {
  if (err instanceof Error && err.message === 'Unauthorized') {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
  }
  console.error('API Error:', err);
  return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
}
