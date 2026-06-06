import Link from 'next/link';

const FEATURES = [
  {
    icon: '🧠',
    title: 'Teaches, doesn\'t just answer',
    desc: 'Your tutor explains concepts, asks comprehension questions, and adapts in real time — just like a human teacher.',
  },
  {
    icon: '⚡',
    title: 'Live coding environment',
    desc: 'Write and run code in the browser. The AI analyses your output and gives feedback within 3 seconds.',
  },
  {
    icon: '📈',
    title: 'Mastery-based progression',
    desc: 'You only advance when you genuinely understand. No skipping ahead, no faking it.',
  },
  {
    icon: '🎯',
    title: 'Personalised from day one',
    desc: 'A short diagnostic places you at the right starting point. Your path is built around your goal.',
  },
];

const STEPS = [
  { step: '01', title: 'Choose your subject', desc: 'Python, English, AWS — pick what matters to you.' },
  { step: '02', title: 'Take a quick diagnostic', desc: '5 questions to find your starting point.' },
  { step: '03', title: 'Learn with your AI tutor', desc: 'Conversational lessons that adapt as you go.' },
  { step: '04', title: 'Prove mastery, advance', desc: 'Pass the module assessment to unlock the next one.' },
];

const SUBJECTS = [
  { name: 'Python Development', icon: '🐍', status: 'available', desc: '8 modules from fundamentals to APIs' },
  { name: 'Professional English', icon: '🗣️', status: 'coming', desc: 'Business writing, speaking & fluency' },
  { name: 'AWS Certification', icon: '☁️', status: 'coming', desc: 'Cloud practitioner & solutions architect' },
  { name: 'More subjects', icon: '📚', status: 'soon', desc: 'Full catalogue launching in v2.0' },
];

const PRICING = [
  {
    name: 'Free',
    price: '$0',
    period: '',
    highlight: false,
    features: ['5 tutor sessions', 'Module 1 of any subject', 'Coding environment', 'Basic progress tracking'],
    cta: 'Start free',
    href: '/onboarding',
  },
  {
    name: 'Pro',
    price: '$29',
    period: '/month',
    highlight: true,
    features: ['Unlimited sessions', 'All modules & subjects', 'Full progress analytics', 'Persistent memory (90 days)', 'Certificate of mastery'],
    cta: 'Start Pro',
    href: '/onboarding',
  },
  {
    name: 'Annual',
    price: '$199',
    period: '/year',
    highlight: false,
    features: ['Everything in Pro', 'Unlimited memory', 'Save 43% vs monthly'],
    cta: 'Get Annual',
    href: '/onboarding',
    badge: 'Best value',
  },
];

export default function LandingPage() {
  return (
    <div className="min-h-screen bg-white text-gray-900 font-sans">

      {/* Nav */}
      <nav className="flex items-center justify-between px-6 py-4 max-w-6xl mx-auto">
        <span className="text-xl font-bold text-indigo-600">The AI Academy</span>
        <div className="flex items-center gap-4">
          <Link href="/auth/login" className="text-sm text-gray-600 hover:text-gray-900">Sign in</Link>
          <Link href="/onboarding" className="rounded-full bg-indigo-600 px-4 py-2 text-sm font-medium text-white hover:bg-indigo-700">
            Get started free
          </Link>
        </div>
      </nav>

      {/* Hero */}
      <section className="text-center px-6 py-24 max-w-4xl mx-auto">
        <div className="inline-flex items-center gap-2 rounded-full bg-indigo-50 border border-indigo-100 px-4 py-1.5 text-xs font-medium text-indigo-700 mb-6">
          🎓 AI-powered · Mastery-based · Any subject
        </div>
        <h1 className="text-5xl font-bold tracking-tight text-gray-900 leading-tight mb-6">
          The AI tutor that actually<br />
          <span className="text-indigo-600">teaches you.</span>
        </h1>
        <p className="text-xl text-gray-500 max-w-2xl mx-auto mb-10">
          The AI Academy replaces static courses with a one-on-one tutor that explains, questions,
          and adapts until you genuinely master any subject — starting with Python.
        </p>
        <div className="flex flex-col sm:flex-row gap-3 justify-center">
          <Link href="/onboarding" className="rounded-full bg-indigo-600 px-8 py-3.5 text-base font-semibold text-white hover:bg-indigo-700">
            Start learning free →
          </Link>
          <Link href="#how-it-works" className="rounded-full border border-gray-200 px-8 py-3.5 text-base font-medium text-gray-700 hover:bg-gray-50">
            See how it works
          </Link>
        </div>
        <p className="mt-4 text-xs text-gray-400">No credit card required · Module 1 completely free</p>
      </section>

      {/* Social proof bar */}
      <div className="bg-gray-50 border-y border-gray-100 py-4">
        <div className="max-w-4xl mx-auto flex flex-wrap justify-center gap-8 px-6 text-sm text-gray-500">
          <span>✓ 45%+ course completion rate</span>
          <span>✓ NPS target &gt; 50</span>
          <span>✓ 20–30 min sessions</span>
          <span>✓ Multiple subjects</span>
        </div>
      </div>

      {/* Features */}
      <section className="py-24 px-6 max-w-6xl mx-auto">
        <h2 className="text-3xl font-bold text-center mb-4">Why The AI Academy is different</h2>
        <p className="text-center text-gray-500 mb-14 max-w-xl mx-auto">
          Existing platforms deliver the same video to every learner. We adapt to you.
        </p>
        <div className="grid sm:grid-cols-2 lg:grid-cols-4 gap-6">
          {FEATURES.map((f) => (
            <div key={f.title} className="rounded-2xl border border-gray-100 bg-gray-50 p-6">
              <div className="text-3xl mb-3">{f.icon}</div>
              <h3 className="font-semibold text-gray-900 mb-2">{f.title}</h3>
              <p className="text-sm text-gray-500 leading-relaxed">{f.desc}</p>
            </div>
          ))}
        </div>
      </section>

      {/* Subjects */}
      <section className="py-24 px-6 bg-gray-50">
        <div className="max-w-4xl mx-auto">
          <h2 className="text-3xl font-bold text-center mb-4">Learn any subject. Master it.</h2>
          <p className="text-center text-gray-500 mb-12 max-w-xl mx-auto">
            We&apos;re launching with Python and expanding fast. One platform, every skill you need.
          </p>
          <div className="grid sm:grid-cols-2 gap-4">
            {SUBJECTS.map((s) => (
              <div key={s.name} className="flex items-start gap-4 rounded-2xl bg-white border border-gray-100 p-5">
                <span className="text-3xl">{s.icon}</span>
                <div className="flex-1">
                  <div className="flex items-center gap-2 mb-1">
                    <h3 className="font-semibold text-gray-900">{s.name}</h3>
                    {s.status === 'available' && (
                      <span className="rounded-full bg-green-50 px-2 py-0.5 text-xs font-medium text-green-700">Available now</span>
                    )}
                    {s.status === 'coming' && (
                      <span className="rounded-full bg-amber-50 px-2 py-0.5 text-xs font-medium text-amber-700">Coming soon</span>
                    )}
                    {s.status === 'soon' && (
                      <span className="rounded-full bg-gray-100 px-2 py-0.5 text-xs font-medium text-gray-500">v2.0</span>
                    )}
                  </div>
                  <p className="text-sm text-gray-500">{s.desc}</p>
                </div>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* How it works */}
      <section id="how-it-works" className="py-24 px-6">
        <div className="max-w-4xl mx-auto">
          <h2 className="text-3xl font-bold text-center mb-14">How it works</h2>
          <div className="grid sm:grid-cols-2 lg:grid-cols-4 gap-8">
            {STEPS.map((s) => (
              <div key={s.step} className="text-center">
                <div className="text-4xl font-bold text-indigo-100 mb-2">{s.step}</div>
                <h3 className="font-semibold text-gray-900 mb-1">{s.title}</h3>
                <p className="text-sm text-gray-500">{s.desc}</p>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* Pricing */}
      <section className="py-24 px-6 bg-gray-50">
        <div className="max-w-5xl mx-auto">
          <h2 className="text-3xl font-bold text-center mb-4">Simple pricing</h2>
          <p className="text-center text-gray-500 mb-14">Start free. Upgrade when you&apos;re ready.</p>
          <div className="grid sm:grid-cols-3 gap-6">
            {PRICING.map((p) => (
              <div key={p.name} className={`relative rounded-2xl p-6 ${p.highlight ? 'bg-indigo-600 text-white shadow-xl' : 'bg-white border border-gray-100'}`}>
                {p.badge && (
                  <span className="absolute -top-3 left-1/2 -translate-x-1/2 rounded-full bg-amber-400 px-3 py-0.5 text-xs font-semibold text-amber-900">
                    {p.badge}
                  </span>
                )}
                <p className={`text-sm font-medium mb-1 ${p.highlight ? 'text-indigo-200' : 'text-gray-500'}`}>{p.name}</p>
                <div className="flex items-baseline gap-1 mb-4">
                  <span className="text-4xl font-bold">{p.price}</span>
                  <span className={`text-sm ${p.highlight ? 'text-indigo-200' : 'text-gray-400'}`}>{p.period}</span>
                </div>
                <ul className="space-y-2 mb-6">
                  {p.features.map((f) => (
                    <li key={f} className={`flex items-start gap-2 text-sm ${p.highlight ? 'text-indigo-100' : 'text-gray-600'}`}>
                      <span className="mt-0.5">✓</span>{f}
                    </li>
                  ))}
                </ul>
                <Link
                  href={p.href}
                  className={`block w-full rounded-full py-2.5 text-center text-sm font-semibold transition-colors ${
                    p.highlight
                      ? 'bg-white text-indigo-600 hover:bg-indigo-50'
                      : 'bg-indigo-600 text-white hover:bg-indigo-700'
                  }`}
                >
                  {p.cta}
                </Link>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* CTA */}
      <section className="py-24 px-6 text-center">
        <h2 className="text-3xl font-bold mb-4">Ready to actually learn?</h2>
        <p className="text-gray-500 mb-8 max-w-md mx-auto">
          Join learners building real skills with an AI tutor that adapts to them.
        </p>
        <Link href="/onboarding" className="rounded-full bg-indigo-600 px-10 py-4 text-base font-semibold text-white hover:bg-indigo-700">
          Get started free →
        </Link>
      </section>

      {/* Footer */}
      <footer className="border-t border-gray-100 py-8 px-6 text-center text-xs text-gray-400">
        © 2026 The AI Academy · <Link href="/auth/login" className="hover:text-gray-600">Sign in</Link>
      </footer>

    </div>
  );
}
