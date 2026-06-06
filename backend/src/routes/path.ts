import { Router } from 'express';
import { db } from '../db/pool';
import { requireAuth, AuthRequest } from '../middleware/auth';

const router = Router();

// GET /api/path
// Returns modules with the learner's mastery score and lock state.
// Filters by the user's active subject.
router.get('/', requireAuth, async (req: AuthRequest, res) => {
  try {
    // Get the user's active subject
    const profileResult = await db.query(
      `SELECT current_module_id, overall_mastery, streak_days, last_session_at, active_subject_id
       FROM learner_profiles WHERE user_id = $1`,
      [req.userId]
    );

    const profile = profileResult.rows[0];
    const activeSubjectId = profile?.active_subject_id;

    if (!activeSubjectId) {
      res.json({
        modules: [],
        profile: profile ?? null,
        subject: null,
      });
      return;
    }

    // Get subject details
    const subjectResult = await db.query(
      `SELECT id, name, slug, description, icon, order_index, practice_kind, mastery_weights
       FROM subjects WHERE id = $1`,
      [activeSubjectId]
    );

    const subject = subjectResult.rows[0] ?? null;

    // Get modules for the active subject
    const result = await db.query(
      `SELECT
         m.id, m.slug, m.title, m.description, m.order_index,
         m.estimated_hours_min, m.estimated_hours_max,
         COALESCE(mm.mastery_score, 0)  AS mastery_score,
         COALESCE(mm.attempts, 0)       AS attempts,
         COALESCE(mm.unlocked, false)   AS unlocked,
         mm.last_assessed_at
       FROM modules m
       LEFT JOIN module_mastery mm
         ON mm.module_id = m.id AND mm.user_id = $1
       WHERE m.subject_id = $2 AND m.published = true
       ORDER BY m.order_index`,
      [req.userId, activeSubjectId]
    );

    res.json({
      modules: result.rows,
      profile: profile ?? null,
      subject: subject,
    });
  } catch (err) {
    console.error('path error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

export default router;
