import { Response, NextFunction } from 'express';
import { db } from '../db/pool';
import { AuthRequest } from './auth';

// Admins come from two sources: the ADMIN_EMAILS env allowlist (bootstrap) and
// the admin_users table (managed in-app). Must run AFTER requireAuth.
function envAdminEmails(): string[] {
  return (process.env.ADMIN_EMAILS ?? '')
    .split(',')
    .map((e) => e.trim().toLowerCase())
    .filter(Boolean);
}

/** Resolve the authed user's email, or null. */
async function emailOf(userId: string): Promise<string | null> {
  const { rows } = await db.query<{ email: string }>('SELECT email FROM users WHERE id = $1', [userId]);
  return rows[0]?.email?.toLowerCase() ?? null;
}

export async function isAdmin(userId: string): Promise<boolean> {
  const email = await emailOf(userId);
  if (!email) return false;
  if (envAdminEmails().includes(email)) return true;
  const { rows } = await db.query('SELECT 1 FROM admin_users WHERE lower(email) = $1', [email]).catch(() => ({ rows: [] }));
  return rows.length > 0;
}

export async function requireAdmin(req: AuthRequest, res: Response, next: NextFunction) {
  if (!req.userId) { res.status(401).json({ error: 'Not authenticated' }); return; }
  const email = await emailOf(req.userId);
  const allowed =
    !!email && (envAdminEmails().includes(email) ||
      (await db.query('SELECT 1 FROM admin_users WHERE lower(email) = $1', [email]).then((r) => r.rows.length > 0).catch(() => false)));
  if (!allowed) { res.status(403).json({ error: 'Admin access required' }); return; }
  req.adminEmail = email ?? undefined;
  next();
}
