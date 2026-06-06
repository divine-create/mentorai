// Best-effort admin audit logging. Never throws — auditing must not break an action.
import { db } from '../db/pool';

export function logAudit(actorEmail: string | undefined, action: string, detail?: unknown): void {
  db.query(
    `INSERT INTO admin_audit_log (actor_email, action, detail) VALUES ($1, $2, $3)`,
    [actorEmail ?? null, action, detail === undefined ? null : JSON.stringify(detail)]
  ).catch(() => {});
}
