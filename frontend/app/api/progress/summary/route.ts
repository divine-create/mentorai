import { NextResponse } from 'next/server';
import { db } from '@/lib/db';
import { requireAuth, handleApiError } from '@/lib/api-utils';

export async function GET() {
  try {
    const userAuth = await requireAuth();

    const [profileResult, weekResult, moduleResult] = await Promise.all([
      db.query(
        `SELECT lp.streak_days, lp.overall_mastery, lp.last_session_at,
                m.title AS current_module_title, m.slug AS current_module_slug
         FROM learner_profiles lp
         LEFT JOIN modules m ON m.id = lp.current_module_id
         WHERE lp.user_id = $1`,
        [userAuth.id]
      ),
      db.query(
        `SELECT COUNT(*) AS count,
                COALESCE(SUM(EXTRACT(EPOCH FROM (ended_at - started_at))), 0) AS total_seconds
         FROM sessions
         WHERE user_id = $1
           AND started_at >= NOW() - INTERVAL '7 days'
           AND ended_at IS NOT NULL`,
        [userAuth.id]
      ),
      db.query(
        `SELECT m.title, m.slug, COALESCE(mm.mastery_score, 0) AS mastery_score, mm.unlocked
         FROM modules m
         LEFT JOIN module_mastery mm ON mm.module_id = m.id AND mm.user_id = $1
         ORDER BY m.order_index`,
        [userAuth.id]
      ),
    ]);

    const profile = profileResult.rows[0];
    const week = weekResult.rows[0];
    const modules = moduleResult.rows;

    const reviewsDue = 0; // TODO: Implement countDueConcepts

    const lastSession = profile?.last_session_at ? new Date(profile.last_session_at) : null;
    const daysSince = lastSession
      ? Math.floor((Date.now() - lastSession.getTime()) / 86_400_000)
      : null;
    const streakAtRisk = daysSince !== null && daysSince === 1;

    let notification: string | null = null;
    if (profile?.current_module_title && daysSince !== null && daysSince >= 1) {
      notification = daysSince === 1
        ? `Your streak is at risk! Come back today to keep your ${profile.streak_days}-day streak alive.`
        : `Welcome back! It's been ${daysSince} days. Your tutor is ready to pick up where you left off in ${profile.current_module_title}.`;
    } else if (reviewsDue > 0) {
      notification = `You have ${reviewsDue} concept${reviewsDue === 1 ? '' : 's'} due for review — a few minutes now keeps them fresh.`;
    }

    return NextResponse.json({
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
    return handleApiError(err);
  }
}
