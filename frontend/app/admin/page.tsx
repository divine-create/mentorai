'use client';

import { useEffect, useRef, useState } from 'react';
import Link from 'next/link';
import { useRouter } from 'next/navigation';
import { createClient } from '@/lib/supabase/client';
import type { Subject } from '@/lib/types';
import AnalyticsTab from './AnalyticsTab';
import UsersTab from './UsersTab';
import ContentTab from './ContentTab';
import SettingsTab from './SettingsTab';

interface Book {
  id: number;
  title: string;
  status: 'processing' | 'ready' | 'failed';
  num_chunks: number;
  error: string | null;
  subject_name: string | null;
  subject_id: number | null;
  created_at: string;
  course_status: 'none' | 'building' | 'built' | 'failed';
  course_error: string | null;
  num_modules: number;
  num_questions: number;
}
interface Hit { id: number; content: string; chapter: string | null; score: number }
interface CourseQuestion { id: string; type: string; difficulty: string; prompt: string; options: { label: string; text: string }[] | null; correct_answer: string | null }
interface CourseModule { id: number; title: string; description: string; questions: CourseQuestion[] }

const API = "";

type Tab = 'books' | 'analytics' | 'users' | 'content' | 'settings';

const TABS: { key: Tab; label: string; icon: string }[] = [
  { key: 'books', label: 'Books', icon: '📚' },
  { key: 'analytics', label: 'Analytics', icon: '📊' },
  { key: 'users', label: 'Users', icon: '👥' },
  { key: 'content', label: 'Content', icon: '🎯' },
  { key: 'settings', label: 'Settings', icon: '⚙️' },
];

export default function AdminPage() {
  const supabase = createClient();
  const router = useRouter();

  const [authed, setAuthed] = useState(false);
  const [loading, setLoading] = useState(true);
  const [subjects, setSubjects] = useState<Subject[]>([]);
  const [books, setBooks] = useState<Book[]>([]);
  const [tab, setTab] = useState<Tab>('books');

  // upload form
  const [title, setTitle] = useState('');
  const [target, setTarget] = useState(''); // subject id, or '__new__'
  const [newSubject, setNewSubject] = useState('');
  const [uploading, setUploading] = useState(false);
  const [uploadError, setUploadError] = useState('');
  const fileRef = useRef<HTMLInputElement>(null);

  // test grounding
  const [testFor, setTestFor] = useState<number | null>(null);
  const [testQuery, setTestQuery] = useState('');
  const [testHits, setTestHits] = useState<Hit[] | null>(null);
  const [testing, setTesting] = useState(false);

  // course review
  const [courseFor, setCourseFor] = useState<number | null>(null);
  const [courseData, setCourseData] = useState<CourseModule[] | null>(null);

  async function token() {
    const { data: { session } } = await supabase.auth.getSession();
    return session?.access_token ?? null;
  }

  async function loadBooks(t: string) {
    const res = await fetch(`${API}/api/admin/books`, { headers: { Authorization: `Bearer ${t}` } });
    if (res.ok) setBooks((await res.json()).books ?? []);
  }

  useEffect(() => {
    async function init() {
      const t = await token();
      if (!t) { router.push('/auth/login'); return; }
      const me = await fetch(`${API}/api/admin/me`, { headers: { Authorization: `Bearer ${t}` } });
      if (!me.ok) { router.push('/dashboard'); return; }
      setAuthed(true);
      const subjRes = await fetch(`${API}/api/subjects`, { headers: { Authorization: `Bearer ${t}` } });
      if (subjRes.ok) setSubjects(await subjRes.json());
      await loadBooks(t);
      setLoading(false);
    }
    init();
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  // Poll while any book is still ingesting or building a course.
  useEffect(() => {
    if (!books.some((b) => b.status === 'processing' || b.course_status === 'building')) return;
    const iv = setInterval(async () => {
      const t = await token();
      if (t) await loadBooks(t);
    }, 2500);
    return () => clearInterval(iv);
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [books]);

  async function upload(e: React.FormEvent) {
    e.preventDefault();
    setUploadError('');
    const file = fileRef.current?.files?.[0];
    if (!file) { setUploadError('Choose a file'); return; }
    if (!title.trim()) { setUploadError('Enter a title'); return; }
    if (!target) { setUploadError('Choose a target subject'); return; }
    if (target === '__new__' && !newSubject.trim()) { setUploadError('Enter the new subject name'); return; }

    const t = await token();
    if (!t) return;

    const form = new FormData();
    form.append('file', file);
    form.append('title', title.trim());
    if (target === '__new__') form.append('newSubject', newSubject.trim());
    else form.append('subjectId', target);

    setUploading(true);
    try {
      const res = await fetch(`${API}/api/admin/books`, {
        method: 'POST',
        headers: { Authorization: `Bearer ${t}` },
        body: form,
      });
      if (!res.ok) {
        setUploadError((await res.json().catch(() => ({}))).error ?? 'Upload failed');
        return;
      }
      setTitle(''); setNewSubject(''); setTarget('');
      if (fileRef.current) fileRef.current.value = '';
      await loadBooks(t);
    } finally {
      setUploading(false);
    }
  }

  async function remove(id: number) {
    if (!confirm('Delete this book and all its passages?')) return;
    const t = await token();
    if (!t) return;
    await fetch(`${API}/api/admin/books/${id}`, { method: 'DELETE', headers: { Authorization: `Bearer ${t}` } });
    await loadBooks(t);
  }

  async function buildCourse(id: number) {
    const t = await token();
    if (!t) return;
    await fetch(`${API}/api/admin/books/${id}/build-course`, {
      method: 'POST',
      headers: { Authorization: `Bearer ${t}` },
    });
    await loadBooks(t); // status flips to 'building'; the poll takes over
  }

  async function loadCourseData(id: number) {
    const t = await token();
    if (!t) return;
    const res = await fetch(`${API}/api/admin/books/${id}/course`, { headers: { Authorization: `Bearer ${t}` } });
    if (res.ok) setCourseData((await res.json()).modules ?? []);
  }

  async function reviewCourse(id: number) {
    if (courseFor === id) { setCourseFor(null); setCourseData(null); return; }
    setCourseFor(id);
    setCourseData(null);
    await loadCourseData(id);
  }

  async function addQuestion(moduleId: number, bookId: number) {
    const t = await token();
    if (!t) return;
    await fetch(`${API}/api/admin/modules/${moduleId}/questions`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${t}` },
      body: JSON.stringify({ type: 'short_answer', difficulty: 'applied', prompt: 'New question', correct_answer: '' }),
    });
    await loadCourseData(bookId);
  }

  async function runTest(id: number) {
    if (!testQuery.trim()) return;
    const t = await token();
    if (!t) return;
    setTesting(true);
    setTestHits(null);
    try {
      const res = await fetch(`${API}/api/admin/books/${id}/test`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${t}` },
        body: JSON.stringify({ query: testQuery.trim() }),
      });
      if (res.ok) setTestHits((await res.json()).hits ?? []);
    } finally {
      setTesting(false);
    }
  }

  if (loading || !authed) {
    return <div className="min-h-screen flex items-center justify-center text-gray-400">Loading…</div>;
  }

  return (
    <div className="min-h-screen bg-gray-50">
      <nav className="bg-white border-b border-gray-200 px-6 py-3 flex items-center justify-between">
        <span className="font-bold text-indigo-600">The AI Academy · Admin</span>
        <Link href="/dashboard" className="text-sm text-gray-500 hover:text-gray-700">← Dashboard</Link>
      </nav>

      {/* Tab bar */}
      <div className="bg-white border-b border-gray-200">
        <div className="max-w-5xl mx-auto px-6">
          <div className="flex gap-1 -mb-px overflow-x-auto">
            {TABS.map((t) => (
              <button
                key={t.key}
                onClick={() => setTab(t.key)}
                className={`px-4 py-3 text-sm font-medium border-b-2 transition-colors whitespace-nowrap ${
                  tab === t.key
                    ? 'border-indigo-600 text-indigo-700'
                    : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300'
                }`}
              >
                <span className="mr-1.5">{t.icon}</span>{t.label}
              </button>
            ))}
          </div>
        </div>
      </div>

      <div className="max-w-5xl mx-auto px-6 py-8">
        {tab === 'books' && (
        <div className="space-y-8">
        {/* Upload */}
        <section className="rounded-2xl bg-white border border-gray-100 p-6">
          <h2 className="font-semibold text-gray-800 mb-1">Add a book</h2>
          <p className="text-sm text-gray-500 mb-4">
            Upload a PDF, EPUB, Markdown, or text file. The mentor will teach grounded in it — learners never see the book.
            Use only public-domain, owned, or licensed material.
          </p>
          <form onSubmit={upload} className="space-y-3">
            <input
              type="text" placeholder="Book title (internal label)"
              value={title} onChange={(e) => setTitle(e.target.value)}
              className="w-full border border-gray-300 rounded-md px-3 py-2 text-sm"
            />
            <div className="flex flex-col sm:flex-row gap-3">
              <select
                value={target} onChange={(e) => setTarget(e.target.value)}
                className="flex-1 border border-gray-300 rounded-md px-3 py-2 text-sm bg-white"
              >
                <option value="">Target subject…</option>
                {subjects.map((s) => (
                  <option key={s.id} value={s.id}>{s.icon} {s.name}</option>
                ))}
                <option value="__new__">+ New subject…</option>
              </select>
              {target === '__new__' && (
                <input
                  type="text" placeholder="New subject name"
                  value={newSubject} onChange={(e) => setNewSubject(e.target.value)}
                  className="flex-1 border border-gray-300 rounded-md px-3 py-2 text-sm"
                />
              )}
            </div>
            <input ref={fileRef} type="file" accept=".pdf,.epub,.txt,.md,.markdown,application/pdf,application/epub+zip,text/plain,text/markdown"
              className="block w-full text-sm text-gray-600 file:mr-3 file:rounded-md file:border-0 file:bg-indigo-50 file:px-3 file:py-2 file:text-indigo-700" />
            {uploadError && <p className="text-sm text-red-600">{uploadError}</p>}
            <button
              type="submit" disabled={uploading}
              className="rounded-md bg-indigo-600 text-white px-5 py-2 text-sm font-medium hover:bg-indigo-700 disabled:opacity-50"
            >
              {uploading ? 'Uploading…' : 'Upload & process'}
            </button>
          </form>
        </section>

        {/* Book list */}
        <section className="rounded-2xl bg-white border border-gray-100 p-6">
          <h2 className="font-semibold text-gray-800 mb-4">Books</h2>
          {books.length === 0 ? (
            <p className="text-sm text-gray-400">No books uploaded yet.</p>
          ) : (
            <div className="space-y-3">
              {books.map((b) => (
                <div key={b.id} className="rounded-xl border border-gray-100 p-4">
                  <div className="flex items-center justify-between gap-3">
                    <div className="min-w-0">
                      <p className="text-sm font-medium text-gray-800 truncate">{b.title}</p>
                      <p className="text-xs text-gray-500">{b.subject_name ?? 'No subject'} · {b.num_chunks} passages</p>
                    </div>
                    <div className="flex items-center gap-2 shrink-0">
                      <StatusBadge status={b.status} />
                      {b.status === 'ready' && (
                        <button onClick={() => { setTestFor(testFor === b.id ? null : b.id); setTestHits(null); setTestQuery(''); }}
                          className="text-xs text-indigo-600 hover:underline">Test</button>
                      )}
                      <button onClick={() => remove(b.id)} className="text-xs text-red-500 hover:underline">Delete</button>
                    </div>
                  </div>
                  {b.status === 'failed' && b.error && (
                    <p className="mt-2 text-xs text-red-600">{b.error}</p>
                  )}

                  {/* Course generation */}
                  {b.status === 'ready' && (
                    <div className="mt-3 border-t border-gray-100 pt-3">
                      <div className="flex items-center gap-2 flex-wrap">
                        <span className="text-xs text-gray-500">Course:</span>
                        <CourseBadge status={b.course_status} />
                        {b.course_status === 'built' && (
                          <span className="text-xs text-gray-500">{b.num_modules} modules · {b.num_questions} questions</span>
                        )}
                        <button onClick={() => buildCourse(b.id)} disabled={b.course_status === 'building'}
                          className="text-xs text-indigo-600 hover:underline disabled:opacity-50 disabled:no-underline">
                          {b.course_status === 'building' ? 'Building…' : b.course_status === 'built' ? 'Rebuild' : 'Generate course'}
                        </button>
                        {b.course_status === 'built' && (
                          <button onClick={() => reviewCourse(b.id)} className="text-xs text-indigo-600 hover:underline">
                            {courseFor === b.id ? 'Hide' : 'Review'}
                          </button>
                        )}
                      </div>
                      {b.course_status === 'failed' && b.course_error && (
                        <p className="mt-1 text-xs text-red-600">{b.course_error}</p>
                      )}
                      {courseFor === b.id && (
                        <div className="mt-3 space-y-3">
                          {!courseData && <p className="text-xs text-gray-400">Loading…</p>}
                          {courseData?.map((m) => (
                            <div key={m.id} className="rounded-md bg-gray-50 p-3">
                              <p className="text-xs font-semibold text-gray-800 mb-2">{m.title}</p>
                              <div className="space-y-2">
                                {m.questions.map((q) => (
                                  <QuestionEditor key={q.id} q={q} onChanged={() => loadCourseData(b.id)} />
                                ))}
                              </div>
                              <button onClick={() => addQuestion(m.id, b.id)} className="mt-2 text-xs text-indigo-600 hover:underline">
                                + Add question
                              </button>
                            </div>
                          ))}
                        </div>
                      )}
                    </div>
                  )}

                  {testFor === b.id && b.status === 'ready' && (
                    <div className="mt-3 border-t border-gray-100 pt-3">
                      <div className="flex gap-2">
                        <input
                          type="text" placeholder="Ask something the book covers…"
                          value={testQuery} onChange={(e) => setTestQuery(e.target.value)}
                          onKeyDown={(e) => e.key === 'Enter' && runTest(b.id)}
                          className="flex-1 border border-gray-300 rounded-md px-3 py-1.5 text-sm"
                        />
                        <button onClick={() => runTest(b.id)} disabled={testing}
                          className="rounded-md bg-gray-800 text-white px-3 py-1.5 text-sm disabled:opacity-50">
                          {testing ? '…' : 'Retrieve'}
                        </button>
                      </div>
                      {testHits && (
                        <ul className="mt-3 space-y-2">
                          {testHits.length === 0 && <li className="text-xs text-gray-400">No passages found.</li>}
                          {testHits.map((h) => (
                            <li key={h.id} className="text-xs text-gray-600 bg-gray-50 rounded-md p-2">
                              <span className="text-gray-400">{h.chapter ?? '—'} · score {h.score.toFixed(3)}</span>
                              <p className="mt-1 line-clamp-3">{h.content}</p>
                            </li>
                          ))}
                        </ul>
                      )}
                    </div>
                  )}
                </div>
              ))}
            </div>
          )}
        </section>
        </div>
        )}

        {tab === 'analytics' && <AnalyticsTab />}
        {tab === 'users' && <UsersTab />}
        {tab === 'content' && <ContentTab />}
        {tab === 'settings' && <SettingsTab />}
      </div>
    </div>
  );
}

function StatusBadge({ status }: { status: Book['status'] }) {
  const map = {
    processing: ['Processing', 'bg-amber-100 text-amber-700'],
    ready: ['Ready', 'bg-green-100 text-green-700'],
    failed: ['Failed', 'bg-red-100 text-red-700'],
  } as const;
  const [label, cls] = map[status];
  return <span className={`rounded-full px-2 py-0.5 text-xs font-medium ${cls}`}>{label}</span>;
}

function CourseBadge({ status }: { status: Book['course_status'] }) {
  const map = {
    none: ['Not built', 'bg-gray-100 text-gray-500'],
    building: ['Building…', 'bg-amber-100 text-amber-700'],
    built: ['Built', 'bg-green-100 text-green-700'],
    failed: ['Failed', 'bg-red-100 text-red-700'],
  } as const;
  const [label, cls] = map[status];
  return <span className={`rounded-full px-2 py-0.5 text-xs font-medium ${cls}`}>{label}</span>;
}

// Inline editor for one generated question: tweak type/difficulty/prompt,
// edit multiple-choice options and mark the correct one, save or delete.
function QuestionEditor({ q, onChanged }: { q: CourseQuestion; onChanged: () => void }) {
  const supabase = createClient();
  const [type, setType] = useState(q.type);
  const [difficulty, setDifficulty] = useState(q.difficulty);
  const [prompt, setPrompt] = useState(q.prompt);
  const [options, setOptions] = useState<string[]>(q.options?.map((o) => o.text) ?? ['', '', '', '']);
  const [correct, setCorrect] = useState(q.correct_answer ?? '');
  const [busy, setBusy] = useState(false);
  const isMC = type === 'multiple_choice';

  async function tk() {
    const { data: { session } } = await supabase.auth.getSession();
    return session?.access_token ?? null;
  }

  async function save() {
    const t = await tk();
    if (!t) return;
    setBusy(true);
    const body: Record<string, unknown> = { type, difficulty, prompt };
    if (isMC) {
      const clean = options.map((s) => s.trim()).filter(Boolean).slice(0, 6);
      body.options = clean.map((text, i) => ({ label: String.fromCharCode(65 + i), text }));
      body.correct_answer = clean.includes(correct) ? correct : (clean[0] ?? '');
    } else {
      body.options = null;
      body.correct_answer = correct || null;
    }
    try {
      await fetch(`${API}/api/admin/questions/${q.id}`, {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${t}` },
        body: JSON.stringify(body),
      });
      onChanged();
    } finally {
      setBusy(false);
    }
  }

  async function del() {
    if (!confirm('Delete this question?')) return;
    const t = await tk();
    if (!t) return;
    setBusy(true);
    await fetch(`${API}/api/admin/questions/${q.id}`, { method: 'DELETE', headers: { Authorization: `Bearer ${t}` } });
    onChanged();
  }

  return (
    <div className="rounded-md border border-gray-200 bg-white p-3 space-y-2">
      <div className="flex items-center gap-2">
        <select value={type} onChange={(e) => setType(e.target.value)} className="text-xs border border-gray-300 rounded px-1.5 py-1">
          <option value="multiple_choice">multiple_choice</option>
          <option value="short_answer">short_answer</option>
          <option value="explanation">explanation</option>
        </select>
        <select value={difficulty} onChange={(e) => setDifficulty(e.target.value)} className="text-xs border border-gray-300 rounded px-1.5 py-1">
          <option value="foundational">foundational</option>
          <option value="applied">applied</option>
          <option value="advanced">advanced</option>
        </select>
        <span className="flex-1" />
        <button onClick={del} disabled={busy} className="text-xs text-red-500 hover:underline">Delete</button>
      </div>
      <textarea value={prompt} onChange={(e) => setPrompt(e.target.value)} rows={2}
        className="w-full text-xs border border-gray-300 rounded px-2 py-1.5" />
      {isMC ? (
        <div className="space-y-1">
          {options.map((opt, i) => (
            <div key={i} className="flex items-center gap-2">
              <input type="radio" name={`correct-${q.id}`} checked={correct === opt && opt !== ''} onChange={() => setCorrect(opt)} />
              <input
                value={opt}
                onChange={(e) => {
                  const next = [...options];
                  const old = next[i];
                  next[i] = e.target.value;
                  setOptions(next);
                  if (correct === old) setCorrect(e.target.value);
                }}
                placeholder={`Option ${String.fromCharCode(65 + i)}`}
                className="flex-1 text-xs border border-gray-300 rounded px-2 py-1"
              />
            </div>
          ))}
          <p className="text-[11px] text-gray-400">Select the radio for the correct option.</p>
        </div>
      ) : (
        <input value={correct} onChange={(e) => setCorrect(e.target.value)} placeholder="Correct answer / key points"
          className="w-full text-xs border border-gray-300 rounded px-2 py-1.5" />
      )}
      <button onClick={save} disabled={busy} className="rounded bg-indigo-600 text-white text-xs px-3 py-1 hover:bg-indigo-700 disabled:opacity-50">
        {busy ? 'Saving…' : 'Save'}
      </button>
    </div>
  );
}

