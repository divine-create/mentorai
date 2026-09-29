'use client';

import { useEffect, useRef, useState } from 'react';
import { useParams, useRouter } from 'next/navigation';
import CodeMirror from '@uiw/react-codemirror';
import { python } from '@codemirror/lang-python';
import { createClient } from '@/lib/supabase/client';
import FeedbackButtons from '@/components/FeedbackButtons';

declare global {
  interface Window {
    loadPyodide: (opts: { indexURL: string }) => Promise<{
      runPythonAsync: (code: string) => Promise<unknown>;
    }>;
  }
}

const MAX_HINTS = 3;

const STARTER_CODE = `# Write your Python code here
print("Hello, world!")
`;

interface TestCase {
  input?: string;
  expected_output: string;
}

interface Question {
  id: string;
  type: string;
  prompt: string;
  test_cases?: TestCase[];
}

export default function CodePage() {
  const { moduleSlug } = useParams<{ moduleSlug: string }>();
  const router = useRouter();
  const supabase = createClient();

  const [code, setCode] = useState(STARTER_CODE);
  const [stdin, setStdin] = useState('');
  const [output, setOutput] = useState('');
  const [aiFeedback, setAiFeedback] = useState('');
  const [hints, setHints] = useState<string[]>([]);
  const [hintsUsed, setHintsUsed] = useState(0);
  const [solutionRevealed, setSolutionRevealed] = useState(false);
  const [running, setRunning] = useState(false);
  const [loadingFeedback, setLoadingFeedback] = useState(false);
  const [pyodideReady, setPyodideReady] = useState(false);
  const [sessionId, setSessionId] = useState<string | null>(null);
  const [question, setQuestion] = useState<Question | null>(null);
  const [testResults, setTestResults] = useState<{ passed: boolean; expected: string; actual: string }[]>([]);
  const [moduleId, setModuleId] = useState<number | null>(null);
  const [exercise, setExercise] = useState<{ title: string; instructions: string } | null>(null);
  const [assessmentQuestion, setAssessmentQuestion] = useState<{
    questionId: string;
    prompt: string;
    starterCode: string;
    testCases: { input: string; expected_output: string }[];
  } | null>(null);

  const pyodideRef = useRef<Awaited<ReturnType<typeof window.loadPyodide>> | null>(null);
  const closedRef = useRef(false);

  // ── Close session on leave ────────────────────────────────────────────────────
  // The coding environment is part of the lesson, not a separate session. Moving
  // back to the chat (/learn/[slug]) or to a sibling tool (/learn/[slug]/web …)
  // must NOT close the session — otherwise the chat reopens a fresh session on
  // return and the whole conversation restarts. Only close when truly leaving
  // this module (e.g. to the dashboard).
  useEffect(() => {
    return () => {
      if (!sessionId || closedRef.current) return;
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
  }, [sessionId, supabase]);

  const codeStorageKey = `mentorai:code:${moduleSlug}`;

  // ── Decide initial editor contents ────────────────────────────────────────────
  // Priority: assessment coding question > tutor exercise > saved draft > starter.
  // Guarded to run EXACTLY once: the handoff payloads are one-shot (we removeItem
  // them), so under React StrictMode's double-invoke in dev a second pass would
  // find the handoff already consumed and fall through to the saved draft,
  // clobbering the starter we just applied. The ref makes consumption idempotent.
  const initRef = useRef(false);
  useEffect(() => {
    if (initRef.current) return;
    initRef.current = true;

    // Check for an assessment coding question handoff first.
    const assessmentRaw = sessionStorage.getItem(`mentorai:assessment-coding:${moduleSlug}`);
    if (assessmentRaw) {
      sessionStorage.removeItem(`mentorai:assessment-coding:${moduleSlug}`);
      try {
        const aq = JSON.parse(assessmentRaw);
        if (aq && typeof aq.starterCode === 'string') {
          setCode(aq.starterCode);
          setAssessmentQuestion(aq);
          return;
        }
      } catch {
        // Ignore a malformed handoff payload.
      }
    }

    const raw = sessionStorage.getItem(`mentorai:exercise:${moduleSlug}`);
    if (raw) {
      sessionStorage.removeItem(`mentorai:exercise:${moduleSlug}`);
      try {
        const ex = JSON.parse(raw);
        if (ex && typeof ex.starter === 'string') {
          setCode(ex.starter);
          setExercise({
            title: typeof ex.title === 'string' ? ex.title : 'Coding exercise',
            instructions: typeof ex.instructions === 'string' ? ex.instructions : '',
          });
          return;
        }
      } catch {
        // Ignore a malformed handoff payload and fall through to the saved draft.
      }
    }
    const saved = localStorage.getItem(codeStorageKey);
    if (saved) setCode(saved);
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [moduleSlug]);

  // Persist the draft so a refresh or navigating away doesn't lose work.
  useEffect(() => {
    if (code) localStorage.setItem(codeStorageKey, code);
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [code]);

  function resetCode() {
    // If this is an assessment coding question, reset to the assessment starter,
    // otherwise use the default starter code.
    if (assessmentQuestion) {
      setCode(assessmentQuestion.starterCode);
    } else {
      setCode(STARTER_CODE);
    }
    localStorage.removeItem(codeStorageKey);
  }

  // ── Send the current code + output back to the tutor to discuss ───────────────
  function discussWithTutor() {
    sessionStorage.setItem(`mentorai:discuss:${moduleSlug}`, JSON.stringify({ code, output }));
    router.push(`/learn/${moduleSlug}`);
  }

  // ── Load Pyodide ─────────────────────────────────────────────────────────────
  useEffect(() => {
    const script = document.createElement('script');
    script.src = 'https://cdn.jsdelivr.net/pyodide/v0.27.0/full/pyodide.js';
    script.onload = async () => {
      pyodideRef.current = await window.loadPyodide({
        indexURL: 'https://cdn.jsdelivr.net/pyodide/v0.27.0/full/',
      });
      // The runner is non-interactive: there is no real stdin. Override input()
      // so it reads from the StringIO we wire up per run (used by test cases) and
      // falls back to '' instead of throwing — code using input() then runs to
      // completion and produces visible output rather than a stdin error.
      await pyodideRef.current.runPythonAsync(`
import builtins, sys
def __mentor_input(prompt=''):
    try: sys.stdout.write(str(prompt))
    except Exception: pass
    line = sys.stdin.readline() if hasattr(sys.stdin, 'readline') else ''
    return line.rstrip('\\n') if line else ''
builtins.input = __mentor_input
      `);
      setPyodideReady(true);
    };
    document.head.appendChild(script);
  }, []);

  // ── Get session id from URL state or create one ───────────────────────────────
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

      // Fetch a coding question for this module
      const questionsRes = await fetch(`/api/assessments/${mod.id}/questions`, {
        headers: { Authorization: `Bearer ${session.access_token}` },
      });
      const questions = await questionsRes.json();
      const codingQuestion = questions.find((q: Question) => q.type === 'coding' && q.test_cases);
      if (codingQuestion) {
        setQuestion(codingQuestion);
      }

      const sessRes = await fetch(`/api/tutor/session`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${session.access_token}` },
        body: JSON.stringify({ moduleId: mod.id }),
      });
      const { sessionId: sid } = await sessRes.json();
      setSessionId(sid);
    }
    init();
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [moduleSlug]);

  // ── Keyboard shortcut Cmd/Ctrl+Enter ─────────────────────────────────────────
  useEffect(() => {
    function onKey(e: KeyboardEvent) {
      if ((e.metaKey || e.ctrlKey) && e.key === 'Enter') runCode();
    }
    window.addEventListener('keydown', onKey);
    return () => window.removeEventListener('keydown', onKey);
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [code, pyodideReady]);

  // ── Run code ─────────────────────────────────────────────────────────────────
  async function runCode() {
    if (!pyodideReady || running) return;
    setRunning(true);
    setOutput('');
    setAiFeedback('');
    setTestResults([]);

    let stdout = '';
    let stderr = '';

    try {
      // Redirect stdout/stderr and feed input() from the learner-provided stdin
      // box (one value per line), so exercises that use input() actually run.
      // The user's code runs inside a Python try/except so a runtime error becomes
      // a normal traceback written to the captured stderr — instead of throwing out
      // to JS, which would skip the getvalue() reads below and lose BOTH any output
      // printed before the crash AND the error itself. We then always read back
      // both streams, so errors are reliably shown in the Output panel.
      await pyodideRef.current!.runPythonAsync(`
import sys, io, traceback as __tb
sys.stdout = io.StringIO()
sys.stderr = io.StringIO()
sys.stdin = io.StringIO(${JSON.stringify(stdin ? (stdin.endsWith('\n') ? stdin : stdin + '\n') : '')})
try:
    exec(compile(${JSON.stringify(code)}, '<your code>', 'exec'), {'__name__': '__main__'})
except SystemExit:
    pass
except BaseException:
    __tb.print_exc()
`);

      stdout = String(await pyodideRef.current!.runPythonAsync('sys.stdout.getvalue()'));
      stderr = String(await pyodideRef.current!.runPythonAsync('sys.stderr.getvalue()'));
    } catch (err: unknown) {
      // Reached only if the harness itself fails (e.g. Pyodide crash) — user-code
      // errors are captured as a traceback in stderr above.
      stderr = err instanceof Error ? err.message : String(err);
    }

    const combinedOutput = [stdout, stderr].filter(Boolean).join('\n');
    setOutput(combinedOutput || '(no output)');

    // Run test cases if available (prefer assessment question test cases,
    // fall back to module coding question test cases).
    const testCasesToRun = assessmentQuestion?.testCases ?? question?.test_cases ?? [];
    if (testCasesToRun.length > 0) {
      const results = await runTestCases(testCasesToRun);
      setTestResults(results);
      
      // Submit coding attempt to backend
      if (sessionId && moduleId) {
        const qId = assessmentQuestion?.questionId ?? question?.id;
        if (qId) {
          await submitCodingAttempt(qId, results);
        }
      }
    }

    setRunning(false);

    // Get AI feedback
    await fetchAIFeedback(code, combinedOutput, stderr);
  }

  async function runTestCases(testCases: TestCase[]) {
    const results: { passed: boolean; expected: string; actual: string }[] = [];
    
    for (const tc of testCases) {
      let actual = '';
      let stderr = '';
      try {
        // Redirect streams, feed this case's stdin, and run the code inside a
        // Python try/except so a crash is captured as a traceback (in stderr)
        // rather than throwing out to JS. Note: each setup must be awaited before
        // running the code (the previous version fired them without await).
        await pyodideRef.current!.runPythonAsync(`
import sys, io, traceback as __tb
sys.stdin = io.StringIO(${JSON.stringify(tc.input ? (tc.input.endsWith('\n') ? tc.input : tc.input + '\n') : '')})
sys.stdout = io.StringIO()
sys.stderr = io.StringIO()
try:
    exec(compile(${JSON.stringify(code)}, '<your code>', 'exec'), {'__name__': '__main__'})
except SystemExit:
    pass
except BaseException:
    __tb.print_exc()
`);
        actual = String(await pyodideRef.current!.runPythonAsync('sys.stdout.getvalue()')).trim();
        stderr = String(await pyodideRef.current!.runPythonAsync('sys.stderr.getvalue()')).trim();
      } catch (err: unknown) {
        stderr = err instanceof Error ? err.message : String(err);
      }

      const expected = tc.expected_output.trim();
      results.push({
        // A run that errored never passes; otherwise compare exact stdout.
        passed: stderr === '' && actual === expected,
        expected,
        actual: actual || stderr, // surface the error when the code crashed
      });
    }

    return results;
  }

  async function submitCodingAttempt(questionId: string, testResults: { passed: boolean; expected: string; actual: string }[]) {
    const { data: { session } } = await supabase.auth.getSession();
    if (!session || !sessionId) return;

    try {
      const res = await fetch(`/api/assessments/submit`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${session.access_token}` },
        body: JSON.stringify({
          questionId,
          answer: testResults.every(r => r.passed) ? 'passed' : 'failed',
          sessionId,
          code,
          testResults,
          hint_used: hintsUsed > 0,
          solution_revealed: solutionRevealed
        }),
      });
      const data = await res.json().catch(() => ({}));

      // Hand the result back to the assessment page so it can mark this coding
      // question done and advance. Keyed by module slug; read on return.
      if (assessmentQuestion && assessmentQuestion.questionId === questionId) {
        const passedAll = testResults.length > 0 && testResults.every(r => r.passed);
        sessionStorage.setItem(`mentorai:assessment-coding-result:${moduleSlug}`, JSON.stringify({
          questionId,
          correct: typeof data.correct === 'boolean' ? data.correct : passedAll,
          feedback: data.feedback ?? (passedAll
            ? `All ${testResults.length} test cases passed.`
            : `${testResults.filter(r => r.passed).length}/${testResults.length} test cases passed.`),
        }));
      }
    } catch (err) {
      console.error('Failed to submit coding attempt:', err);
    }
  }

  async function fetchAIFeedback(code: string, output: string, error: string) {
    const { data: { session } } = await supabase.auth.getSession();
    if (!session || !sessionId) return;

    setLoadingFeedback(true);
    const res = await fetch(`/api/tutor/code-feedback`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${session.access_token}` },
      body: JSON.stringify({ sessionId, code, output, hasError: !!error, instructions: exercise?.instructions }),
    });
    const data = await res.json();
    setAiFeedback(data.feedback ?? '');
    setLoadingFeedback(false);
  }

  async function requestHint() {
    if (hintsUsed >= MAX_HINTS) return;
    const { data: { session } } = await supabase.auth.getSession();
    if (!session || !sessionId) return;

    const res = await fetch(`/api/tutor/hint`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${session.access_token}` },
      body: JSON.stringify({ sessionId, code, hintNumber: hintsUsed + 1, instructions: exercise?.instructions }),
    });
    const data = await res.json();
    setHints((prev) => [...prev, data.hint]);
    setHintsUsed((n) => n + 1);
  }

  async function revealSolution() {
    const { data: { session } } = await supabase.auth.getSession();
    if (!session || !sessionId) return;

    const res = await fetch(`/api/tutor/solution`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${session.access_token}` },
      body: JSON.stringify({ sessionId, code, instructions: exercise?.instructions }),
    });
    const data = await res.json();
    setCode(data.solution);
    setSolutionRevealed(true);
  }

  return (
    <div className="flex flex-col h-screen bg-gray-900 text-gray-100">
      {/* Header */}
      <header className="flex items-center justify-between px-4 py-2 bg-gray-800 border-b border-gray-700">
        <div className="flex items-center gap-3">
          <button
            onClick={() => router.push(`/learn/${moduleSlug}`)}
            className="flex items-center gap-1.5 rounded-md border border-gray-600 bg-gray-700 px-3 py-1.5 text-sm font-medium text-gray-100 hover:bg-gray-600 hover:border-gray-500"
          >
            ← Back to chat
          </button>
          <span className="text-sm font-medium text-gray-200">Coding Environment</span>
          {!pyodideReady && <span className="text-xs text-amber-400 animate-pulse">Loading Python…</span>}
        </div>
        <button
          onClick={runCode}
          disabled={!pyodideReady || running}
          className="flex items-center gap-2 rounded-md bg-green-600 px-4 py-1.5 text-sm font-medium hover:bg-green-700 disabled:opacity-40"
        >
          {running ? '▶ Running…' : '▶ Run'}
          <span className="text-xs text-green-300 hidden sm:inline">⌘↵</span>
        </button>
      </header>

      {/* Tutor-assigned exercise */}
      {exercise && (
        <div className="border-b border-indigo-800 bg-indigo-950/60 px-4 py-3">
          <p className="text-xs font-semibold uppercase tracking-wide text-indigo-300">
            💻 Exercise from your tutor — {exercise.title}
          </p>
          {exercise.instructions && (
            <p className="mt-1 text-sm text-indigo-100">{exercise.instructions}</p>
          )}
        </div>
      )}

      {/* Assessment coding question */}
      {assessmentQuestion && (
        <div className="border-b border-emerald-800 bg-emerald-950/60 px-4 py-3 flex items-start justify-between gap-3">
          <div className="min-w-0">
            <p className="text-xs font-semibold uppercase tracking-wide text-emerald-300">
              📝 Assessment coding question
            </p>
            <p className="mt-1 text-sm text-emerald-100 line-clamp-2">{assessmentQuestion.prompt}</p>
            {assessmentQuestion.testCases.length > 0 && (
              <p className="mt-1 text-xs text-emerald-400">
                {assessmentQuestion.testCases.length} test case{assessmentQuestion.testCases.length > 1 ? 's' : ''} — all must pass
              </p>
            )}
          </div>
          <button
            onClick={() => router.push(`/learn/${moduleSlug}/assessment`)}
            className={`shrink-0 rounded-md px-3 py-1.5 text-xs font-medium ${
              testResults.length > 0
                ? 'bg-emerald-500 text-white hover:bg-emerald-400'
                : 'border border-emerald-600 bg-emerald-800 text-emerald-100 hover:bg-emerald-700'
            }`}
          >
            {testResults.length > 0
              ? (testResults.every(r => r.passed) ? '✓ Passed — return to assessment →' : 'Return to assessment →')
              : '← Back to assessment'}
          </button>
        </div>
      )}

      {/* Split pane — stacked on mobile, side-by-side on md+ */}
      <div className="flex flex-col md:flex-row flex-1 overflow-hidden">

        {/* Editor */}
        <div className="flex flex-col flex-1 min-h-0 border-b md:border-b-0 md:border-r border-gray-700">
          <div className="flex items-center justify-between px-3 py-1.5 bg-gray-800 text-xs text-gray-400">
            <span>main.py</span>
            <button onClick={resetCode} className="text-gray-400 hover:text-white" title="Reset to starter code">
              ↺ Reset
            </button>
          </div>
          <div className="flex-1 min-h-0 overflow-auto bg-gray-900">
            <CodeMirror
              value={code}
              onChange={(value) => setCode(value)}
              extensions={[python()]}
              theme="dark"
              height="100%"
              basicSetup={{ lineNumbers: true, highlightActiveLine: true, tabSize: 4 }}
              className="h-full text-sm"
            />
          </div>
          {/* Standard input — fed to input() one value per line when you Run */}
          <div className="border-t border-gray-700 bg-gray-800">
            <label className="flex items-center justify-between px-3 py-1.5 text-xs text-gray-400">
              <span>Input (stdin)</span>
              <span className="text-gray-500">one value per line, for input()</span>
            </label>
            <textarea
              value={stdin}
              onChange={(e) => setStdin(e.target.value)}
              placeholder="e.g.&#10;Ada&#10;42"
              rows={2}
              spellCheck={false}
              className="w-full resize-y bg-gray-950 px-3 py-2 font-mono text-xs text-gray-200 placeholder-gray-600 focus:outline-none"
            />
          </div>

          {/* Hint / Solution controls */}
          <div className="flex items-center gap-3 px-3 py-2 bg-gray-800 border-t border-gray-700">
            <button
              onClick={requestHint}
              disabled={hintsUsed >= MAX_HINTS}
              className="text-xs text-amber-400 hover:text-amber-300 disabled:opacity-40"
            >
              💡 Hint ({MAX_HINTS - hintsUsed} remaining)
            </button>
            {hintsUsed >= MAX_HINTS && !solutionRevealed && (
              <button onClick={revealSolution} className="text-xs text-red-400 hover:text-red-300">
                Show solution
              </button>
            )}
            {solutionRevealed && <span className="text-xs text-gray-500">Solution revealed</span>}
          </div>
          {solutionRevealed && (
            <div className="px-3 pb-2 bg-gray-800">
              <FeedbackButtons
                kind="solution"
                sessionId={sessionId}
                moduleId={moduleId}
                excerpt={code}
              />
            </div>
          )}
        </div>

        {/* Output + AI feedback */}
        <div className="flex flex-col flex-1 min-h-0 overflow-y-auto">
          {/* Output */}
          <div className="flex items-center justify-between px-3 py-1.5 bg-gray-800 text-xs text-gray-400 border-b border-gray-700">
            <span>Output</span>
            {output && (
              <button
                onClick={discussWithTutor}
                className="rounded-md bg-indigo-600 px-2.5 py-1 text-xs font-medium text-white hover:bg-indigo-700"
              >
                Discuss with tutor →
              </button>
            )}
          </div>
          <pre className="p-4 font-mono text-sm text-green-300 whitespace-pre-wrap min-h-[80px] bg-gray-950">
            {output || (running ? 'Running…' : '')}
          </pre>

          {/* AI Feedback */}
          <div className="px-3 py-1.5 bg-gray-800 text-xs text-gray-400 border-y border-gray-700">AI Feedback</div>
          <div className="p-4 text-sm text-gray-200 leading-relaxed flex-1">
            {loadingFeedback
              ? <span className="text-gray-500 animate-pulse">Analysing your code…</span>
              : aiFeedback || <span className="text-gray-600">Run your code to get feedback.</span>
            }
          </div>

          {/* Hints */}
          {hints.length > 0 && (
            <div className="border-t border-gray-700 p-4 space-y-2">
              <p className="text-xs text-amber-400 font-medium">Hints</p>
              {hints.map((h, i) => (
                <div key={i} className="text-sm text-gray-300 bg-gray-800 rounded p-3">
                  <span className="text-amber-400 font-medium">Hint {i + 1}: </span>{h}
                  <FeedbackButtons
                    kind="hint"
                    sessionId={sessionId}
                    moduleId={moduleId}
                    messageIndex={i}
                    excerpt={h}
                    className="mt-2 border-t border-gray-700 pt-2"
                  />
                </div>
              ))}
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
