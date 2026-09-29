import { NextResponse } from 'next/server';
import { db } from '@/lib/db';
import { requireAuth, handleApiError } from '@/lib/api-utils';

const EXPERIENCE_LEVELS = ['none', 'some', 'intermediate'] as const;

export async function GET() {
  try {
    const userAuth = await requireAuth();

    const [userRow, statsRow, qaRow, recentRows] = await Promise.all([
      db.query(
        `SELECT u.email, u.name, u.goal, u.experience, u.subscription_status, u.created_at,
                lp.streak_days, lp.overall_mastery
         FROM users u
         LEFT JOIN learner_profiles lp ON lp.user_id = u.id
         WHERE u.id = $1`,
        [userAuth.id]
      ),
      db.query<{ sessions: string; seconds: string; modules_completed: string }>(
        `SELECT
           (SELECT COUNT(*) FROM sessions
              WHERE user_id = $1 AND ended_at IS NOT NULL)                   AS sessions,
           (SELECT COALESCE(SUM(EXTRACT(EPOCH FROM (ended_at - started_at))), 0)
              FROM sessions WHERE user_id = $1 AND ended_at IS NOT NULL)      AS seconds,
           (SELECT COUNT(*) FROM module_mastery
              WHERE user_id = $1 AND mastery_score >= 80)                     AS modules_completed`,
        [userAuth.id]
      ),
      db.query<{ answered: string; correct: string }>(
        `SELECT COUNT(*) AS answered, COUNT(*) FILTER (WHERE is_correct) AS correct
         FROM quiz_attempts WHERE user_id = $1`,
        [userAuth.id]
      ),
      db.query(
        `SELECT m.title AS module_title, m.slug AS module_slug,
                s.started_at, s.ended_at, s.summary_text,
                EXTRACT(EPOCH FROM (s.ended_at - s.started_at))::int AS duration_seconds
         FROM sessions s
         JOIN modules m ON m.id = s.module_id
         WHERE s.user_id = $1 AND s.ended_at IS NOT NULL
         ORDER BY s.ended_at DESC
         LIMIT 8`,
        [userAuth.id]
      ),
    ]);

    const u = userRow.rows[0];
    if (!u) { return NextResponse.json({ error: 'User not found' }, { status: 404 }); }

    const stats = statsRow.rows[0];
    const qa = qaRow.rows[0];
    const answered = Number(qa?.answered ?? 0);
    const correct = Number(qa?.correct ?? 0);

    return NextResponse.json({
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
      recentSessions: recentRows.rows.map((r: any) => ({
        moduleTitle: r.module_title,
        moduleSlug: r.module_slug,
        endedAt: r.ended_at,
        durationMinutes: Math.max(1, Math.round(Number(r.duration_seconds ?? 0) / 60)),
        summary: r.summary_text,
      })),
    });
  } catch (err) {
    return handleApiError(err);
  }
}

export async function PATCH(request: Request) {
  try {
    const userAuth = await requireAuth();
    const { name, goal, experience } = await request.json() as { name?: string; goal?: string; experience?: string };

    if (experience && !EXPERIENCE_LEVELS.includes(experience as any)) {
      return NextResponse.json({ error: 'Invalid experience level' }, { status: 400 });
    }

    if (name === undefined && goal === undefined && experience === undefined) {
      return NextResponse.json({ error: 'Nothing to update' }, { status: 400 });
    }

    const result = await db.query<{ name: string; goal: string | null; experience: string | null }>(
      `UPDATE users SET
         name = COALESCE($2, name),
         goal = COALESCE($3, goal),
         experience = COALESCE($4, experience),
         updated_at = NOW()
       WHERE id = $1
       RETURNING name, goal, experience`,
      [userAuth.id, name ?? null, goal ?? null, experience ?? null]
    );

    return NextResponse.json(result.rows[0]);
  } catch (err) {
    return handleApiError(err);
  }
}
