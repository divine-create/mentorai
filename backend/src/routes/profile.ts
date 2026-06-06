import { Router } from 'express';
import { db } from '../db/pool';
import { requireAuth, AuthRequest } from '../middleware/auth';
import { requireString, requireOneOf, sendValidationErrors } from '../middleware/validate';

// Allowed onboarding experience levels (kept in sync with the signup flow's
// EXPERIENCE_LEVELS in frontend/app/onboarding/page.tsx).
const EXPERIENCE_LEVELS = ['none', 'some', 'intermediate'] as const;

const router = Router();

// ─── GET /api/profile ─────────────────────────────────────────────────────────
// Everything the learner profile page needs: identity, lifetime learning stats,
// and recent session activity. Read-only.
router.get('/', requireAuth, async (req: AuthRequest, res) => {
  try {
    const [userRow, statsRow, qaRow, recentRows] = await Promise.all([
      db.query(
        `SELECT u.email, u.name, u.goal, u.experience, u.subscription_status, u.created_at,
                lp.streak_days, lp.overall_mastery
         FROM users u
         LEFT JOIN learner_profiles lp ON lp.user_id = u.id
         WHERE u.id = $1`,
        [req.userId]
      ),
      // Completed sessions + total study time + modules completed.
      db.query<{ sessions: string; seconds: string; modules_completed: string }>(
        `SELECT
           (SELECT COUNT(*) FROM sessions
              WHERE user_id = $1 AND ended_at IS NOT NULL)                   AS sessions,
           (SELECT COALESCE(SUM(EXTRACT(EPOCH FROM (ended_at - started_at))), 0)
              FROM sessions WHERE user_id = $1 AND ended_at IS NOT NULL)      AS seconds,
           (SELECT COUNT(*) FROM module_mastery
              WHERE user_id = $1 AND mastery_score >= 80)                     AS modules_completed`,
        [req.userId]
      ),
      // Questions answered + accuracy over all graded attempts.
      db.query<{ answered: string; correct: string }>(
        `SELECT COUNT(*) AS answered, COUNT(*) FILTER (WHERE is_correct) AS correct
         FROM quiz_attempts WHERE user_id = $1`,
        [req.userId]
      ),
      // Recent completed sessions with their AI summary.
      db.query(
        `SELECT m.title AS module_title, m.slug AS module_slug,
                s.started_at, s.ended_at, s.summary_text,
                EXTRACT(EPOCH FROM (s.ended_at - s.started_at))::int AS duration_seconds
         FROM sessions s
         JOIN modules m ON m.id = s.module_id
         WHERE s.user_id = $1 AND s.ended_at IS NOT NULL
         ORDER BY s.ended_at DESC
         LIMIT 8`,
        [req.userId]
      ),
    ]);

    const u = userRow.rows[0];
    if (!u) { res.status(404).json({ error: 'User not found' }); return; }

    const stats = statsRow.rows[0];
    const qa = qaRow.rows[0];
    const answered = Number(qa?.answered ?? 0);
    const correct = Number(qa?.correct ?? 0);

    res.json({
      profile: {
        name: u.name,
        email: u.email,
        goal: u.goal,
        experience: u.experience,
        subscription_status: u.subscription_status,
        created_at: u.created_at,
        streak_days: u.streak_days ?? 0,
        overall_mastery: Math.round(Number(u.overall_mastery ?? 0)),
      },
      stats: {
        totalSessions: Number(stats?.sessions ?? 0),
        totalMinutes: Math.round(Number(stats?.seconds ?? 0) / 60),
        questionsAnswered: answered,
        accuracyPct: answered > 0 ? Math.round((correct / answered) * 100) : 0,
        modulesCompleted: Number(stats?.modules_completed ?? 0),
      },
      recentSessions: recentRows.rows.map((r) => ({
        moduleTitle: r.module_title,
        moduleSlug: r.module_slug,
        endedAt: r.ended_at,
        durationMinutes: Math.max(1, Math.round(Number(r.duration_seconds ?? 0) / 60)),
        summary: r.summary_text,
      })),
    });
  } catch (err) {
    console.error('profile/get error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// ─── PATCH /api/profile ───────────────────────────────────────────────────────
// Update the learner-editable identity fields (name, goal). Both optional;
// only provided fields are changed.
router.patch('/', requireAuth, async (req: AuthRequest, res) => {
  const { name, goal, experience } = req.body as { name?: string; goal?: string; experience?: string };

  const checks = [];
  if (name !== undefined) checks.push(requireString(name, 'name'));
  if (goal !== undefined) checks.push(requireString(goal, 'goal'));
  if (experience !== undefined) checks.push(requireOneOf(experience, 'experience', EXPERIENCE_LEVELS));
  if (checks.length && sendValidationErrors(res, checks)) return;

  if (name === undefined && goal === undefined && experience === undefined) {
    res.status(400).json({ error: 'Nothing to update — provide name, goal, and/or experience.' });
    return;
  }

  try {
    const result = await db.query<{ name: string; goal: string | null; experience: string | null }>(
      `UPDATE users SET
         name = COALESCE($2, name),
         goal = COALESCE($3, goal),
         experience = COALESCE($4, experience),
         updated_at = NOW()
       WHERE id = $1
       RETURNING name, goal, experience`,
      [req.userId, name ?? null, goal ?? null, experience ?? null]
    );
    res.json(result.rows[0]);
  } catch (err) {
    console.error('profile/patch error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

export default router;
