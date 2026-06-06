'use client';

import { useState } from 'react';
import { useRouter } from 'next/navigation';
import { createClient } from '@/lib/supabase/client';

// ─── Types ────────────────────────────────────────────────────────────────────
type Step = 'welcome' | 'goal' | 'experience' | 'diagnostic' | 'path' | 'account';

const GOALS = [
  { id: 'job',      label: 'Get a developer job',       emoji: '💼' },
  { id: 'data',     label: 'Get into data science',     emoji: '📊' },
  { id: 'automate', label: 'Automate tasks at work',    emoji: '⚙️' },
  { id: 'web',      label: 'Build web apps',            emoji: '🌐' },
  { id: 'general',  label: 'Learn Python generally',    emoji: '🐍' },
];

const EXPERIENCE_LEVELS = [
  { id: 'none',         label: 'Complete beginner',       sub: 'Never written code before' },
  { id: 'some',         label: 'Some experience',         sub: 'Tried Python or another language' },
  { id: 'intermediate', label: 'Intermediate',            sub: 'Comfortable with basics' },
];

const DIAGNOSTIC_QUESTIONS = [
  {
    id: 'q1',
    prompt: 'What does this print?\n\nx = [1, 2, 3]\nprint(x[-1])',
    options: ['1', '2', '3', 'Error'],
    correct: '3',
  },
  {
    id: 'q2',
    prompt: 'Which keyword defines a function in Python?',
    options: ['function', 'def', 'fn', 'func'],
    correct: 'def',
  },
  {
    id: 'q3',
    prompt: 'What is the output of: print(type(3.14))?',
    options: ["<class 'int'>", "<class 'float'>", "<class 'str'>", "<class 'number'>"],
    correct: "<class 'float'>",
  },
  {
    id: 'q4',
    prompt: 'Which of these creates a dictionary?',
    options: ['[1, 2, 3]', '(1, 2, 3)', "{'a': 1}", '{1, 2, 3}'],
    correct: "{'a': 1}",
  },
  {
    id: 'q5',
    prompt: 'What does `range(3)` produce?',
    options: ['[1, 2, 3]', '[0, 1, 2]', '[0, 1, 2, 3]', 'Error'],
    correct: '[0, 1, 2]',
  },
];

// ─── Component ────────────────────────────────────────────────────────────────
export default function OnboardingPage() {
  const router = useRouter();
  const supabase = createClient();

  const [step, setStep] = useState<Step>('welcome');
  const [goal, setGoal] = useState('');
  const [experience, setExperience] = useState('');
  const [answers, setAnswers] = useState<Record<string, string>>({});
  const [currentQ, setCurrentQ] = useState(0);
  const [startingModule, setStartingModule] = useState(1);

  // Account creation state
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [name, setName] = useState('');
  const [authError, setAuthError] = useState('');
  const [authLoading, setAuthLoading] = useState(false);

  // ── Diagnostic scoring ──────────────────────────────────────────────────────
  function computeStartingModule() {
    const correct = DIAGNOSTIC_QUESTIONS.filter((q) => answers[q.id] === q.correct).length;
    if (experience === 'intermediate' && correct >= 4) return 3; // start at Functions
    if (experience === 'some' && correct >= 3) return 2;         // start at Control Flow
    return 1;                                                     // start at Fundamentals
  }

  function handleDiagnosticAnswer(answer: string) {
    const q = DIAGNOSTIC_QUESTIONS[currentQ];
    const updated = { ...answers, [q.id]: answer };
    setAnswers(updated);

    if (currentQ < DIAGNOSTIC_QUESTIONS.length - 1) {
      setCurrentQ(currentQ + 1);
    } else {
      // All answered — compute path
      const correct = DIAGNOSTIC_QUESTIONS.filter((dq) => updated[dq.id] === dq.correct).length;
      let mod = 1;
      if (experience === 'intermediate' && correct >= 4) mod = 3;
      else if (experience === 'some' && correct >= 3) mod = 2;
      setStartingModule(mod);
      setStep('path');
    }
  }

  // ── Account creation ────────────────────────────────────────────────────────
  async function handleCreateAccount(e: React.FormEvent) {
    e.preventDefault();
    setAuthLoading(true);
    setAuthError('');

    const { error, data } = await supabase.auth.signUp({
      email,
      password,
      options: { data: { name } },
    });

    if (error) {
      setAuthError(error.message);
      setAuthLoading(false);
      return;
    }

    // Sync to backend with goal
    if (data.session) {
      await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/auth/sync`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${data.session.access_token}`,
        },
        body: JSON.stringify({ email, name, goal, experience, startingModule }),
      });
    }

    router.push('/dashboard');
  }

  async function handleGoogleAccount() {
    await supabase.auth.signInWithOAuth({
      provider: 'google',
      options: {
        redirectTo: `${location.origin}/auth/callback?next=/dashboard`,
        queryParams: { goal, experience },
      },
    });
  }

  // ── Render ──────────────────────────────────────────────────────────────────
  return (
    <main className="min-h-screen bg-gray-50 flex items-center justify-center px-4 py-12">
      <div className="w-full max-w-lg">

        {/* WELCOME */}
        {step === 'welcome' && (
          <div className="text-center space-y-6">
            <div className="text-5xl">🐍</div>
            <h1 className="text-3xl font-bold text-gray-900">Meet your AI Python tutor</h1>
            <p className="text-gray-500 max-w-sm mx-auto">
              MentorAI teaches you Python through real conversation — explaining, questioning,
              and adapting until you genuinely understand.
            </p>
            <button
              onClick={() => setStep('goal')}
              className="rounded-md bg-indigo-600 px-8 py-3 text-sm font-medium text-white hover:bg-indigo-700"
            >
              Get started
            </button>
          </div>
        )}

        {/* GOAL */}
        {step === 'goal' && (
          <div className="space-y-6">
            <h2 className="text-xl font-bold text-gray-900">What&apos;s your goal?</h2>
            <div className="grid gap-3">
              {GOALS.map((g) => (
                <button
                  key={g.id}
                  onClick={() => { setGoal(g.id); setStep('experience'); }}
                  className="flex items-center gap-3 rounded-lg border border-gray-200 bg-white px-4 py-3 text-left hover:border-indigo-400 hover:bg-indigo-50 transition-colors"
                >
                  <span className="text-2xl">{g.emoji}</span>
                  <span className="text-sm font-medium text-gray-800">{g.label}</span>
                </button>
              ))}
            </div>
          </div>
        )}

        {/* EXPERIENCE */}
        {step === 'experience' && (
          <div className="space-y-6">
            <h2 className="text-xl font-bold text-gray-900">Where are you now?</h2>
            <div className="grid gap-3">
              {EXPERIENCE_LEVELS.map((lvl) => (
                <button
                  key={lvl.id}
                  onClick={() => { setExperience(lvl.id); setStep('diagnostic'); }}
                  className="flex flex-col rounded-lg border border-gray-200 bg-white px-4 py-3 text-left hover:border-indigo-400 hover:bg-indigo-50 transition-colors"
                >
                  <span className="text-sm font-medium text-gray-800">{lvl.label}</span>
                  <span className="text-xs text-gray-500">{lvl.sub}</span>
                </button>
              ))}
            </div>
          </div>
        )}

        {/* DIAGNOSTIC */}
        {step === 'diagnostic' && (
          <div className="space-y-6">
            <div className="flex items-center justify-between">
              <h2 className="text-xl font-bold text-gray-900">Quick check</h2>
              <span className="text-xs text-gray-400">{currentQ + 1} / {DIAGNOSTIC_QUESTIONS.length}</span>
            </div>
            {/* Progress bar */}
            <div className="h-1.5 w-full rounded-full bg-gray-200">
              <div
                className="h-1.5 rounded-full bg-indigo-500 transition-all"
                style={{ width: `${((currentQ) / DIAGNOSTIC_QUESTIONS.length) * 100}%` }}
              />
            </div>
            <div className="rounded-lg bg-white border border-gray-200 p-4">
              <pre className="text-sm text-gray-800 whitespace-pre-wrap font-mono">
                {DIAGNOSTIC_QUESTIONS[currentQ].prompt}
              </pre>
            </div>
            <div className="grid gap-2">
              {DIAGNOSTIC_QUESTIONS[currentQ].options.map((opt) => (
                <button
                  key={opt}
                  onClick={() => handleDiagnosticAnswer(opt)}
                  className="rounded-md border border-gray-200 bg-white px-4 py-2.5 text-left text-sm hover:border-indigo-400 hover:bg-indigo-50 transition-colors"
                >
                  {opt}
                </button>
              ))}
            </div>
          </div>
        )}

        {/* PATH REVEAL */}
        {step === 'path' && (
          <div className="space-y-6 text-center">
            <div className="text-4xl">✨</div>
            <h2 className="text-2xl font-bold text-gray-900">Your path is ready</h2>
            <p className="text-gray-500">
              Based on your answers, you&apos;ll start at{' '}
              <strong>
                {startingModule === 1 ? 'Python Fundamentals' :
                 startingModule === 2 ? 'Control Flow' : 'Functions'}
              </strong>
              {' '}and work through 8 modules to mastery.
            </p>
            <div className="rounded-lg bg-indigo-50 border border-indigo-100 p-4 text-left space-y-2">
              {['Python Fundamentals', 'Control Flow', 'Functions', 'Data Structures',
                'OOP', 'File Handling', 'Working with APIs', 'Capstone Project'].map((mod, i) => (
                <div key={mod} className="flex items-center gap-2 text-sm">
                  <span className={i + 1 < startingModule ? 'text-gray-300' : i + 1 === startingModule ? 'text-indigo-600 font-semibold' : 'text-gray-600'}>
                    {i + 1 < startingModule ? '✓' : i + 1 === startingModule ? '▶' : '○'}
                  </span>
                  <span className={i + 1 === startingModule ? 'text-indigo-700 font-semibold' : i + 1 < startingModule ? 'text-gray-400 line-through' : 'text-gray-600'}>
                    {mod}
                  </span>
                </div>
              ))}
            </div>
            <button
              onClick={() => setStep('account')}
              className="w-full rounded-md bg-indigo-600 px-4 py-3 text-sm font-medium text-white hover:bg-indigo-700"
            >
              Save my path &amp; create account
            </button>
          </div>
        )}

        {/* ACCOUNT CREATION */}
        {step === 'account' && (
          <div className="space-y-6">
            <h2 className="text-xl font-bold text-gray-900">Create your account</h2>
            <p className="text-sm text-gray-500">Your learning path is saved once you sign up.</p>

            {authError && (
              <p className="text-sm text-red-600 bg-red-50 border border-red-200 rounded px-3 py-2">{authError}</p>
            )}

            <form onSubmit={handleCreateAccount} className="space-y-4">
              <div>
                <label htmlFor="name" className="block text-sm font-medium text-gray-700">Name</label>
                <input id="name" type="text" required value={name} onChange={(e) => setName(e.target.value)}
                  className="mt-1 block w-full rounded-md border border-gray-300 px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500" />
              </div>
              <div>
                <label htmlFor="email" className="block text-sm font-medium text-gray-700">Email</label>
                <input id="email" type="email" required value={email} onChange={(e) => setEmail(e.target.value)}
                  className="mt-1 block w-full rounded-md border border-gray-300 px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500" />
              </div>
              <div>
                <label htmlFor="password" className="block text-sm font-medium text-gray-700">Password</label>
                <input id="password" type="password" required minLength={8} value={password} onChange={(e) => setPassword(e.target.value)}
                  className="mt-1 block w-full rounded-md border border-gray-300 px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500" />
              </div>
              <button type="submit" disabled={authLoading}
                className="w-full rounded-md bg-indigo-600 px-4 py-2 text-sm font-medium text-white hover:bg-indigo-700 disabled:opacity-50">
                {authLoading ? 'Creating account…' : 'Start learning'}
              </button>
            </form>

            <div className="relative">
              <div className="absolute inset-0 flex items-center"><div className="w-full border-t border-gray-200" /></div>
              <div className="relative flex justify-center text-xs text-gray-400"><span className="bg-gray-50 px-2">or</span></div>
            </div>

            <button onClick={handleGoogleAccount}
              className="w-full flex items-center justify-center gap-2 rounded-md border border-gray-300 bg-white px-4 py-2 text-sm font-medium text-gray-700 hover:bg-gray-50">
              <svg className="h-4 w-4" viewBox="0 0 24 24" aria-hidden="true">
                <path d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z" fill="#4285F4"/>
                <path d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z" fill="#34A853"/>
                <path d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l3.66-2.84z" fill="#FBBC05"/>
                <path d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z" fill="#EA4335"/>
              </svg>
              Continue with Google
            </button>
          </div>
        )}

      </div>
    </main>
  );
}
