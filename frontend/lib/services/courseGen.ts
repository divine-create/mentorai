// ─── Course generation from a book ────────────────────────────────────────────
// Turns an ingested book into a real learning path: chapters become modules (one
// concept each), each book chunk is mapped to its module, and an LLM generates a
// question bank per chapter — grounded strictly in that chapter's text — stored
// in the existing `questions` table. Tagged with book_id so a rebuild or a book
// deletion cleanly removes the derived course.

import { db } from '../db';
import { createChat } from './llm';
import { embed, cosineSim } from './embeddings';
import { getSettings } from './settings';

interface ChunkRow { id: number; chapter: string | null; content: string }
interface Group { title: string; text: string; ids: number[] }

interface GenQuestion {
  type: 'multiple_choice' | 'short_answer' | 'explanation';
  difficulty: 'foundational' | 'applied' | 'advanced';
  prompt: string;
  options: { label: string; text: string }[] | null;
  correct_answer: string | null;
}

function slugify(s: string): string {
  return (s || '').toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/^-|-$/g, '') || 'module';
}

function firstSentence(text: string): string {
  const t = text.replace(/\s+/g, ' ').trim();
  const m = t.match(/^.{0,200}?[.!?](\s|$)/);
  return (m ? m[0] : t.slice(0, 160)).trim();
}

/** Group consecutive chunks by chapter; fall back to even windows when headings are absent or noisy. */
function groupChunks(chunks: ChunkRow[]): Group[] {
  const byChapter: { chapter: string | null; contents: string[]; ids: number[] }[] = [];
  for (const c of chunks) {
    const last = byChapter[byChapter.length - 1];
    if (last && last.chapter === c.chapter) {
      last.contents.push(c.content);
      last.ids.push(c.id);
    } else {
      byChapter.push({ chapter: c.chapter, contents: [c.content], ids: [c.id] });
    }
  }

  // Too few (no headings) or implausibly many → window into ~12 modules.
  // A well-structured book (~20–40 real chapters) takes the chapter path below.
  if (byChapter.length < 2 || byChapter.length > 40) {
    const target = Math.min(12, Math.max(1, Math.ceil(chunks.length / 4)));
    const size = Math.ceil(chunks.length / target);
    const groups: Group[] = [];
    for (let i = 0; i < chunks.length; i += size) {
      const slice = chunks.slice(i, i + size);
      groups.push({
        title: `Part ${groups.length + 1}`,
        text: slice.map((c) => c.content).join('\n\n'),
        ids: slice.map((c) => c.id),
      });
    }
    return groups;
  }

  return byChapter.map((g, i) => ({
    title: g.chapter ?? `Part ${i + 1}`,
    text: g.contents.join('\n\n'),
    ids: g.ids,
  }));
}

/** Parse the LLM's JSON into validated, DB-ready questions. Bad entries are skipped. */
function parseQuestions(raw: string): GenQuestion[] {
  let parsed: any;
  try {
    parsed = JSON.parse(raw.match(/\{[\s\S]*\}/)?.[0] ?? '{}');
  } catch {
    return [];
  }
  const arr: any[] = Array.isArray(parsed.questions) ? parsed.questions : [];
  const diffs = ['foundational', 'applied', 'advanced'];
  const out: GenQuestion[] = [];

  for (const q of arr) {
    const type = q?.type;
    if (!['multiple_choice', 'short_answer', 'explanation'].includes(type)) continue;
    const prompt = typeof q.prompt === 'string' ? q.prompt.trim() : '';
    if (!prompt) continue;
    const difficulty = diffs.includes(q.difficulty) ? q.difficulty : 'applied';

    if (type === 'multiple_choice') {
      const opts = Array.isArray(q.options)
        ? q.options.filter((o: unknown) => typeof o === 'string' && (o as string).trim()).slice(0, 6)
        : [];
      if (opts.length < 2) continue;
      const ansIdx = Number.isInteger(q.answer) && q.answer >= 0 && q.answer < opts.length ? q.answer : 0;
      const options = opts.map((t: string, i: number) => ({ label: String.fromCharCode(65 + i), text: t.trim() }));
      out.push({ type, difficulty, prompt, options, correct_answer: options[ansIdx].text });
    } else {
      const ca = typeof q.correct_answer === 'string' ? q.correct_answer.trim() : '';
      out.push({ type, difficulty, prompt, options: null, correct_answer: ca || null });
    }
  }
  return out;
}

/**
 * Sample text from across a chapter (beginning → middle → end) up to a bounded
 * budget, so questions cover the whole chapter rather than only its opening.
 */
function sampleAcross(text: string, budget = 9000): string {
  if (text.length <= budget) return text;
  const windows = 3;
  const win = Math.floor(budget / windows);
  const parts: string[] = [];
  for (let i = 0; i < windows; i++) {
    const start = Math.floor((text.length - win) * (i / (windows - 1)));
    parts.push(text.slice(start, start + win));
  }
  return parts.join('\n…\n');
}

async function generateQuestions(modelId: string, title: string, text: string, count: number): Promise<GenQuestion[]> {
  const prompt = `You are creating quiz questions for a lesson titled "${title}".
Base EVERY question strictly on the lesson content below — do not use outside knowledge, and never refer to "the text", "the passage", or "the lesson"; phrase questions as standalone.

LESSON CONTENT:
${sampleAcross(text)}

Write exactly ${count} questions testing understanding of this content. Mix the types and span difficulties foundational → applied → advanced:
- mostly "multiple_choice" (each with 4 options) and "short_answer" (with a concise correct answer)
- include at least one "explanation" question asking the learner to explain a concept in their own words

Reply with ONLY valid JSON, no prose outside it:
{"questions":[
 {"type":"multiple_choice","difficulty":"foundational","prompt":"...","options":["...","...","...","..."],"answer":0},
 {"type":"short_answer","difficulty":"applied","prompt":"...","correct_answer":"..."},
 {"type":"explanation","difficulty":"advanced","prompt":"...","correct_answer":"the key points a strong answer should contain"}
]}`;

  const raw = await createChat({ modelId, maxTokens: 1800, feature: 'course-gen', messages: [{ role: 'user', content: prompt }] });
  return parseQuestions(raw);
}

/**
 * Build (or rebuild) the learning path for a book. Idempotent: clears any prior
 * generated course for this book first. Tracks progress on the books row.
 */
export async function buildCourseFromBook(bookId: number, modelId: string): Promise<void> {
  await db.query(`UPDATE books SET course_status = 'building', course_error = NULL WHERE id = $1`, [bookId]);

  try {
    const bookRes = await db.query<{ subject_id: number | null }>(`SELECT subject_id FROM books WHERE id = $1`, [bookId]);
    const subjectId = bookRes.rows[0]?.subject_id;
    if (!subjectId) throw new Error('Book has no subject to attach modules to.');

    const chunksRes = await db.query<ChunkRow>(
      `SELECT id, chapter, content FROM book_chunks WHERE book_id = $1 ORDER BY chunk_index`,
      [bookId]
    );
    if (chunksRes.rows.length === 0) throw new Error('No passages to build a course from. Ingest the book first.');

    // Clear any previously generated course for this book (concepts/questions/mastery cascade).
    await db.query(`DELETE FROM modules WHERE book_id = $1`, [bookId]);

    const groups = groupChunks(chunksRes.rows);
    const baseRes = await db.query<{ m: number }>(
      `SELECT COALESCE(MAX(order_index), 0) AS m FROM modules WHERE subject_id = $1`,
      [subjectId]
    );
    const base = Number(baseRes.rows[0].m);
    const perChapter = (await getSettings()).questionsPerChapter || 5;

    let totalQuestions = 0;
    for (let i = 0; i < groups.length; i++) {
      const g = groups[i];
      const slug = `b${bookId}-m${i + 1}-${slugify(g.title)}`.slice(0, 80);
      const description = firstSentence(g.text);

      // Generated modules start as DRAFTS (published=false) so an admin reviews
      // before learners see them.
      const mod = await db.query<{ id: number }>(
        `INSERT INTO modules (slug, title, description, order_index, subject_id, book_id, published, estimated_hours_min, estimated_hours_max)
         VALUES ($1, $2, $3, $4, $5, $6, false, 1, 2) RETURNING id`,
        [slug, g.title.slice(0, 200), description, base + i + 1, subjectId, bookId]
      );
      const moduleId = mod.rows[0].id;

      const concept = await db.query<{ id: number }>(
        `INSERT INTO concepts (module_id, title, description, order_index) VALUES ($1, $2, $3, 1) RETURNING id`,
        [moduleId, g.title.slice(0, 200), description]
      );
      const conceptId = concept.rows[0].id;

      await db.query(`UPDATE book_chunks SET module_id = $1 WHERE id = ANY($2::int[])`, [moduleId, g.ids]);

      // Embeddings for this chapter's chunks → used to score how well each
      // generated question is grounded in the source (faithfulness).
      const chunkVecs = (
        await db.query<{ embedding: number[] }>(`SELECT embedding FROM book_chunks WHERE id = ANY($1::int[])`, [g.ids])
      ).rows.map((r) => r.embedding);

      const questions = await generateQuestions(modelId, g.title, g.text, perChapter);
      for (const q of questions) {
        let groundedness: number | null = null;
        try {
          const qVec = await embed(`${q.prompt} ${q.correct_answer ?? ''}`);
          groundedness = chunkVecs.length ? Math.max(...chunkVecs.map((v: any) => cosineSim(qVec, v))) : null;
        } catch { /* scoring is best-effort */ }

        await db.query(
          `INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, groundedness)
           VALUES ($1, $2, $3, $4, $5, $6, $7, $8)`,
          [moduleId, conceptId, q.type, q.difficulty, q.prompt, q.options ? JSON.stringify(q.options) : null, q.correct_answer, groundedness]
        );
        totalQuestions++;
      }
    }

    await db.query(
      `UPDATE books SET course_status = 'built', num_modules = $2, num_questions = $3, course_error = NULL WHERE id = $1`,
      [bookId, groups.length, totalQuestions]
    );
  } catch (err) {
    const message = err instanceof Error ? err.message : String(err);
    console.error(`buildCourseFromBook(${bookId}) failed:`, message);
    await db.query(`UPDATE books SET course_status = 'failed', course_error = $2 WHERE id = $1`, [bookId, message]);
  }
}
