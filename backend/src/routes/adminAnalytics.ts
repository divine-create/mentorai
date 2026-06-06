import { Router } from 'express';
import { db } from '../db/pool';
import { requireAuth, AuthRequest } from '../middleware/auth';
import { requireAdmin } from '../middleware/admin';

const router = Router();
router.use(requireAuth, requireAdmin);

// GET /api/admin/analytics — platform overview.
router.get('/analytics', async (_req, res) => {
  try {
    const overview = await db.query(
      `SELECT
         (SELECT COUNT(*) FROM users) AS total_users,
         (SELECT COUNT(DISTINCT user_id) FROM sessions WHERE started_at > NOW() - INTERVAL '7 days') AS active_7d,
         (SELECT COUNT(*) FROM sessions) AS total_sessions,
         (SELECT COUNT(*) FROM books) AS total_books`
    );
    const subscriptions = await db.query(
      `SELECT subscription_status, COUNT(*)::int AS n FROM users GROUP BY subscription_status`
    );
    const subjects = await db.query(
      `SELECT s.id, s.name, s.icon,
              COUNT(DISTINCT m.id)::int AS modules,
              COALESCE(ROUND(AVG(mm.mastery_score)), 0)::int AS avg_mastery,
              COUNT(mm.*) FILTER (WHERE mm.mastery_score >= 80)::int AS completions
       FROM subjects s
       LEFT JOIN modules m ON m.subject_id = s.id AND m.published = true
       LEFT JOIN module_mastery mm ON mm.module_id = m.id
       GROUP BY s.id
       ORDER BY s.order_index`
    );
    res.json({
      overview: overview.rows[0],
      subscriptions: subscriptions.rows,
      subjects: subjects.rows,
    });
  } catch (err) {
    console.error('admin/analytics error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// GET /api/admin/analytics/questions?subjectId= — per-question performance, so an
// admin can spot (and fix) weak questions. Includes groundedness for faithfulness.
router.get('/analytics/questions', async (req, res) => {
  const subjectId = req.query.subjectId ? Number(req.query.subjectId) : null;
  try {
    const result = await db.query(
      `SELECT q.id, q.prompt, q.type, q.difficulty, q.groundedness,
              m.title AS module_title, m.subject_id,
              COUNT(qa.*)::int AS attempts,
              COUNT(qa.*) FILTER (WHERE qa.is_correct)::int AS correct
       FROM questions q
       JOIN modules m ON m.id = q.module_id
       LEFT JOIN quiz_attempts qa ON qa.question_id = q.id
       ${subjectId ? 'WHERE m.subject_id = $1' : ''}
       GROUP BY q.id, m.title, m.subject_id
       ORDER BY attempts DESC, correct ASC
       LIMIT 200`,
      subjectId ? [subjectId] : []
    );
    res.json({ questions: result.rows });
  } catch (err) {
    console.error('admin/analytics/questions error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// Rough per-1M-token USD pricing for a cost estimate (input/output blended-ish).
const PRICING: Record<string, { in: number; out: number }> = {
  'claude-sonnet-4-5': { in: 3, out: 15 },
  'claude-haiku-4-5': { in: 1, out: 5 },
  'deepseek-chat': { in: 0.27, out: 1.1 },
  'deepseek-reasoner': { in: 0.55, out: 2.19 },
  'gemini-2.5-flash': { in: 0.3, out: 2.5 },
  'gemini-2.5-pro': { in: 1.25, out: 10 },
};

// GET /api/admin/analytics/usage — LLM token usage + estimated cost.
router.get('/analytics/usage', async (_req, res) => {
  try {
    const byModel = await db.query<{ provider: string; model: string; in_tok: string; out_tok: string; calls: string }>(
      `SELECT provider, model,
              SUM(input_tokens)::bigint AS in_tok, SUM(output_tokens)::bigint AS out_tok, COUNT(*)::bigint AS calls
       FROM llm_usage GROUP BY provider, model ORDER BY (SUM(input_tokens) + SUM(output_tokens)) DESC`
    );
    const byFeature = await db.query(
      `SELECT COALESCE(feature, 'untagged') AS feature,
              SUM(input_tokens)::bigint AS in_tok, SUM(output_tokens)::bigint AS out_tok, COUNT(*)::bigint AS calls
       FROM llm_usage GROUP BY feature ORDER BY (SUM(input_tokens) + SUM(output_tokens)) DESC`
    );
    const rows = byModel.rows.map((r) => {
      const p = PRICING[r.model];
      const inTok = Number(r.in_tok);
      const outTok = Number(r.out_tok);
      const costUsd = p ? (inTok / 1e6) * p.in + (outTok / 1e6) * p.out : null;
      return { ...r, in_tok: inTok, out_tok: outTok, calls: Number(r.calls), cost_usd: costUsd };
    });
    const totalCost = rows.reduce((s, r) => s + (r.cost_usd ?? 0), 0);
    res.json({ byModel: rows, byFeature: byFeature.rows, totalCostUsd: totalCost });
  } catch (err) {
    console.error('admin/analytics/usage error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// GET /api/admin/analytics/feedback — explicit learner feedback for admin review:
// tutor thumbs by kind (+ recent 👎), per-module ratings, and NPS.
router.get('/analytics/feedback', async (_req, res) => {
  try {
    // Tutor 👍/👎 grouped by kind (chat/hint/solution).
    const messageCounts = await db.query(
      `SELECT kind,
              COUNT(*) FILTER (WHERE rating = 'up')::int   AS up,
              COUNT(*) FILTER (WHERE rating = 'down')::int AS down
       FROM message_feedback
       GROUP BY kind
       ORDER BY kind`
    );
    // Most recent 👎 with context, so admins can read what went wrong.
    const recentDowns = await db.query(
      `SELECT mf.kind, mf.comment, mf.excerpt, mf.created_at, m.title AS module_title
       FROM message_feedback mf
       LEFT JOIN modules m ON m.id = mf.module_id
       WHERE mf.rating = 'down'
       ORDER BY mf.created_at DESC
       LIMIT 20`
    );

    // Per-module averages + response count, joined for titles.
    const moduleRatings = await db.query(
      `SELECT m.id AS module_id, m.title,
              COUNT(mf.*)::int AS responses,
              ROUND(AVG(mf.difficulty)::numeric, 1)  AS avg_difficulty,
              ROUND(AVG(mf.clarity)::numeric, 1)     AS avg_clarity,
              ROUND(AVG(mf.helpfulness)::numeric, 1) AS avg_helpfulness
       FROM module_feedback mf
       JOIN modules m ON m.id = mf.module_id
       GROUP BY m.id, m.title
       ORDER BY responses DESC
       LIMIT 100`
    );
    const moduleComments = await db.query(
      `SELECT mf.comment, mf.created_at, m.title AS module_title
       FROM module_feedback mf
       JOIN modules m ON m.id = mf.module_id
       WHERE mf.comment IS NOT NULL AND mf.comment <> ''
       ORDER BY mf.updated_at DESC
       LIMIT 20`
    );

    // NPS: histogram, headline score, and recent comments.
    const npsHistogram = await db.query<{ score: number; n: number }>(
      `SELECT score, COUNT(*)::int AS n FROM nps_response GROUP BY score ORDER BY score`
    );
    const npsSummary = await db.query<{ total: number; promoters: number; detractors: number }>(
      `SELECT COUNT(*)::int AS total,
              COUNT(*) FILTER (WHERE score >= 9)::int AS promoters,
              COUNT(*) FILTER (WHERE score <= 6)::int AS detractors
       FROM nps_response`
    );
    const npsComments = await db.query(
      `SELECT score, comment, created_at FROM nps_response
       WHERE comment IS NOT NULL AND comment <> ''
       ORDER BY created_at DESC LIMIT 20`
    );

    const s = npsSummary.rows[0] ?? { total: 0, promoters: 0, detractors: 0 };
    const npsScore = s.total > 0
      ? Math.round(((s.promoters - s.detractors) / s.total) * 100)
      : null;

    res.json({
      messages: { counts: messageCounts.rows, recentDowns: recentDowns.rows },
      modules: { ratings: moduleRatings.rows, comments: moduleComments.rows },
      nps: {
        score: npsScore,
        total: s.total,
        promoters: s.promoters,
        detractors: s.detractors,
        histogram: npsHistogram.rows,
        comments: npsComments.rows,
      },
    });
  } catch (err) {
    console.error('admin/analytics/feedback error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

export default router;
