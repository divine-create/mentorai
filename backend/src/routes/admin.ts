import { Router } from 'express';
import multer from 'multer';
import { db } from '../db/pool';
import { requireAuth, AuthRequest } from '../middleware/auth';
import { requireAdmin } from '../middleware/admin';
import { requireString, sendValidationErrors } from '../middleware/validate';
import { ingestBook } from '../services/ingest';
import { buildCourseFromBook } from '../services/courseGen';
import { retrieveChunks, embed, toVectorLiteral, pgvectorReady } from '../services/embeddings';
import { createChat } from '../services/llm';
import { logAudit } from '../services/audit';
import { getUserModelId } from './models';

const router = Router();

// In-memory upload — the original file is parsed then discarded; only the
// derived chunks/embeddings are stored. 25MB ceiling for a book.
const upload = multer({ storage: multer.memoryStorage(), limits: { fileSize: 25 * 1024 * 1024 } });

// Every admin route requires auth + admin allowlist.
router.use(requireAuth, requireAdmin);

// GET /api/admin/me — lets the frontend confirm admin access for showing the nav link.
router.get('/me', (_req, res) => res.json({ admin: true }));

// ─── POST /api/admin/books ────────────────────────────────────────────────────
// multipart: file + { title, subjectId? | newSubject? } (one target required).
// Creates the book row (status 'processing'), resolves/creates the subject,
// kicks off async ingestion, and returns immediately.
router.post('/books', upload.single('file'), async (req: AuthRequest, res) => {
  const { title, subjectId, newSubject, license, source_url } = req.body as {
    title?: string;
    subjectId?: string;
    newSubject?: string;
    license?: string;
    source_url?: string;
  };

  if (!req.file) { res.status(400).json({ error: 'A file is required' }); return; }
  if (sendValidationErrors(res, [requireString(title, 'title')])) return;
  if (!subjectId && !newSubject) {
    res.status(400).json({ error: 'Provide subjectId or newSubject' });
    return;
  }

  try {
    // Resolve the target subject — existing or freshly created.
    let resolvedSubjectId: number;
    if (newSubject) {
      const slug = newSubject.trim().toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/^-|-$/g, '');
      const created = await db.query<{ id: number }>(
        `INSERT INTO subjects (slug, name, description, icon, practice_kind, is_available, order_index)
         VALUES ($1, $2, $3, '📘', 'none', true,
                 COALESCE((SELECT MAX(order_index) + 1 FROM subjects), 1))
         ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name
         RETURNING id`,
        [slug, newSubject.trim(), `Learn ${newSubject.trim()}.`]
      );
      resolvedSubjectId = created.rows[0].id;
    } else {
      const found = await db.query<{ id: number }>('SELECT id FROM subjects WHERE id = $1', [Number(subjectId)]);
      if (!found.rows[0]) { res.status(400).json({ error: 'Unknown subject' }); return; }
      resolvedSubjectId = found.rows[0].id;
    }

    const book = await db.query<{ id: number; title: string; status: string; subject_id: number }>(
      `INSERT INTO books (title, subject_id, uploaded_by, status, license, source_url)
       VALUES ($1, $2, $3, 'processing', $4, $5)
       RETURNING id, title, status, subject_id`,
      [title!.trim(), resolvedSubjectId, req.userId, license?.trim() || null, source_url?.trim() || null]
    );
    const bookId = book.rows[0].id;

    // Fire-and-forget ingestion. The buffer is captured here; status is polled by the UI.
    void ingestBook(bookId, resolvedSubjectId, req.file.buffer, req.file.mimetype, req.file.originalname);

    logAudit(req.adminEmail, 'book.upload', { id: bookId, title: title!.trim(), subjectId: resolvedSubjectId });
    res.status(201).json({ book: book.rows[0] });
  } catch (err) {
    console.error('admin/books create error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// ─── GET /api/admin/books ─────────────────────────────────────────────────────
router.get('/books', async (_req, res) => {
  try {
    const result = await db.query(
      `SELECT b.id, b.title, b.status, b.num_chunks, b.error, b.created_at, b.license, b.source_url,
              b.course_status, b.course_error, b.num_modules, b.num_questions,
              s.name AS subject_name, s.id AS subject_id
       FROM books b
       LEFT JOIN subjects s ON s.id = b.subject_id
       ORDER BY b.created_at DESC`
    );
    res.json({ books: result.rows });
  } catch (err) {
    console.error('admin/books list error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// ─── GET /api/admin/books/:id ─────────────────────────────────────────────────
router.get('/books/:id', async (req, res) => {
  try {
    const result = await db.query(
      `SELECT b.id, b.title, b.status, b.num_chunks, b.error, b.created_at,
              s.name AS subject_name, s.id AS subject_id
       FROM books b LEFT JOIN subjects s ON s.id = b.subject_id
       WHERE b.id = $1`,
      [req.params.id]
    );
    if (!result.rows[0]) { res.status(404).json({ error: 'Book not found' }); return; }
    res.json({ book: result.rows[0] });
  } catch (err) {
    console.error('admin/books get error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// ─── DELETE /api/admin/books/:id ──────────────────────────────────────────────
router.delete('/books/:id', async (req, res) => {
  try {
    await db.query('DELETE FROM books WHERE id = $1', [req.params.id]); // chunks cascade
    res.json({ success: true });
  } catch (err) {
    console.error('admin/books delete error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// ─── POST /api/admin/books/:id/test ───────────────────────────────────────────
// Sanity-check grounding before learners see it: returns the passages a query
// would retrieve for the book's subject.
router.post('/books/:id/test', async (req, res) => {
  const { query } = req.body as { query?: string };
  if (sendValidationErrors(res, [requireString(query, 'query')])) return;

  try {
    const book = await db.query<{ subject_id: number }>('SELECT subject_id FROM books WHERE id = $1', [req.params.id]);
    if (!book.rows[0]) { res.status(404).json({ error: 'Book not found' }); return; }

    const hits = await retrieveChunks(book.rows[0].subject_id, query!.trim(), 4);
    res.json({ hits });
  } catch (err) {
    console.error('admin/books test error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// ─── POST /api/admin/books/:id/build-course ───────────────────────────────────
// Generate a learning path (modules + concepts + question bank) from the book's
// chunks. Requires the book to be 'ready'. Runs async; course_status is polled.
router.post('/books/:id/build-course', async (req: AuthRequest, res) => {
  try {
    const book = await db.query<{ status: string; course_status: string }>(
      `SELECT status, course_status FROM books WHERE id = $1`,
      [req.params.id]
    );
    if (!book.rows[0]) { res.status(404).json({ error: 'Book not found' }); return; }
    if (book.rows[0].status !== 'ready') { res.status(400).json({ error: 'Book is not finished processing yet' }); return; }
    if (book.rows[0].course_status === 'building') { res.status(409).json({ error: 'Course is already building' }); return; }

    const bookId = Number(req.params.id);
    const modelId = await getUserModelId(req.userId!);
    void buildCourseFromBook(bookId, modelId); // fire-and-forget; status polled by the UI
    res.status(202).json({ building: true });
  } catch (err) {
    console.error('admin/books build-course error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// ─── GET /api/admin/books/:id/course ──────────────────────────────────────────
// Read-only review of the generated course: modules with their questions.
router.get('/books/:id/course', async (req, res) => {
  try {
    const modules = await db.query(
      `SELECT id, title, description, order_index FROM modules WHERE book_id = $1 ORDER BY order_index`,
      [req.params.id]
    );
    const questions = await db.query(
      `SELECT q.id, q.module_id, q.type, q.difficulty, q.prompt, q.options, q.correct_answer
       FROM questions q
       JOIN modules m ON m.id = q.module_id
       WHERE m.book_id = $1
       ORDER BY q.module_id, q.difficulty`,
      [req.params.id]
    );
    const byModule: Record<number, unknown[]> = {};
    for (const q of questions.rows) (byModule[q.module_id] ??= []).push(q);
    res.json({
      modules: modules.rows.map((m) => ({ ...m, questions: byModule[m.id] ?? [] })),
    });
  } catch (err) {
    console.error('admin/books course error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// ─── Per-question editing (review/fix generated questions) ────────────────────
const Q_TYPES = ['multiple_choice', 'short_answer', 'explanation', 'coding', 'math_problem'];
const Q_DIFFS = ['foundational', 'applied', 'advanced'];

// PATCH /api/admin/questions/:id — update any provided field.
router.patch('/questions/:id', async (req, res) => {
  const { prompt, type, difficulty, options, correct_answer } = req.body as {
    prompt?: string; type?: string; difficulty?: string; options?: unknown; correct_answer?: string | null;
  };
  if (type !== undefined && !Q_TYPES.includes(type)) { res.status(400).json({ error: 'Invalid type' }); return; }
  if (difficulty !== undefined && !Q_DIFFS.includes(difficulty)) { res.status(400).json({ error: 'Invalid difficulty' }); return; }
  if (prompt !== undefined && (typeof prompt !== 'string' || !prompt.trim())) { res.status(400).json({ error: 'Prompt cannot be empty' }); return; }

  const sets: string[] = [];
  const vals: unknown[] = [];
  let i = 1;
  if (prompt !== undefined) { sets.push(`prompt = $${i++}`); vals.push(prompt.trim()); }
  if (type !== undefined) { sets.push(`type = $${i++}`); vals.push(type); }
  if (difficulty !== undefined) { sets.push(`difficulty = $${i++}`); vals.push(difficulty); }
  if (options !== undefined) { sets.push(`options = $${i++}`); vals.push(options ? JSON.stringify(options) : null); }
  if (correct_answer !== undefined) { sets.push(`correct_answer = $${i++}`); vals.push(correct_answer ?? null); }
  if (sets.length === 0) { res.status(400).json({ error: 'Nothing to update' }); return; }

  try {
    vals.push(req.params.id);
    const r = await db.query(
      `UPDATE questions SET ${sets.join(', ')} WHERE id = $${i}
       RETURNING id, type, difficulty, prompt, options, correct_answer`,
      vals
    );
    if (!r.rows[0]) { res.status(404).json({ error: 'Question not found' }); return; }
    res.json({ question: r.rows[0] });
  } catch (err) {
    console.error('admin/questions patch error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// DELETE /api/admin/questions/:id
router.delete('/questions/:id', async (req, res) => {
  try {
    await db.query('DELETE FROM questions WHERE id = $1', [req.params.id]);
    res.json({ success: true });
  } catch (err) {
    console.error('admin/questions delete error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// POST /api/admin/modules/:moduleId/questions — add a question to a module.
router.post('/modules/:moduleId/questions', async (req, res) => {
  const { type = 'short_answer', difficulty = 'applied', prompt = '', options = null, correct_answer = null } =
    req.body as { type?: string; difficulty?: string; prompt?: string; options?: unknown; correct_answer?: string | null };
  if (!Q_TYPES.includes(type) || !Q_DIFFS.includes(difficulty) || typeof prompt !== 'string' || !prompt.trim()) {
    res.status(400).json({ error: 'A valid type, difficulty, and prompt are required' });
    return;
  }
  try {
    const concept = await db.query<{ id: number }>(
      `SELECT id FROM concepts WHERE module_id = $1 ORDER BY order_index LIMIT 1`,
      [req.params.moduleId]
    );
    const r = await db.query(
      `INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer)
       VALUES ($1, $2, $3, $4, $5, $6, $7)
       RETURNING id, type, difficulty, prompt, options, correct_answer`,
      [req.params.moduleId, concept.rows[0]?.id ?? null, type, difficulty, prompt.trim(),
       options ? JSON.stringify(options) : null, correct_answer]
    );
    res.status(201).json({ question: r.rows[0] });
  } catch (err) {
    console.error('admin/modules add-question error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// ─── Chunk management (fix extraction noise) ──────────────────────────────────
// GET /api/admin/books/:id/chunks
router.get('/books/:id/chunks', async (req, res) => {
  try {
    const r = await db.query(
      `SELECT id, chapter, section, chunk_index, content FROM book_chunks WHERE book_id = $1 ORDER BY chunk_index`,
      [req.params.id]
    );
    res.json({ chunks: r.rows });
  } catch (err) {
    console.error('admin/chunks list error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// PATCH /api/admin/chunks/:id — edit a chunk's text and re-embed it.
router.patch('/chunks/:id', async (req: AuthRequest, res) => {
  const { content } = req.body as { content?: string };
  if (typeof content !== 'string' || !content.trim()) { res.status(400).json({ error: 'content required' }); return; }
  try {
    const vec = await embed(content.trim());
    if (await pgvectorReady()) {
      await db.query(`UPDATE book_chunks SET content = $2, embedding = $3, embedding_v = $4::vector WHERE id = $1`,
        [req.params.id, content.trim(), vec, toVectorLiteral(vec)]);
    } else {
      await db.query(`UPDATE book_chunks SET content = $2, embedding = $3 WHERE id = $1`,
        [req.params.id, content.trim(), vec]);
    }
    logAudit(req.adminEmail, 'chunk.edit', { id: req.params.id });
    res.json({ success: true });
  } catch (err) {
    console.error('admin/chunks patch error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// DELETE /api/admin/chunks/:id — drop a junk chunk (TOC/index/etc).
router.delete('/chunks/:id', async (req: AuthRequest, res) => {
  try {
    const r = await db.query(`DELETE FROM book_chunks WHERE id = $1 RETURNING book_id`, [req.params.id]);
    if (r.rows[0]) {
      await db.query(`UPDATE books SET num_chunks = (SELECT COUNT(*) FROM book_chunks WHERE book_id = $1) WHERE id = $1`,
        [r.rows[0].book_id]);
    }
    logAudit(req.adminEmail, 'chunk.delete', { id: req.params.id });
    res.json({ success: true });
  } catch (err) {
    console.error('admin/chunks delete error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// ─── Teach-test sandbox ───────────────────────────────────────────────────────
// POST /api/admin/books/:id/teach-test — preview the grounded mentor as a learner
// would experience it (non-streaming), to confirm the book stays invisible.
router.post('/books/:id/teach-test', async (req: AuthRequest, res) => {
  const { message, history = [] } = req.body as { message?: string; history?: { role: 'user' | 'assistant'; content: string }[] };
  if (typeof message !== 'string' || !message.trim()) { res.status(400).json({ error: 'message required' }); return; }
  try {
    const book = await db.query<{ subject_id: number }>('SELECT subject_id FROM books WHERE id = $1', [req.params.id]);
    if (!book.rows[0]) { res.status(404).json({ error: 'Book not found' }); return; }

    const chunks = await retrieveChunks(book.rows[0].subject_id, message.trim(), 5);
    const passages = chunks.map((c, i) => `[${i + 1}]${c.chapter ? ` (${c.chapter})` : ''} ${c.content}`).join('\n\n');
    const system = `You are an expert, warm mentor. Use the reference knowledge below as your authoritative source.
NEVER mention a book, text, document, passage, "source", or "according to" — speak as an expert who simply knows this.
Before explaining, ask a question to gauge understanding; use analogies and worked examples; if something isn't covered, teach it from your own expertise without flagging any gap.

## Reference knowledge (internal use only)
${passages || '(no passages found)'}`;

    const reply = await createChat({
      modelId: await getUserModelId(req.userId!),
      maxTokens: 700,
      feature: 'teach-test',
      system,
      messages: [...history.slice(-6), { role: 'user', content: message.trim() }],
    });
    res.json({ reply, retrieved: chunks.map((c) => ({ chapter: c.chapter, score: c.score })) });
  } catch (err) {
    console.error('admin/teach-test error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

export default router;
