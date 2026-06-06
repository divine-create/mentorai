import { Router } from 'express';
import { db } from '../db/pool';
import { requireAuth, AuthRequest } from '../middleware/auth';
import { requireFields, requireString, requireNumber, sendValidationErrors } from '../middleware/validate';

const router = Router();

// POST /api/auth/sync
// Called after Supabase login to ensure user row exists in our DB.
router.post('/sync', requireAuth, async (req: AuthRequest, res) => {
  try {
    const { name, email, goal, experience, startingModule } = req.body as {
      name?: string;
      email: string;
      goal?: string;
      experience?: string;
      startingModule?: number;
    };

    // --- Validation ---
    const missing = requireFields(req.body, ['email']);
    if (missing) { res.status(400).json({ error: missing }); return; }
    if (sendValidationErrors(res, [
      requireString(email, 'email'),
    ])) return;
    if (name !== undefined && sendValidationErrors(res, [requireString(name, 'name')])) return;
    if (goal !== undefined && sendValidationErrors(res, [requireString(goal, 'goal')])) return;
    if (experience !== undefined && sendValidationErrors(res, [requireString(experience, 'experience')])) return;
    if (startingModule !== undefined && sendValidationErrors(res, [requireNumber(startingModule, 'startingModule')])) return;

    const result = await db.query<{ id: string; subscription_status: string; goal: string | null }>(
      `INSERT INTO users (id, email, name, goal, experience)
       VALUES ($1, $2, $3, $4, $5)
       ON CONFLICT (id) DO UPDATE SET
         name = COALESCE(EXCLUDED.name, users.name),
         goal = COALESCE(EXCLUDED.goal, users.goal),
         experience = COALESCE(EXCLUDED.experience, users.experience),
         updated_at = NOW()
       RETURNING id, subscription_status, goal`,
      [req.userId, email, name ?? null, goal ?? null, experience ?? null]
    );

    const user = result.rows[0];

    // Get default subject — prefer `python-native`, fall back to the first
    // AVAILABLE subject. This makes the signup flow robust even when the
    // curated set of subjects changes.
    const defaultSubject = await db.query<{ id: number }>(
      `SELECT id FROM subjects
       WHERE is_available = true
       ORDER BY (slug = 'python-native') DESC, order_index ASC
       LIMIT 1`
    );
    const defaultSubjectId = defaultSubject.rows[0]?.id ?? null;

    // Ensure learner_profile row exists; set starting module and active subject if provided
    await db.query(
      `INSERT INTO learner_profiles (user_id, current_module_id, active_subject_id)
       VALUES ($1, $2, $3)
       ON CONFLICT (user_id) DO UPDATE SET
         current_module_id = COALESCE($2, learner_profiles.current_module_id),
         active_subject_id = COALESCE(learner_profiles.active_subject_id, $3)`,
      [req.userId, startingModule ?? null, defaultSubjectId]
    );

    // Unlock module 1 (and starting module if different) for this user
    const modulesToUnlock = Array.from(new Set([1, startingModule ?? 1]));
    for (const modId of modulesToUnlock) {
      await db.query(
        `INSERT INTO module_mastery (user_id, module_id, unlocked)
         VALUES ($1, $2, true)
         ON CONFLICT (user_id, module_id) DO UPDATE SET unlocked = true`,
        [req.userId, modId]
      );
    }

    res.json({ user, experience, startingModule });
  } catch (err) {
    console.error('auth/sync error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// GET /api/auth/me
router.get('/me', requireAuth, async (req: AuthRequest, res) => {
  try {
    const result = await db.query(
      `SELECT u.id, u.email, u.name, u.subscription_status, u.goal,
              lp.current_module_id, lp.overall_mastery, lp.streak_days
       FROM users u
       LEFT JOIN learner_profiles lp ON lp.user_id = u.id
       WHERE u.id = $1`,
      [req.userId]
    );
    if (!result.rows[0]) {
      res.status(404).json({ error: 'User not found' });
      return;
    }
    res.json(result.rows[0]);
  } catch (err) {
    console.error('auth/me error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

export default router;
