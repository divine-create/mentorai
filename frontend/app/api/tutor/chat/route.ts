import { NextResponse } from 'next/server';
import { db } from '@/lib/db';
import { requireAuth, handleApiError } from '@/lib/api-utils';
import { streamChat } from '@/lib/services/llm';
import { recordUserMessage, recordAssistantTurn } from '@/lib/services/adaptation';
import { manageContext, buildSystemPrompt } from '@/lib/services/tutorHelpers';



function iteratorToStream(iterator: AsyncGenerator<string>) {
  return new ReadableStream({
    async pull(controller) {
      const { value, done } = await iterator.next();
      if (done) {
        controller.close();
      } else {
        controller.enqueue(new TextEncoder().encode(`data: ${JSON.stringify({ content: value })}\n\n`));
      }
    },
  });
}

export async function POST(request: Request) {
  try {
    const userAuth = await requireAuth();
    const { sessionId, message, codeContext, instructions } = await request.json();

    if (!sessionId) return NextResponse.json({ error: 'Missing sessionId' }, { status: 400 });

    const adaptationHint = await recordUserMessage(sessionId, message);
    let fullUserMessage = message;
    if (codeContext) {
      fullUserMessage += '\n\n[Learner\'s current code]:\n```python\n' + codeContext + '\n```';
    }
    if (adaptationHint) {
      fullUserMessage += '\n\n' + adaptationHint;
    }

    await db.query(
      `INSERT INTO messages (session_id, role, content) VALUES ($1, 'user', $2)`,
      [sessionId, fullUserMessage]
    );

    const historyResult = await db.query(
      `SELECT role, content FROM messages WHERE session_id = $1 ORDER BY created_at ASC`,
      [sessionId]
    );

    const modelId = 'claude-sonnet';

    const recentHistory = await manageContext(sessionId, historyResult.rows, modelId);
    const systemPrompt = await buildSystemPrompt(userAuth.id, sessionId, historyResult.rows.length <= 1, fullUserMessage);

    const stream = streamChat({
      modelId,
      system: systemPrompt,
      messages: recentHistory,
      maxTokens: 500,
      feature: 'tutor-chat',
    });

    const readableStream = iteratorToStream(stream);

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
