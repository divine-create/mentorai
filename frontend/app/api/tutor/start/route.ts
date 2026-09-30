import { NextResponse } from 'next/server';
import { db } from '@/lib/db';
import { requireAuth, handleApiError } from '@/lib/api-utils';
import { streamChat } from '@/lib/services/llm';
import { buildSystemPrompt } from '@/lib/services/tutorHelpers';

function iteratorToStream(iterator: AsyncGenerator<string>, onComplete: (fullText: string) => void) {
  let fullText = '';
  return new ReadableStream({
    async pull(controller) {
      const { value, done } = await iterator.next();
      if (done) {
        onComplete(fullText);
        controller.close();
      } else {
        fullText += value;
        controller.enqueue(new TextEncoder().encode(`data: ${JSON.stringify({ content: value })}\n\n`));
      }
    },
  });
}

export async function POST(request: Request) {
  try {
    const userAuth = await requireAuth();
    const { sessionId } = await request.json();

    if (!sessionId) return NextResponse.json({ error: 'Missing sessionId' }, { status: 400 });

    const modelId = 'claude-sonnet';

    const systemPrompt = await buildSystemPrompt(userAuth.id, sessionId, true, '');

    // For the start of a session, we use a single user prompt telling the tutor to begin
    const startPrompt = "Hello! I am ready to start this module. Please greet me and ask the first question to begin our session.";

    const stream = streamChat({
      modelId,
      system: systemPrompt,
      messages: [{ role: 'user', content: startPrompt }],
      maxTokens: 500,
      feature: 'tutor-chat',
    });

    const readableStream = iteratorToStream(stream, async (fullText) => {
      // Save both the implied user message and the assistant's response to the DB
      try {
        await db.query(
          `INSERT INTO messages (session_id, role, content) VALUES ($1, 'user', $2)`,
          [sessionId, startPrompt]
        );
        await db.query(
          `INSERT INTO messages (session_id, role, content) VALUES ($1, 'assistant', $2)`,
          [sessionId, fullText]
        );
      } catch (e) {
        console.error("Failed to save start messages", e);
      }
    });

    return new Response(readableStream, {
      headers: {
        'Content-Type': 'text/event-stream',
        'Cache-Control': 'no-cache, no-transform',
        'Connection': 'keep-alive',
      },
    });

  } catch (err) {
    return handleApiError(err);
  }
}
