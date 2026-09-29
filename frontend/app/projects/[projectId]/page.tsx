'use client';

import { useEffect, useMemo, useState } from 'react';
import { useParams, useRouter } from 'next/navigation';
import CodeMirror from '@uiw/react-codemirror';
import { html as htmlLang } from '@codemirror/lang-html';
import { css as cssLang } from '@codemirror/lang-css';
import { createClient } from '@/lib/supabase/client';
import MessageContent from '@/components/MessageContent';

interface CriterionResult { criterion: string; met: boolean; note: string }
interface Review { passed: boolean; feedback: string; criteriaResults: CriterionResult[] }
interface Project {
  id: number; slug: string; title: string; brief: string;
  starter: { html?: string; css?: string };
  acceptance_criteria: string[];
}

export default function ProjectPage() {
  const { projectId } = useParams<{ projectId: string }>();
  const router = useRouter();
  const supabase = createClient();

  const [project, setProject] = useState<Project | null>(null);
  const [html, setHtml] = useState('');
  const [css, setCss] = useState('');
  const [doc, setDoc] = useState('');
  const [review, setReview] = useState<Review | null>(null);
  const [submitting, setSubmitting] = useState(false);
  const [loading, setLoading] = useState(true);

  // Load project + any previous submission.
  useEffect(() => {
    async function init() {
      const { data: { session } } = await supabase.auth.getSession();
      if (!session) { router.push('/auth/login'); return; }
      const res = await fetch(`/api/projects/${projectId}`, {
        headers: { Authorization: `Bearer ${session.access_token}` },
      });
      if (!res.ok) { router.push('/dashboard'); return; }
      const { project: p, submission } = await res.json();
      setProject(p);
      const content = submission?.content ?? {};
      setHtml(content.html ?? p.starter?.html ?? '');
      setCss(content.css ?? p.starter?.css ?? '');
      if (submission) {
        setReview({
          passed: submission.passed,
          feedback: submission.feedback ?? '',
          criteriaResults: submission.criteria_results ?? [],
        });
      }
      setLoading(false);
    }
    init();
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [projectId]);

  const srcDoc = useMemo(
    () => `<!DOCTYPE html><html><head><meta charset="utf-8"><style>${css}</style></head><body>${html}</body></html>`,
    [html, css]
  );
  useEffect(() => {
    const t = setTimeout(() => setDoc(srcDoc), 300);
    return () => clearTimeout(t);
  }, [srcDoc]);

  async function submit() {
    if (submitting) return;
    const { data: { session } } = await supabase.auth.getSession();
    if (!session) return;
    setSubmitting(true);
    try {
      const res = await fetch(`/api/projects/${projectId}/submit`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${session.access_token}` },
        body: JSON.stringify({ html, css }),
      });
      if (res.ok) setReview(await res.json());
    } finally {
      setSubmitting(false);
    }
  }

  if (loading || !project) {
    return <div className="min-h-screen flex items-center justify-center bg-gray-900 text-gray-400">Loading project…</div>;
  }

  // Prefer per-criterion review results; otherwise show the plain checklist.
  const checklist = review?.criteriaResults?.length
    ? review.criteriaResults
    : project.acceptance_criteria.map((c) => ({ criterion: c, met: false, note: '' }));

  return (
    <div className="flex flex-col h-screen bg-gray-900 text-gray-100">
      <header className="flex items-center justify-between px-4 py-2 bg-gray-800 border-b border-gray-700">
        <div className="flex items-center gap-3">
          <button
            onClick={() => router.push('/dashboard')}
            className="flex items-center gap-1.5 rounded-md border border-gray-600 bg-gray-700 px-3 py-1.5 text-sm font-medium text-gray-100 hover:bg-gray-600 hover:border-gray-500"
          >
            ← Dashboard
          </button>
          <span className="text-sm font-medium text-gray-200">Project · {project.title}</span>
        </div>
        <button
          onClick={submit}
          disabled={submitting}
          className="rounded-md bg-green-600 px-4 py-1.5 text-sm font-medium text-white hover:bg-green-700 disabled:opacity-50"
        >
          {submitting ? 'Reviewing…' : 'Submit for review'}
        </button>
      </header>

      <div className="flex flex-col lg:flex-row flex-1 overflow-hidden">
        {/* Brief + criteria + feedback */}
        <aside className="lg:w-80 shrink-0 border-b lg:border-b-0 lg:border-r border-gray-700 overflow-y-auto bg-gray-800 p-4 text-sm">
          <div className="prose-invert max-w-none text-gray-200">
            <MessageContent text={project.brief} />
          </div>

          {review && (
            <div className={`mt-4 rounded-md border p-3 ${review.passed ? 'border-green-600 bg-green-950/40' : 'border-amber-600 bg-amber-950/30'}`}>
              <p className={`text-sm font-semibold ${review.passed ? 'text-green-300' : 'text-amber-300'}`}>
                {review.passed ? '✓ Project passed!' : 'Almost there — see notes below'}
              </p>
              {review.feedback && <p className="mt-1 text-xs text-gray-300">{review.feedback}</p>}
            </div>
          )}

          <div className="mt-4">
            <p className="mb-2 text-xs font-semibold uppercase tracking-wide text-gray-400">Acceptance criteria</p>
            <ul className="space-y-2">
              {checklist.map((c, i) => (
                <li key={i} className="flex gap-2 text-xs">
                  <span className={review ? (c.met ? 'text-green-400' : 'text-red-400') : 'text-gray-500'}>
                    {review ? (c.met ? '✓' : '✗') : '○'}
                  </span>
                  <span className="flex-1">
                    <span className="text-gray-200">{c.criterion}</span>
                    {review && c.note && <span className="block text-gray-500">{c.note}</span>}
                  </span>
                </li>
              ))}
            </ul>
          </div>
        </aside>

        {/* Workspace: editors + preview */}
        <div className="flex flex-col md:flex-row flex-1 overflow-hidden">
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
          <div className="flex flex-col flex-1 min-h-0">
            <div className="px-3 py-1.5 bg-gray-800 text-xs text-gray-400 border-b border-gray-700">Preview</div>
            <iframe title="preview" sandbox="allow-scripts" srcDoc={doc} className="flex-1 w-full bg-white" />
          </div>
        </div>
      </div>
    </div>
  );
}
