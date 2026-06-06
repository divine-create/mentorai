import { Router } from 'express';
import { db } from '../db/pool';
import { requireAuth, AuthRequest } from '../middleware/auth';
import { requireAdmin } from '../middleware/admin';
import { logAudit } from '../services/audit';
import { isValidModelId } from '../services/llm';

const router = Router();
router.use(requireAuth, requireAdmin);

const PRACTICE_KINDS = ['code', 'problem', 'web', 'none'];
const slugify = (s: string) => s.toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/^-|-$/g, '') || 'item';

// ─── Subjects ─────────────────────────────────────────────────────────────────
router.get('/content/subjects', async (_req, res) => {
  try {
    const result = await db.query(
      `SELECT s.id, s.slug, s.name, s.description, s.icon, s.order_index, s.is_available, s.practice_kind, s.teach_model,
              COUNT(m.*)::int AS modules,
              COUNT(m.*) FILTER (WHERE m.published)::int AS published_modules
       FROM subjects s LEFT JOIN modules m ON m.subject_id = s.id
       GROUP BY s.id ORDER BY s.order_index`
    );
    res.json({ subjects: result.rows });
  } catch (err) {
    console.error('admin content subjects error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

router.post('/content/subjects', async (req: AuthRequest, res) => {
  const { name, icon, description, practice_kind = 'none' } = req.body as Record<string, string>;
  if (!name?.trim()) { res.status(400).json({ error: 'name required' }); return; }
  if (!PRACTICE_KINDS.includes(practice_kind)) { res.status(400).json({ error: 'invalid practice_kind' }); return; }
  try {
    const r = await db.query(
      `INSERT INTO subjects (slug, name, description, icon, practice_kind, is_available, order_index)
       VALUES ($1, $2, $3, $4, $5, true, COALESCE((SELECT MAX(order_index)+1 FROM subjects), 1))
       ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name RETURNING *`,
      [slugify(name), name.trim(), description ?? null, icon || '📘', practice_kind]
    );
    logAudit(req.adminEmail, 'subject.create', { id: r.rows[0].id, name });
    res.status(201).json({ subject: r.rows[0] });
  } catch (err) {
    console.error('admin content subject create error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

router.patch('/content/subjects/:id', async (req: AuthRequest, res) => {
  const { name, icon, description, is_available, order_index, practice_kind, teach_model } = req.body as Record<string, unknown>;
  if (practice_kind !== undefined && !PRACTICE_KINDS.includes(String(practice_kind))) { res.status(400).json({ error: 'invalid practice_kind' }); return; }
  if (teach_model !== undefined && teach_model !== null && teach_model !== '' && !isValidModelId(String(teach_model))) { res.status(400).json({ error: 'invalid teach_model' }); return; }
  const sets: string[] = []; const vals: unknown[] = []; let i = 1;
  const set = (col: string, v: unknown) => { sets.push(`${col} = $${i++}`); vals.push(v); };
  if (name !== undefined) set('name', String(name).trim());
  if (icon !== undefined) set('icon', icon);
  if (description !== undefined) set('description', description);
  if (is_available !== undefined) set('is_available', !!is_available);
  if (order_index !== undefined) set('order_index', Number(order_index));
  if (practice_kind !== undefined) set('practice_kind', practice_kind);
  if (teach_model !== undefined) set('teach_model', teach_model || null);
  if (sets.length === 0) { res.status(400).json({ error: 'nothing to update' }); return; }
  try {
    vals.push(req.params.id);
    const r = await db.query(`UPDATE subjects SET ${sets.join(', ')} WHERE id = $${i} RETURNING *`, vals);
    if (!r.rows[0]) { res.status(404).json({ error: 'Subject not found' }); return; }
    logAudit(req.adminEmail, 'subject.update', { id: req.params.id });
    res.json({ subject: r.rows[0] });
  } catch (err) {
    console.error('admin content subject update error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

router.delete('/content/subjects/:id', async (req: AuthRequest, res) => {
  try {
    const mods = await db.query('SELECT COUNT(*)::int AS n FROM modules WHERE subject_id = $1', [req.params.id]);
    if (mods.rows[0].n > 0) { res.status(409).json({ error: 'Subject has modules — delete or move them first' }); return; }
    await db.query('DELETE FROM subjects WHERE id = $1', [req.params.id]);
    logAudit(req.adminEmail, 'subject.delete', { id: req.params.id });
    res.json({ success: true });
  } catch (err) {
    console.error('admin content subject delete error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// ─── Modules ──────────────────────────────────────────────────────────────────
router.get('/content/subjects/:id/modules', async (req, res) => {
  try {
    const result = await db.query(
      `SELECT m.id, m.slug, m.title, m.description, m.order_index, m.published, m.book_id,
              COUNT(q.*)::int AS questions
       FROM modules m LEFT JOIN questions q ON q.module_id = m.id
       WHERE m.subject_id = $1
       GROUP BY m.id ORDER BY m.order_index`,
      [req.params.id]
    );
    res.json({ modules: result.rows });
  } catch (err) {
    console.error('admin content modules error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

router.post('/content/subjects/:id/modules', async (req: AuthRequest, res) => {
  const { title, description } = req.body as Record<string, string>;
  if (!title?.trim()) { res.status(400).json({ error: 'title required' }); return; }
  try {
    const slug = `s${req.params.id}-${slugify(title)}-${Date.now().toString(36)}`.slice(0, 80);
    const r = await db.query(
      `INSERT INTO modules (slug, title, description, order_index, subject_id, published, estimated_hours_min, estimated_hours_max)
       VALUES ($1, $2, $3, COALESCE((SELECT MAX(order_index)+1 FROM modules WHERE subject_id=$4), 1), $4, true, 1, 2)
       RETURNING id, slug, title, description, order_index, published`,
      [slug, title.trim(), description ?? null, req.params.id]
    );
    logAudit(req.adminEmail, 'module.create', { id: r.rows[0].id });
    res.status(201).json({ module: r.rows[0] });
  } catch (err) {
    console.error('admin content module create error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

router.patch('/content/modules/:id', async (req: AuthRequest, res) => {
  const { title, description, order_index, published } = req.body as Record<string, unknown>;
  const sets: string[] = []; const vals: unknown[] = []; let i = 1;
  const set = (col: string, v: unknown) => { sets.push(`${col} = $${i++}`); vals.push(v); };
  if (title !== undefined) set('title', String(title).trim());
  if (description !== undefined) set('description', description);
  if (order_index !== undefined) set('order_index', Number(order_index));
  if (published !== undefined) set('published', !!published);
  if (sets.length === 0) { res.status(400).json({ error: 'nothing to update' }); return; }
  try {
    vals.push(req.params.id);
    const r = await db.query(`UPDATE modules SET ${sets.join(', ')} WHERE id = $${i} RETURNING id, title, description, order_index, published`, vals);
    if (!r.rows[0]) { res.status(404).json({ error: 'Module not found' }); return; }
    logAudit(req.adminEmail, 'module.update', { id: req.params.id, published });
    res.json({ module: r.rows[0] });
  } catch (err) {
    console.error('admin content module update error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

router.delete('/content/modules/:id', async (req: AuthRequest, res) => {
  try {
    await db.query('DELETE FROM modules WHERE id = $1', [req.params.id]); // concepts/questions/mastery cascade
    logAudit(req.adminEmail, 'module.delete', { id: req.params.id });
    res.json({ success: true });
  } catch (err) {
    console.error('admin content module delete error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// Publish/unpublish every module of a book at once (handy after course generation).
router.post('/content/books/:id/publish', async (req: AuthRequest, res) => {
  const publish = req.body?.published !== false; // default true
  try {
    const r = await db.query('UPDATE modules SET published = $2 WHERE book_id = $1', [req.params.id, publish]);
    logAudit(req.adminEmail, 'book.publishCourse', { id: req.params.id, published: publish, count: r.rowCount });
    res.json({ updated: r.rowCount, published: publish });
  } catch (err) {
    console.error('admin content book publish error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// ─── Projects ─────────────────────────────────────────────────────────────────
router.get('/content/projects', async (_req, res) => {
  try {
    const r = await db.query(
      `SELECT p.id, p.subject_id, p.slug, p.title, p.brief, p.starter, p.acceptance_criteria, p.order_index,
              s.name AS subject_name
       FROM projects p LEFT JOIN subjects s ON s.id = p.subject_id ORDER BY p.subject_id, p.order_index`
    );
    res.json({ projects: r.rows });
  } catch (err) {
    console.error('admin content projects error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

router.post('/content/projects', async (req: AuthRequest, res) => {
  const { subject_id, title, brief, starter, acceptance_criteria, order_index } = req.body as Record<string, unknown>;
  if (!subject_id || !String(title ?? '').trim()) { res.status(400).json({ error: 'subject_id and title required' }); return; }
  try {
    const slug = `${slugify(String(title))}-${Date.now().toString(36)}`;
    const r = await db.query(
      `INSERT INTO projects (subject_id, slug, title, brief, starter, acceptance_criteria, order_index)
       VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING *`,
      [subject_id, slug, String(title).trim(), brief ?? '', JSON.stringify(starter ?? {}),
       JSON.stringify(acceptance_criteria ?? []), Number(order_index) || 0]
    );
    logAudit(req.adminEmail, 'project.create', { id: r.rows[0].id });
    res.status(201).json({ project: r.rows[0] });
  } catch (err) {
    console.error('admin content project create error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

router.patch('/content/projects/:id', async (req: AuthRequest, res) => {
  const { title, brief, starter, acceptance_criteria, order_index } = req.body as Record<string, unknown>;
  const sets: string[] = []; const vals: unknown[] = []; let i = 1;
  const set = (col: string, v: unknown) => { sets.push(`${col} = $${i++}`); vals.push(v); };
  if (title !== undefined) set('title', String(title).trim());
  if (brief !== undefined) set('brief', brief);
  if (starter !== undefined) set('starter', JSON.stringify(starter));
  if (acceptance_criteria !== undefined) set('acceptance_criteria', JSON.stringify(acceptance_criteria));
  if (order_index !== undefined) set('order_index', Number(order_index));
  if (sets.length === 0) { res.status(400).json({ error: 'nothing to update' }); return; }
  try {
    vals.push(req.params.id);
    const r = await db.query(`UPDATE projects SET ${sets.join(', ')} WHERE id = $${i} RETURNING *`, vals);
    if (!r.rows[0]) { res.status(404).json({ error: 'Project not found' }); return; }
    logAudit(req.adminEmail, 'project.update', { id: req.params.id });
    res.json({ project: r.rows[0] });
  } catch (err) {
    console.error('admin content project update error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

router.delete('/content/projects/:id', async (req: AuthRequest, res) => {
  try {
    await db.query('DELETE FROM projects WHERE id = $1', [req.params.id]);
    logAudit(req.adminEmail, 'project.delete', { id: req.params.id });
    res.json({ success: true });
  } catch (err) {
    console.error('admin content project delete error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

export default router;
