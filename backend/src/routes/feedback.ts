// ─── Explicit learner feedback ────────────────────────────────────────────────
// Lightweight, optional signals the learner can give about the experience:
//   - 👍/👎 (+ comment) on tutor replies, hints, and solutions  → message_feedback
//   - end-of-module ratings (difficulty/clarity/helpfulness)     → module_feedback
//   - periodic Net Promoter Score                                → nps_response
// Everything is consumed by the admin analytics dashboard; nothing here feeds
// back into the live tutor. Failures are non-fatal to the learner's flow.

import { Router } from 'express';
import { db } from '../db/pool';
import { requireAuth, AuthRequest } from '../middleware/auth';
import {
  requireFields,
  requireString,
  requireNumber,
  requireOneOf,
  sendValidationErrors,
} from '../middleware/validate';

const router = Router();

const FEEDBACK_KINDS = ['chat', 'hint', 'solution'] as const;
const RATINGS = ['up', 'down'] as const;

// How long after a prompt (shown, dismissed, or answered) before NPS resurfaces.
const NPS_COOLDOWN_DAYS = 30;
// Don't pester brand-new learners — require some real usage first.
const NPS_MIN_SESSIONS = 3;

// Trim free-text so a pathological client can't store unbounded blobs.
function clip(val: unknown, max: number): string | null {
  if (typeof val !== 'string') return null;
  const t = val.trim();
  return t ? t.slice(0, max) : null;
}

// POST /api/feedback/message — 👍/👎 on a tutor reply, hint, or solution.
router.post('/message', requireAuth, async (req: AuthRequest, res) => {
  const { sessionId, moduleId, kind, rating, comment, excerpt, messageIndex } = req.body as {
    sessionId?: string;
    moduleId?: number;
    kind?: string;
    rating?: string;
    comment?: string;
    excerpt?: string;
    messageIndex?: number;
  };

  const missing = requireFields(req.body, ['kind', 'rating']);
  if (missing) { res.status(400).json({ error: missing }); return; }
  if (sendValidationErrors(res, [
    requireOneOf(kind, 'kind', FEEDBACK_KINDS),
    requireOneOf(rating, 'rating', RATINGS),
  ])) return;

  try {
    await db.query(
      `INSERT INTO message_feedback
         (user_id, session_id, module_id, kind, rating, comment, excerpt, message_index)
       VALUES ($1, $2, $3, $4, $5, $6, $7, $8)`,
      [
        req.userId,
        sessionId ?? null,
        typeof moduleId === 'number' ? moduleId : null,
        kind,
        rating,
        clip(comment, 2000),
        clip(excerpt, 1000),
        typeof messageIndex === 'number' ? messageIndex : null,
      ]
    );
    res.json({ ok: true });
  } catch (err) {
    console.error('feedback/message error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// POST /api/feedback/module — end-of-module rating (upsert per learner+module).
router.post('/module', requireAuth, async (req: AuthRequest, res) => {
  const { moduleId, difficulty, clarity, helpfulness, comment } = req.body as {
    moduleId?: number;
    difficulty?: number;
    clarity?: number;
    helpfulness?: number;
    comment?: string;
  };

  const missing = requireFields(req.body, ['moduleId']);
  if (missing) { res.status(400).json({ error: missing }); return; }
  if (sendValidationErrors(res, [requireNumber(moduleId, 'moduleId')])) return;

  // Each rating is optional but, when present, must be 1..5.
  const inRange = (v: unknown) => v === undefined || v === null
    || (typeof v === 'number' && Number.isInteger(v) && v >= 1 && v <= 5);
  if (![difficulty, clarity, helpfulness].every(inRange)) {
    res.status(400).json({ error: 'Ratings must be integers from 1 to 5' });
    return;
  }

  try {
    await db.query(
      `INSERT INTO module_feedback
         (user_id, module_id, difficulty, clarity, helpfulness, comment)
       VALUES ($1, $2, $3, $4, $5, $6)
       ON CONFLICT (user_id, module_id) DO UPDATE SET
         difficulty  = EXCLUDED.difficulty,
         clarity     = EXCLUDED.clarity,
         helpfulness = EXCLUDED.helpfulness,
         comment     = EXCLUDED.comment`,
      [
        req.userId,
        moduleId,
        difficulty ?? null,
        clarity ?? null,
        helpfulness ?? null,
        clip(comment, 2000),
      ]
    );
    res.json({ ok: true });
  } catch (err) {
    console.error('feedback/module error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// GET /api/feedback/nps/eligible — should we show the NPS prompt now?
router.get('/nps/eligible', requireAuth, async (req: AuthRequest, res) => {
  try {
    const { rows } = await db.query<{ eligible: boolean }>(
      `SELECT (
         COALESCE(lp.last_nps_prompt_at, 'epoch') < NOW() - ($2 || ' days')::interval
         AND (SELECT COUNT(*) FROM sessions s WHERE s.user_id = $1 AND s.ended_at IS NOT NULL) >= $3
       ) AS eligible
       FROM learner_profiles lp WHERE lp.user_id = $1`,
      [req.userId, NPS_COOLDOWN_DAYS, NPS_MIN_SESSIONS]
    );
    res.json({ eligible: rows[0]?.eligible === true });
  } catch (err) {
    console.error('feedback/nps/eligible error:', err);
    res.json({ eligible: false });
  }
});

// Stamp the throttle so the prompt backs off after being shown/answered.
async function stampNpsPrompt(userId: string) {
  await db.query(
    `UPDATE learner_profiles SET last_nps_prompt_at = NOW() WHERE user_id = $1`,
    [userId]
  );
}

// POST /api/feedback/nps — record an NPS score.
router.post('/nps', requireAuth, async (req: AuthRequest, res) => {
  const { score, comment } = req.body as { score?: number; comment?: string };

  const missing = requireFields(req.body, ['score']);
  if (missing) { res.status(400).json({ error: missing }); return; }
  if (sendValidationErrors(res, [requireNumber(score, 'score')])) return;
  if (!Number.isInteger(score) || (score as number) < 0 || (score as number) > 10) {
    res.status(400).json({ error: 'score must be an integer from 0 to 10' });
    return;
  }

  try {
    await db.query(
      `INSERT INTO nps_response (user_id, score, comment) VALUES ($1, $2, $3)`,
      [req.userId, score, clip(comment, 2000)]
    );
    await stampNpsPrompt(req.userId!);
    res.json({ ok: true });
  } catch (err) {
    console.error('feedback/nps error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// POST /api/feedback/nps/dismiss — learner dismissed the prompt; back off.
router.post('/nps/dismiss', requireAuth, async (req: AuthRequest, res) => {
  try {
    await stampNpsPrompt(req.userId!);
    res.json({ ok: true });
  } catch (err) {
    console.error('feedback/nps/dismiss error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

export default router;
