// ─── Admin: re-engagement notifications ───────────────────────────────────────
// Lets an admin trigger the weekly progress email run (or a real cron can hit
// it). Mounted under /api/admin.

import { Router } from 'express';
import { requireAuth, AuthRequest } from '../middleware/auth';
import { requireAdmin } from '../middleware/admin';
import { runWeeklyEmails, emailConfigured } from '../services/notify';
import { logAudit } from '../services/audit';

const router = Router();

// GET /api/admin/notifications/status — is an email transport configured?
router.get('/notifications/status', requireAuth, requireAdmin, async (_req, res) => {
  res.json({ emailConfigured: emailConfigured() });
});

// POST /api/admin/notifications/weekly — generate (and send, if configured) the
// weekly progress email for all learners. Body: { force?: boolean }.
router.post('/notifications/weekly', requireAuth, requireAdmin, async (req: AuthRequest, res) => {
  try {
    const force = req.body?.force === true;
    const result = await runWeeklyEmails({ force });
    logAudit(req.adminEmail, 'notifications.weekly', { force, ...result });
    res.json(result);
  } catch (err) {
    console.error('notifications/weekly error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

export default router;
