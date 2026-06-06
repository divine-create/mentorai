-- AI Academy — Optional pgvector acceleration
--
-- If the pgvector extension is available on the server, add a native `vector`
-- column + cosine index to book_chunks and backfill it from the real[] column,
-- so retrieval can rank in SQL instead of in-process. If the extension is NOT
-- available (e.g. the stock postgres image), this migration is a NO-OP and the
-- app transparently keeps using the real[] + in-process cosine path.
--
-- Everything is wrapped so `npm run migrate` never fails when pgvector is absent.

DO $$
BEGIN
  BEGIN
    CREATE EXTENSION IF NOT EXISTS vector;
  EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE 'pgvector not available (%): keeping real[] + in-process cosine.', SQLERRM;
  END;

  IF EXISTS (SELECT 1 FROM pg_extension WHERE extname = 'vector') THEN
    ALTER TABLE book_chunks ADD COLUMN IF NOT EXISTS embedding_v vector(384);

    -- Backfill from the real[] column. real[]::text is '{a,b,c}'; vector wants '[a,b,c]'.
    UPDATE book_chunks
    SET embedding_v = replace(replace(embedding::text, '{', '['), '}', ']')::vector
    WHERE embedding_v IS NULL AND embedding IS NOT NULL;

    CREATE INDEX IF NOT EXISTS idx_book_chunks_vec
      ON book_chunks USING hnsw (embedding_v vector_cosine_ops);

    RAISE NOTICE 'pgvector enabled: book_chunks.embedding_v added and indexed.';
  END IF;
END$$;
