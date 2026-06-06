import { Response, NextFunction } from 'express';
import { db } from '../db/pool';
import { AuthRequest } from './auth';
import { isAdmin } from './admin';

export const FREE_SESSION_LIMIT = 5;

/**
 * Returns true if a free-tier user has reached their session cap.
 * Admins and paid users are never limited. On DB error, fails open (returns
 * false) so a transient hiccup never blocks a paying experience.
 */
export async function isFreeLimitReached(userId: string): Promise<boolean> {
  try {
    // Admins (ADMIN_EMAILS allowlist or admin_users) always have unlimited access.
    if (await isAdmin(userId)) return false;

    const result = await db.query<{ subscription_status: string }>(
      `SELECT subscription_status FROM users WHERE id = $1`,
      [userId]
    );
    const status = result.rows[0]?.subscription_status ?? 'free';
    if (status !== 'free') return false;

    const countResult = await db.query<{ count: string }>(
      `SELECT COUNT(*) AS count FROM sessions WHERE user_id = $1`,
      [userId]
    );
    return Number(countResult.rows[0].count) >= FREE_SESSION_LIMIT;
  } catch {
    return false;
  }
}

// Enforce free-tier session limit (middleware form)
export async function enforceFreeLimit(req: AuthRequest, res: Response, next: NextFunction) {
  if (await isFreeLimitReached(req.userId!)) {
    res.status(402).json({
      error: 'free_limit_reached',
      message: `Free plan includes ${FREE_SESSION_LIMIT} sessions. Upgrade to Pro to continue.`,
    });
    return;
  }
  next();
}
