import { Router } from 'express';
import { db } from '../db/pool';
import { requireAuth, AuthRequest } from '../middleware/auth';
import { requireFields, requireString, sendValidationErrors } from '../middleware/validate';
import { reviewWebSubmission } from '../services/projectReview';
import { getUserModelId } from './models';

const router = Router();

// GET /api/projects — projects for the learner's active subject, each annotated
// with the learner's latest submission status.
router.get('/', requireAuth, async (req: AuthRequest, res) => {
  try {
    const profile = await db.query<{ active_subject_id: number }>(
      `SELECT active_subject_id FROM learner_profiles WHERE user_id = $1`,
      [req.userId]
    );
    const subjectId = profile.rows[0]?.active_subject_id;
    if (!subjectId) { res.json({ projects: [] }); return; }

    const result = await db.query(
      `SELECT p.id, p.slug, p.title, p.order_index,
              COALESCE(ls.passed, false) AS passed,
              ls.created_at AS last_submitted_at
       FROM projects p
       LEFT JOIN LATERAL (
         SELECT passed, created_at FROM project_submissions
         WHERE project_id = p.id AND user_id = $1
         ORDER BY created_at DESC LIMIT 1
       ) ls ON true
       WHERE p.subject_id = $2
       ORDER BY p.order_index`,
      [req.userId, subjectId]
    );
    res.json({ projects: result.rows });
  } catch (err) {
    console.error('projects/list error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// GET /api/projects/:id — full project, plus the learner's latest submission
// (so the workspace restores their work and last review).
router.get('/:id', requireAuth, async (req: AuthRequest, res) => {
  try {
    const projResult = await db.query(
      `SELECT id, subject_id, slug, title, brief, starter, acceptance_criteria, order_index
       FROM projects WHERE id = $1`,
      [req.params.id]
    );
    const project = projResult.rows[0];
    if (!project) { res.status(404).json({ error: 'Project not found' }); return; }

    const subResult = await db.query(
      `SELECT content, passed, feedback, criteria_results, created_at
       FROM project_submissions
       WHERE project_id = $1 AND user_id = $2
       ORDER BY created_at DESC LIMIT 1`,
      [req.params.id, req.userId]
    );
    res.json({ project, submission: subResult.rows[0] ?? null });
  } catch (err) {
    console.error('projects/get error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// POST /api/projects/:id/submit — { html, css } → tutor reviews against the
// acceptance criteria, persists the submission, returns the result.
router.post('/:id/submit', requireAuth, async (req: AuthRequest, res) => {
  const { html, css } = req.body as { html: string; css: string };

  const missing = requireFields(req.body, ['html', 'css']);
  if (missing) { res.status(400).json({ error: missing }); return; }
  if (sendValidationErrors(res, [requireString(html, 'html'), requireString(css, 'css')])) return;

  try {
    const projResult = await db.query<{ brief: string; acceptance_criteria: string[] }>(
      `SELECT brief, acceptance_criteria FROM projects WHERE id = $1`,
      [req.params.id]
    );
    const project = projResult.rows[0];
    if (!project) { res.status(404).json({ error: 'Project not found' }); return; }

    const review = await reviewWebSubmission({
      modelId: await getUserModelId(req.userId!),
      brief: project.brief,
      criteria: Array.isArray(project.acceptance_criteria) ? project.acceptance_criteria : [],
      html,
      css,
    });

    await db.query(
      `INSERT INTO project_submissions (user_id, project_id, content, passed, feedback, criteria_results)
       VALUES ($1, $2, $3, $4, $5, $6)`,
      [
        req.userId,
        req.params.id,
        JSON.stringify({ html, css }),
        review.passed,
        review.feedback,
        JSON.stringify(review.criteriaResults),
      ]
    );

    res.json(review);
  } catch (err) {
    console.error('projects/submit error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

export default router;
