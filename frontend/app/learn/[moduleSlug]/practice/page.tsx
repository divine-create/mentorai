'use client';

import { useEffect, useMemo, useRef, useState } from 'react';
import { useParams, useRouter } from 'next/navigation';
import { createClient } from '@/lib/supabase/client';
import MathGrapher from '@/components/MathGrapher';

// Math practice workspace — the 'problem' subjects' counterpart to the Python
// coding environment. The learner graphs functions and jots working, then hands
// it back to the tutor to discuss.
export default function MathPracticePage() {
  const { moduleSlug } = useParams<{ moduleSlug: string }>();
  const router = useRouter();
  const supabase = createClient();

  const exprKey = `mentorai:mathexpr:${moduleSlug}`;
  const notesKey = `mentorai:mathnotes:${moduleSlug}`;

  const [rawExpr, setRawExpr] = useState('y = x^2 - 4\ny = 2x + 3');
  const [notes, setNotes] = useState('');
  const [moduleTitle, setModuleTitle] = useState('');
  const [sessionId, setSessionId] = useState<string | null>(null);
  const closedRef = useRef(false);

  // One function per line; tolerate a leading "y =".
  const expressions = useMemo(
    () => rawExpr.split('\n').map((l) => l.trim()).filter(Boolean).map((l) => l.replace(/^y\s*=\s*/i, '')),
    [rawExpr]
  );

  // Restore any saved draft.
  useEffect(() => {
    const e = localStorage.getItem(exprKey);
    const n = localStorage.getItem(notesKey);
    if (e !== null) setRawExpr(e);
    if (n !== null) setNotes(n);
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [moduleSlug]);

  useEffect(() => { localStorage.setItem(exprKey, rawExpr); /* eslint-disable-next-line */ }, [rawExpr]);
  useEffect(() => { localStorage.setItem(notesKey, notes); /* eslint-disable-next-line */ }, [notes]);

  // Bootstrap a tutoring session for this module (so "Discuss" lands in context).
  useEffect(() => {
    async function init() {
      const { data: { session } } = await supabase.auth.getSession();
      if (!session) { router.push('/auth/login'); return; }
      const pathRes = await fetch(`/api/path`, {
        headers: { Authorization: `Bearer ${session.access_token}` },
      });
      const pathData = await pathRes.json();
      const mod = pathData.modules.find((m: { slug: string; id: number; title: string }) => m.slug === moduleSlug);
      if (!mod) { router.push('/dashboard'); return; }
      setModuleTitle(mod.title);
      const sessRes = await fetch(`/api/tutor/session`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${session.access_token}` },
        body: JSON.stringify({ moduleId: mod.id }),
      });
      const { sessionId: sid } = await sessRes.json().catch(() => ({}));
      if (sid) setSessionId(sid);
    }
    init();
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [moduleSlug]);

  // Close session on leave (keeps time/streak tracking accurate). Staying within
  // this lesson — back to the chat or a sibling tool — must NOT close it, or the
  // chat restarts on return. Only close when truly leaving the module.
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

  function discussWithTutor() {
    sessionStorage.setItem(
      `mentorai:discuss:${moduleSlug}`,
      JSON.stringify({ kind: 'math', expressions, notes })
    );
    router.push(`/learn/${moduleSlug}`);
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
          <span className="text-sm font-medium text-gray-200">Math Workspace</span>
          {moduleTitle && <span className="text-xs text-gray-500 hidden sm:inline">· {moduleTitle}</span>}
        </div>
        <button
          onClick={discussWithTutor}
          className="rounded-md bg-indigo-600 px-3 py-1.5 text-sm font-medium text-white hover:bg-indigo-700"
        >
          Discuss with tutor →
        </button>
      </header>

      {/* Split pane */}
      <div className="flex flex-col md:flex-row flex-1 overflow-hidden">
        {/* Inputs */}
        <div className="flex flex-col flex-1 min-h-0 border-b md:border-b-0 md:border-r border-gray-700 overflow-y-auto">
          <div className="px-3 py-1.5 bg-gray-800 text-xs text-gray-400">Functions to graph (one per line)</div>
          <textarea
            value={rawExpr}
            onChange={(e) => setRawExpr(e.target.value)}
            spellCheck={false}
            placeholder={'y = x^2 - 4\ny = 2x + 3'}
            className="resize-none bg-gray-900 p-4 font-mono text-sm text-gray-100 focus:outline-none leading-relaxed h-32"
          />
          <p className="px-4 pb-2 text-[11px] text-gray-500">
            Use <code className="text-gray-400">x</code> as the variable. Supports <code className="text-gray-400">^</code>,
            {' '}<code className="text-gray-400">sqrt()</code>, <code className="text-gray-400">sin()</code>,
            {' '}<code className="text-gray-400">abs()</code>, etc. Window is −10…10.
          </p>

          <div className="px-3 py-1.5 bg-gray-800 text-xs text-gray-400 border-t border-gray-700">Your working / notes</div>
          <textarea
            value={notes}
            onChange={(e) => setNotes(e.target.value)}
            spellCheck={false}
            placeholder="Show your steps here — e.g. factor, substitute, solve…"
            className="flex-1 min-h-[120px] resize-none bg-gray-900 p-4 text-sm text-gray-100 focus:outline-none leading-relaxed"
          />
        </div>

        {/* Graph */}
        <div className="flex flex-col flex-1 min-h-0 overflow-y-auto">
          <div className="px-3 py-1.5 bg-gray-800 text-xs text-gray-400 border-b border-gray-700">Graph</div>
          <div className="p-4">
            <MathGrapher expressions={expressions} />
            <div className="mt-3 space-y-1 text-xs">
              {expressions.length === 0 && <p className="text-gray-500">Type a function above to plot it.</p>}
              {expressions.map((e, i) => (
                <p key={i} className="font-mono text-gray-300">
                  <span className="inline-block h-2 w-2 rounded-full align-middle mr-2" style={{ backgroundColor: ['#818cf8', '#f472b6', '#34d399', '#fbbf24', '#22d3ee'][i % 5] }} />
                  y = {e}
                </p>
              ))}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
