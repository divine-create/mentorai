'use client';

import { useEffect, useRef, useState } from 'react';
import { useParams, useRouter } from 'next/navigation';
import { createClient } from '@/lib/supabase/client';
import ModuleRating from '@/components/ModuleRating';

interface Question {
  id: string;
  type: 'multiple_choice' | 'short_answer' | 'coding' | 'explanation';
  difficulty: 'foundational' | 'applied' | 'advanced';
  prompt: string;
  options?: { label: string; text: string }[];
  test_cases?: { input: string; expected_output: string }[];
  starter_code?: string | null;
}

interface AnswerResult {
  correct: boolean;
  feedback: string;
  nextDifficulty: string;
  needsTutor: boolean;
}

// Per-question state so learners can skip, jump around, and revisit anything
// unattempted before finishing — instead of a strictly linear, one-shot flow.
type QStatus = 'unseen' | 'skipped' | 'correct' | 'wrong';

export default function AssessmentPage() {
  const { moduleSlug } = useParams<{ moduleSlug: string }>();
  const router = useRouter();
  const supabase = createClient();

  const [questions, setQuestions] = useState<Question[]>([]);
  const [moduleId, setModuleId] = useState<number | null>(null);
  const [sessionId, setSessionId] = useState<string | null>(null);
  const [current, setCurrent] = useState(0);
  const [answer, setAnswer] = useState('');
  const [result, setResult] = useState<AnswerResult | null>(null);
  // One status per question (parallel to `questions`); score is derived from it.
  const [statuses, setStatuses] = useState<QStatus[]>([]);
  const [submitting, setSubmitting] = useState(false);
  const [done, setDone] = useState(false);
  const [failedAttempts, setFailedAttempts] = useState(0);
  const [hydrated, setHydrated] = useState(false);
  // When the learner tries to finish with questions still unattempted, surface a
  // confirm instead of silently scoring them wrong, so nothing gets stranded.
  const [showFinishConfirm, setShowFinishConfirm] = useState(false);
  const closedRef = useRef(false);

  const progressKey = `mentorai:assessment-progress:${moduleSlug}`;
  const codingResultKey = `mentorai:assessment-coding-result:${moduleSlug}`;

  // Mastery-gate state from the backend complete endpoint.
  const [completing, setCompleting] = useState(false);
  const [passed, setPassed] = useState<boolean | null>(null);
  const [nextModuleId, setNextModuleId] = useState<number | null>(null);
  const [nextModuleSlug, setNextModuleSlug] = useState<string | null>(null);
  const [nextModuleTitle, setNextModuleTitle] = useState<string | null>(null);

  // ── Close session on leave ────────────────────────────────────────────────────
  useEffect(() => {
    return () => {
      if (!sessionId || closedRef.current) return;
      // Detouring to the coding environment (/learn/[slug]/code) or back to the
      // chat must NOT close the session mid-assessment — otherwise the tutor
      // conversation restarts on return. Only close when truly leaving the module.
      if (typeof window !== 'undefined') {
        const path = window.location.pathname;
        const base = `/learn/${moduleSlug}`;
        if (path === base || path.startsWith(`${base}/`)) return;
      }
      closedRef.current = true;
      supabase.auth.getSession().then(({ data: { session } }) => {
        if (!session) return;
        fetch(`/api/sessions/${sessionId}/close`, {
          method: 'POST',
          headers: { Authorization: `Bearer ${session.access_token}` },
        }).catch(() => {});
      });
    };
  }, [sessionId, supabase, moduleSlug]);

  useEffect(() => {
    async function init() {
      const { data: { session } } = await supabase.auth.getSession();
      if (!session) return;

      const pathRes = await fetch(`/api/path`, {
        headers: { Authorization: `Bearer ${session.access_token}` },
      });
      const pathData = await pathRes.json();
      const mod = pathData.modules.find((m: { slug: string; id: number }) => m.slug === moduleSlug);
      if (!mod) return;
      setModuleId(mod.id);

      const [qRes, sessRes] = await Promise.all([
        fetch(`/api/assessments/${mod.id}/questions`, {
          headers: { Authorization: `Bearer ${session.access_token}` },
        }),
        fetch(`/api/tutor/session`, {
          method: 'POST',
          headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${session.access_token}` },
          body: JSON.stringify({ moduleId: mod.id }),
        }),
      ]);

      const qs: Question[] = await qRes.json();
      setQuestions(qs);
      const { sessionId: sid } = await sessRes.json();
      setSessionId(sid);

      // ── Resume in-progress state ───────────────────────────────────────────────
      // Returning from the coding environment remounts this page, so restore the
      // place and per-question statuses we stashed before the detour.
      let restoredCurrent = 0;
      let restoredStatuses: QStatus[] = Array(qs.length).fill('unseen');
      let restoredResult: AnswerResult | null = null;
      const progressRaw = sessionStorage.getItem(progressKey);
      if (progressRaw) {
        try {
          const p = JSON.parse(progressRaw);
          if (typeof p.current === 'number') restoredCurrent = p.current;
          if (Array.isArray(p.statuses) && p.statuses.length === qs.length) {
            restoredStatuses = p.statuses as QStatus[];
          }
          if (p.result) restoredResult = p.result as AnswerResult;
        } catch {
          // Ignore malformed progress.
        }
      }

      // Apply a coding-question result handed back by the coding environment so the
      // assessment can mark that exercise done. Setting the status by index is
      // idempotent, so a refresh or re-entry can't double-count it.
      const codingResultRaw = sessionStorage.getItem(codingResultKey);
      if (codingResultRaw) {
        sessionStorage.removeItem(codingResultKey);
        try {
          const cr = JSON.parse(codingResultRaw);
          const idx = qs.findIndex((qq) => qq.id === cr.questionId);
          if (idx >= 0) {
            restoredCurrent = idx;
            restoredStatuses[idx] = cr.correct ? 'correct' : 'wrong';
            restoredResult = {
              correct: !!cr.correct,
              feedback: cr.feedback ?? (cr.correct ? 'All tests passed.' : 'Some tests failed.'),
              nextDifficulty: '',
              needsTutor: false,
            };
          }
        } catch {
          // Ignore malformed result.
        }
      }

      setCurrent(restoredCurrent);
      setStatuses(restoredStatuses);
      if (restoredResult) setResult(restoredResult);
      setHydrated(true);
    }
    init();
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [moduleSlug]);

  // Persist progress so a detour to the coding environment (or a refresh) resumes
  // in place. Guarded by `hydrated` so it can't clobber stored progress before the
  // init effect has read it back.
  useEffect(() => {
    if (!hydrated) return;
    if (done) {
      sessionStorage.removeItem(progressKey);
      return;
    }
    sessionStorage.setItem(progressKey, JSON.stringify({ current, statuses, result }));
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [hydrated, done, current, statuses, result]);

  async function submitAnswer() {
    if (!answer.trim() || submitting) return;
    const { data: { session } } = await supabase.auth.getSession();
    if (!session) return;

    setSubmitting(true);
    const res = await fetch(`/api/assessments/submit`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${session.access_token}` },
      body: JSON.stringify({ questionId: questions[current].id, answer, sessionId }),
    });
    const data: AnswerResult = await res.json();
    setResult(data);
    setStatus(current, data.correct ? 'correct' : 'wrong');
    if (!data.correct) setFailedAttempts((n) => n + 1);
    setSubmitting(false);
    // Note: a 2-wrong streak (data.needsTutor) no longer force-redirects to the
    // tutor — that stranded the remaining exercises. Help is offered as an opt-in
    // button in the result panel instead (see `goToTutorForHelp`).
  }

  // Set a single question's status without disturbing the others.
  function setStatus(idx: number, st: QStatus) {
    setStatuses((prev) => {
      const nextStatuses = prev.length ? [...prev] : Array(questions.length).fill('unseen');
      nextStatuses[idx] = st;
      return nextStatuses;
    });
  }

  // Opt-in: leave the struggling note and head to the tutor (the learner can come
  // back and resume — progress is preserved in sessionStorage).
  function goToTutorForHelp() {
    sessionStorage.setItem(`mentorai:assessment:${moduleSlug}`, JSON.stringify({ status: 'struggling' }));
    router.push(`/learn/${moduleSlug}`);
  }

  // ── Open a coding question in the coding environment ───────────────────────────
  function openCodingEnvironment() {
    const codingQ = questions[current];
    if (!codingQ || codingQ.type !== 'coding') return;

    // Save the question's starter code, prompt, test cases, and question id
    // so the code page can pre-populate the editor and auto-submit the result.
    sessionStorage.setItem(`mentorai:assessment-coding:${moduleSlug}`, JSON.stringify({
      questionId: codingQ.id,
      prompt: codingQ.prompt,
      starterCode: codingQ.starter_code ?? '# Write your solution here\n',
      testCases: codingQ.test_cases ?? [],
    }));

    router.push(`/learn/${moduleSlug}/code`);
  }

  // ── Complete assessment and gate mastery ──────────────────────────────────────
  async function completeAssessment() {
    if (!moduleId || completing) return;
    const { data: { session } } = await supabase.auth.getSession();
    if (!session) return;

    setCompleting(true);
    try {
      const res = await fetch(`/api/assessments/${moduleId}/complete`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${session.access_token}` },
      });
      const data = await res.json();
      setPassed(data.passed);
      setNextModuleId(data.nextModuleId);
      if (data.nextModuleSlug) setNextModuleSlug(data.nextModuleSlug);
      if (data.nextModuleTitle) setNextModuleTitle(data.nextModuleTitle);

      // Leave a result note so the tutor proactively acknowledges the outcome
      // when the learner returns to this module's chat ("Review tutor"), and so
      // the chat can offer a "Next module" button on a pass. Keyed by THIS
      // module's slug, so jumping straight to the next module won't fire it.
      sessionStorage.setItem(`mentorai:assessment:${moduleSlug}`, JSON.stringify({
        status: data.passed ? 'passed' : 'failed',
        correct: statuses.filter((s) => s === 'correct').length,
        total: questions.length,
        nextSlug: data.nextModuleSlug ?? null,
        nextTitle: data.nextModuleTitle ?? null,
      }));
    } catch (err) {
      console.error('Failed to complete assessment:', err);
    } finally {
      setCompleting(false);
      setDone(true);
    }
  }

  // Jump to a specific question (from the navigator or skip), clearing the
  // per-question answer/result view.
  function goTo(idx: number) {
    setResult(null);
    setAnswer('');
    setShowFinishConfirm(false);
    setCurrent(idx);
  }

  // Indices still needing an attempt (never seen or explicitly skipped).
  function unattemptedIndices(): number[] {
    return questions
      .map((_, i) => i)
      .filter((i) => statuses[i] === 'unseen' || statuses[i] === 'skipped' || statuses[i] === undefined);
  }

  // Advance after answering: go to the next still-unattempted question (wrapping),
  // or, if everything has been attempted, prompt to finish.
  function next() {
    const remaining = unattemptedIndices().filter((i) => i !== current);
    if (remaining.length === 0) {
      tryFinish();
      return;
    }
    const after = remaining.find((i) => i > current);
    goTo(after !== undefined ? after : remaining[0]);
  }

  // Defer the current question and move on — it stays in the "to revisit" set.
  function skip() {
    if (statuses[current] === 'unseen' || statuses[current] === undefined) setStatus(current, 'skipped');
    const remaining = unattemptedIndices().filter((i) => i !== current);
    if (remaining.length === 0) { goTo(Math.min(current + 1, questions.length - 1)); return; }
    const after = remaining.find((i) => i > current);
    goTo(after !== undefined ? after : remaining[0]);
  }

  // Finish — but never strand exercises: if any are unattempted, surface them
  // first so the learner can revisit (or knowingly finish anyway).
  function tryFinish() {
    if (unattemptedIndices().length > 0) {
      setShowFinishConfirm(true);
      return;
    }
    void completeAssessment();
  }

  const q = questions[current];
  const correctCount = statuses.filter((s) => s === 'correct').length;
  const unattempted = unattemptedIndices();
  const allAttempted = questions.length > 0 && unattempted.length === 0;
  const pct = questions.length > 0 ? Math.round((correctCount / questions.length) * 100) : 0;

  if (done) {
    return (
      <main className="min-h-screen flex items-center justify-center bg-gray-50 px-4">
        <div className="w-full max-w-md text-center space-y-6">
          {completing ? (
            <>
              <div className="text-5xl">⏳</div>
              <h1 className="text-2xl font-bold text-gray-900">Calculating mastery...</h1>
              <p className="text-gray-500">Saving your results and updating your progress.</p>
            </>
          ) : (
            <>
              <div className="text-5xl">{passed ? '🎉' : '📚'}</div>
              <h1 className="text-2xl font-bold text-gray-900">
                {passed ? 'Module complete!' : 'Keep practising'}
              </h1>
              <p className="text-gray-500">You scored <strong>{correctCount}/{questions.length}</strong> ({pct}%)</p>
              {passed
                ? <p className="text-green-600 font-medium">You&apos;ve met the mastery threshold. The next module is unlocked!</p>
                : <p className="text-amber-600">Your tutor will review the concepts you missed.</p>
              }
              <div className="flex gap-3 justify-center">
                {passed && nextModuleSlug && (
                  <button onClick={() => router.push(`/learn/${nextModuleSlug}`)}
                    className="rounded-full bg-green-600 px-6 py-2.5 text-sm font-medium text-white hover:bg-green-700">
                    {nextModuleTitle ? `Next: ${nextModuleTitle} →` : 'Start next module →'}
                  </button>
                )}
                <button onClick={() => router.push(`/learn/${moduleSlug}`)}
                  className="rounded-full bg-indigo-600 px-6 py-2.5 text-sm font-medium text-white hover:bg-indigo-700">
                  {passed ? 'Review tutor' : 'Back to tutor'}
                </button>
                <button onClick={() => router.push('/dashboard')}
                  className="rounded-full border border-gray-300 px-6 py-2.5 text-sm font-medium text-gray-700 hover:bg-gray-50">
                  Dashboard
                </button>
              </div>
              {moduleId !== null && (
                <ModuleRating moduleId={moduleId} moduleSlug={moduleSlug} className="text-left" />
              )}
            </>
          )}
        </div>
      </main>
    );
  }

  if (!q) {
    return <div className="min-h-screen flex items-center justify-center text-gray-400">Loading assessment…</div>;
  }

  return (
    <main className="min-h-screen bg-gray-50 px-4 py-12">
      <div className="max-w-xl mx-auto space-y-6">
        {/* Header */}
        <div className="flex items-center justify-between">
          <h1 className="text-lg font-bold text-gray-900">Module Assessment</h1>
          <span className="text-sm text-gray-500">{current + 1} / {questions.length}</span>
        </div>

        {/* Progress — fraction of exercises attempted */}
        <div className="h-1.5 w-full rounded-full bg-gray-200">
          <div className="h-1.5 rounded-full bg-indigo-500 transition-all"
            style={{ width: `${(questions.filter((_, i) => statuses[i] === 'correct' || statuses[i] === 'wrong').length / questions.length) * 100}%` }} />
        </div>

        {/* Navigator — jump to any exercise, and revisit skipped/unseen ones */}
        <div className="flex flex-wrap items-center gap-1.5">
          {questions.map((qq, i) => {
            const st = statuses[i] ?? 'unseen';
            const tone = st === 'correct' ? 'bg-green-500 text-white border-green-500'
              : st === 'wrong' ? 'bg-red-500 text-white border-red-500'
              : st === 'skipped' ? 'bg-amber-100 text-amber-700 border-amber-300'
              : 'bg-white text-gray-500 border-gray-300';
            return (
              <button
                key={i}
                onClick={() => goTo(i)}
                title={`Question ${i + 1}${qq.type === 'coding' ? ' (coding)' : ''} — ${st}`}
                className={`h-8 w-8 rounded-full border text-xs font-medium transition ${tone} ${i === current ? 'ring-2 ring-indigo-400 ring-offset-1' : ''}`}
              >
                {i + 1}
              </button>
            );
          })}
          {statuses.some((s) => s === 'correct' || s === 'wrong') && (
            <button onClick={tryFinish} className="ml-auto text-xs font-medium text-indigo-600 hover:underline">
              Finish assessment →
            </button>
          )}
        </div>

        {/* Difficulty badge */}
        <span className={`inline-block rounded-full px-2.5 py-0.5 text-xs font-medium ${
          q.difficulty === 'foundational' ? 'bg-green-50 text-green-700' :
          q.difficulty === 'applied' ? 'bg-amber-50 text-amber-700' :
          'bg-red-50 text-red-700'
        }`}>{q.difficulty}</span>

        {/* Question */}
        <div className="rounded-xl bg-white border border-gray-200 p-5">
          <pre className="text-sm text-gray-800 whitespace-pre-wrap font-sans">{q.prompt}</pre>
        </div>

        {/* Answer input */}
        {!result && (
          <>
            {q.type === 'multiple_choice' && q.options ? (
              <div className="space-y-2">
                {q.options.map((opt) => (
                  <button key={opt.label}
                    onClick={() => setAnswer(opt.text)}
                    className={`w-full text-left rounded-lg border px-4 py-3 text-sm transition-colors ${
                      answer === opt.text
                        ? 'border-indigo-500 bg-indigo-50 text-indigo-800'
                        : 'border-gray-200 bg-white hover:border-indigo-300'
                    }`}>
                    <span className="font-medium mr-2">{opt.label}.</span>{opt.text}
                  </button>
                ))}
              </div>
            ) : q.type === 'coding' ? (
              <div className="rounded-xl border border-indigo-200 bg-indigo-50 p-5 text-center space-y-3">
                <p className="text-sm text-indigo-800 font-medium">💻 This is a coding question</p>
                <p className="text-xs text-indigo-600">Solve it in the interactive coding environment with test cases and AI feedback.</p>
                <button onClick={openCodingEnvironment}
                  className="rounded-full bg-indigo-600 px-6 py-2.5 text-sm font-medium text-white hover:bg-indigo-700">
                  Open in coding environment →
                </button>
              </div>
            ) : (
              <textarea
                value={answer}
                onChange={(e) => setAnswer(e.target.value)}
                placeholder={q.type === 'explanation' ? 'Explain this concept in your own words…' : 'Your answer…'}
                rows={4}
                className="w-full rounded-lg border border-gray-300 px-4 py-3 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500"
              />
            )}
            {q.type !== 'coding' && (
              <button onClick={submitAnswer} disabled={!answer.trim() || submitting}
                className="w-full rounded-full bg-indigo-600 py-2.5 text-sm font-medium text-white hover:bg-indigo-700 disabled:opacity-40">
                {submitting ? 'Checking…' : 'Submit answer'}
              </button>
            )}
            {/* Defer this exercise and come back to it later — nothing gets stranded. */}
            <button onClick={skip}
              className="w-full rounded-full border border-gray-300 py-2 text-sm font-medium text-gray-600 hover:bg-gray-50">
              Skip for now
            </button>
          </>
        )}

        {/* Result */}
        {result && (
          <div className={`rounded-xl border p-4 space-y-3 ${result.correct ? 'border-green-200 bg-green-50' : 'border-red-200 bg-red-50'}`}>
            <p className={`font-semibold ${result.correct ? 'text-green-700' : 'text-red-700'}`}>
              {result.correct ? '✓ Correct!' : '✗ Not quite'}
            </p>
            <p className="text-sm text-gray-700">{result.feedback}</p>
            <div className="flex flex-wrap gap-2">
              <button onClick={next}
                className="rounded-full bg-indigo-600 px-6 py-2 text-sm font-medium text-white hover:bg-indigo-700">
                {allAttempted ? 'Finish & see results' : 'Next question'}
              </button>
              {/* A 2-wrong streak no longer yanks the learner out; help is opt-in so
                  they can still finish the remaining exercises. */}
              {result.needsTutor && (
                <button onClick={goToTutorForHelp}
                  className="rounded-full border border-amber-300 bg-amber-50 px-4 py-2 text-sm font-medium text-amber-800 hover:bg-amber-100">
                  Review with your tutor →
                </button>
              )}
            </div>
          </div>
        )}

        {/* Take a break suggestion after 3 failed attempts */}
        {failedAttempts >= 3 && (
          <div className="rounded-xl bg-amber-50 border border-amber-200 p-4 text-sm text-amber-800">
            💛 You&apos;re almost there — consider taking a short break before your next attempt. Fresh eyes help!
          </div>
        )}

        {/* Finish guard — don't strand exercises: surface unattempted ones first. */}
        {showFinishConfirm && (
          <div className="rounded-xl border border-amber-200 bg-amber-50 p-4 space-y-3">
            <p className="text-sm font-medium text-amber-800">
              You still have {unattempted.length} unattempted {unattempted.length === 1 ? 'exercise' : 'exercises'}
              {' '}(question{unattempted.length === 1 ? '' : 's'} {unattempted.map((i) => i + 1).join(', ')}).
              You won&apos;t get any credit for them, which lowers your final score.
            </p>
            <div className="flex flex-wrap gap-2">
              <button onClick={() => goTo(unattempted[0])}
                className="rounded-full bg-indigo-600 px-4 py-2 text-sm font-medium text-white hover:bg-indigo-700">
                Revisit them
              </button>
              <button onClick={() => { setShowFinishConfirm(false); void completeAssessment(); }}
                className="rounded-full border border-gray-300 px-4 py-2 text-sm font-medium text-gray-700 hover:bg-gray-50">
                Finish anyway
              </button>
            </div>
          </div>
        )}
      </div>
    </main>
  );
}
