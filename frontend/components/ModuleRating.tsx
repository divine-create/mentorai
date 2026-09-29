'use client';

import { useState } from 'react';
import { createClient } from '@/lib/supabase/client';

interface ModuleRatingProps {
  moduleId: number;
  /** Slug used to remember (in localStorage) that this module was already rated. */
  moduleSlug: string;
  className?: string;
}

const ROWS = [
  { key: 'difficulty', label: 'How hard was this module?', low: 'Too easy', high: 'Too hard' },
  { key: 'clarity', label: 'How clear were the explanations?', low: 'Confusing', high: 'Crystal clear' },
  { key: 'helpfulness', label: 'How helpful was the AI tutor?', low: 'Not helpful', high: 'Very helpful' },
] as const;

type RowKey = (typeof ROWS)[number]['key'];

// End-of-module rating card: three 1–5 scales + an optional comment. Shown once
// per module (guarded by a localStorage flag). POSTs to /api/feedback/module.
export default function ModuleRating({ moduleId, moduleSlug, className = '' }: ModuleRatingProps) {
  const supabase = createClient();
  const storageKey = `mentorai:rated:${moduleSlug}`;

  const [hidden, setHidden] = useState(() => {
    if (typeof window === 'undefined') return false;
    return window.localStorage.getItem(storageKey) === '1';
  });
  const [scores, setScores] = useState<Record<RowKey, number | null>>({
    difficulty: null, clarity: null, helpfulness: null,
  });
  const [comment, setComment] = useState('');
  const [saving, setSaving] = useState(false);
  const [done, setDone] = useState(false);

  function remember() {
    try { window.localStorage.setItem(storageKey, '1'); } catch { /* ignore */ }
  }

  function dismiss() {
    remember();
    setHidden(true);
  }

  async function submit() {
    setSaving(true);
    try {
      const { data: { session } } = await supabase.auth.getSession();
      if (session) {
        await fetch(`/api/feedback/module`, {
          method: 'POST',
          headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${session.access_token}` },
          body: JSON.stringify({
            moduleId,
            difficulty: scores.difficulty ?? undefined,
            clarity: scores.clarity ?? undefined,
            helpfulness: scores.helpfulness ?? undefined,
            comment: comment.trim() || undefined,
          }),
        });
      }
      remember();
      setDone(true);
    } catch {
      // non-fatal — still mark done so we don't nag
      remember();
      setDone(true);
    } finally {
      setSaving(false);
    }
  }

  if (hidden) return null;

  if (done) {
    return (
      <div className={`rounded-2xl bg-white border border-gray-100 p-5 text-center ${className}`}>
        <p className="text-sm text-gray-600">Thanks — your feedback helps us improve this module. 🙌</p>
      </div>
    );
  }

  const anyScored = Object.values(scores).some((v) => v !== null);

  return (
    <div className={`rounded-2xl bg-white border border-gray-100 p-5 ${className}`}>
      <div className="flex items-center justify-between mb-3">
        <h3 className="font-semibold text-gray-800">How was this module?</h3>
        <button onClick={dismiss} className="text-xs text-gray-400 hover:text-gray-600">Skip</button>
      </div>

      <div className="space-y-3">
        {ROWS.map((row) => (
          <div key={row.key}>
            <p className="text-xs font-medium text-gray-600 mb-1">{row.label}</p>
            <div className="flex items-center gap-1.5">
              {[1, 2, 3, 4, 5].map((n) => (
                <button
                  key={n}
                  onClick={() => setScores((s) => ({ ...s, [row.key]: n }))}
                  aria-label={`${row.label} — ${n} of 5`}
                  className={`h-8 w-8 rounded-full text-sm font-medium transition-colors ${
                    scores[row.key] && n <= (scores[row.key] as number)
                      ? 'bg-indigo-600 text-white'
                      : 'bg-gray-100 text-gray-500 hover:bg-gray-200'
                  }`}
                >
                  {n}
                </button>
              ))}
              <span className="ml-1 text-[10px] text-gray-400">{row.low} → {row.high}</span>
            </div>
          </div>
        ))}

        <textarea
          value={comment}
          onChange={(e) => setComment(e.target.value)}
          rows={2}
          placeholder="Anything else you'd like us to know? (optional)"
          className="w-full rounded-lg border border-gray-300 px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500"
        />

        <div className="flex gap-2">
          <button
            onClick={submit}
            disabled={saving || (!anyScored && !comment.trim())}
            className="rounded-full bg-indigo-600 px-4 py-2 text-sm font-medium text-white hover:bg-indigo-700 disabled:opacity-50"
          >
            {saving ? 'Sending…' : 'Submit'}
          </button>
          <button
            onClick={dismiss}
            className="rounded-full border border-gray-300 px-4 py-2 text-sm font-medium text-gray-700 hover:bg-gray-50"
          >
            Not now
          </button>
        </div>
      </div>
    </div>
  );
}
