'use client';

// ─── Spaced-repetition review ─────────────────────────────────────────────────
// Walks the learner through concepts that are due for review (from
// GET /api/review/due), one concept at a time. Answers are graded by
// POST /api/review/grade, which reschedules each concept via SM-2.

import { useEffect, useState } from 'react';
import { useRouter } from 'next/navigation';
import { createClient } from '@/lib/supabase/client';

interface ReviewQuestion {
  id: string;
  type: 'multiple_choice' | 'short_answer' | 'explanation';
  difficulty: string;
  prompt: string;
  options?: { label: string; text: string }[];
}

interface ReviewConcept {
  conceptId: number;
  title: string;
  description: string | null;
  moduleSlug: string | null;
  moduleTitle: string | null;
  mastery: number;
  questions: ReviewQuestion[];
}

interface GradeResult {
  correct: number;
  total: number;
  results: { questionId: string; correct: boolean; feedback: string }[];
}

export default function ReviewPage() {
  const router = useRouter();
  const supabase = createClient();

  const [loading, setLoading] = useState(true);
  const [concepts, setConcepts] = useState<ReviewConcept[]>([]);
  const [idx, setIdx] = useState(0);
  const [answers, setAnswers] = useState<Record<string, string>>({});
  const [result, setResult] = useState<GradeResult | null>(null);
  const [submitting, setSubmitting] = useState(false);
  const [reviewed, setReviewed] = useState(0);

  useEffect(() => {
    async function load() {
      const { data: { session } } = await supabase.auth.getSession();
      if (!session) { router.push('/auth/login'); return; }
      try {
        const res = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/review/due`, {
          headers: { Authorization: `Bearer ${session.access_token}` },
        });
        const data = await res.json().catch(() => ({ concepts: [] }));
        setConcepts(Array.isArray(data.concepts) ? data.concepts : []);
      } catch {
        setConcepts([]);
      }
      setLoading(false);
    }
    load();
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const concept = concepts[idx];
  const allAnswered = concept?.questions.every((q) => (answers[q.id] ?? '').trim().length > 0);

  async function submitConcept() {
    if (!concept || submitting || !allAnswered) return;
    const { data: { session } } = await supabase.auth.getSession();
    if (!session) return;

    setSubmitting(true);
    try {
      const res = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/review/grade`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${session.access_token}` },
        body: JSON.stringify({
          conceptId: concept.conceptId,
          answers: concept.questions.map((q) => ({ questionId: q.id, answer: answers[q.id] ?? '' })),
        }),
      });
      const data: GradeResult = await res.json();
      setResult(data);
      setReviewed((n) => n + 1);
    } catch {
      // Leave the learner on the same card to retry.
    } finally {
      setSubmitting(false);
    }
  }

  function nextConcept() {
    setResult(null);
    setAnswers({});
    setIdx((n) => n + 1);
  }

  if (loading) {
    return <div className="min-h-screen flex items-center justify-center text-gray-400">Loading your review…</div>;
  }

  // Nothing due, or finished the queue.
  if (concepts.length === 0 || idx >= concepts.length) {
    const finished = concepts.length > 0;
    return (
      <main className="min-h-screen flex items-center justify-center bg-gray-50 px-4">
        <div className="w-full max-w-md text-center space-y-5">
          <div className="text-5xl">{finished ? '🎉' : '✅'}</div>
          <h1 className="text-2xl font-bold text-gray-900">
            {finished ? 'Review complete!' : 'Nothing due right now'}
          </h1>
          <p className="text-gray-500">
            {finished
              ? `You refreshed ${reviewed} concept${reviewed === 1 ? '' : 's'}. They'll resurface when they're due again.`
              : 'Concepts you’ve mastered will appear here when it’s time to refresh them. Keep learning!'}
          </p>
          <button onClick={() => router.push('/dashboard')}
            className="rounded-full bg-indigo-600 px-6 py-2.5 text-sm font-medium text-white hover:bg-indigo-700">
            Back to dashboard
          </button>
        </div>
      </main>
    );
  }

  const resultById = new Map((result?.results ?? []).map((r) => [r.questionId, r]));

  return (
    <main className="min-h-screen bg-gray-50 px-4 py-10">
      <div className="max-w-xl mx-auto space-y-6">
        {/* Header */}
        <div className="flex items-center justify-between">
          <div>
            <p className="text-xs font-medium uppercase tracking-wide text-indigo-500">🔁 Spaced review</p>
            <h1 className="text-lg font-bold text-gray-900">{concept.title}</h1>
            {concept.moduleTitle && <p className="text-xs text-gray-400">from {concept.moduleTitle}</p>}
          </div>
          <span className="text-sm text-gray-500">{idx + 1} / {concepts.length}</span>
        </div>

        {/* Progress */}
        <div className="h-1.5 w-full rounded-full bg-gray-200">
          <div className="h-1.5 rounded-full bg-indigo-500 transition-all" style={{ width: `${(idx / concepts.length) * 100}%` }} />
        </div>

        {/* Questions */}
        {concept.questions.map((q, qi) => {
          const r = resultById.get(q.id);
          return (
            <div key={q.id} className="rounded-xl bg-white border border-gray-200 p-5 space-y-3">
              <pre className="text-sm text-gray-800 whitespace-pre-wrap font-sans">{qi + 1}. {q.prompt}</pre>

              {q.type === 'multiple_choice' && q.options ? (
                <div className="space-y-2">
                  {q.options.map((opt) => (
                    <button key={opt.label}
                      disabled={!!result}
                      onClick={() => setAnswers((a) => ({ ...a, [q.id]: opt.text }))}
                      className={`w-full text-left rounded-lg border px-4 py-2.5 text-sm transition-colors disabled:opacity-70 ${
                        answers[q.id] === opt.text
                          ? 'border-indigo-500 bg-indigo-50 text-indigo-800'
                          : 'border-gray-200 bg-white hover:border-indigo-300'
                      }`}>
                      <span className="font-medium mr-2">{opt.label}.</span>{opt.text}
                    </button>
                  ))}
                </div>
              ) : (
                <textarea
                  value={answers[q.id] ?? ''}
                  disabled={!!result}
                  onChange={(e) => setAnswers((a) => ({ ...a, [q.id]: e.target.value }))}
                  placeholder={q.type === 'explanation' ? 'Explain in your own words…' : 'Your answer…'}
                  rows={3}
                  className="w-full rounded-lg border border-gray-300 px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500 disabled:bg-gray-50"
                />
              )}

              {r && (
                <div className={`rounded-lg border p-3 text-sm ${r.correct ? 'border-green-200 bg-green-50 text-green-800' : 'border-red-200 bg-red-50 text-red-800'}`}>
                  <span className="font-semibold">{r.correct ? '✓ Correct' : '✗ Not quite'}</span>
                  {r.feedback && <span className="ml-2 text-gray-700">{r.feedback}</span>}
                </div>
              )}
            </div>
          );
        })}

        {/* Actions */}
        {!result ? (
          <button onClick={submitConcept} disabled={!allAnswered || submitting}
            className="w-full rounded-full bg-indigo-600 py-2.5 text-sm font-medium text-white hover:bg-indigo-700 disabled:opacity-40">
            {submitting ? 'Checking…' : 'Check my recall'}
          </button>
        ) : (
          <div className="flex items-center justify-between gap-3">
            <p className="text-sm text-gray-600">You got <strong>{result.correct}/{result.total}</strong> right.</p>
            <button onClick={nextConcept}
              className="rounded-full bg-indigo-600 px-6 py-2.5 text-sm font-medium text-white hover:bg-indigo-700">
              {idx + 1 >= concepts.length ? 'Finish' : 'Next concept →'}
            </button>
          </div>
        )}

        <button onClick={() => router.push('/dashboard')} className="block text-center w-full text-xs text-gray-400 hover:text-gray-600">
          Exit review
        </button>
      </div>
    </main>
  );
}
