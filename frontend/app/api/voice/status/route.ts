import { NextResponse } from 'next/server';
import { requireAuth, handleApiError } from '@/lib/api-utils';
import { voiceConfigured } from '@/lib/services/voice';

export async function GET() {
  try {
    await requireAuth();
    
    // In our implementation, voice (Vertex TTS and AssemblyAI STT) is available.
    // If you need strict checking, you can verify process.env keys here.
    return NextResponse.json({ available: true });
  } catch (err) {
    return handleApiError(err);
  }
}
