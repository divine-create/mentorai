import { Router } from 'express';
import { db } from '../db/pool';
import { requireAuth, AuthRequest } from '../middleware/auth';
import { requireString, sendValidationErrors } from '../middleware/validate';
import { createChat } from '../services/llm';
import { getUserModelId } from './models';

const router = Router();

// POST /api/sessions/:id/close
// Summarises the session via Claude, persists summary, updates streak.
router.post('/:id/close', requireAuth, async (req: AuthRequest, res) => {
  const { id } = req.params;

  // --- Validation ---
  if (sendValidationErrors(res, [requireString(id, 'id (param)')])) return;

  try {
    // Fetch all messages for this session
    const msgResult = await db.query<{ role: string; content: string }>(
      `SELECT role, content FROM messages WHERE session_id = $1 ORDER BY created_at`,
      [id]
    );

    const messages = msgResult.rows;
    if (messages.length === 0) {
      await db.query(`UPDATE sessions SET ended_at = NOW() WHERE id = $1`, [id]);
      res.json({ summary: null });
      return;
    }

    // Generate structured summary
    const transcript = messages.map((m) => `${m.role.toUpperCase()}: ${m.content}`).join('\n\n');
    const summary = await createChat({
      modelId: await getUserModelId(req.userId!),
      maxTokens: 300,
      messages: [{
        role: 'user',
        content: `Summarise this tutoring session in 2-3 sentences. Include: concepts covered, learner's understanding level, and what to focus on next.\n\n${transcript}`,
      }],
    });

    // Extract concept IDs covered (from session messages mentioning concepts)
    const sessionResult = await db.query(
      `SELECT module_id FROM sessions WHERE id = $1`,
      [id]
    );
    const moduleId = sessionResult.rows[0]?.module_id;

    // Close session with summary
    await db.query(
      `UPDATE sessions SET ended_at = NOW(), summary_text = $1 WHERE id = $2`,
      [summary, id]
    );

    // Update streak: if last session was yesterday or today, increment; else reset to 1
    await db.query(
      `UPDATE learner_profiles SET
         streak_days = CASE
           WHEN last_session_at::date = CURRENT_DATE THEN streak_days
           WHEN last_session_at::date = CURRENT_DATE - 1 THEN streak_days + 1
           ELSE 1
         END,
         last_session_at = NOW(),
         current_module_id = COALESCE($1::int, current_module_id),
         updated_at = NOW()
       WHERE user_id = $2`,
      [moduleId ?? null, req.userId]
    );

    res.json({ summary });
  } catch (err) {
    console.error('session/close error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// GET /api/sessions/recent
// Returns the last session summary for the learner (used in tutor system prompt).
router.get('/recent', requireAuth, async (req: AuthRequest, res) => {
  try {
    const result = await db.query(
      `SELECT s.id, s.summary_text, s.started_at, s.ended_at, m.title AS module_title
       FROM sessions s
       LEFT JOIN modules m ON m.id = s.module_id
       WHERE s.user_id = $1 AND s.ended_at IS NOT NULL
       ORDER BY s.ended_at DESC LIMIT 1`,
      [req.userId]
    );
    res.json(result.rows[0] ?? null);
  } catch (err) {
    res.status(500).json({ error: 'Internal server error' });
  }
});

export default router;
