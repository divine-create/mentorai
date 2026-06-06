// ─── Local text embeddings + retrieval ────────────────────────────────────────
// Embeds text fully in-process with a small sentence-transformer (MiniLM) via
// transformers.js — no API key, no credits, no external calls beyond the one-time
// model download. Vectors are 384-dim and L2-normalized, so cosine similarity is
// just a dot product. Retrieval ranks a subject's stored book chunks against a
// query in JS (brute force is <50ms for a handful of books).

import { db } from '../db/pool';

const MODEL = 'Xenova/all-MiniLM-L6-v2';

// transformers.js is ESM-only; this project is CommonJS (ts-node). A true dynamic
// import (hidden from the TS down-leveler via Function) loads it without require().
const dynamicImport = new Function('s', 'return import(s)') as (s: string) => Promise<any>;

let extractorPromise: Promise<any> | null = null;

function getExtractor(): Promise<any> {
  if (!extractorPromise) {
    extractorPromise = dynamicImport('@xenova/transformers').then(({ pipeline }) =>
      pipeline('feature-extraction', MODEL)
    );
  }
  return extractorPromise;
}

/** Embed a string into a 384-dim, L2-normalized vector. */
export async function embed(text: string): Promise<number[]> {
  const extractor = await getExtractor();
  const output = await extractor(text.replace(/\s+/g, ' ').trim().slice(0, 4000), {
    pooling: 'mean',
    normalize: true,
  });
  return Array.from(output.data as Float32Array);
}

/** Cosine similarity. Vectors are normalized, so this is effectively a dot product. */
export function cosineSim(a: number[], b: number[]): number {
  let dot = 0;
  let na = 0;
  let nb = 0;
  const n = Math.min(a.length, b.length);
  for (let i = 0; i < n; i++) {
    dot += a[i] * b[i];
    na += a[i] * a[i];
    nb += b[i] * b[i];
  }
  if (na === 0 || nb === 0) return 0;
  return dot / (Math.sqrt(na) * Math.sqrt(nb));
}

export interface RetrievedChunk {
  id: number;
  content: string;
  chapter: string | null;
  section: string | null;
  score: number;
}

/** Cheap existence check — lets callers skip loading the model when a subject has no book. */
export async function subjectHasChunks(subjectId: number): Promise<boolean> {
  const { rows } = await db.query('SELECT 1 FROM book_chunks WHERE subject_id = $1 LIMIT 1', [subjectId]);
  return rows.length > 0;
}

/** Format a vector for a pgvector literal: '[a,b,c]'. */
export function toVectorLiteral(vec: number[]): string {
  return `[${vec.join(',')}]`;
}

// Whether the pgvector `embedding_v` column exists (detected once). When present
// we rank in SQL; otherwise we fall back to loading rows and ranking in-process.
let pgvectorReadyPromise: Promise<boolean> | null = null;
export function pgvectorReady(): Promise<boolean> {
  if (!pgvectorReadyPromise) {
    pgvectorReadyPromise = db
      .query(`SELECT 1 FROM information_schema.columns WHERE table_name='book_chunks' AND column_name='embedding_v'`)
      .then((r) => r.rows.length > 0)
      .catch(() => false);
  }
  return pgvectorReadyPromise;
}

/** Return the top-k book chunks for a subject most similar to `query`. */
export async function retrieveChunks(subjectId: number, query: string, k = 4): Promise<RetrievedChunk[]> {
  const qVec = await embed(query);

  // Fast path: rank in SQL with the pgvector cosine operator + index.
  if (await pgvectorReady()) {
    const { rows } = await db.query<RetrievedChunk>(
      `SELECT id, content, chapter, section, 1 - (embedding_v <=> $2::vector) AS score
       FROM book_chunks
       WHERE subject_id = $1 AND embedding_v IS NOT NULL
       ORDER BY embedding_v <=> $2::vector
       LIMIT $3`,
      [subjectId, toVectorLiteral(qVec), k]
    );
    if (rows.length > 0) return rows.map((r) => ({ ...r, score: Number(r.score) }));
    // else fall through (e.g. rows predate the vector column) to in-process ranking
  }

  // Fallback: load the subject's chunks and rank in-process.
  const { rows } = await db.query<{
    id: number;
    content: string;
    chapter: string | null;
    section: string | null;
    embedding: number[];
  }>('SELECT id, content, chapter, section, embedding FROM book_chunks WHERE subject_id = $1', [subjectId]);

  if (rows.length === 0) return [];

  return rows
    .map((r) => ({
      id: r.id,
      content: r.content,
      chapter: r.chapter,
      section: r.section,
      score: cosineSim(qVec, r.embedding),
    }))
    .sort((a, b) => b.score - a.score)
    .slice(0, k);
}
