import { NextResponse } from 'next/server';
import { requireAuth, handleApiError } from '@/lib/api-utils';
import { synthesizeSpeech } from '@/lib/services/voice';

export async function POST(request: Request) {
  try {
    await requireAuth();
    const { text } = await request.json();

    if (!text) {
      return NextResponse.json({ error: 'Missing text' }, { status: 400 });
    }

    const audioBuffer = await synthesizeSpeech(text);

    return new NextResponse(audioBuffer, {
      status: 200,
      headers: {
        'Content-Type': 'audio/wav',
        'Content-Length': audioBuffer.length.toString(),
      },
    });
  } catch (err) {
    return handleApiError(err);
  }
}
