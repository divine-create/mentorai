import { Router } from 'express';
import { db } from '../db/pool';
import { requireAuth, AuthRequest } from '../middleware/auth';
import { requireAdmin } from '../middleware/admin';
import { logAudit } from '../services/audit';

const router = Router();
router.use(requireAuth, requireAdmin);

const SUB_STATUSES = ['free', 'pro', 'annual', 'cancelled'];

// GET /api/admin/users — learners with progress + subscription.
router.get('/users', async (req, res) => {
  const q = typeof req.query.q === 'string' ? req.query.q.trim() : '';
  try {
    const result = await db.query(
      `SELECT u.id, u.email, u.name, u.subscription_status, u.created_at,
              COALESCE(lp.overall_mastery, 0) AS overall_mastery,
              COALESCE(lp.streak_days, 0) AS streak_days,
              lp.last_session_at,
              (SELECT COUNT(*) FROM sessions s WHERE s.user_id = u.id)::int AS sessions
       FROM users u LEFT JOIN learner_profiles lp ON lp.user_id = u.id
       ${q ? 'WHERE u.email ILIKE $1 OR u.name ILIKE $1' : ''}
       ORDER BY u.created_at DESC LIMIT 500`,
      q ? [`%${q}%`] : []
    );
    res.json({ users: result.rows });
  } catch (err) {
    console.error('admin users list error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// PATCH /api/admin/users/:id/subscription — grant/revoke Pro etc.
router.patch('/users/:id/subscription', async (req: AuthRequest, res) => {
  const { status } = req.body as { status?: string };
  if (!status || !SUB_STATUSES.includes(status)) {
    res.status(400).json({ error: `status must be one of: ${SUB_STATUSES.join(', ')}` });
    return;
  }
  try {
    const r = await db.query(
      `UPDATE users SET subscription_status = $2, updated_at = NOW() WHERE id = $1 RETURNING id, email, subscription_status`,
      [req.params.id, status]
    );
    if (!r.rows[0]) { res.status(404).json({ error: 'User not found' }); return; }
    logAudit(req.adminEmail, 'user.subscription', { id: req.params.id, status });
    res.json({ user: r.rows[0] });
  } catch (err) {
    console.error('admin users subscription error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// POST /api/admin/users/:id/reset — wipe a learner's progress (keeps the account).
router.post('/users/:id/reset', async (req: AuthRequest, res) => {
  try {
    await db.query('BEGIN');
    await db.query('DELETE FROM module_mastery WHERE user_id = $1', [req.params.id]);
    await db.query(
      `UPDATE learner_profiles
       SET overall_mastery = 0, current_module_id = NULL, weak_concept_ids = '{}', strong_concept_ids = '{}',
           streak_days = 0, last_session_at = NULL
       WHERE user_id = $1`,
      [req.params.id]
    );
    await db.query('COMMIT');
    logAudit(req.adminEmail, 'user.resetProgress', { id: req.params.id });
    res.json({ success: true });
  } catch (err) {
    await db.query('ROLLBACK').catch(() => {});
    console.error('admin users reset error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

export default router;
