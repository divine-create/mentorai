'use client';

import { useEffect, useMemo, useRef, useState } from 'react';
import { useParams, useRouter } from 'next/navigation';
import CodeMirror from '@uiw/react-codemirror';
import { html as htmlLang } from '@codemirror/lang-html';
import { css as cssLang } from '@codemirror/lang-css';
import { createClient } from '@/lib/supabase/client';

// HTML/CSS live-preview playground — the 'web' subjects' practice surface.
// Two editors feed a sandboxed iframe; the learner can hand their markup back to
// the tutor to discuss.
const STARTER_HTML = `<h1>Hello, web!</h1>
<p>Edit the HTML and CSS to see the page update live.</p>
<button class="cta">Click me</button>`;

const STARTER_CSS = `body { font-family: system-ui, sans-serif; padding: 1.5rem; }
h1 { color: #4f46e5; }
.cta {
  padding: 8px 16px;
  border: none;
  border-radius: 6px;
  background: #4f46e5;
  color: white;
}`;

export default function WebPlaygroundPage() {
  const { moduleSlug } = useParams<{ moduleSlug: string }>();
  const router = useRouter();
  const supabase = createClient();

  const htmlKey = `mentorai:webhtml:${moduleSlug}`;
  const cssKey = `mentorai:webcss:${moduleSlug}`;

  const [html, setHtml] = useState(STARTER_HTML);
  const [css, setCss] = useState(STARTER_CSS);
  const [doc, setDoc] = useState('');
  const [moduleTitle, setModuleTitle] = useState('');
  const [sessionId, setSessionId] = useState<string | null>(null);
  const closedRef = useRef(false);

  // Restore saved draft.
  useEffect(() => {
    const h = localStorage.getItem(htmlKey);
    const c = localStorage.getItem(cssKey);
    if (h !== null) setHtml(h);
    if (c !== null) setCss(c);
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [moduleSlug]);

  useEffect(() => { localStorage.setItem(htmlKey, html); /* eslint-disable-next-line */ }, [html]);
  useEffect(() => { localStorage.setItem(cssKey, css); /* eslint-disable-next-line */ }, [css]);

  // Debounce the rendered document so the iframe doesn't reload on every keypress.
  const srcDoc = useMemo(
    () => `<!DOCTYPE html><html><head><meta charset="utf-8"><style>${css}</style></head><body>${html}</body></html>`,
    [html, css]
  );
  useEffect(() => {
    const t = setTimeout(() => setDoc(srcDoc), 300);
    return () => clearTimeout(t);
  }, [srcDoc]);

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

  // Close session on leave. Staying within this lesson — back to the chat or a
  // sibling tool — must NOT close it, or the chat restarts on return. Only close
  // when truly leaving the module.
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
    sessionStorage.setItem(`mentorai:discuss:${moduleSlug}`, JSON.stringify({ kind: 'web', html, css }));
    router.push(`/learn/${moduleSlug}`);
  }

  function reset() {
    setHtml(STARTER_HTML);
    setCss(STARTER_CSS);
    localStorage.removeItem(htmlKey);
    localStorage.removeItem(cssKey);
  }

  return (
    <div className="flex flex-col h-screen bg-gray-900 text-gray-100">
      <header className="flex items-center justify-between px-4 py-2 bg-gray-800 border-b border-gray-700">
        <div className="flex items-center gap-3">
          <button
            onClick={() => router.push(`/learn/${moduleSlug}`)}
            className="flex items-center gap-1.5 rounded-md border border-gray-600 bg-gray-700 px-3 py-1.5 text-sm font-medium text-gray-100 hover:bg-gray-600 hover:border-gray-500"
          >
            ← Back to chat
          </button>
          <span className="text-sm font-medium text-gray-200">HTML/CSS Playground</span>
          {moduleTitle && <span className="text-xs text-gray-500 hidden sm:inline">· {moduleTitle}</span>}
        </div>
        <div className="flex items-center gap-3">
          <button onClick={reset} className="text-gray-400 hover:text-white text-sm" title="Reset to starter">↺ Reset</button>
          <button
            onClick={discussWithTutor}
            className="rounded-md bg-indigo-600 px-3 py-1.5 text-sm font-medium text-white hover:bg-indigo-700"
          >
            Discuss with tutor →
          </button>
        </div>
      </header>

      <div className="flex flex-col md:flex-row flex-1 overflow-hidden">
        {/* Editors */}
        <div className="flex flex-col flex-1 min-h-0 border-b md:border-b-0 md:border-r border-gray-700">
          <div className="px-3 py-1.5 bg-gray-800 text-xs text-gray-400">index.html</div>
          <div className="flex-1 min-h-0 overflow-auto bg-gray-900">
            <CodeMirror value={html} onChange={setHtml} extensions={[htmlLang()]} theme="dark" height="100%" className="h-full text-sm" />
          </div>
          <div className="px-3 py-1.5 bg-gray-800 text-xs text-gray-400 border-t border-gray-700">style.css</div>
          <div className="flex-1 min-h-0 overflow-auto bg-gray-900">
            <CodeMirror value={css} onChange={setCss} extensions={[cssLang()]} theme="dark" height="100%" className="h-full text-sm" />
          </div>
        </div>

        {/* Live preview */}
        <div className="flex flex-col flex-1 min-h-0">
          <div className="px-3 py-1.5 bg-gray-800 text-xs text-gray-400 border-b border-gray-700">Preview</div>
          <iframe
            title="preview"
            sandbox="allow-scripts"
            srcDoc={doc}
            className="flex-1 w-full bg-white"
          />
        </div>
      </div>
    </div>
  );
}
