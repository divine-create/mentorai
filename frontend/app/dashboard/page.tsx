'use client';

import { useEffect, useState } from 'react';
import Link from 'next/link';
import { createClient } from '@/lib/supabase/client';
import NpsPrompt from '@/components/NpsPrompt';
import type { LearningPath, Module, Subject, SubjectOverview, ProgressSummary } from '@/lib/types';

export default function DashboardPage() {
  const supabase = createClient();
  const [data, setData] = useState<LearningPath | null>(null);
  const [userName, setUserName] = useState('');
  const [summary, setSummary] = useState<ProgressSummary | null>(null);
  const [notificationDismissed, setNotificationDismissed] = useState(false);
  const [loading, setLoading] = useState(true);
  const [subjects, setSubjects] = useState<Subject[]>([]);
  const [overview, setOverview] = useState<SubjectOverview[]>([]);
  const [switchingSubject, setSwitchingSubject] = useState<string | null>(null);
  const [projects, setProjects] = useState<{ id: number; title: string; passed: boolean }[]>([]);
  const [isAdmin, setIsAdmin] = useState(false);

  async function authHeader() {
    const { data: { session } } = await supabase.auth.getSession();
    return session ? { Authorization: `Bearer ${session.access_token}` } : null;
  }

  async function loadProjects(token: string) {
    try {
      const res = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/projects`, {
        headers: { Authorization: `Bearer ${token}` },
      });
      const d = await res.json();
      setProjects(d.projects ?? []);
    } catch {
      setProjects([]);
    }
  }

  useEffect(() => {
    async function load() {
      const { data: { session } } = await supabase.auth.getSession();
      if (!session) return;
      const token = session.access_token;

      // Sync user to backend database
      await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/auth/sync`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${token}` },
        body: JSON.stringify({
          email: session.user.email,
          name: session.user.user_metadata?.name,
        }),
      }).catch(() => {});

      const h = { Authorization: `Bearer ${token}` };
      const [pathRes, meRes, subjectsRes, overviewRes, summaryRes] = await Promise.all([
        fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/path`, { headers: h }),
        fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/auth/me`, { headers: h }),
        fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/subjects`, { headers: h }),
        fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/subjects/overview`, { headers: h }),
        fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/progress/summary`, { headers: h }),
      ]);

      setData(await pathRes.json().catch(() => null));
      const me = await meRes.json().catch(() => ({}));
      setUserName(me.name ?? me.email ?? '');
      setSubjects(await subjectsRes.json().catch(() => []));
      setOverview(await overviewRes.json().catch(() => []));
      setSummary(await summaryRes.json().catch(() => null));
      await loadProjects(token);
      // Admins (env allowlist on the backend) get an Admin nav link.
      fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/admin/me`, { headers: h })
        .then((r) => setIsAdmin(r.ok))
        .catch(() => {});
      setLoading(false);
    }
    load();
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  // Switch (or start) a subject, then reload everything that depends on it.
  async function switchSubject(subjectId: string | number) {
    const h = await authHeader();
    if (!h) return;
    const idStr = String(subjectId);

    setSwitchingSubject(idStr);
    try {
      const res = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/subjects/switch`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json', ...h },
        body: JSON.stringify({ subjectId: idStr }),
      });
      if (res.ok) {
        const [pathRes, overviewRes, summaryRes] = await Promise.all([
          fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/path`, { headers: h }),
          fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/subjects/overview`, { headers: h }),
          fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/progress/summary`, { headers: h }),
        ]);
        setData(await pathRes.json().catch(() => null));
        setOverview(await overviewRes.json().catch(() => []));
        setSummary(await summaryRes.json().catch(() => null));
        const { data: { session } } = await supabase.auth.getSession();
        if (session) await loadProjects(session.access_token);
        if (typeof window !== 'undefined') window.scrollTo({ top: 0, behavior: 'smooth' });
      }
    } finally {
      setSwitchingSubject(null);
    }
  }

  if (loading) {
    return <div className="min-h-screen flex items-center justify-center text-gray-400">Loading…</div>;
  }

  const profile = data?.profile;
  const modules = data?.modules ?? [];
  const subject = data?.subject;
  const currentMod = modules.find((m) => m.id === profile?.current_module_id) ?? modules.find((m) => m.unlocked);
  const completedCount = modules.filter((m) => m.mastery_score >= 80).length;

  // Catalog split: "enrolled" = active or has any progress; the rest is "available".
  const enrolled = overview.filter((s) => s.started || s.active);
  const available = overview.filter((s) => !s.started && !s.active);

  // ── Next-step recommendation ──────────────────────────────────────────────
  const next = computeNextStep(modules, currentMod, subject);
  const showBanner = !!summary?.notification && !notificationDismissed;

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Nav */}
      <nav className="bg-white border-b border-gray-200 px-6 py-3 flex items-center justify-between">
        <span className="font-bold text-indigo-600">The AI Academy</span>
        <div className="flex items-center gap-4">
          {subjects.length > 1 && (
            <select
              value={subject?.id ?? ''}
              onChange={(e) => switchSubject(e.target.value)}
              disabled={switchingSubject !== null}
              className="text-sm border border-gray-300 rounded-md px-2 py-1 bg-white"
            >
              {subjects.map((s) => (
                <option key={s.id} value={s.id}>
                  {s.icon} {s.name}
                </option>
              ))}
            </select>
          )}
          {isAdmin && (
            <Link href="/admin" className="text-sm text-indigo-600 hover:text-indigo-800">Admin</Link>
          )}
          <Link href="/profile" className="text-sm text-gray-500 hover:text-indigo-600">
            Hi, {userName.split(' ')[0]}
          </Link>
          <button
            onClick={() => supabase.auth.signOut().then(() => window.location.href = '/')}
            className="text-xs text-gray-400 hover:text-gray-600"
          >
            Sign out
          </button>
        </div>
      </nav>

      <div className="max-w-5xl mx-auto px-6 py-8 space-y-6">

        {/* Occasional NPS prompt (self-gates via /api/feedback/nps/eligible) */}
        <NpsPrompt />

        {/* Welcome-back / streak banner */}
        {showBanner && (
          <div className={`flex items-center justify-between gap-4 rounded-xl px-5 py-3 text-sm ${
            summary?.streakAtRisk
              ? 'bg-amber-50 border border-amber-200 text-amber-800'
              : 'bg-indigo-50 border border-indigo-100 text-indigo-800'
          }`}>
            <span className="flex items-center gap-2">
              <span>{summary?.streakAtRisk ? '🔥' : '👋'}</span>
              <span>{summary?.notification}</span>
            </span>
            <button
              onClick={() => setNotificationDismissed(true)}
              aria-label="Dismiss"
              className="shrink-0 text-current/60 hover:text-current"
            >
              ✕
            </button>
          </div>
        )}

        {/* Next-step recommendation */}
        {next && (
          <Link
            href={next.href}
            className="flex items-center justify-between gap-4 rounded-2xl bg-white border border-indigo-100 px-5 py-4 hover:border-indigo-300 hover:shadow-sm transition"
          >
            <span className="flex items-center gap-3 min-w-0">
              <span className="text-2xl shrink-0">{next.emoji}</span>
              <span className="min-w-0">
                <span className="block text-xs font-medium uppercase tracking-wide text-indigo-500">Next step</span>
                <span className="block text-sm font-semibold text-gray-800 truncate">{next.label}</span>
              </span>
            </span>
            <span className="shrink-0 rounded-full bg-indigo-600 text-white px-4 py-1.5 text-sm font-medium">{next.cta}</span>
          </Link>
        )}

        {/* Spaced-repetition review prompt */}
        {(summary?.reviewsDue ?? 0) > 0 && (
          <Link
            href="/review"
            className="flex items-center justify-between gap-4 rounded-2xl bg-white border border-amber-200 px-5 py-4 hover:border-amber-300 hover:shadow-sm transition"
          >
            <span className="flex items-center gap-3 min-w-0">
              <span className="text-2xl shrink-0">🔁</span>
              <span className="min-w-0">
                <span className="block text-xs font-medium uppercase tracking-wide text-amber-600">Spaced review</span>
                <span className="block text-sm font-semibold text-gray-800 truncate">
                  {summary!.reviewsDue} concept{summary!.reviewsDue === 1 ? '' : 's'} due — refresh them before they fade
                </span>
              </span>
            </span>
            <span className="shrink-0 rounded-full bg-amber-500 text-white px-4 py-1.5 text-sm font-medium">Review</span>
          </Link>
        )}

        {/* Current module hero */}
        {currentMod && (
          <div className="rounded-2xl bg-indigo-600 text-white p-6 flex flex-col sm:flex-row sm:items-center gap-4">
            <div className="flex-1">
              <div className="flex items-center gap-2 mb-1">
                <span className="text-2xl">{subject?.icon}</span>
                <p className="text-indigo-200 text-sm">{subject?.name}</p>
              </div>
              <h2 className="text-2xl font-bold mb-2">{currentMod.title}</h2>
              <p className="text-indigo-200 text-sm">{currentMod.description}</p>
              {currentMod.mastery_score > 0 && (
                <div className="mt-3">
                  <div className="flex justify-between text-xs text-indigo-200 mb-1">
                    <span>Mastery</span><span>{currentMod.mastery_score}%</span>
                  </div>
                  <div className="h-1.5 rounded-full bg-indigo-500">
                    <div className="h-1.5 rounded-full bg-white transition-all" style={{ width: `${currentMod.mastery_score}%` }} />
                  </div>
                </div>
              )}
            </div>
            <div className="flex flex-col gap-2 shrink-0">
              <Link href={`/learn/${currentMod.slug}`}
                className="rounded-full bg-white text-indigo-600 px-6 py-2.5 text-sm font-semibold text-center hover:bg-indigo-50">
                Your tutor is ready →
              </Link>
              <Link href={`/learn/${currentMod.slug}/assessment`}
                className="rounded-full border border-indigo-400 text-white px-6 py-2 text-sm font-medium text-center hover:bg-indigo-700">
                Take assessment
              </Link>
            </div>
          </div>
        )}

        {/* My courses */}
        {enrolled.length > 0 && (
          <section id="my-courses" className="space-y-3">
            <h3 className="font-semibold text-gray-800">My courses</h3>
            <div className="grid sm:grid-cols-2 lg:grid-cols-3 gap-4">
              {enrolled.map((s) => (
                <CourseCard
                  key={s.id}
                  course={s}
                  busy={switchingSubject === String(s.id)}
                  onSelect={() => switchSubject(s.id)}
                />
              ))}
            </div>
          </section>
        )}

        {/* Explore more courses */}
        {available.length > 0 && (
          <section id="courses" className="space-y-3">
            <h3 className="font-semibold text-gray-800">Explore more courses</h3>
            <div className="grid sm:grid-cols-2 lg:grid-cols-3 gap-4">
              {available.map((s) => (
                <CourseCard
                  key={s.id}
                  course={s}
                  busy={switchingSubject === String(s.id)}
                  onSelect={() => switchSubject(s.id)}
                />
              ))}
            </div>
          </section>
        )}

        <div className="grid lg:grid-cols-3 gap-6">
          {/* Learning path */}
          <div className="lg:col-span-2 space-y-3">
            <h3 className="font-semibold text-gray-800">
              {subject ? `${subject.name} — your path` : 'Your learning path'}
            </h3>
            {modules.length === 0 ? (
              <div className="rounded-2xl border border-dashed border-gray-200 bg-white px-6 py-10 text-center">
                <p className="text-3xl mb-2">📚</p>
                <p className="text-sm font-medium text-gray-700">No lessons here yet</p>
                <p className="text-sm text-gray-400 mt-1">
                  Pick a course above to start learning, or check back soon.
                </p>
              </div>
            ) : (
              modules.map((mod: Module) => (
                <ModuleCard key={mod.id} mod={mod} isCurrent={mod.id === profile?.current_module_id} />
              ))
            )}
          </div>

          {/* Stats sidebar */}
          <div className="space-y-4">
            <div className="rounded-2xl bg-white border border-gray-100 p-5 space-y-4">
              <h3 className="font-semibold text-gray-800">Your progress</h3>

              <Stat label="Day streak" value={`${summary?.streak ?? profile?.streak_days ?? 0} 🔥`} />
              <Stat label="This week" value={`${summary?.weekSessions ?? 0} sessions · ${summary?.weekMinutes ?? 0} min`} />
              <Stat label="Overall mastery" value={`${Math.round(summary?.overallMastery ?? profile?.overall_mastery ?? 0)}%`} />
              <Stat label="Modules completed" value={`${completedCount} / ${modules.length}`} />

              {profile?.last_session_at && (
                <Stat label="Last session" value={formatDate(profile.last_session_at)} />
              )}
            </div>

            {/* Quick links */}
            <div className="rounded-2xl bg-white border border-gray-100 p-5 space-y-2">
              <h3 className="font-semibold text-gray-800 mb-3">Quick links</h3>
              {currentMod && (
                <>
                  <QuickLink href={`/learn/${currentMod.slug}`} label="💬 Open tutor chat" />
                  {subject?.practice_kind === 'problem' ? (
                    <QuickLink href={`/learn/${currentMod.slug}/practice`} label="📐 Math workspace" />
                  ) : subject?.practice_kind === 'web' ? (
                    <QuickLink href={`/learn/${currentMod.slug}/web`} label="🌐 HTML/CSS playground" />
                  ) : (
                    <QuickLink href={`/learn/${currentMod.slug}/code`} label="⚡ Coding environment" />
                  )}
                  <QuickLink href={`/learn/${currentMod.slug}/assessment`} label="📝 Take assessment" />
                </>
              )}
              {(summary?.reviewsDue ?? 0) > 0 && (
                <QuickLink href="/review" label={`🔁 Review due (${summary!.reviewsDue})`} />
              )}
            </div>

            {/* Projects */}
            {projects.length > 0 && (
              <div className="rounded-2xl bg-white border border-gray-100 p-5">
                <h3 className="font-semibold text-gray-800 mb-3">Projects</h3>
                <div className="space-y-2">
                  {projects.map((p) => (
                    <Link
                      key={p.id}
                      href={`/projects/${p.id}`}
                      className="flex items-center justify-between rounded-lg border border-gray-100 px-3 py-2 text-sm text-gray-700 hover:bg-gray-50"
                    >
                      <span className="flex items-center gap-2">
                        <span>{p.passed ? '✅' : '🛠️'}</span>
                        <span className="truncate">{p.title}</span>
                      </span>
                      <span className="text-xs text-indigo-600">{p.passed ? 'Review' : 'Build'}</span>
                    </Link>
                  ))}
                </div>
              </div>
            )}
          </div>
        </div>
      </div>
    </div>
  );
}

// Decide the single most useful next action from the active subject's modules.
function computeNextStep(
  modules: Module[],
  currentMod: Module | undefined,
  subject: Subject | null | undefined,
): { label: string; cta: string; href: string; emoji: string } | null {
  if (modules.length === 0) {
    return { label: 'Pick a course to begin learning', cta: 'Browse', href: '#courses', emoji: '🚀' };
  }
  if (!currentMod) return null;

  // Ready for assessment: solid progress but not yet passed.
  if (currentMod.unlocked && currentMod.mastery_score >= 50 && currentMod.mastery_score < 80) {
    return {
      label: `You're ready — take the ${currentMod.title} assessment`,
      cta: 'Assess',
      href: `/learn/${currentMod.slug}/assessment`,
      emoji: '🎯',
    };
  }

  // Passed the current module: nudge toward the next one if it exists.
  if (currentMod.mastery_score >= 80) {
    const idx = modules.findIndex((m) => m.id === currentMod.id);
    const nextMod = modules[idx + 1];
    if (nextMod) {
      return {
        label: `Start ${nextMod.title}`,
        cta: nextMod.unlocked ? 'Start' : 'Continue',
        href: `/learn/${nextMod.slug}`,
        emoji: '✨',
      };
    }
    return {
      label: `You've completed every lesson in ${subject?.name ?? 'this course'}! 🎉`,
      cta: 'Review',
      href: `/learn/${currentMod.slug}`,
      emoji: '🏆',
    };
  }

  // Otherwise: keep learning the current module.
  return {
    label: `Continue ${currentMod.title}`,
    cta: 'Continue',
    href: `/learn/${currentMod.slug}`,
    emoji: '📖',
  };
}

function CourseCard({
  course,
  busy,
  onSelect,
}: {
  course: SubjectOverview;
  busy: boolean;
  onSelect: () => void;
}) {
  const enrolled = course.started || course.active;
  return (
    <div className={`flex flex-col rounded-2xl border bg-white p-5 ${
      course.active ? 'border-indigo-300 ring-1 ring-indigo-200' : 'border-gray-100'
    }`}>
      <div className="flex items-start gap-3">
        <span className="text-2xl shrink-0">{course.icon ?? '📘'}</span>
        <div className="min-w-0 flex-1">
          <p className="text-sm font-semibold text-gray-800 truncate">{course.name}</p>
          <p className="text-xs text-gray-400">{course.total_modules} modules</p>
        </div>
        {course.active && (
          <span className="shrink-0 rounded-full bg-indigo-100 text-indigo-700 px-2 py-0.5 text-[10px] font-semibold uppercase tracking-wide">
            Active
          </span>
        )}
      </div>

      {course.description && !enrolled && (
        <p className="mt-3 text-xs text-gray-500 line-clamp-2">{course.description}</p>
      )}

      {enrolled && (
        <div className="mt-3">
          <div className="flex justify-between text-xs text-gray-400 mb-1">
            <span>{course.completed_modules} / {course.total_modules} done</span>
            <span>{course.progress_pct}%</span>
          </div>
          <div className="h-1.5 rounded-full bg-gray-100">
            <div className="h-1.5 rounded-full bg-indigo-500 transition-all" style={{ width: `${course.progress_pct}%` }} />
          </div>
        </div>
      )}

      <button
        onClick={onSelect}
        disabled={busy || course.active}
        className={`mt-4 rounded-full px-4 py-2 text-sm font-medium transition disabled:opacity-60 ${
          course.active
            ? 'bg-gray-100 text-gray-500 cursor-default'
            : enrolled
            ? 'border border-indigo-200 text-indigo-700 hover:bg-indigo-50'
            : 'bg-indigo-600 text-white hover:bg-indigo-700'
        }`}
      >
        {busy ? 'Loading…' : course.active ? 'Currently learning' : enrolled ? 'Continue' : 'Start course'}
      </button>
    </div>
  );
}

function ModuleCard({ mod, isCurrent }: { mod: Module; isCurrent: boolean }) {
  const passed = mod.mastery_score >= 80;
  return (
    <div className={`flex items-center gap-4 rounded-xl border bg-white px-4 py-3 ${isCurrent ? 'border-indigo-300 ring-1 ring-indigo-200' : 'border-gray-100'}`}>
      <div className={`flex h-8 w-8 shrink-0 items-center justify-center rounded-full text-sm font-bold ${
        passed ? 'bg-green-100 text-green-700' :
        isCurrent ? 'bg-indigo-100 text-indigo-700' :
        mod.unlocked ? 'bg-gray-100 text-gray-600' :
        'bg-gray-50 text-gray-300'
      }`}>
        {passed ? '✓' : mod.order_index}
      </div>
      <div className="flex-1 min-w-0">
        <p className={`text-sm font-medium truncate ${mod.unlocked ? 'text-gray-800' : 'text-gray-400'}`}>{mod.title}</p>
        {mod.mastery_score > 0 && (
          <div className="mt-1 h-1 w-full rounded-full bg-gray-100">
            <div className={`h-1 rounded-full ${passed ? 'bg-green-500' : 'bg-indigo-400'}`} style={{ width: `${mod.mastery_score}%` }} />
          </div>
        )}
      </div>
      <div className="shrink-0 text-right">
        {mod.unlocked ? (
          <Link href={`/learn/${mod.slug}`} className="text-xs text-indigo-600 hover:underline">
            {isCurrent ? 'Continue' : passed ? 'Review' : 'Start'}
          </Link>
        ) : (
          <span
            className="text-xs text-gray-300 cursor-help"
            title="Pass the previous module's assessment to unlock this lesson."
          >
            🔒
          </span>
        )}
      </div>
    </div>
  );
}

function Stat({ label, value }: { label: string; value: string }) {
  return (
    <div className="flex justify-between items-center">
      <span className="text-sm text-gray-500">{label}</span>
      <span className="text-sm font-semibold text-gray-800">{value}</span>
    </div>
  );
}

function QuickLink({ href, label }: { href: string; label: string }) {
  return (
    <Link href={href} className="block rounded-lg px-3 py-2 text-sm text-gray-700 hover:bg-gray-50">
      {label}
    </Link>
  );
}

function formatDate(iso: string) {
  const d = new Date(iso);
  const diff = Math.floor((Date.now() - d.getTime()) / 86_400_000);
  if (diff === 0) return 'Today';
  if (diff === 1) return 'Yesterday';
  return `${diff} days ago`;
}
