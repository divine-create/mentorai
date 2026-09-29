import { NextResponse } from 'next/server';
import { requireAuth, handleApiError } from '@/lib/api-utils';

export async function POST(req: Request) {
  try {
    // Ensure the user is logged in before granting a token
    await requireAuth();

    const apiKey = process.env.ASSEMBLYAI_API_KEY;
    if (!apiKey) {
      return NextResponse.json(
        { error: 'ASSEMBLYAI_API_KEY is missing' },
        { status: 500 }
      );
    }

    // AssemblyAI uses expiresIn (in seconds)
    const response = await fetch('https://api.assemblyai.com/v2/realtime/token', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        Authorization: apiKey,
      },
      body: JSON.stringify({ expires_in: 3600 }),
    });

    if (!response.ok) {
      const err = await response.text();
      console.error('AssemblyAI token error:', err);
      return NextResponse.json(
        { error: 'Failed to generate AssemblyAI token' },
        { status: response.status }
      );
    }

    const data = await response.json();
    return NextResponse.json({ token: data.token });
  } catch (err) {
    return handleApiError(err);
  }
}
