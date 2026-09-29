'use client';

import { useEffect, useState } from 'react';
import { createClient } from '@/lib/supabase/client';

const API = "";

interface Overview { total_users: number; active_7d: number; total_sessions: number; total_books: number }
interface SubjectRow { id: number; name: string; icon: string; modules: number; avg_mastery: number; completions: number }
interface UsageRow { provider: string; model: string; in_tok: number; out_tok: number; calls: number; cost_usd: number | null }
interface QuestionRow { id: string; prompt: string; type: string; difficulty: string; groundedness: number | null; module_title: string; subject_id: number; attempts: number; correct: number }
interface MsgCount { kind: string; up: number; down: number }
interface RecentDown { kind: string; comment: string | null; excerpt: string | null; created_at: string; module_title: string | null }
interface ModuleRatingRow { module_id: number; title: string; responses: number; avg_difficulty: number | null; avg_clarity: number | null; avg_helpfulness: number | null }
interface ModuleComment { comment: string; created_at: string; module_title: string }
interface NpsComment { score: number; comment: string; created_at: string }
interface FeedbackData {
  messages: { counts: MsgCount[]; recentDowns: RecentDown[] };
  modules: { ratings: ModuleRatingRow[]; comments: ModuleComment[] };
  nps: { score: number | null; total: number; promoters: number; detractors: number; histogram: { score: number; n: number }[]; comments: NpsComment[] };
}

export default function AnalyticsTab() {
  const supabase = createClient();
  const [overview, setOverview] = useState<Overview | null>(null);
  const [subs, setSubs] = useState<{ subscription_status: string; n: number }[]>([]);
  const [subjects, setSubjects] = useState<SubjectRow[]>([]);
  const [usage, setUsage] = useState<UsageRow[]>([]);
  const [totalCost, setTotalCost] = useState(0);
  const [questions, setQuestions] = useState<QuestionRow[]>([]);
  const [feedback, setFeedback] = useState<FeedbackData | null>(null);

  async function token() { const { data: { session } } = await supabase.auth.getSession(); return session?.access_token ?? null; }

  useEffect(() => {
    (async () => {
      const t = await token();
      if (!t) return;
      const h = { Authorization: `Bearer ${t}` };
      const [a, u, q, f] = await Promise.all([
        fetch(`${API}/api/admin/analytics`, { headers: h }).then((r) => r.json()),
        fetch(`${API}/api/admin/analytics/usage`, { headers: h }).then((r) => r.json()),
        fetch(`${API}/api/admin/analytics/questions`, { headers: h }).then((r) => r.json()),
        fetch(`${API}/api/admin/analytics/feedback`, { headers: h }).then((r) => r.json()),
      ]);
      setOverview(a.overview); setSubs(a.subscriptions ?? []); setSubjects(a.subjects ?? []);
      setUsage(u.byModel ?? []); setTotalCost(u.totalCostUsd ?? 0);
      setQuestions(q.questions ?? []);
      setFeedback(f && !f.error ? f : null);
    })();
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  // Weakest questions with enough signal: lowest correct-rate among those attempted.
  const weak = questions
    .filter((q) => q.attempts >= 3)
    .map((q) => ({ ...q, rate: q.correct / q.attempts }))
    .sort((a, b) => a.rate - b.rate)
    .slice(0, 12);
  const ungrounded = questions.filter((q) => q.groundedness !== null && q.groundedness < 0.3).slice(0, 12);

  return (
    <div className="space-y-6">
      <div className="grid grid-cols-2 sm:grid-cols-4 gap-3">
        <Card label="Users" value={overview?.total_users ?? 0} />
        <Card label="Active (7d)" value={overview?.active_7d ?? 0} />
        <Card label="Sessions" value={overview?.total_sessions ?? 0} />
        <Card label="Books" value={overview?.total_books ?? 0} />
      </div>

      <Panel title="Subscriptions">
        <div className="flex flex-wrap gap-2">
          {subs.length === 0 && <span className="text-sm text-gray-400">No data</span>}
          {subs.map((s) => (
            <span key={s.subscription_status} className="rounded-full bg-gray-100 px-3 py-1 text-xs text-gray-700">
              {s.subscription_status}: <strong>{s.n}</strong>
            </span>
          ))}
        </div>
      </Panel>

      <Panel title="Subjects">
        <table className="w-full text-sm">
          <thead><tr className="text-left text-xs text-gray-400"><th className="py-1">Subject</th><th>Modules</th><th>Avg mastery</th><th>Completions</th></tr></thead>
          <tbody>
            {subjects.map((s) => (
              <tr key={s.id} className="border-t border-gray-100">
                <td className="py-1.5">{s.icon} {s.name}</td><td>{s.modules}</td><td>{s.avg_mastery}%</td><td>{s.completions}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </Panel>

      <Panel title={`LLM usage — est. cost $${totalCost.toFixed(4)}`}>
        <table className="w-full text-sm">
          <thead><tr className="text-left text-xs text-gray-400"><th className="py-1">Model</th><th>Calls</th><th>In tok</th><th>Out tok</th><th>Cost</th></tr></thead>
          <tbody>
            {usage.length === 0 && <tr><td className="py-1.5 text-gray-400" colSpan={5}>No usage logged yet.</td></tr>}
            {usage.map((u) => (
              <tr key={u.provider + u.model} className="border-t border-gray-100">
                <td className="py-1.5">{u.model}</td><td>{u.calls}</td><td>{u.in_tok.toLocaleString()}</td><td>{u.out_tok.toLocaleString()}</td>
                <td>{u.cost_usd === null ? '—' : `$${u.cost_usd.toFixed(4)}`}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </Panel>

      <Panel title="Weakest questions (lowest correct-rate, ≥3 attempts)">
        {weak.length === 0 ? <p className="text-sm text-gray-400">Not enough attempts yet.</p> : (
          <ul className="space-y-1.5">
            {weak.map((q) => (
              <li key={q.id} className="text-xs text-gray-600">
                <span className="text-red-600 font-medium">{Math.round(q.rate * 100)}%</span>{' '}
                <span className="text-gray-400">({q.correct}/{q.attempts}, {q.module_title})</span> {q.prompt}
              </li>
            ))}
          </ul>
        )}
      </Panel>

      {ungrounded.length > 0 && (
        <Panel title="Possibly ungrounded generated questions (low source support)">
          <ul className="space-y-1.5">
            {ungrounded.map((q) => (
              <li key={q.id} className="text-xs text-gray-600">
                <span className="text-amber-600 font-medium">{q.groundedness!.toFixed(2)}</span>{' '}
                <span className="text-gray-400">({q.module_title})</span> {q.prompt}
              </li>
            ))}
          </ul>
        </Panel>
      )}

      {/* ── Explicit learner feedback ─────────────────────────────────────── */}
      <Panel title="Tutor feedback (👍 / 👎 on replies, hints, solutions)">
        {!feedback || feedback.messages.counts.length === 0 ? (
          <p className="text-sm text-gray-400">No thumbs feedback yet.</p>
        ) : (
          <>
            <div className="flex flex-wrap gap-2 mb-3">
              {feedback.messages.counts.map((c) => {
                const total = c.up + c.down;
                const pct = total > 0 ? Math.round((c.up / total) * 100) : 0;
                return (
                  <span key={c.kind} className="rounded-full bg-gray-100 px-3 py-1 text-xs text-gray-700">
                    {c.kind}: <span className="text-green-600 font-medium">👍 {c.up}</span>{' '}
                    <span className="text-red-600 font-medium">👎 {c.down}</span>{' '}
                    <span className="text-gray-400">({pct}% positive)</span>
                  </span>
                );
              })}
            </div>
            {feedback.messages.recentDowns.length > 0 && (
              <>
                <p className="text-xs text-gray-400 mb-1">Recent 👎</p>
                <ul className="space-y-1.5">
                  {feedback.messages.recentDowns.map((d, i) => (
                    <li key={i} className="text-xs text-gray-600">
                      <span className="text-gray-400">[{d.kind}{d.module_title ? `, ${d.module_title}` : ''}]</span>{' '}
                      {d.comment ? <span className="text-gray-800">“{d.comment}”</span> : <span className="text-gray-400 italic">no comment</span>}
                      {d.excerpt && <span className="block text-gray-400 line-clamp-2 mt-0.5">{d.excerpt}</span>}
                    </li>
                  ))}
                </ul>
              </>
            )}
          </>
        )}
      </Panel>

      <Panel title="Module ratings (avg of 1–5)">
        {!feedback || feedback.modules.ratings.length === 0 ? (
          <p className="text-sm text-gray-400">No module ratings yet.</p>
        ) : (
          <table className="w-full text-sm">
            <thead><tr className="text-left text-xs text-gray-400"><th className="py-1">Module</th><th>Responses</th><th>Difficulty</th><th>Clarity</th><th>Helpfulness</th></tr></thead>
            <tbody>
              {feedback.modules.ratings.map((m) => (
                <tr key={m.module_id} className="border-t border-gray-100">
                  <td className="py-1.5">{m.title}</td><td>{m.responses}</td>
                  <td>{m.avg_difficulty ?? '—'}</td><td>{m.avg_clarity ?? '—'}</td><td>{m.avg_helpfulness ?? '—'}</td>
                </tr>
              ))}
            </tbody>
          </table>
        )}
        {feedback && feedback.modules.comments.length > 0 && (
          <ul className="mt-3 space-y-1.5">
            {feedback.modules.comments.map((c, i) => (
              <li key={i} className="text-xs text-gray-600">
                <span className="text-gray-400">({c.module_title})</span> “{c.comment}”
              </li>
            ))}
          </ul>
        )}
      </Panel>

      <Panel title="Net Promoter Score">
        {!feedback || feedback.nps.total === 0 ? (
          <p className="text-sm text-gray-400">No NPS responses yet.</p>
        ) : (
          <>
            <div className="flex items-baseline gap-3 mb-3">
              <span className={`text-3xl font-bold ${
                (feedback.nps.score ?? 0) >= 50 ? 'text-green-600' : (feedback.nps.score ?? 0) >= 0 ? 'text-amber-600' : 'text-red-600'
              }`}>{feedback.nps.score ?? '—'}</span>
              <span className="text-xs text-gray-400">
                {feedback.nps.total} responses · {feedback.nps.promoters} promoters · {feedback.nps.detractors} detractors
              </span>
            </div>
            <div className="flex items-end gap-1 h-16">
              {Array.from({ length: 11 }, (_, n) => {
                const row = feedback.nps.histogram.find((x) => x.score === n);
                const count = row?.n ?? 0;
                const max = Math.max(1, ...feedback.nps.histogram.map((x) => x.n));
                const color = n >= 9 ? 'bg-green-500' : n >= 7 ? 'bg-gray-300' : 'bg-red-400';
                return (
                  <div key={n} className="flex flex-1 flex-col items-center justify-end gap-0.5">
                    <div className={`w-full rounded-t ${color}`} style={{ height: `${(count / max) * 100}%` }} title={`${n}: ${count}`} />
                    <span className="text-[10px] text-gray-400">{n}</span>
                  </div>
                );
              })}
            </div>
            {feedback.nps.comments.length > 0 && (
              <ul className="mt-3 space-y-1.5">
                {feedback.nps.comments.map((c, i) => (
                  <li key={i} className="text-xs text-gray-600">
                    <span className="font-medium text-gray-500">{c.score}</span> — “{c.comment}”
                  </li>
                ))}
              </ul>
            )}
          </>
        )}
      </Panel>
    </div>
  );
}

function Card({ label, value }: { label: string; value: number }) {
  return (
    <div className="rounded-2xl bg-white border border-gray-100 p-4">
      <p className="text-2xl font-bold text-gray-800">{value}</p>
      <p className="text-xs text-gray-500">{label}</p>
    </div>
  );
}
function Panel({ title, children }: { title: string; children: React.ReactNode }) {
  return (
    <div className="rounded-2xl bg-white border border-gray-100 p-5">
      <h3 className="font-semibold text-gray-800 mb-3 text-sm">{title}</h3>
      {children}
    </div>
  );
}

