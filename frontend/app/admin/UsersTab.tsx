'use client';

import { useEffect, useState } from 'react';
import { createClient } from '@/lib/supabase/client';

const API = process.env.NEXT_PUBLIC_API_URL;
const STATUSES = ['free', 'pro', 'annual', 'cancelled'];

interface User {
  id: string; email: string; name: string | null; subscription_status: string;
  overall_mastery: number; streak_days: number; last_session_at: string | null; sessions: number;
}

export default function UsersTab() {
  const supabase = createClient();
  const [users, setUsers] = useState<User[]>([]);
  const [q, setQ] = useState('');
  const [loading, setLoading] = useState(true);

  async function token() { const { data: { session } } = await supabase.auth.getSession(); return session?.access_token ?? null; }

  async function load(search = '') {
    const t = await token();
    if (!t) return;
    const res = await fetch(`${API}/api/admin/users${search ? `?q=${encodeURIComponent(search)}` : ''}`, { headers: { Authorization: `Bearer ${t}` } });
    if (res.ok) setUsers((await res.json()).users ?? []);
    setLoading(false);
  }

  useEffect(() => { load(); /* eslint-disable-next-line react-hooks/exhaustive-deps */ }, []);

  async function setSub(id: string, status: string) {
    const t = await token();
    if (!t) return;
    await fetch(`${API}/api/admin/users/${id}/subscription`, {
      method: 'PATCH', headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${t}` },
      body: JSON.stringify({ status }),
    });
    setUsers((us) => us.map((u) => (u.id === id ? { ...u, subscription_status: status } : u)));
  }

  async function reset(id: string) {
    if (!confirm('Reset this learner\'s progress (mastery, current module, streak)? Account is kept.')) return;
    const t = await token();
    if (!t) return;
    await fetch(`${API}/api/admin/users/${id}/reset`, { method: 'POST', headers: { Authorization: `Bearer ${t}` } });
    await load(q);
  }

  return (
    <div className="rounded-2xl bg-white border border-gray-100 p-5">
      <div className="flex items-center gap-2 mb-4">
        <h3 className="font-semibold text-gray-800 text-sm flex-1">Users</h3>
        <input value={q} onChange={(e) => setQ(e.target.value)} onKeyDown={(e) => e.key === 'Enter' && load(q)}
          placeholder="Search email/name…" className="border border-gray-300 rounded-md px-2 py-1 text-sm" />
        <button onClick={() => load(q)} className="text-sm text-indigo-600 hover:underline">Search</button>
      </div>
      {loading ? <p className="text-sm text-gray-400">Loading…</p> : (
        <div className="overflow-x-auto">
          <table className="w-full text-sm">
            <thead><tr className="text-left text-xs text-gray-400">
              <th className="py-1">Email</th><th>Plan</th><th>Mastery</th><th>Streak</th><th>Sessions</th><th></th>
            </tr></thead>
            <tbody>
              {users.map((u) => (
                <tr key={u.id} className="border-t border-gray-100">
                  <td className="py-1.5">
                    <div className="text-gray-800">{u.email}</div>
                    {u.name && <div className="text-xs text-gray-400">{u.name}</div>}
                  </td>
                  <td>
                    <select value={u.subscription_status} onChange={(e) => setSub(u.id, e.target.value)}
                      className="text-xs border border-gray-300 rounded px-1.5 py-1">
                      {STATUSES.map((s) => <option key={s} value={s}>{s}</option>)}
                    </select>
                  </td>
                  <td>{Math.round(u.overall_mastery)}%</td>
                  <td>{u.streak_days}🔥</td>
                  <td>{u.sessions}</td>
                  <td><button onClick={() => reset(u.id)} className="text-xs text-red-500 hover:underline">Reset</button></td>
                </tr>
              ))}
              {users.length === 0 && <tr><td colSpan={6} className="py-2 text-gray-400">No users.</td></tr>}
            </tbody>
          </table>
        </div>
      )}
    </div>
  );
}
