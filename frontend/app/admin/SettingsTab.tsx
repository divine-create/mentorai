'use client';

import { useEffect, useState } from 'react';
import { createClient } from '@/lib/supabase/client';

const API = "";

interface Model { id: string; label: string; provider: string; available: boolean }
interface Settings { defaultModel: string; questionsPerChapter: number; chunkTargetChars: number }
interface AdminUser { email: string; added_by: string; created_at: string }
interface AuditEntry { id: string; actor_email: string; action: string; detail: unknown; created_at: string }

export default function SettingsTab() {
  const supabase = createClient();
  const [settings, setSettings] = useState<Settings | null>(null);
  const [models, setModels] = useState<Model[]>([]);
  const [defaultModel, setDefaultModel] = useState('');
  const [questionsPerChapter, setQuestionsPerChapter] = useState(10);
  const [chunkTargetChars, setChunkTargetChars] = useState(2000);
  const [savingSettings, setSavingSettings] = useState(false);
  const [settingsMessage, setSettingsMessage] = useState('');
  const [admins, setAdmins] = useState<AdminUser[]>([]);
  const [envAdmins, setEnvAdmins] = useState<string[]>([]);
  const [newAdminEmail, setNewAdminEmail] = useState('');
  const [addingAdmin, setAddingAdmin] = useState(false);
  const [adminMessage, setAdminMessage] = useState('');
  const [auditEntries, setAuditEntries] = useState<AuditEntry[]>([]);
  const [loadingAudit, setLoadingAudit] = useState(true);
  const [emailConfigured, setEmailConfigured] = useState<boolean | null>(null);
  const [sendingWeekly, setSendingWeekly] = useState(false);
  const [weeklyMessage, setWeeklyMessage] = useState('');

  async function token() {
    const { data: { session } } = await supabase.auth.getSession();
    return session?.access_token ?? null;
  }

  async function loadSettings() {
    const t = await token();
    if (!t) return;
    const res = await fetch(`${API}/api/admin/settings`, { headers: { Authorization: `Bearer ${t}` } });
    if (!res.ok) return;
    const data = await res.json();
    const s: Settings = data.settings;
    setSettings(s);
    setDefaultModel(s.defaultModel);
    setQuestionsPerChapter(s.questionsPerChapter);
    setChunkTargetChars(s.chunkTargetChars);
    setModels(data.models ?? []);
  }

  async function saveSettings() {
    setSettingsMessage('');
    setSavingSettings(true);
    try {
      const t = await token();
      if (!t) return;
      const body: Record<string, unknown> = {};
      if (defaultModel !== settings?.defaultModel) body.defaultModel = defaultModel;
      if (questionsPerChapter !== settings?.questionsPerChapter) body.questionsPerChapter = questionsPerChapter;
      if (chunkTargetChars !== settings?.chunkTargetChars) body.chunkTargetChars = chunkTargetChars;
      const res = await fetch(`${API}/api/admin/settings`, {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${t}` },
        body: JSON.stringify(body),
      });
      if (res.ok) { setSettingsMessage('Settings saved.'); await loadSettings(); }
      else { const err = await res.json().catch(() => ({ error: 'Save failed' })); setSettingsMessage(err.error ?? 'Save failed'); }
    } finally { setSavingSettings(false); }
  }

  async function loadAdmins() {
    const t = await token();
    if (!t) return;
    const res = await fetch(`${API}/api/admin/admins`, { headers: { Authorization: `Bearer ${t}` } });
    if (!res.ok) return;
    const data = await res.json();
    setAdmins(data.admins ?? []);
    setEnvAdmins(data.envAdmins ?? []);
  }

  async function addAdmin(e: React.FormEvent) {
    e.preventDefault();
    if (!newAdminEmail.trim()) return;
    setAdminMessage('');
    setAddingAdmin(true);
    try {
      const t = await token();
      if (!t) return;
      const res = await fetch(`${API}/api/admin/admins`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${t}` },
        body: JSON.stringify({ email: newAdminEmail.trim() }),
      });
      if (res.ok) { setNewAdminEmail(''); setAdminMessage('Admin added.'); await loadAdmins(); }
      else { const err = await res.json().catch(() => ({ error: 'Failed to add admin' })); setAdminMessage(err.error ?? 'Failed to add admin'); }
    } finally { setAddingAdmin(false); }
  }

  async function removeAdmin(email: string) {
    if (!confirm(`Remove admin ${email}?`)) return;
    setAdminMessage('');
    const t = await token();
    if (!t) return;
    const res = await fetch(`${API}/api/admin/admins/${encodeURIComponent(email)}`, { method: 'DELETE', headers: { Authorization: `Bearer ${t}` } });
    if (res.ok) { setAdminMessage('Admin removed.'); await loadAdmins(); }
    else { const err = await res.json().catch(() => ({ error: 'Failed to remove admin' })); setAdminMessage(err.error ?? 'Failed to remove admin'); }
  }

  async function loadAudit() {
    setLoadingAudit(true);
    const t = await token();
    if (!t) return;
    const res = await fetch(`${API}/api/admin/audit`, { headers: { Authorization: `Bearer ${t}` } });
    if (res.ok) { const data = await res.json(); setAuditEntries(data.entries ?? []); }
    setLoadingAudit(false);
  }

  async function loadNotifyStatus() {
    const t = await token();
    if (!t) return;
    const res = await fetch(`${API}/api/admin/notifications/status`, { headers: { Authorization: `Bearer ${t}` } });
    if (res.ok) { const data = await res.json(); setEmailConfigured(!!data.emailConfigured); }
  }

  async function runWeeklyEmails() {
    setWeeklyMessage('');
    setSendingWeekly(true);
    try {
      const t = await token();
      if (!t) return;
      const res = await fetch(`${API}/api/admin/notifications/weekly`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${t}` },
        body: JSON.stringify({ force: true }),
      });
      const data = await res.json().catch(() => ({}));
      if (res.ok) {
        setWeeklyMessage(
          `Processed ${data.processed}: ${data.sent} sent, ${data.generated} generated, ${data.skipped} skipped, ${data.failed} failed.`
        );
        await loadAudit();
      } else {
        setWeeklyMessage(data.error ?? 'Run failed');
      }
    } finally {
      setSendingWeekly(false);
    }
  }

  useEffect(() => { loadSettings(); loadAdmins(); loadAudit(); loadNotifyStatus(); /* eslint-disable-next-line react-hooks/exhaustive-deps */ }, []);

  const availableModels = models.filter((m) => m.available);

  return (
    <div className="space-y-6">
      {/* Panel 1: App Settings */}
      <Panel title="App Settings">
        <div className="space-y-4">
          <div>
            <label className="block text-xs text-gray-500 mb-1">Default model</label>
            <select value={defaultModel} onChange={(e) => setDefaultModel(e.target.value)}
              className="w-full border border-gray-300 rounded-md px-3 py-2 text-sm bg-white">
              {availableModels.length === 0 && <option value="">No available models</option>}
              {availableModels.map((m) => (<option key={m.id} value={m.id}>{m.label} ({m.provider})</option>))}
            </select>
          </div>
          <div>
            <label className="block text-xs text-gray-500 mb-1">Questions per chapter ({questionsPerChapter})</label>
            <input type="number" min={1} max={15} value={questionsPerChapter}
              onChange={(e) => setQuestionsPerChapter(Math.max(1, Math.min(15, Number(e.target.value) || 1)))}
              onBlur={() => setQuestionsPerChapter(Math.max(1, Math.min(15, questionsPerChapter)))}
              className="w-full border border-gray-300 rounded-md px-3 py-2 text-sm" />
            <p className="text-[11px] text-gray-400 mt-0.5">Clamped between 1 and 15.</p>
          </div>
          <div>
            <label className="block text-xs text-gray-500 mb-1">Chunk target characters ({chunkTargetChars.toLocaleString()})</label>
            <input type="number" min={500} max={4000} step={100} value={chunkTargetChars}
              onChange={(e) => setChunkTargetChars(Math.max(500, Math.min(4000, Number(e.target.value) || 500)))}
              onBlur={() => setChunkTargetChars(Math.max(500, Math.min(4000, chunkTargetChars)))}
              className="w-full border border-gray-300 rounded-md px-3 py-2 text-sm" />
            <p className="text-[11px] text-gray-400 mt-0.5">Clamped between 500 and 4,000.</p>
          </div>
          <div className="flex items-center gap-3">
            <button onClick={saveSettings} disabled={savingSettings}
              className="rounded-md bg-indigo-600 text-white px-5 py-2 text-sm font-medium hover:bg-indigo-700 disabled:opacity-50">
              {savingSettings ? 'Saving…' : 'Save'}
            </button>
            {settingsMessage && <span className={`text-sm ${settingsMessage === 'Settings saved.' ? 'text-green-600' : 'text-red-600'}`}>{settingsMessage}</span>}
          </div>
        </div>
      </Panel>

      {/* Panel 2: Admin Management */}
      <Panel title="Admin Management">
        <div className="space-y-4">
          {envAdmins.length > 0 && (
            <div>
              <p className="text-xs text-gray-500 mb-1.5">Environment admins (read-only, set via env vars):</p>
              <div className="flex flex-wrap gap-2">
                {envAdmins.map((email) => (<span key={email} className="rounded-full bg-gray-100 px-3 py-1 text-xs text-gray-600">{email}</span>))}
              </div>
            </div>
          )}
          <div>
            <p className="text-xs text-gray-500 mb-1.5">Database admins (managed here):</p>
            <table className="w-full text-sm">
              <thead>
                <tr className="text-left text-xs text-gray-400">
                  <th className="py-1">Email</th><th>Added by</th><th>Added at</th><th></th>
                </tr>
              </thead>
              <tbody>
                {admins.length === 0 && <tr><td colSpan={4} className="py-2 text-gray-400">No additional admins.</td></tr>}
                {admins.map((a) => (
                  <tr key={a.email} className="border-t border-gray-100">
                    <td className="py-1.5 text-gray-800">{a.email}</td>
                    <td className="text-gray-500">{a.added_by}</td>
                    <td className="text-gray-500">{new Date(a.created_at).toLocaleString()}</td>
                    <td><button onClick={() => removeAdmin(a.email)} className="text-xs text-red-500 hover:underline">Remove</button></td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
          <form onSubmit={addAdmin} className="flex items-center gap-2">
            <input type="email" placeholder="admin@example.com" value={newAdminEmail}
              onChange={(e) => setNewAdminEmail(e.target.value)}
              className="flex-1 border border-gray-300 rounded-md px-3 py-2 text-sm" required />
            <button type="submit" disabled={addingAdmin || !newAdminEmail.trim()}
              className="rounded-md bg-indigo-600 text-white px-4 py-2 text-sm font-medium hover:bg-indigo-700 disabled:opacity-50">
              {addingAdmin ? 'Adding…' : 'Add'}
            </button>
          </form>
          {adminMessage && <p className={`text-sm ${adminMessage === 'Admin added.' || adminMessage === 'Admin removed.' ? 'text-green-600' : 'text-red-600'}`}>{adminMessage}</p>}
        </div>
      </Panel>

      {/* Panel 3: Re-engagement */}
      <Panel title="Re-engagement Emails">
        <div className="space-y-3">
          <p className="text-sm text-gray-600">
            Generate this week&apos;s progress email for every learner. {emailConfigured === null
              ? ''
              : emailConfigured
              ? 'An email transport is configured — messages will be sent.'
              : 'No email transport configured (set RESEND_API_KEY) — content is generated and logged but not sent.'}
          </p>
          <div className="flex items-center gap-3">
            <button onClick={runWeeklyEmails} disabled={sendingWeekly}
              className="rounded-md bg-indigo-600 text-white px-5 py-2 text-sm font-medium hover:bg-indigo-700 disabled:opacity-50">
              {sendingWeekly ? 'Running…' : 'Run weekly emails'}
            </button>
            {weeklyMessage && <span className="text-sm text-gray-600">{weeklyMessage}</span>}
          </div>
        </div>
      </Panel>

      {/* Panel 4: Audit Log */}
      <Panel title="Audit Log">
        {loadingAudit ? <p className="text-sm text-gray-400">Loading…</p>
        : auditEntries.length === 0 ? <p className="text-sm text-gray-400">No audit entries yet.</p>
        : (
          <div className="overflow-x-auto">
            <table className="w-full text-sm">
              <thead>
                <tr className="text-left text-xs text-gray-400">
                  <th className="py-1">Actor</th><th>Action</th><th>Detail</th><th>Timestamp</th>
                </tr>
              </thead>
              <tbody>
                {auditEntries.map((e) => (
                  <tr key={e.id} className="border-t border-gray-100">
                    <td className="py-1.5 text-gray-800 whitespace-nowrap">{e.actor_email}</td>
                    <td className="text-gray-600 whitespace-nowrap">{e.action}</td>
                    <td className="text-gray-500 max-w-xs truncate">
                      {e.detail != null ? (
                        <span className="cursor-help" title={typeof e.detail === 'string' ? e.detail : JSON.stringify(e.detail, null, 2)}>
                          {typeof e.detail === 'string'
                            ? (e.detail.length > 80 ? e.detail.slice(0, 80) + '…' : e.detail)
                            : (JSON.stringify(e.detail).length > 80 ? JSON.stringify(e.detail).slice(0, 80) + '…' : JSON.stringify(e.detail))}
                        </span>
                      ) : <span className="text-gray-300">—</span>}
                    </td>
                    <td className="text-gray-500 whitespace-nowrap">{new Date(e.created_at).toLocaleString()}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </Panel>
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


