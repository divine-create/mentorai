'use client';

import { useEffect, useRef, useState, useCallback } from 'react';
import { useParams, useRouter } from 'next/navigation';
import { createClient } from '@/lib/supabase/client';
import QuizCard, { Quiz } from '@/components/QuizCard';
import MessageContent from '@/components/MessageContent';
import FeedbackButtons from '@/components/FeedbackButtons';
import { TTSPlayer, VoiceInputController, VoicePhase, extractNewSentences } from '@/lib/voice';

interface Message {
  role: 'user' | 'assistant';
  content: string;
}

interface Exercise {
  title: string;
  instructions: string;
  starter: string;
}

// Steering controls — one tap lets the learner drive the tutor's altitude. The
// "simpler" / "lost" ones also trip the backend's confusion detection, which
// nudges the tutor to re-explain a different way.
const QUICK_REPLIES = [
  "Got it 👍 keep going",
  "Can you give an example?",
  "Explain it more simply",
  "Go deeper on this",
  "I'm lost — re-explain that",
];

// The tutor can embed directives in its message — a coding exercise or a quiz.
// We parse them out so we render rich UI (a button / an interactive card)
// instead of raw JSON.
//
// IMPORTANT: the closing marker ([[/EXERCISE]] / [[/QUIZ]]) is treated as
// OPTIONAL. Gemini reliably omits [[/EXERCISE]] after long directives, so we
// locate the JSON payload by brace-matching from the opening marker rather than
// requiring a closing marker. The closing marker is consumed if present.

// Find one directive: returns its JSON payload and the [start,end) span it
// occupies in `content` (span includes the opening marker and, if present, the
// trailing closing marker). Returns null if no complete JSON object is found
// (e.g. the reply was truncated mid-JSON) so partial JSON stays hidden.
function findDirective(
  content: string,
  name: 'EXERCISE' | 'QUIZ' | 'ASSESSMENT',
): { json: string; start: number; end: number } | null {
  const open = `[[${name}]]`;
  const start = content.indexOf(open);
  if (start === -1) return null;
  const braceStart = content.indexOf('{', start + open.length);
  if (braceStart === -1) return null;

  let depth = 0, inStr = false, esc = false;
  for (let i = braceStart; i < content.length; i++) {
    const ch = content[i];
    if (inStr) {
      if (esc) esc = false;
      else if (ch === '\\') esc = true;
      else if (ch === '"') inStr = false;
    } else if (ch === '"') {
      inStr = true;
    } else if (ch === '{') {
      depth++;
    } else if (ch === '}') {
      depth--;
      if (depth === 0) {
        let end = i + 1;
        // Consume an optional closing marker (with leading whitespace).
        const rest = content.slice(end);
        const closeMatch = rest.match(new RegExp(`^\\s*\\[\\[/${name}\\]\\]`));
        if (closeMatch) end += closeMatch[0].length;
        return { json: content.slice(braceStart, i + 1), start, end };
      }
    }
  }
  return null; // unterminated JSON — leave hidden until the rest streams in
}

// Build a sensible fallback starter from the instructions when the tutor omits
// (or leaves blank) the "starter" field — so the editor never silently falls
// back to the generic hello-world default for a real exercise.
function scaffoldFromInstructions(instructions: string): string {
  const lines = instructions.trim()
    ? instructions.trim().split('\n').map((l) => `# ${l}`)
    : ['# Write your solution below.'];
  return `${lines.join('\n')}\n\n`;
}

function parseExercise(text: string): Exercise | null {
  const d = findDirective(text, 'EXERCISE');
  if (!d) return null;
  try {
    const parsed = JSON.parse(d.json);
    // Accept the directive as long as it carries a title or instructions; the
    // starter is treated as optional and scaffolded from the instructions when
    // missing/blank, rather than dropping the exercise entirely.
    if (parsed && (typeof parsed.title === 'string' || typeof parsed.instructions === 'string')) {
      const instructions = typeof parsed.instructions === 'string' ? parsed.instructions : '';
      const starter = typeof parsed.starter === 'string' && parsed.starter.trim()
        ? parsed.starter
        : scaffoldFromInstructions(instructions);
      return {
        title: typeof parsed.title === 'string' ? parsed.title : 'Coding exercise',
        instructions,
        starter,
      };
    }
  } catch {
    // Malformed directive — ignore; the span is stripped from the text anyway.
  }
  return null;
}

function parseQuiz(text: string): Quiz | null {
  const d = findDirective(text, 'QUIZ');
  if (!d) return null;
  try {
    const p = JSON.parse(d.json);
    if (
      p &&
      typeof p.question === 'string' &&
      Array.isArray(p.options) &&
      p.options.length >= 2 &&
      typeof p.answer === 'number' &&
      p.answer >= 0 &&
      p.answer < p.options.length
    ) {
      return {
        question: p.question,
        options: p.options.map(String),
        answer: p.answer,
        explanation: typeof p.explanation === 'string' ? p.explanation : undefined,
      };
    }
  } catch {
    // Malformed — ignore.
  }
  return null;
}

// The tutor emits [[ASSESSMENT]] when the learner is ready for the module's
// Final Assessment; we render it as a button that opens the assessment page.
function parseAssessment(text: string): { label: string } | null {
  const d = findDirective(text, 'ASSESSMENT');
  if (!d) return null;
  try {
    const p = JSON.parse(d.json);
    const label = typeof p.label === 'string' && p.label.trim() ? p.label : null;
    return { label: label ?? "I'm ready — start the assessment" };
  } catch {
    return null;
  }
}

// Parse an assistant message into display text plus any embedded directives.
// Parsed directive spans are removed from the text; any dangling opening marker
// (a reply truncated mid-directive) is also stripped so raw JSON never leaks.
function parseMessage(content: string): { text: string; exercise: Exercise | null; quiz: Quiz | null; assessment: { label: string } | null } {
  const exercise = parseExercise(content);
  const quiz = parseQuiz(content);
  const assessment = parseAssessment(content);
  let text = content;
  for (const name of ['EXERCISE', 'QUIZ', 'ASSESSMENT'] as const) {
    const d = findDirective(text, name);
    if (d) text = text.slice(0, d.start) + text.slice(d.end);
  }
  text = stripDirectivesForStream(text).trim();
  return { text, exercise, quiz, assessment };
}

// While streaming, a directive may be half-arrived. Hide everything from the
// earliest opening marker onward so raw JSON never flashes; the rich UI appears
// once the message is complete.
function stripDirectivesForStream(content: string): string {
  const idxs = [content.indexOf('[[EXERCISE]]'), content.indexOf('[[QUIZ]]'), content.indexOf('[[ASSESSMENT]]')].filter((i) => i !== -1);
  return idxs.length === 0 ? content : content.slice(0, Math.min(...idxs)).trimEnd();
}

export default function TutorPage() {
  const { moduleSlug } = useParams<{ moduleSlug: string }>();
  const router = useRouter();
  const supabase = createClient();

  const [sessionId, setSessionId] = useState<string | null>(null);
  const [moduleId, setModuleId] = useState<number | null>(null);
  const [moduleTitle, setModuleTitle] = useState('');
  const [practiceKind, setPracticeKind] = useState<string>('code');
  const [messages, setMessages] = useState<Message[]>([]);
  const [input, setInput] = useState('');
  const [streaming, setStreaming] = useState(false);
  const [token, setToken] = useState('');
  const [error, setError] = useState<string | null>(null);
  // Set after a passing assessment so the chat can offer to advance the learner.
  const [nextModule, setNextModule] = useState<{ slug: string; title: string | null } | null>(null);
  const bottomRef = useRef<HTMLDivElement>(null);
  const closedRef = useRef(false);
  const startedRef = useRef(false);
  const discussHandledRef = useRef(false);
  const assessmentHandledRef = useRef(false);

  // ── Voice (read-aloud TTS + wake-word STT) ───────────────────────────────────
  const [voiceAvailable, setVoiceAvailable] = useState(false);
  const [readAloud, setReadAloud] = useState(false);
  const [voicePhase, setVoicePhase] = useState<VoicePhase>('off');
  const ttsRef = useRef<TTSPlayer | null>(null);
  const sttRef = useRef<VoiceInputController | null>(null);
  const ttsIdxRef = useRef(0);
  const sendRef = useRef<(text: string) => void>(() => {});

  const getToken = useCallback(async () => {
    const { data: { session } } = await supabase.auth.getSession();
    return session?.access_token ?? null;
  }, [supabase]);

  // ── Close session (call on leave) ────────────────────────────────────────────
  const closeSession = useCallback(async () => {
    if (!sessionId || closedRef.current) return;

    // Stepping into this module's own coding/math/web environment is NOT leaving
    // the lesson — those are sibling routes under /learn/[moduleSlug]/. Closing
    // the session there would orphan the conversation and force a fresh restart
    // (with quizzes reset) on return. Only close when truly leaving the module.
    if (typeof window !== 'undefined' &&
        window.location.pathname.startsWith(`/learn/${moduleSlug}/`)) {
      return;
    }

    closedRef.current = true;

    const { data: { session } } = await supabase.auth.getSession();
    if (!session) return;

    try {
      await fetch(`/api/sessions/${sessionId}/close`, {
        method: 'POST',
        headers: { Authorization: `Bearer ${session.access_token}` },
      });
    } catch {
      // Best-effort — don't block navigation on failure
    }
  }, [sessionId, supabase, moduleSlug]);

  // Close session on unmount / navigation away
  useEffect(() => {
    return () => { closeSession(); };
  }, [closeSession]);

  // Close session on tab close / browser refresh
  useEffect(() => {
    const handler = () => { closeSession(); };
    window.addEventListener('beforeunload', handler);
    return () => window.removeEventListener('beforeunload', handler);
  }, [closeSession]);

  // ── Init: resolve module, create session, load history ──────────────────────
  useEffect(() => {
    async function init() {
      const { data: { session } } = await supabase.auth.getSession();
      if (!session) { router.push('/auth/login'); return; }

      // Resolve module id from slug
      const pathRes = await fetch(`/api/path`, {
        headers: { Authorization: `Bearer ${session.access_token}` },
      });
      const pathData = await pathRes.json().catch(() => ({}));
      // A non-OK response (rate limit, auth, server error) has no `modules` array
      // — surface a clear message instead of crashing on `.find`.
      if (!pathRes.ok || !Array.isArray(pathData.modules)) {
        setError(
          pathData.error === 'rate_limit_exceeded'
            ? 'You’re doing that a bit too fast. Please wait a moment, then refresh.'
            : 'Could not load this lesson. Please refresh and try again.'
        );
        return;
      }
      const mod = pathData.modules.find((m: { slug: string; id: number; title: string }) => m.slug === moduleSlug);
      if (!mod) { router.push('/dashboard'); return; }
      setModuleId(mod.id);
      setModuleTitle(mod.title);
      // 'code' subjects (Python) get the Pyodide editor; 'problem'/'none'
      // subjects (Mathematics) learn in chat, so hide coding affordances.
      setPracticeKind(pathData.subject?.practice_kind ?? 'code');

      // Create (or reuse) session
      const sessRes = await fetch(`/api/tutor/session`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${session.access_token}`,
        },
        body: JSON.stringify({ moduleId: mod.id }),
      });
      const sessData = await sessRes.json().catch(() => ({}));
      if (!sessRes.ok || !sessData.sessionId) {
        setError(
          sessData.error === 'free_limit_reached'
            ? sessData.message || 'You have reached your free session limit. Upgrade to continue.'
            : 'Could not start a tutoring session. Please try again.'
        );
        return;
      }
      const sid = sessData.sessionId;
      setSessionId(sid);

      // Load existing messages (resuming session)
      const msgRes = await fetch(
        `/api/tutor/session/${sid}/messages`,
        { headers: { Authorization: `Bearer ${session.access_token}` } }
      );
      const msgs = await msgRes.json();
      const history: Message[] = Array.isArray(msgs) ? msgs : [];
      // If the learner is returning from a just-completed assessment, the tutor's
      // proactive acknowledgement drives the next turn — don't also fire the
      // generic lesson opening on an otherwise-empty session.
      const assessmentPending = typeof window !== 'undefined' &&
        !!sessionStorage.getItem(`mentorai:assessment:${moduleSlug}`);
      if (history.length > 0) {
        setMessages(history);
      } else if (!assessmentPending) {
        // Fresh session — have the tutor open the lesson automatically.
        startLesson(sid, session.access_token);
      }

      // If the learner came back from the coding environment to discuss their
      // work, send that code + output to the tutor now (history is loaded).
      maybeSendDiscuss(sid, session.access_token, history);
      // If they came back from the module assessment, have the tutor react to
      // the result (congratulate on a pass / offer to review a miss).
      maybeSendAssessmentResult(sid, session.access_token, history);
    }
    init();
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [moduleSlug]);

  useEffect(() => {
    bottomRef.current?.scrollIntoView({ behavior: 'smooth' });
  }, [messages, token]);

  // ── Voice setup: build the TTS player, check server availability, tear down ──
  useEffect(() => {
    let cancelled = false;
    ttsRef.current = new TTSPlayer('', getToken);
    (async () => {
      try {
        const token = await getToken();
        if (!token) return;
        const res = await fetch(`/api/voice/status`, {
          headers: { Authorization: `Bearer ${token}` },
        });
        const data = await res.json().catch(() => ({}));
        if (!cancelled) setVoiceAvailable(!!data.available);
      } catch {
        // Voice UI stays hidden if status can't be fetched.
      }
    })();
    return () => {
      cancelled = true;
      ttsRef.current?.stop();
      sttRef.current?.stop();
    };
  }, [getToken]);

  function toggleReadAloud() {
    const next = !readAloud;
    setReadAloud(next);
    ttsRef.current?.setEnabled(next);
  }

  async function toggleVoiceMode() {
    if (voicePhase !== 'off') {
      sttRef.current?.stop();
      setVoicePhase('off');
      return;
    }
    if (!sttRef.current) {
      sttRef.current = new VoiceInputController(
        '',
        getToken,
        (text) => sendRef.current(text),
        (p) => setVoicePhase(p),
        (partial) => setInput(partial) // Show real-time streaming text in the chat box!
      );
    }
    try {
      await sttRef.current.start();
    } catch {
      setError('Microphone access is needed for voice input.');
      setVoicePhase('off');
    }
  }

  // ── Read an SSE token stream into the chat ───────────────────────────────────
  async function consumeStream(res: Response) {
    if (!res.ok || !res.body) {
      setStreaming(false);
      setError('The tutor could not respond. Please try again.');
      return;
    }

    const reader = res.body.getReader();
    const decoder = new TextDecoder();
    let accumulated = '';

    // Reset read-aloud for this reply (clears any leftover speech).
    ttsRef.current?.stop();
    ttsIdxRef.current = 0;

    while (true) {
      const { done, value } = await reader.read();
      if (done) break;

      const chunk = decoder.decode(value);
      const lines = chunk.split('\n');
      for (const line of lines) {
        if (!line.startsWith('data: ')) continue;
        try {
          const payload = JSON.parse(line.slice(6));
          if (payload.token) {
            accumulated += payload.token;
            setToken(accumulated);
            // Read along: enqueue each newly-completed sentence (directives stripped).
            if (ttsRef.current?.isEnabled()) {
              const speakable = stripDirectivesForStream(accumulated);
              const { sentences, nextIdx } = extractNewSentences(speakable, ttsIdxRef.current, false);
              sentences.forEach((s) => ttsRef.current?.enqueue(s));
              ttsIdxRef.current = nextIdx;
            }
          }
          if (payload.error) {
            setError('The tutor hit an error generating a response. Please try again.');
            setToken('');
            setStreaming(false);
          }
          if (payload.done && accumulated) {
            // Flush any trailing sentence to the read-aloud queue.
            if (ttsRef.current?.isEnabled()) {
              const speakable = stripDirectivesForStream(accumulated);
              const { sentences } = extractNewSentences(speakable, ttsIdxRef.current, true);
              sentences.forEach((s) => ttsRef.current?.enqueue(s));
            }
            setMessages((prev) => [...prev, { role: 'assistant', content: accumulated }]);
            setToken('');
            setStreaming(false);
          }
        } catch { /* ignore parse errors */ }
      }
    }
    setStreaming(false);
  }

  // ── Auto-start: tutor opens the lesson on a fresh session ────────────────────
  async function startLesson(sid: string, accessToken: string) {
    if (startedRef.current) return;
    startedRef.current = true;
    setStreaming(true);
    setToken('');
    setError(null);

    const res = await fetch(`/api/tutor/start`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        Authorization: `Bearer ${accessToken}`,
      },
      body: JSON.stringify({ sessionId: sid }),
    });

    // If the session was already started (e.g. StrictMode double-mount), the
    // server returns JSON, not a stream — just stop the typing indicator.
    if (res.headers.get('content-type')?.includes('application/json')) {
      setStreaming(false);
      return;
    }
    await consumeStream(res);
  }

  // ── Coding-environment handoff ───────────────────────────────────────────────
  // Stash a tutor-authored exercise and open the editor pre-loaded with it.
  function openExercise(exercise: Exercise) {
    sessionStorage.setItem(`mentorai:exercise:${moduleSlug}`, JSON.stringify(exercise));
    router.push(`/learn/${moduleSlug}/code`);
  }

  // Record an inline-quiz answer to the adaptation/mastery engine (best-effort),
  // then let the tutor react and continue the lesson. The tutor already has its
  // own quiz (with the correct answer) in the conversation history, so the
  // continuation only needs to convey what the learner chose.
  async function recordQuizOutcome(correct: boolean, chosen: string) {
    if (!sessionId || streaming) return;
    const { data: { session } } = await supabase.auth.getSession();
    if (!session) return;
    try {
      await fetch(`/api/tutor/feedback`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${session.access_token}` },
        body: JSON.stringify({ sessionId, outcome: correct ? 'correct' : 'wrong', chosen }),
      });
    } catch {
      // Best-effort — a failed record shouldn't break the quiz UX.
    }

    // Continue the conversation so the tutor responds to the answer.
    const note = correct
      ? `I answered that quick check correctly (I chose "${chosen}"). Let's keep going.`
      : `For that quick check I chose "${chosen}", which wasn't right. Can you help me understand, then continue?`;
    send(note);
  }

  // On return from the editor, post the learner's code + output to the tutor.
  async function maybeSendDiscuss(sid: string, accessToken: string, history: Message[]) {
    if (discussHandledRef.current) return;
    const key = `mentorai:discuss:${moduleSlug}`;
    const raw = sessionStorage.getItem(key);
    if (!raw) return;
    discussHandledRef.current = true;
    sessionStorage.removeItem(key);

    let payload: {
      kind?: 'code' | 'math' | 'web';
      code?: string; output?: string;
      expressions?: string[]; notes?: string;
      html?: string; css?: string;
    };
    try {
      payload = JSON.parse(raw);
    } catch {
      return;
    }

    let composed: string;
    if (payload.kind === 'math') {
      composed =
        `Here's what I worked on in the math workspace:\n\n` +
        (payload.expressions?.length ? `Graphed: ${payload.expressions.join(', ')}\n\n` : '') +
        (payload.notes ? `My working / notes:\n${payload.notes}\n\n` : '') +
        `Can you check my reasoning and tell me how I did?`;
    } else if (payload.kind === 'web') {
      composed =
        `Here's the HTML and CSS I wrote in the playground:\n\n` +
        `\`\`\`html\n${payload.html || ''}\n\`\`\`\n\n` +
        `\`\`\`css\n${payload.css || ''}\n\`\`\`\n\n` +
        `Can you review it and tell me how I did?`;
    } else {
      composed =
        `Here's the code I wrote in the coding environment:\n\n` +
        `\`\`\`python\n${payload.code}\n\`\`\`\n\n` +
        `Output:\n\`\`\`\n${payload.output || '(no output)'}\n\`\`\`\n\n` +
        `Can you review it and tell me how I did?`;
    }

    setMessages((prev) => [...prev, { role: 'user', content: composed }]);
    setStreaming(true);
    setToken('');
    setError(null);

    const res = await fetch(`/api/tutor/chat`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${accessToken}` },
      body: JSON.stringify({ sessionId: sid, message: composed, history }),
    });
    await consumeStream(res);
  }

  // On return from the module assessment, report the outcome to the tutor so it
  // reacts immediately (congratulate a pass, offer to review a miss, or help when
  // the learner bounced out after struggling) instead of sitting silent until the
  // learner types. Mirrors maybeSendDiscuss; sessionStorage removal dedupes it.
  async function maybeSendAssessmentResult(sid: string, accessToken: string, history: Message[]) {
    if (assessmentHandledRef.current || discussHandledRef.current) return;
    const key = `mentorai:assessment:${moduleSlug}`;
    const raw = sessionStorage.getItem(key);
    if (!raw) return;
    assessmentHandledRef.current = true;
    sessionStorage.removeItem(key);

    let payload: {
      status?: 'passed' | 'failed' | 'struggling';
      correct?: number; total?: number;
      nextSlug?: string | null; nextTitle?: string | null;
    };
    try {
      payload = JSON.parse(raw);
    } catch {
      return;
    }

    // On a pass with a next module, surface a button to advance the learner.
    if (payload.status === 'passed' && payload.nextSlug) {
      setNextModule({ slug: payload.nextSlug, title: payload.nextTitle ?? null });
    }

    const score = payload.correct != null && payload.total != null ? ` (${payload.correct}/${payload.total})` : '';
    let composed: string;
    if (payload.status === 'passed') {
      composed = `I just finished this module's assessment${score} and passed! 🎉`;
    } else if (payload.status === 'failed') {
      composed = `I just finished this module's assessment${score}, but didn't quite reach the pass mark. Can we go over the parts I struggled with?`;
    } else {
      composed = `I got a couple of assessment questions wrong in a row and came back to you. Can you help me understand what I'm missing?`;
    }

    setMessages((prev) => [...prev, { role: 'user', content: composed }]);
    setStreaming(true);
    setToken('');
    setError(null);

    const res = await fetch(`/api/tutor/chat`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${accessToken}` },
      body: JSON.stringify({ sessionId: sid, message: composed, history }),
    });
    await consumeStream(res);
  }

  // ── Send message ─────────────────────────────────────────────────────────────
  async function send(text: string) {
    if (!text.trim() || !sessionId || streaming) return;
    const { data: { session } } = await supabase.auth.getSession();
    if (!session) return;

    const userMsg: Message = { role: 'user', content: text };
    setMessages((prev) => [...prev, userMsg]);
    setInput('');
    setStreaming(true);
    setToken('');
    setError(null);

    const res = await fetch(`/api/tutor/chat`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        Authorization: `Bearer ${session.access_token}`,
      },
      body: JSON.stringify({
        sessionId,
        message: text,
        history: messages,
      }),
    });

    await consumeStream(res);
  }

  // Keep the voice controller calling the latest send (avoids stale closure).
  sendRef.current = send;

  // ── Render message content (Markdown + math via MessageContent) ──────────────
  function renderContent(content: string) {
    return <MessageContent text={content} />;
  }

  return (
    <div className="flex flex-col h-screen bg-gray-50">
      {/* Context bar */}
      <header className="flex items-center justify-between border-b border-gray-200 bg-white px-4 py-3">
        <div className="flex items-center gap-3">
          <button
            onClick={() => router.push('/dashboard')}
            className="flex items-center gap-1.5 rounded-md border border-gray-300 px-3 py-1.5 text-sm font-medium text-gray-700 hover:bg-gray-50"
          >
            ← Dashboard
          </button>
          <div className="h-8 w-8 rounded-full bg-indigo-600 flex items-center justify-center text-white text-sm font-bold">M</div>
          <div>
            <p className="text-xs text-gray-500">Current module</p>
            <p className="text-sm font-semibold text-gray-800">{moduleTitle || '…'}</p>
          </div>
        </div>
        <div className="flex items-center gap-3">
          <button
            onClick={() => router.push('/profile')}
            title="Your profile"
            aria-label="Your profile"
            className="rounded-md border border-gray-300 px-2.5 py-1.5 text-sm text-gray-600 hover:bg-gray-50"
          >
            👤
          </button>
          {voiceAvailable && (
            <button
              onClick={toggleReadAloud}
              title={readAloud ? 'Turn off read-aloud' : 'Read tutor replies aloud'}
              aria-pressed={readAloud}
              className={`rounded-md border px-2.5 py-1.5 text-sm ${
                readAloud ? 'border-indigo-300 bg-indigo-50 text-indigo-700' : 'border-gray-300 text-gray-600 hover:bg-gray-50'
              }`}
            >
              {readAloud ? '🔊' : '🔇'}
            </button>
          )}
          {voiceAvailable && VoiceInputController.supported() && (
            <button
              onClick={toggleVoiceMode}
              title={voicePhase === 'off' ? 'Voice input — say “speak”, then talk' : 'Turn off voice input'}
              aria-pressed={voicePhase !== 'off'}
              className={`flex items-center gap-1.5 rounded-md border px-2.5 py-1.5 text-sm ${
                voicePhase !== 'off' ? 'border-red-300 bg-red-50 text-red-600' : 'border-gray-300 text-gray-600 hover:bg-gray-50'
              }`}
            >
              🎤
              {voicePhase === 'listening' && <span className="text-[10px]">say “speak”</span>}
              {voicePhase === 'recording' && <span className="text-[10px] animate-pulse">listening…</span>}
              {voicePhase === 'transcribing' && <span className="text-[10px]">transcribing…</span>}
            </button>
          )}
          {practiceKind === 'code' && (
            <button
              onClick={() => router.push(`/learn/${moduleSlug}/code`)}
              className="rounded-md border border-gray-300 px-3 py-1.5 text-xs font-medium text-gray-700 hover:bg-gray-50"
            >
              Open coding environment
            </button>
          )}
          {practiceKind === 'problem' && (
            <button
              onClick={() => router.push(`/learn/${moduleSlug}/practice`)}
              className="rounded-md border border-gray-300 px-3 py-1.5 text-xs font-medium text-gray-700 hover:bg-gray-50"
            >
              Open math workspace
            </button>
          )}
          {practiceKind === 'web' && (
            <button
              onClick={() => router.push(`/learn/${moduleSlug}/web`)}
              className="rounded-md border border-gray-300 px-3 py-1.5 text-xs font-medium text-gray-700 hover:bg-gray-50"
            >
              Open HTML/CSS playground
            </button>
          )}
        </div>
      </header>

      {/* Error banner */}
      {error && (
        <div className="flex items-center justify-between gap-3 border-b border-red-200 bg-red-50 px-4 py-2 text-sm text-red-700">
          <span>{error}</span>
          <div className="flex items-center gap-3 shrink-0">
            <button onClick={() => router.push('/upgrade')} className="font-medium underline hover:no-underline">
              Upgrade
            </button>
            <button onClick={() => setError(null)} aria-label="Dismiss" className="text-red-400 hover:text-red-600">
              ✕
            </button>
          </div>
        </div>
      )}

      {/* Messages */}
      <div className="flex-1 overflow-y-auto px-4 py-6 space-y-4">
        {messages.length === 0 && !streaming && (
          <p className="text-center text-sm text-gray-400">Your tutor is ready. Say hello or ask a question.</p>
        )}

        {messages.map((msg, i) => {
          const { text, exercise, quiz, assessment } = msg.role === 'assistant'
            ? parseMessage(msg.content)
            : { text: msg.content, exercise: null, quiz: null, assessment: null };
          return (
            <div key={i} className={`flex ${msg.role === 'user' ? 'justify-end' : 'justify-start'}`}>
              {msg.role === 'assistant' && (
                <div className="h-7 w-7 rounded-full bg-indigo-600 flex items-center justify-center text-white text-xs font-bold mr-2 mt-1 shrink-0">M</div>
              )}
              <div className={`max-w-[75%] rounded-2xl px-4 py-3 text-sm ${
                msg.role === 'user'
                  ? 'bg-indigo-600 text-white rounded-br-sm'
                  : 'bg-white border border-gray-200 text-gray-800 rounded-bl-sm'
              }`}>
                {renderContent(text)}
                {exercise && (
                  <button
                    onClick={() => openExercise(exercise)}
                    className="mt-3 flex w-full items-center gap-2 rounded-lg border border-indigo-200 bg-indigo-50 px-3 py-2 text-left text-xs font-medium text-indigo-700 hover:bg-indigo-100"
                  >
                    <span>💻</span>
                    <span className="flex-1">
                      Open exercise{exercise.title ? `: ${exercise.title}` : ''}
                      {exercise.instructions && (
                        <span className="block font-normal text-indigo-500">{exercise.instructions}</span>
                      )}
                    </span>
                    <span className="text-indigo-400">→</span>
                  </button>
                )}
                {quiz && (
                  <QuizCard
                    quiz={quiz}
                    storageKey={`mentorai:quiz:${sessionId}:${i}`}
                    onAnswer={recordQuizOutcome}
                  />
                )}
                {assessment && (
                  <button
                    onClick={() => router.push(`/learn/${moduleSlug}/assessment`)}
                    className="mt-3 flex w-full items-center gap-2 rounded-lg border border-emerald-200 bg-emerald-50 px-3 py-2 text-left text-xs font-semibold text-emerald-700 hover:bg-emerald-100"
                  >
                    <span>🎯</span>
                    <span className="flex-1">{assessment.label}</span>
                    <span className="text-emerald-400">→</span>
                  </button>
                )}
                {msg.role === 'assistant' && text.trim() && (
                  <FeedbackButtons
                    kind="chat"
                    sessionId={sessionId}
                    moduleId={moduleId}
                    messageIndex={i}
                    excerpt={text}
                    className="mt-2 border-t border-gray-100 pt-2"
                  />
                )}
              </div>
            </div>
          );
        })}

        {/* Streaming token */}
        {streaming && token && (
          <div className="flex justify-start">
            <div className="h-7 w-7 rounded-full bg-indigo-600 flex items-center justify-center text-white text-xs font-bold mr-2 mt-1 shrink-0">M</div>
            <div className="max-w-[75%] rounded-2xl rounded-bl-sm bg-white border border-gray-200 px-4 py-3 text-sm text-gray-800">
              {renderContent(stripDirectivesForStream(token))}
              <span className="inline-block w-1.5 h-4 bg-indigo-400 animate-pulse ml-0.5 align-middle" />
            </div>
          </div>
        )}

        {streaming && !token && (
          <div className="flex justify-start gap-1 pl-9">
            {[0, 1, 2].map((i) => (
              <span key={i} className="h-2 w-2 rounded-full bg-gray-300 animate-bounce" style={{ animationDelay: `${i * 0.15}s` }} />
            ))}
          </div>
        )}

        <div ref={bottomRef} />
      </div>

      {/* Next-module banner — shown after passing this module's assessment */}
      {nextModule && (
        <div className="flex items-center justify-between gap-3 border-t border-green-200 bg-green-50 px-4 py-3">
          <span className="flex items-center gap-2 text-sm text-green-800 min-w-0">
            <span>🎉</span>
            <span className="truncate">
              Module complete — next up{nextModule.title ? `: ${nextModule.title}` : ''}.
            </span>
          </span>
          <button
            onClick={() => router.push(`/learn/${nextModule.slug}`)}
            className="shrink-0 rounded-full bg-green-600 px-4 py-1.5 text-sm font-medium text-white hover:bg-green-700"
          >
            Next module →
          </button>
        </div>
      )}

      {/* Quick reply chips — shown after last assistant message */}
      {!streaming && messages.at(-1)?.role === 'assistant' && (
        <div className="flex gap-2 px-4 pb-2 flex-wrap">
          {QUICK_REPLIES.map((r) => (
            <button
              key={r}
              onClick={() => send(r)}
              className="rounded-full border border-indigo-200 bg-indigo-50 px-3 py-1 text-xs text-indigo-700 hover:bg-indigo-100"
            >
              {r}
            </button>
          ))}
        </div>
      )}

      {/* Input */}
      <form
        onSubmit={(e) => { e.preventDefault(); send(input); }}
        className="border-t border-gray-200 bg-white px-4 py-3 flex gap-2"
      >
        <input
          value={input}
          onChange={(e) => setInput(e.target.value)}
          placeholder="Type a message…"
          disabled={streaming}
          className="flex-1 rounded-full border border-gray-300 px-4 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500 disabled:opacity-50"
        />
        <button
          type="submit"
          disabled={streaming || !input.trim()}
          className="rounded-full bg-indigo-600 px-4 py-2 text-sm font-medium text-white hover:bg-indigo-700 disabled:opacity-40"
        >
          Send
        </button>
      </form>
    </div>
  );
}
