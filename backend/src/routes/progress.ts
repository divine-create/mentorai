import { Router } from 'express';
import { db } from '../db/pool';
import { requireAuth, AuthRequest } from '../middleware/auth';
import { createChat } from '../services/llm';
import { getUserModelId } from './models';
import { countDueConcepts } from '../services/review';

const router = Router();

// GET /api/progress/summary
// Returns streak, mastery per module, weekly stats, and a personalised notification message.
router.get('/summary', requireAuth, async (req: AuthRequest, res) => {
  try {
    const [profileResult, weekResult, moduleResult] = await Promise.all([
      db.query(
        `SELECT lp.streak_days, lp.overall_mastery, lp.last_session_at,
                m.title AS current_module_title, m.slug AS current_module_slug
         FROM learner_profiles lp
         LEFT JOIN modules m ON m.id = lp.current_module_id
         WHERE lp.user_id = $1`,
        [req.userId]
      ),
      // Sessions this week
      db.query<{ count: string; total_seconds: string }>(
        `SELECT COUNT(*) AS count,
                COALESCE(SUM(EXTRACT(EPOCH FROM (ended_at - started_at))), 0) AS total_seconds
         FROM sessions
         WHERE user_id = $1
           AND started_at >= NOW() - INTERVAL '7 days'
           AND ended_at IS NOT NULL`,
        [req.userId]
      ),
      db.query(
        `SELECT m.title, m.slug, COALESCE(mm.mastery_score, 0) AS mastery_score, mm.unlocked
         FROM modules m
         LEFT JOIN module_mastery mm ON mm.module_id = m.id AND mm.user_id = $1
         ORDER BY m.order_index`,
        [req.userId]
      ),
    ]);

    const profile = profileResult.rows[0];
    const week = weekResult.rows[0];
    const modules = moduleResult.rows;

    // Concepts due for spaced-repetition review (active subject).
    const reviewsDue = await countDueConcepts(req.userId!).catch(() => 0);

    // Streak loss detection
    const lastSession = profile?.last_session_at ? new Date(profile.last_session_at) : null;
    const daysSince = lastSession
      ? Math.floor((Date.now() - lastSession.getTime()) / 86_400_000)
      : null;
    const streakAtRisk = daysSince !== null && daysSince === 1;

    // Notification message — streak/welcome-back takes priority; otherwise nudge
    // the learner toward any concepts due for review.
    let notification: string | null = null;
    if (profile?.current_module_title && daysSince !== null && daysSince >= 1) {
      notification = daysSince === 1
        ? `Your streak is at risk! Come back today to keep your ${profile.streak_days}-day streak alive.`
        : `Welcome back! It's been ${daysSince} days. Your tutor is ready to pick up where you left off in ${profile.current_module_title}.`;
    } else if (reviewsDue > 0) {
      notification = `You have ${reviewsDue} concept${reviewsDue === 1 ? '' : 's'} due for review — a few minutes now keeps them fresh.`;
    }

    res.json({
      streak: profile?.streak_days ?? 0,
      streakAtRisk,
      overallMastery: Math.round(profile?.overall_mastery ?? 0),
      currentModule: { title: profile?.current_module_title, slug: profile?.current_module_slug },
      weekSessions: Number(week?.count ?? 0),
      weekMinutes: Math.round(Number(week?.total_seconds ?? 0) / 60),
      modules,
      reviewsDue,
      notification,
    });
  } catch (err) {
    console.error('progress/summary error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// GET /api/progress/weekly-email-content
// Generates weekly summary text (used by a cron job to send emails).
router.get('/weekly-email-content', requireAuth, async (req: AuthRequest, res) => {
  try {
    const summaryRes = await db.query(
      `SELECT u.name,
              lp.streak_days, lp.overall_mastery,
              m.title AS current_module,
              (SELECT COUNT(*) FROM sessions s WHERE s.user_id = u.id AND s.started_at >= NOW() - INTERVAL '7 days') AS sessions_this_week,
              (SELECT COUNT(*) FROM module_mastery mm WHERE mm.user_id = u.id AND mm.mastery_score >= 80) AS modules_completed
       FROM users u
       LEFT JOIN learner_profiles lp ON lp.user_id = u.id
       LEFT JOIN modules m ON m.id = lp.current_module_id
       WHERE u.id = $1`,
      [req.userId]
    );
    const row = summaryRes.rows[0];

    const text = await createChat({
      modelId: await getUserModelId(req.userId!),
      maxTokens: 200,
      messages: [{
        role: 'user',
        content: `Write a warm, encouraging 2-sentence weekly progress summary for ${row?.name ?? 'a learner'} who:
- Completed ${row?.sessions_this_week ?? 0} sessions this week
- Has a ${row?.streak_days ?? 0}-day streak
- Is ${row?.overall_mastery ?? 0}% through their overall mastery
- Is currently studying: ${row?.current_module ?? 'Python Fundamentals'}
End with one forward-looking hook for next week.`,
      }],
    });

    res.json({ summary: text, data: row });
  } catch {
    res.status(500).json({ error: 'Internal server error' });
  }
});

export default router;
