// ─── Book ingestion pipeline ──────────────────────────────────────────────────
// Turns an uploaded file (PDF / text / Markdown) into embedded passages stored in
// `book_chunks`. Runs asynchronously after the upload responds; status is tracked
// on the `books` row and polled by the admin UI. The original file is never
// persisted — only the derived passages and their embeddings.

import AdmZip from 'adm-zip';
import { db } from '../db/pool';
import { embed, pgvectorReady, toVectorLiteral } from './embeddings';
import { getSettings } from './settings';

// pdf-parse v2 is an ESM, class-based API; this project is CommonJS (ts-node).
// A true dynamic import (hidden from the TS down-leveler via Function) loads it
// without require(). Same trick as services/embeddings.ts.
const dynamicImport = new Function('s', 'return import(s)') as (s: string) => Promise<any>;

const DEFAULT_TARGET_CHARS = 1500; // ~400 tokens per chunk

interface Chunk {
  chapter: string | null;
  section: string | null;
  content: string;
}

/** Strip XHTML to text, turning headings/blocks into the paragraph/heading shape the chunker expects. */
function htmlToText(html: string): string {
  return html
    .replace(/<\?xml[\s\S]*?\?>/g, '')
    .replace(/<!DOCTYPE[\s\S]*?>/gi, '')
    .replace(/<head[\s\S]*?<\/head>/gi, '')
    .replace(/<(script|style)[\s\S]*?<\/\1>/gi, '')
    .replace(/<h[1-6][^>]*>/gi, '\n\n# ')                              // headings → "# ..." so headingOf detects them
    .replace(/<\/h[1-6]>/gi, '\n\n')
    .replace(/<li[^>]*>/gi, '• ')
    .replace(/<\/(p|div|li|tr|section|article|blockquote|h[1-6])>/gi, '\n\n')
    .replace(/<br\s*\/?>(?!\n)/gi, '\n')
    .replace(/<[^>]+>/g, ' ')                                          // strip remaining tags
    .replace(/&nbsp;/gi, ' ').replace(/&amp;/gi, '&').replace(/&lt;/gi, '<')
    .replace(/&gt;/gi, '>').replace(/&quot;/gi, '"').replace(/&#39;|&apos;/gi, "'")
    .replace(/&#(\d+);/g, (_, n) => { try { return String.fromCodePoint(Number(n)); } catch { return ''; } })
    .replace(/[ \t]+/g, ' ')
    .replace(/\n{3,}/g, '\n\n');
}

/** Extract reading-order text from an EPUB (a zip of XHTML referenced by an OPF spine). */
function parseEpub(buffer: Buffer): string {
  const zip = new AdmZip(buffer);
  const read = (p: string) => zip.getEntry(p)?.getData().toString('utf-8') ?? '';

  const container = read('META-INF/container.xml');
  const opfPath = container.match(/full-path="([^"]+)"/)?.[1];
  if (!opfPath) throw new Error('Invalid EPUB: container.xml has no rootfile.');
  const opf = read(opfPath);
  const opfDir = opfPath.includes('/') ? opfPath.replace(/\/[^/]*$/, '/') : '';

  // manifest: id → href
  const manifest: Record<string, string> = {};
  for (const tag of opf.match(/<item\b[^>]*>/gi) ?? []) {
    const id = tag.match(/\bid="([^"]+)"/)?.[1];
    const href = tag.match(/\bhref="([^"]+)"/)?.[1];
    if (id && href) manifest[id] = href;
  }
  // spine: reading order of idrefs
  const order: string[] = [];
  for (const m of opf.matchAll(/<itemref\b[^>]*\bidref="([^"]+)"/gi)) order.push(m[1]);

  const parts: string[] = [];
  for (const id of order) {
    const href = manifest[id];
    if (!href) continue;
    const entryPath = decodeURIComponent((opfDir + href).replace(/^\.\//, ''));
    const html = read(entryPath);
    if (html) parts.push(htmlToText(html));
  }
  if (parts.length === 0) throw new Error('EPUB contained no readable spine documents.');
  return parts.join('\n\n');
}

/** Raw text from a PDF, preserving pdf-parse's `-- N of NNN --` page separators. */
export async function parsePdf(buffer: Buffer): Promise<string> {
  const { PDFParse } = await dynamicImport('pdf-parse');
  const parser = new PDFParse({ data: buffer });
  try {
    const result = await parser.getText();
    return result.text ?? '';
  } finally {
    await parser.destroy();
  }
}

function isPdf(mime: string, filename: string): boolean {
  return mime === 'application/pdf' || filename.toLowerCase().endsWith('.pdf');
}

async function parse(buffer: Buffer, mime: string, filename: string): Promise<string> {
  const lower = filename.toLowerCase();
  if (isPdf(mime, filename)) return parsePdf(buffer);
  if (mime === 'application/epub+zip' || lower.endsWith('.epub')) {
    return parseEpub(buffer);
  }
  return buffer.toString('utf-8');
}

const PAGE_MARKER = /--\s*\d+\s+of\s+\d+\s*--/g;
const normalizeTitle = (s: string) => s.toLowerCase().replace(/[^a-z0-9]+/g, ' ').trim();

/**
 * Structured extraction for technical-book PDFs that carry a table of contents
 * plus per-page running headers (e.g. "Getting Started \t5" on right pages,
 * "158 \tChapter 9" on left pages). Returns chapter-tagged chunks, or null when
 * the book isn't in this shape (caller falls back to the heuristic chunker).
 */
interface BookSection { key: string; title: string } // key: "ch:3" | "ap:A"

export function extractStructuredChapters(rawText: string, targetChars: number): Chunk[] | null {
  const pages = rawText.split(PAGE_MARKER);
  if (pages.length < 10) return null; // not pdf-parse's paged output

  // 1. Parse the TOC → ordered sections (chapters, then appendices).
  const sections: BookSection[] = [];
  const seen = new Set<string>();
  const addSection = (key: string, title: string) => {
    const t = title.replace(/\s+/g, ' ').trim();
    if (!seen.has(key) && t && t.length <= 80) { seen.add(key); sections.push({ key, title: t }); }
  };
  for (const seg of pages) {
    for (const line of seg.split('\n')) {
      const ch = line.match(/^\s*Chapter\s+(\d+):\s+(.+?)\s*\t/i);
      if (ch) { addSection(`ch:${Number(ch[1])}`, ch[2]); continue; }
      const ap = line.match(/^\s*Appendix\s+([A-Z]):\s+(.+?)\s*\t/i);
      if (ap) addSection(`ap:${ap[1].toUpperCase()}`, ap[2]);
    }
    if (sections.length >= 50) break;
  }
  const chapterCount = sections.filter((s) => s.key.startsWith('ch:')).length;
  if (chapterCount < 3) return null;
  // Order: chapters by number, then appendices by letter.
  sections.sort((a, b) => {
    const rank = (k: string) => (k.startsWith('ch:') ? Number(k.slice(3)) : 1000 + (k.charCodeAt(3) || 0));
    return rank(a.key) - rank(b.key);
  });
  const keyByNormTitle = new Map(sections.map((s) => [normalizeTitle(s.title), s.key]));
  const validKeys = new Set(sections.map((s) => s.key));

  // 2. Walk pages, assigning each to a section via its running header. Front
  //    matter (before chapter 1) is dropped; an Index header (either order)
  //    stops collection, dropping the index.
  const sectionText = new Map<string, string[]>();
  let current: string | null = null;
  for (const seg of pages) {
    const trimmed = seg.replace(/^\s+/, '');
    const firstLine = (trimmed.split('\n')[0] ?? '').trim();

    if (/^(index\b|\d+\s*\t\s*index\b)/i.test(firstLine)) { current = null; continue; }

    let detected: string | null = null;
    const leftCh = firstLine.match(/^\d+\s*\t\s*Chapter\s+(\d+)\b/i);
    const leftAp = firstLine.match(/^\d+\s*\t\s*Appendix\s+([A-Z])\b/i);
    if (leftCh) detected = `ch:${Number(leftCh[1])}`;
    else if (leftAp) detected = `ap:${leftAp[1].toUpperCase()}`;
    else {
      const right = firstLine.match(/^(.+?)\s*\t\s*\d+\s*$/);
      if (right) detected = keyByNormTitle.get(normalizeTitle(right[1])) ?? null;
    }
    if (detected && validKeys.has(detected)) current = detected;
    if (current === null) continue;

    // Drop the running-header line; keep the rest of the page.
    sectionText.set(current, [...(sectionText.get(current) ?? []), trimmed.split('\n').slice(1).join('\n')]);
  }

  // 3. clean() + chunk() per section, tagging chunks with the real title.
  const out: Chunk[] = [];
  for (const s of sections) {
    const texts = sectionText.get(s.key);
    if (!texts || texts.length === 0) continue;
    for (const c of chunk(clean(texts.join('\n\n')), targetChars)) {
      out.push({ chapter: s.title, section: s.title, content: c.content });
    }
  }
  return out.length > 0 ? out : null;
}

/** Normalize extracted text: drop noise, fix line-break artifacts, keep paragraph breaks. */
function clean(raw: string): string {
  return raw
    .replace(/\r\n/g, '\n')
    .replace(PAGE_MARKER, '\n\n')           // pdf-parse "-- N of NNN --" page separators
    .replace(/\f/g, '\n\n')                 // form feed = page break
    .replace(/(\w)-\n(\w)/g, '$1$2')        // de-hyphenate words split across lines
    .replace(/^[ \t]*\d+[ \t]*$/gm, '')     // page-number-only lines
    .replace(/\n{3,}/g, '\n\n')             // collapse big gaps to a paragraph break
    .trim();
}

/** Does this line look like a chapter/section heading? */
function headingOf(line: string): string | null {
  const t = line.trim();
  if (!t || t.length > 80) return null;
  if (/^#{1,6}\s+\S/.test(t)) return t.replace(/^#{1,6}\s+/, '');           // markdown
  if (/^(chapter|part|section|unit)\s+[\dIVXLCM]+/i.test(t)) return t;       // "Chapter 3"
  if (/^\d+(\.\d+)*\.?\s+\S/.test(t) && t.split(' ').length <= 10) return t; // "1.2 Title"
  return null;
}

/**
 * Split cleaned text into ~TARGET_CHARS passages on paragraph boundaries, never
 * spanning a heading, tagging each with the most recent heading as chapter.
 */
function chunk(text: string, targetChars: number): Chunk[] {
  const blocks = text.split(/\n{2,}/).map((b) => b.replace(/\n/g, ' ').replace(/\s+/g, ' ').trim()).filter(Boolean);

  const chunks: Chunk[] = [];
  let chapter: string | null = null;
  let buf = '';

  const flush = () => {
    const content = buf.trim();
    if (content.length >= 40) chunks.push({ chapter, section: chapter, content });
    buf = '';
  };

  for (const block of blocks) {
    const heading = headingOf(block);
    if (heading) {
      flush();             // close the previous section
      chapter = heading;
      continue;            // headings orient retrieval but aren't content on their own
    }
    if (buf.length + block.length > targetChars && buf.length > 0) flush();
    buf += (buf ? ' ' : '') + block;
  }
  flush();

  return chunks;
}

/**
 * Full pipeline for one book. The caller holds the upload buffer; we parse →
 * clean → chunk → embed → store, then mark the book ready (or failed).
 */
export async function ingestBook(
  bookId: number,
  subjectId: number | null,
  buffer: Buffer,
  mime: string,
  filename: string
): Promise<void> {
  try {
    const targetChars = (await getSettings()).chunkTargetChars || DEFAULT_TARGET_CHARS;

    // PDFs: try structured (TOC + running-header) chapter extraction first, so a
    // textbook becomes real chapter modules; fall back to the heuristic chunker.
    let chunks: Chunk[];
    if (isPdf(mime, filename)) {
      const rawText = await parsePdf(buffer);
      chunks = extractStructuredChapters(rawText, targetChars) ?? chunk(clean(rawText), targetChars);
    } else {
      const text = await parse(buffer, mime, filename);
      chunks = chunk(clean(text), targetChars);
    }
    if (chunks.length === 0) throw new Error('No readable text could be extracted from the file.');

    const usePgvector = await pgvectorReady();
    let idx = 0;
    for (const c of chunks) {
      const vec = await embed(c.content);
      if (usePgvector) {
        await db.query(
          `INSERT INTO book_chunks (book_id, subject_id, chapter, section, chunk_index, content, embedding, embedding_v)
           VALUES ($1, $2, $3, $4, $5, $6, $7, $8::vector)`,
          [bookId, subjectId, c.chapter, c.section, idx++, c.content, vec, toVectorLiteral(vec)]
        );
      } else {
        await db.query(
          `INSERT INTO book_chunks (book_id, subject_id, chapter, section, chunk_index, content, embedding)
           VALUES ($1, $2, $3, $4, $5, $6, $7)`,
          [bookId, subjectId, c.chapter, c.section, idx++, c.content, vec]
        );
      }
    }

    await db.query(`UPDATE books SET status = 'ready', num_chunks = $2, error = NULL WHERE id = $1`, [
      bookId,
      chunks.length,
    ]);
  } catch (err) {
    const message = err instanceof Error ? err.message : String(err);
    console.error(`ingestBook(${bookId}) failed:`, message);
    await db.query(`UPDATE books SET status = 'failed', error = $2 WHERE id = $1`, [bookId, message]);
  }
}
