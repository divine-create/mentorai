import { Router } from 'express';
import { db } from '../db/pool';
import { requireAuth, AuthRequest } from '../middleware/auth';

const router = Router();

// ─── GET /api/subjects ────────────────────────────────────────────────────────
// Returns all available subjects for the current user
router.get('/', requireAuth, async (req: AuthRequest, res) => {
  try {
    const result = await db.query(
      `SELECT id, name, slug, description, icon, order_index, practice_kind, mastery_weights
       FROM subjects
       ORDER BY order_index`
    );
    res.json(result.rows);
  } catch (err) {
    console.error('subjects/list error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// ─── GET /api/subjects/overview ───────────────────────────────────────────────
// Per-learner rollup for the dashboard course catalog: one row per available
// subject with total/completed module counts, average mastery, and whether the
// learner has started it (any mastery or session progress) or it is active.
// `started || active` = "enrolled" on the dashboard. Read-only.
// NOTE: declared before '/:subjectId' so the literal path isn't captured by the
// param route.
router.get('/overview', requireAuth, async (req: AuthRequest, res) => {
  try {
    const result = await db.query(
      `SELECT s.id, s.slug, s.name, s.description, s.icon, s.order_index, s.practice_kind,
              COUNT(DISTINCT m.id)                                       AS total_modules,
              COUNT(DISTINCT m.id) FILTER (WHERE mm.mastery_score >= 80) AS completed_modules,
              COALESCE(ROUND(AVG(mm.mastery_score) FILTER (WHERE mm.id IS NOT NULL)), 0) AS avg_mastery,
              (COUNT(mm.id) > 0 OR COUNT(sess.id) > 0)                   AS started,
              (s.id = lp.active_subject_id)                             AS active
       FROM subjects s
       LEFT JOIN modules m          ON m.subject_id = s.id AND m.published = true
       LEFT JOIN module_mastery mm  ON mm.module_id = m.id AND mm.user_id = $1
       LEFT JOIN sessions sess      ON sess.module_id = m.id AND sess.user_id = $1
       LEFT JOIN learner_profiles lp ON lp.user_id = $1
       WHERE s.is_available = true
       GROUP BY s.id, lp.active_subject_id
       ORDER BY s.order_index`,
      [req.userId]
    );

    const subjects = result.rows.map((r) => {
      const total = Number(r.total_modules);
      const completed = Number(r.completed_modules);
      return {
        id: r.id,
        slug: r.slug,
        name: r.name,
        description: r.description,
        icon: r.icon,
        practice_kind: r.practice_kind,
        total_modules: total,
        completed_modules: completed,
        avg_mastery: Number(r.avg_mastery),
        progress_pct: total > 0 ? Math.round((completed / total) * 100) : 0,
        started: r.started,
        active: r.active,
      };
    });

    res.json(subjects);
  } catch (err) {
    console.error('subjects/overview error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// ─── GET /api/subjects/:subjectId ─────────────────────────────────────────────
// Returns a specific subject with its modules
router.get('/:subjectId', requireAuth, async (req: AuthRequest, res) => {
  const { subjectId } = req.params;

  try {
    const subjectResult = await db.query(
      `SELECT id, name, slug, description, icon, order_index, practice_kind, mastery_weights
       FROM subjects
       WHERE id = $1`,
      [subjectId]
    );

    if (subjectResult.rows.length === 0) {
      res.status(404).json({ error: 'Subject not found' });
      return;
    }

    const modulesResult = await db.query(
      `SELECT id, title, slug, description, order_index
       FROM modules
       WHERE subject_id = $1
       ORDER BY order_index`,
      [subjectId]
    );

    res.json({
      ...subjectResult.rows[0],
      modules: modulesResult.rows,
    });
  } catch (err) {
    console.error('subjects/get error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// ─── POST /api/subjects/switch ────────────────────────────────────────────────
// Switch the user's active subject. Body: { subjectId }
router.post('/switch', requireAuth, async (req: AuthRequest, res) => {
  const { subjectId } = req.body as { subjectId: string };

  // Validation
  if (!subjectId || typeof subjectId !== 'string') {
    res.status(400).json({ error: 'subjectId is required and must be a string' });
    return;
  }

  try {
    // Verify the subject exists AND is currently available to learners.
    // Hidden subjects still live in the database (admins can re-enable them)
    // but learners must not be able to navigate to them.
    const subjectCheck = await db.query<{ id: number; is_available: boolean }>(
      `SELECT id, is_available FROM subjects WHERE id = $1`,
      [subjectId]
    );

    if (subjectCheck.rows.length === 0) {
      res.status(404).json({ error: 'Subject not found' });
      return;
    }
    if (!subjectCheck.rows[0].is_available) {
      res.status(403).json({ error: 'This subject is not currently available.' });
      return;
    }

    // Get or create learner profile and update active subject
    await db.query(
      `INSERT INTO learner_profiles (user_id, active_subject_id)
       VALUES ($1, $2)
       ON CONFLICT (user_id) DO UPDATE SET active_subject_id = $2`,
      [req.userId, subjectId]
    );

    // A subject is unusable until its first module is unlocked. The signup flow
    // only ever unlocks the very first subject's module 1, so unlock this
    // subject's first module (lowest order_index) here — idempotent — and point
    // current_module_id at the learner's resume position in this subject (their
    // most-advanced unlocked module, falling back to the first).
    const firstModule = await db.query<{ id: number }>(
      `SELECT id FROM modules WHERE subject_id = $1 ORDER BY order_index LIMIT 1`,
      [subjectId]
    );
    if (firstModule.rows[0]) {
      await db.query(
        `INSERT INTO module_mastery (user_id, module_id, unlocked)
         VALUES ($1, $2, true)
         ON CONFLICT (user_id, module_id) DO UPDATE SET unlocked = true`,
        [req.userId, firstModule.rows[0].id]
      );

      const resume = await db.query<{ id: number }>(
        `SELECT m.id FROM modules m
           JOIN module_mastery mm ON mm.module_id = m.id AND mm.user_id = $1
          WHERE m.subject_id = $2 AND mm.unlocked = true
          ORDER BY m.order_index DESC LIMIT 1`,
        [req.userId, subjectId]
      );
      const resumeModuleId = resume.rows[0]?.id ?? firstModule.rows[0].id;
      await db.query(
        `UPDATE learner_profiles SET current_module_id = $2 WHERE user_id = $1`,
        [req.userId, resumeModuleId]
      );
    }

    res.json({ success: true, message: 'Subject switched successfully' });
  } catch (err) {
    console.error('subjects/switch error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

export default router;
