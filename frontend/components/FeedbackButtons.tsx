'use client';

import { useState } from 'react';
import { createClient } from '@/lib/supabase/client';

type Kind = 'chat' | 'hint' | 'solution';

interface FeedbackButtonsProps {
  kind: Kind;
  /** Snapshot of the AI text, for admin context (trimmed server-side). */
  excerpt?: string;
  sessionId?: string | null;
  moduleId?: number | null;
  /** Ordinal within the session's chat, when known. */
  messageIndex?: number;
  className?: string;
}

// A subtle 👍/👎 footer for a piece of AI output. Clicking 👎 (or the comment
// affordance) reveals a one-line note box. Fire-and-forget: failures are silent
// so they never disrupt the learner's flow. POSTs to /api/feedback/message.
export default function FeedbackButtons({
  kind,
  excerpt,
  sessionId,
  moduleId,
  messageIndex,
  className = '',
}: FeedbackButtonsProps) {
  const supabase = createClient();
  const [rating, setRating] = useState<'up' | 'down' | null>(null);
  const [showComment, setShowComment] = useState(false);
  const [comment, setComment] = useState('');
  const [done, setDone] = useState(false);

  async function send(value: 'up' | 'down', withComment?: string) {
    try {
      const { data: { session } } = await supabase.auth.getSession();
      if (!session) return;
      await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/feedback/message`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${session.access_token}` },
        body: JSON.stringify({
          kind,
          rating: value,
          sessionId: sessionId ?? undefined,
          moduleId: moduleId ?? undefined,
          excerpt: excerpt?.slice(0, 500),
          messageIndex,
          comment: withComment,
        }),
      });
    } catch {
      // non-fatal
    }
  }

  function pick(value: 'up' | 'down') {
    setRating(value);
    if (value === 'down') {
      // Give a 👎 a chance to explain why before recording.
      setShowComment(true);
    } else {
      void send('up');
      setDone(true);
    }
  }

  function submitComment() {
    void send(rating ?? 'down', comment.trim() || undefined);
    setDone(true);
  }

  if (done) {
    return <p className={`text-[11px] text-gray-400 ${className}`}>Thanks for the feedback.</p>;
  }

  return (
    <div className={`text-xs text-gray-400 ${className}`}>
      {!showComment ? (
        <div className="flex items-center gap-2">
          <span className="text-[11px]">Helpful?</span>
          <button
            onClick={() => pick('up')}
            aria-label="Helpful"
            className="rounded px-1.5 py-0.5 hover:bg-gray-100 hover:text-gray-700"
          >
            👍
          </button>
          <button
            onClick={() => pick('down')}
            aria-label="Not helpful"
            className="rounded px-1.5 py-0.5 hover:bg-gray-100 hover:text-gray-700"
          >
            👎
          </button>
        </div>
      ) : (
        <div className="flex items-center gap-2">
          <input
            value={comment}
            onChange={(e) => setComment(e.target.value)}
            onKeyDown={(e) => { if (e.key === 'Enter') submitComment(); }}
            autoFocus
            placeholder="What was off? (optional)"
            className="flex-1 rounded border border-gray-300 px-2 py-1 text-xs text-gray-700 focus:outline-none focus:ring-1 focus:ring-indigo-400"
          />
          <button
            onClick={submitComment}
            className="rounded bg-indigo-600 px-2 py-1 text-[11px] font-medium text-white hover:bg-indigo-700"
          >
            Send
          </button>
        </div>
      )}
    </div>
  );
}
