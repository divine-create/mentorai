'use client';

import { useEffect, useState } from 'react';
import Link from 'next/link';
import { useRouter } from 'next/navigation';
import { createClient } from '@/lib/supabase/client';
import type { ProfileData, SubjectOverview } from '@/lib/types';

// Human-readable labels for the onboarding experience ids (kept in sync with
// EXPERIENCE_LEVELS in app/onboarding/page.tsx and the backend enum).
const EXPERIENCE_LABELS: Record<string, string> = {
  none: 'Complete beginner',
  some: 'Some experience',
  intermediate: 'Intermediate',
};

export default function ProfilePage() {
  const supabase = createClient();
  const router = useRouter();

  const [data, setData] = useState<ProfileData | null>(null);
  const [overview, setOverview] = useState<SubjectOverview[]>([]);
  const [loading, setLoading] = useState(true);

  // Edit state
  const [editing, setEditing] = useState(false);
  const [name, setName] = useState('');
  const [goal, setGoal] = useState('');
  const [experience, setExperience] = useState('');
  const [saving, setSaving] = useState(false);
  const [saveError, setSaveError] = useState<string | null>(null);

  async function authHeader() {
    const { data: { session } } = await supabase.auth.getSession();
    return session ? { Authorization: `Bearer ${session.access_token}` } : null;
  }

  useEffect(() => {
    async function load() {
      const { data: { session } } = await supabase.auth.getSession();
      if (!session) { router.push('/auth/login'); return; }
      const h = { Authorization: `Bearer ${session.access_token}` };
      const [profRes, ovRes] = await Promise.all([
        fetch(`/api/profile`, { headers: h }),
        fetch(`/api/subjects/overview`, { headers: h }),
      ]);
      const prof: ProfileData | null = await profRes.json().catch(() => null);
      setData(prof);
      setOverview(await ovRes.json().catch(() => []));
      if (prof) {
        setName(prof.profile.name ?? '');
        setGoal(prof.profile.goal ?? '');
        setExperience(prof.profile.experience ?? '');
      }
      setLoading(false);
    }
    load();
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  async function saveProfile() {
    const h = await authHeader();
    if (!h) return;
    setSaving(true);
    setSaveError(null);
    try {
      const res = await fetch(`/api/profile`, {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json', ...h },
        body: JSON.stringify({ name: name.trim(), goal: goal.trim(), experience: experience || undefined }),
      });
      if (!res.ok) {
        const e = await res.json().catch(() => ({}));
        setSaveError(e.error || 'Could not save. Please try again.');
        return;
      }
      setData((d) => d ? { ...d, profile: { ...d.profile, name: name.trim(), goal: goal.trim(), experience: experience || null } } : d);
      setEditing(false);
    } finally {
      setSaving(false);
    }
  }

  if (loading) {
    return <div className="min-h-screen flex items-center justify-center text-gray-400">Loading…</div>;
  }
  if (!data) {
    return <div className="min-h-screen flex items-center justify-center text-gray-400">Could not load your profile.</div>;
  }

  const { profile, stats, recentSessions } = data;
  const initial = (profile.name || profile.email || '?').trim().charAt(0).toUpperCase();
  const isPaid = profile.subscription_status && profile.subscription_status !== 'free';
  const hours = Math.floor(stats.totalMinutes / 60);
  const mins = stats.totalMinutes % 60;
  const timeStudied = hours > 0 ? `${hours}h ${mins}m` : `${mins}m`;

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Nav */}
      <nav className="bg-white border-b border-gray-200 px-6 py-3 flex items-center justify-between">
        <Link href="/dashboard" className="font-bold text-indigo-600">The AI Academy</Link>
        <Link
          href="/dashboard"
          className="rounded-md border border-gray-300 px-3 py-1.5 text-sm font-medium text-gray-700 hover:bg-gray-50"
        >
          ← Dashboard
        </Link>
      </nav>

      <div className="max-w-4xl mx-auto px-6 py-8 space-y-6">

        {/* Identity header */}
        <div className="rounded-2xl bg-white border border-gray-100 p-6 flex items-start gap-5">
          <div className="h-16 w-16 shrink-0 rounded-full bg-indigo-600 flex items-center justify-center text-white text-2xl font-bold">
            {initial}
          </div>
          <div className="flex-1 min-w-0">
            <div className="flex items-center gap-2 flex-wrap">
              <h1 className="text-xl font-bold text-gray-900 truncate">{profile.name || 'Learner'}</h1>
              <span className={`rounded-full px-2 py-0.5 text-[11px] font-semibold uppercase tracking-wide ${
                isPaid ? 'bg-green-100 text-green-700' : 'bg-gray-100 text-gray-500'
              }`}>
                {isPaid ? profile.subscription_status : 'Free'}
              </span>
            </div>
            <p className="text-sm text-gray-500">{profile.email}</p>
            <p className="text-xs text-gray-400 mt-1">Member since {formatDate(profile.created_at)}</p>
          </div>
          {!isPaid && (
            <Link
              href="/upgrade"
              className="shrink-0 rounded-full bg-indigo-600 px-4 py-2 text-sm font-medium text-white hover:bg-indigo-700"
            >
              Upgrade
            </Link>
          )}
        </div>

        {/* Learning stats */}
        <section className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-6 gap-3">
          <StatCard label="Day streak" value={`${profile.streak_days}`} accent="🔥" />
          <StatCard label="Overall mastery" value={`${profile.overall_mastery}%`} />
          <StatCard label="Sessions" value={`${stats.totalSessions}`} />
          <StatCard label="Time studied" value={timeStudied} />
          <StatCard label="Questions" value={`${stats.questionsAnswered}`} />
          <StatCard label="Accuracy" value={`${stats.accuracyPct}%`} />
        </section>

        <div className="grid lg:grid-cols-2 gap-6">
          {/* Editable profile */}
          <section className="rounded-2xl bg-white border border-gray-100 p-6">
            <div className="flex items-center justify-between mb-4">
              <h2 className="font-semibold text-gray-800">Profile</h2>
              {!editing && (
                <button onClick={() => setEditing(true)} className="text-sm text-indigo-600 hover:underline">
                  Edit
                </button>
              )}
            </div>

            {editing ? (
              <div className="space-y-4">
                <div>
                  <label className="block text-xs font-medium text-gray-500 mb-1">Name</label>
                  <input
                    value={name}
                    onChange={(e) => setName(e.target.value)}
                    className="w-full rounded-lg border border-gray-300 px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500"
                    placeholder="Your name"
                  />
                </div>
                <div>
                  <label className="block text-xs font-medium text-gray-500 mb-1">Learning goal</label>
                  <textarea
                    value={goal}
                    onChange={(e) => setGoal(e.target.value)}
                    rows={3}
                    className="w-full rounded-lg border border-gray-300 px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500"
                    placeholder="e.g. Become confident writing Python for data analysis"
                  />
                </div>
                <div>
                  <label className="block text-xs font-medium text-gray-500 mb-1">Experience level</label>
                  <select
                    value={experience}
                    onChange={(e) => setExperience(e.target.value)}
                    className="w-full rounded-lg border border-gray-300 px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500"
                  >
                    <option value="">Prefer not to say</option>
                    {Object.entries(EXPERIENCE_LABELS).map(([id, label]) => (
                      <option key={id} value={id}>{label}</option>
                    ))}
                  </select>
                </div>
                {saveError && <p className="text-xs text-red-600">{saveError}</p>}
                <div className="flex gap-2">
                  <button
                    onClick={saveProfile}
                    disabled={saving}
                    className="rounded-full bg-indigo-600 px-4 py-2 text-sm font-medium text-white hover:bg-indigo-700 disabled:opacity-60"
                  >
                    {saving ? 'Saving…' : 'Save'}
                  </button>
                  <button
                    onClick={() => { setEditing(false); setName(profile.name ?? ''); setGoal(profile.goal ?? ''); setExperience(profile.experience ?? ''); setSaveError(null); }}
                    className="rounded-full border border-gray-300 px-4 py-2 text-sm font-medium text-gray-700 hover:bg-gray-50"
                  >
                    Cancel
                  </button>
                </div>
              </div>
            ) : (
              <div className="space-y-4">
                <Field label="Name" value={profile.name || '—'} />
                <Field label="Learning goal" value={profile.goal || 'No goal set yet — add one to personalise your tutor.'} />
                <Field label="Experience level" value={profile.experience ? EXPERIENCE_LABELS[profile.experience] ?? profile.experience : '—'} />
              </div>
            )}
          </section>

          {/* Per-subject progress */}
          <section className="rounded-2xl bg-white border border-gray-100 p-6">
            <h2 className="font-semibold text-gray-800 mb-4">Course progress</h2>
            {overview.filter((s) => s.started || s.active).length === 0 ? (
              <p className="text-sm text-gray-400">You haven&apos;t started a course yet.</p>
            ) : (
              <div className="space-y-4">
                {overview.filter((s) => s.started || s.active).map((s) => (
                  <div key={s.id}>
                    <div className="flex justify-between text-sm mb-1">
                      <span className="text-gray-700 truncate">{s.icon} {s.name}</span>
                      <span className="text-gray-400">{s.completed_modules}/{s.total_modules}</span>
                    </div>
                    <div className="h-1.5 rounded-full bg-gray-100">
                      <div className="h-1.5 rounded-full bg-indigo-500" style={{ width: `${s.progress_pct}%` }} />
                    </div>
                  </div>
                ))}
              </div>
            )}
          </section>
        </div>

        {/* Recent activity */}
        <section className="rounded-2xl bg-white border border-gray-100 p-6">
          <h2 className="font-semibold text-gray-800 mb-4">Recent activity</h2>
          {recentSessions.length === 0 ? (
            <p className="text-sm text-gray-400">No completed sessions yet. Your learning history will show here.</p>
          ) : (
            <div className="space-y-3">
              {recentSessions.map((s, i) => (
                <Link
                  key={i}
                  href={`/learn/${s.moduleSlug}`}
                  className="block rounded-xl border border-gray-100 px-4 py-3 hover:bg-gray-50"
                >
                  <div className="flex items-center justify-between gap-3">
                    <span className="text-sm font-medium text-gray-800 truncate">{s.moduleTitle}</span>
                    <span className="shrink-0 text-xs text-gray-400">{formatDate(s.endedAt)} · {s.durationMinutes}m</span>
                  </div>
                  {s.summary && <p className="mt-1 text-xs text-gray-500 line-clamp-2">{s.summary}</p>}
                </Link>
              ))}
            </div>
          )}
        </section>
      </div>
    </div>
  );
}

function StatCard({ label, value, accent }: { label: string; value: string; accent?: string }) {
  return (
    <div className="rounded-2xl bg-white border border-gray-100 p-4 text-center">
      <p className="text-2xl font-bold text-gray-900">{value}{accent ? ` ${accent}` : ''}</p>
      <p className="text-xs text-gray-500 mt-0.5">{label}</p>
    </div>
  );
}

function Field({ label, value }: { label: string; value: string }) {
  return (
    <div>
      <p className="text-xs font-medium text-gray-500 mb-1">{label}</p>
      <p className="text-sm text-gray-800 whitespace-pre-wrap">{value}</p>
    </div>
  );
}

function formatDate(iso: string) {
  const d = new Date(iso);
  return d.toLocaleDateString(undefined, { year: 'numeric', month: 'short', day: 'numeric' });
}

