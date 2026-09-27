// ─── Re-engagement notifications ──────────────────────────────────────────────
// Generates and (optionally) sends weekly progress emails. The transport is
// pluggable: if RESEND_API_KEY is set we send via Resend's HTTP API; otherwise
// the content is still generated and recorded in notification_log with status
// 'generated' so it's visible/auditable and ready to send once email is wired up.
//
// Trigger it from the admin endpoint (POST /api/admin/notifications/weekly) or a
// real cron. It throttles per learner (skips anyone emailed in the last 6 days).

import { db } from '../db';
import { createChat, isValidModelId, DEFAULT_MODEL_ID } from './llm';
import { getSettings } from './settings';

const WEEK_MS = 6 * 86_400_000; // throttle window

export function emailConfigured(): boolean {
  return !!process.env.RESEND_API_KEY;
}

async function defaultModelId(): Promise<string> {
  try {
    const { defaultModel } = await getSettings();
    return isValidModelId(defaultModel) ? defaultModel : DEFAULT_MODEL_ID;
  } catch {
    return DEFAULT_MODEL_ID;
  }
}

async function deliver(to: string, subject: string, html: string): Promise<{ sent: boolean; error?: string }> {
  if (!process.env.RESEND_API_KEY) return { sent: false };
  try {
    const res = await fetch('https://api.resend.com/emails', {
      method: 'POST',
      headers: {
        Authorization: `Bearer ${process.env.RESEND_API_KEY}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        from: process.env.EMAIL_FROM || 'The AI Academy <onboarding@resend.dev>',
        to,
        subject,
        html,
      }),
    });
    if (!res.ok) return { sent: false, error: `Resend ${res.status}: ${await res.text().catch(() => '')}` };
    return { sent: true };
  } catch (e) {
    return { sent: false, error: (e as Error).message };
  }
}

async function logNotification(
  userId: string,
  status: 'sent' | 'skipped' | 'failed' | 'generated',
  subject: string | null,
  body: string | null,
  error?: string | null
): Promise<void> {
  await db.query(
    `INSERT INTO notification_log (user_id, kind, channel, subject, body, status, error)
     VALUES ($1, 'weekly_email', 'email', $2, $3, $4, $5)`,
    [userId, subject, body, status, error ?? null]
  ).catch((err) => console.error('logNotification failed:', (err as Error).message));
}

export interface WeeklyRunResult {
  processed: number;
  sent: number;
  generated: number; // content made but no transport configured
  skipped: number;   // throttled
  failed: number;
  emailConfigured: boolean;
}

/**
 * Generate (and send, if configured) the weekly progress email for every active
 * learner. `force` ignores the per-learner throttle.
 */
export async function runWeeklyEmails(opts?: { force?: boolean }): Promise<WeeklyRunResult> {
  const force = opts?.force ?? false;
  const model = await defaultModelId();
  const result: WeeklyRunResult = {
    processed: 0, sent: 0, generated: 0, skipped: 0, failed: 0, emailConfigured: emailConfigured(),
  };

  const { rows } = await db.query<{
    id: string; email: string | null; name: string | null;
    streak_days: number; overall_mastery: string; last_weekly_email_at: Date | null;
    current_module: string | null;
  }>(
    `SELECT u.id, u.email, u.name, lp.streak_days, lp.overall_mastery, lp.last_weekly_email_at,
            m.title AS current_module
     FROM users u
     JOIN learner_profiles lp ON lp.user_id = u.id
     LEFT JOIN modules m ON m.id = lp.current_module_id`
  );

  for (const r of rows) {
    result.processed++;

    if (!force && r.last_weekly_email_at && Date.now() - new Date(r.last_weekly_email_at).getTime() < WEEK_MS) {
      result.skipped++;
      continue;
    }

    // Per-learner stats for the email.
    const { rows: statRows } = await db.query<{ sessions_week: string; modules_done: string; reviews_due: string }>(
      `SELECT
         (SELECT COUNT(*) FROM sessions s WHERE s.user_id = $1 AND s.started_at >= NOW() - INTERVAL '7 days') AS sessions_week,
         (SELECT COUNT(*) FROM module_mastery mm WHERE mm.user_id = $1 AND mm.mastery_score >= 80) AS modules_done,
         (SELECT COUNT(*) FROM concept_progress cp WHERE cp.user_id = $1 AND cp.due_at IS NOT NULL AND cp.due_at <= NOW()) AS reviews_due`,
      [r.id]
    );
    const s = statRows[0];

    let body: string;
    try {
      body = await createChat({
        modelId: model,
        maxTokens: 220,
        feature: 'weekly-email',
        messages: [{
          role: 'user',
          content:
            `Write a warm, encouraging weekly progress email body (2-3 sentences) for ${r.name ?? 'a learner'} who: ` +
            `completed ${Number(s?.sessions_week ?? 0)} sessions this week, has a ${r.streak_days}-day streak, ` +
            `is studying ${r.current_module ?? 'their course'}, has completed ${Number(s?.modules_done ?? 0)} modules, ` +
            `and has ${Number(s?.reviews_due ?? 0)} concepts due for review. ` +
            `End with one forward-looking hook for next week. Plain text, no subject line, no greeting line like "Hi".`,
        }],
      });
    } catch (e) {
      result.failed++;
      await logNotification(r.id, 'failed', null, null, (e as Error).message);
      continue;
    }

    const subject = `Your week at The AI Academy${r.streak_days ? ` — ${r.streak_days}-day streak 🔥` : ''}`;
    const html = `<div style="font-family:sans-serif;line-height:1.6;color:#222">` +
      `<p>Hi ${r.name?.split(' ')[0] ?? 'there'},</p>` +
      `<p>${body.replace(/\n+/g, '<br>')}</p>` +
      (Number(s?.reviews_due ?? 0) > 0
        ? `<p><a href="${process.env.FRONTEND_URL || ''}/review">Review your due concepts →</a></p>`
        : `<p><a href="${process.env.FRONTEND_URL || ''}/dashboard">Jump back in →</a></p>`) +
      `<p style="color:#888;font-size:12px">The AI Academy</p></div>`;

    const delivery = r.email ? await deliver(r.email, subject, html) : { sent: false, error: 'no email on file' };
    const status: 'sent' | 'failed' | 'generated' =
      delivery.sent ? 'sent' : delivery.error ? 'failed' : 'generated';

    if (status === 'sent') {
      result.sent++;
      await db.query(`UPDATE learner_profiles SET last_weekly_email_at = NOW() WHERE user_id = $1`, [r.id]).catch(() => {});
    } else if (status === 'failed') {
      result.failed++;
    } else {
      result.generated++;
    }
    await logNotification(r.id, status, subject, body, delivery.error);
  }

  return result;
}
