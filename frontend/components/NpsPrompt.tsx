'use client';

import { useEffect, useState } from 'react';
import { createClient } from '@/lib/supabase/client';

// Periodic in-app Net Promoter Score. On mount it asks the backend whether the
// learner is eligible (≥3 closed sessions and not prompted in the last 30 days);
// if so it shows a dismissible card. Submitting or dismissing both back off the
// prompt server-side via last_nps_prompt_at.
export default function NpsPrompt({ className = '' }: { className?: string }) {
  const supabase = createClient();
  const [eligible, setEligible] = useState(false);
  const [score, setScore] = useState<number | null>(null);
  const [comment, setComment] = useState('');
  const [done, setDone] = useState(false);
  const [closed, setClosed] = useState(false);

  async function authHeader() {
    const { data: { session } } = await supabase.auth.getSession();
    return session ? { Authorization: `Bearer ${session.access_token}` } : null;
  }

  useEffect(() => {
    let active = true;
    (async () => {
      try {
        const h = await authHeader();
        if (!h) return;
        const res = await fetch(`/api/feedback/nps/eligible`, { headers: h });
        const data = await res.json().catch(() => ({}));
        if (active && data?.eligible === true) setEligible(true);
      } catch {
        // non-fatal — just don't show the prompt
      }
    })();
    return () => { active = false; };
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  async function submit() {
    if (score === null) return;
    try {
      const h = await authHeader();
      if (h) {
        await fetch(`/api/feedback/nps`, {
          method: 'POST',
          headers: { 'Content-Type': 'application/json', ...h },
          body: JSON.stringify({ score, comment: comment.trim() || undefined }),
        });
      }
    } catch {
      // non-fatal
    } finally {
      setDone(true);
    }
  }

  async function dismiss() {
    setClosed(true);
    try {
      const h = await authHeader();
      if (h) {
        await fetch(`/api/feedback/nps/dismiss`, {
          method: 'POST',
          headers: h,
        });
      }
    } catch {
      // non-fatal
    }
  }

  if (!eligible || closed) return null;

  if (done) {
    return (
      <div className={`rounded-2xl border border-indigo-100 bg-indigo-50 p-4 text-center ${className}`}>
        <p className="text-sm text-indigo-700">Thanks for the feedback! 🙏</p>
      </div>
    );
  }

  return (
    <div className={`rounded-2xl border border-indigo-100 bg-indigo-50 p-5 ${className}`}>
      <div className="flex items-start justify-between gap-3">
        <p className="text-sm font-semibold text-indigo-900">
          How likely are you to recommend The AI Academy to a friend?
        </p>
        <button onClick={dismiss} aria-label="Dismiss" className="text-indigo-400 hover:text-indigo-600">✕</button>
      </div>

      <div className="mt-3 flex flex-wrap gap-1.5">
        {Array.from({ length: 11 }, (_, n) => (
          <button
            key={n}
            onClick={() => setScore(n)}
            className={`h-8 w-8 rounded-lg text-sm font-medium transition-colors ${
              score === n
                ? 'bg-indigo-600 text-white'
                : 'bg-white text-indigo-700 hover:bg-indigo-100 border border-indigo-200'
            }`}
          >
            {n}
          </button>
        ))}
      </div>
      <div className="mt-1 flex justify-between text-[10px] text-indigo-400">
        <span>Not likely</span>
        <span>Very likely</span>
      </div>

      {score !== null && (
        <div className="mt-3 space-y-2">
          <textarea
            value={comment}
            onChange={(e) => setComment(e.target.value)}
            rows={2}
            placeholder="What's the main reason for your score? (optional)"
            className="w-full rounded-lg border border-indigo-200 px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500"
          />
          <button
            onClick={submit}
            className="rounded-full bg-indigo-600 px-4 py-2 text-sm font-medium text-white hover:bg-indigo-700"
          >
            Submit
          </button>
        </div>
      )}
    </div>
  );
}
