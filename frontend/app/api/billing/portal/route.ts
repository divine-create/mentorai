import { NextResponse } from 'next/server';

export async function POST() {
  return NextResponse.json({ error: 'billing_disabled', message: 'Stripe billing is not enabled in this build.' }, { status: 503 });
}
