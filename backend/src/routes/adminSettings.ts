import { Router } from 'express';
import { db } from '../db/pool';
import { requireAuth, AuthRequest } from '../middleware/auth';
import { requireAdmin } from '../middleware/admin';
import { logAudit } from '../services/audit';
import { getSettings, setSetting } from '../services/settings';
import { listModels, isValidModelId } from '../services/llm';

const router = Router();
router.use(requireAuth, requireAdmin);

// GET /api/admin/settings — current settings + available models for the dropdown.
router.get('/settings', async (_req, res) => {
  try {
    res.json({ settings: await getSettings(), models: listModels() });
  } catch (err) {
    console.error('admin settings get error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// PATCH /api/admin/settings — update any provided setting.
router.patch('/settings', async (req: AuthRequest, res) => {
  const { defaultModel, questionsPerChapter, chunkTargetChars } = req.body as Record<string, unknown>;
  try {
    if (defaultModel !== undefined) {
      if (!isValidModelId(String(defaultModel))) { res.status(400).json({ error: 'invalid defaultModel' }); return; }
      await setSetting('defaultModel', String(defaultModel));
    }
    if (questionsPerChapter !== undefined) {
      await setSetting('questionsPerChapter', Math.max(1, Math.min(15, Number(questionsPerChapter) || 5)));
    }
    if (chunkTargetChars !== undefined) {
      await setSetting('chunkTargetChars', Math.max(500, Math.min(4000, Number(chunkTargetChars) || 1500)));
    }
    logAudit(req.adminEmail, 'settings.update', req.body);
    res.json({ settings: await getSettings() });
  } catch (err) {
    console.error('admin settings patch error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// ─── Admin allowlist (table; env admins are shown read-only) ──────────────────
router.get('/admins', async (_req, res) => {
  try {
    const table = await db.query(`SELECT email, added_by, created_at FROM admin_users ORDER BY created_at`);
    const env = (process.env.ADMIN_EMAILS ?? '').split(',').map((e) => e.trim().toLowerCase()).filter(Boolean);
    res.json({ admins: table.rows, envAdmins: env });
  } catch (err) {
    console.error('admin admins list error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

router.post('/admins', async (req: AuthRequest, res) => {
  const email = String((req.body as { email?: string }).email ?? '').trim().toLowerCase();
  if (!email || !email.includes('@')) { res.status(400).json({ error: 'valid email required' }); return; }
  try {
    await db.query(
      `INSERT INTO admin_users (email, added_by) VALUES ($1, $2) ON CONFLICT (email) DO NOTHING`,
      [email, req.adminEmail ?? null]
    );
    logAudit(req.adminEmail, 'admin.add', { email });
    res.status(201).json({ success: true });
  } catch (err) {
    console.error('admin admins add error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

router.delete('/admins/:email', async (req: AuthRequest, res) => {
  try {
    await db.query('DELETE FROM admin_users WHERE lower(email) = lower($1)', [req.params.email]);
    logAudit(req.adminEmail, 'admin.remove', { email: req.params.email });
    res.json({ success: true });
  } catch (err) {
    console.error('admin admins remove error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// GET /api/admin/audit — recent admin actions.
router.get('/audit', async (_req, res) => {
  try {
    const r = await db.query(`SELECT id, actor_email, action, detail, created_at FROM admin_audit_log ORDER BY created_at DESC LIMIT 100`);
    res.json({ entries: r.rows });
  } catch (err) {
    console.error('admin audit error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

export default router;
