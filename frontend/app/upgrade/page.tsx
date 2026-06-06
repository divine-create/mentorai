'use client';

import { useState } from 'react';
import { createClient } from '@/lib/supabase/client';
import { useRouter } from 'next/navigation';

const PLANS = [
  {
    id: 'pro_monthly',
    name: 'Pro',
    price: '$29',
    period: '/month',
    features: ['Unlimited sessions', 'All 8 modules', 'Full analytics', 'Memory (90 days)', 'Certificate'],
    highlight: true,
  },
  {
    id: 'pro_annual',
    name: 'Annual',
    price: '$199',
    period: '/year',
    features: ['Everything in Pro', 'Unlimited memory', 'Save 43%'],
    highlight: false,
    badge: 'Best value',
  },
];

export default function UpgradePage() {
  const supabase = createClient();
  const router = useRouter();
  const [loading, setLoading] = useState<string | null>(null);

  async function checkout(planId: string) {
    setLoading(planId);
    const { data: { session } } = await supabase.auth.getSession();
    if (!session) { router.push('/auth/login'); return; }

    const res = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/billing/checkout`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${session.access_token}` },
      body: JSON.stringify({ plan: planId }),
    });
    const { url } = await res.json();
    if (url) window.location.href = url;
    else setLoading(null);
  }

  return (
    <main className="min-h-screen bg-gray-50 flex items-center justify-center px-4 py-16">
      <div className="w-full max-w-2xl space-y-8 text-center">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Upgrade to continue learning</h1>
          <p className="mt-2 text-gray-500">You&apos;ve used your 5 free sessions. Upgrade to unlock unlimited access.</p>
        </div>

        <div className="grid sm:grid-cols-2 gap-5">
          {PLANS.map((p) => (
            <div key={p.id} className={`relative rounded-2xl p-6 text-left ${p.highlight ? 'bg-indigo-600 text-white shadow-xl' : 'bg-white border border-gray-100'}`}>
              {p.badge && (
                <span className="absolute -top-3 left-1/2 -translate-x-1/2 rounded-full bg-amber-400 px-3 py-0.5 text-xs font-semibold text-amber-900">{p.badge}</span>
              )}
              <p className={`text-sm font-medium mb-1 ${p.highlight ? 'text-indigo-200' : 'text-gray-500'}`}>{p.name}</p>
              <div className="flex items-baseline gap-1 mb-4">
                <span className="text-3xl font-bold">{p.price}</span>
                <span className={`text-sm ${p.highlight ? 'text-indigo-200' : 'text-gray-400'}`}>{p.period}</span>
              </div>
              <ul className="space-y-1.5 mb-5">
                {p.features.map((f) => (
                  <li key={f} className={`flex gap-2 text-sm ${p.highlight ? 'text-indigo-100' : 'text-gray-600'}`}>
                    <span>✓</span>{f}
                  </li>
                ))}
              </ul>
              <button
                onClick={() => checkout(p.id)}
                disabled={!!loading}
                className={`w-full rounded-full py-2.5 text-sm font-semibold disabled:opacity-50 ${p.highlight ? 'bg-white text-indigo-600 hover:bg-indigo-50' : 'bg-indigo-600 text-white hover:bg-indigo-700'}`}
              >
                {loading === p.id ? 'Redirecting…' : `Get ${p.name}`}
              </button>
            </div>
          ))}
        </div>

        <button onClick={() => router.push('/dashboard')} className="text-sm text-gray-400 hover:text-gray-600">
          Back to dashboard
        </button>
      </div>
    </main>
  );
}
