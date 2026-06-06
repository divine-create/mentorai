-- AI Academy — Books (invisible knowledge source for the mentor)
--
-- An admin uploads a book; it is parsed into passages (`book_chunks`), each with
-- a stored embedding. At teaching time the tutor silently retrieves the most
-- relevant passages and grounds its explanations in them — the learner never
-- sees the book. Embeddings are stored as real[] and ranked in-process (no
-- pgvector dependency); this scales fine for a handful of books.

CREATE TABLE IF NOT EXISTS books (
  id           SERIAL PRIMARY KEY,
  title        TEXT NOT NULL,
  subject_id   INT REFERENCES subjects(id) ON DELETE CASCADE,
  uploaded_by  UUID REFERENCES users(id) ON DELETE SET NULL,
  status       TEXT NOT NULL DEFAULT 'processing'
    CHECK (status IN ('processing', 'ready', 'failed')),
  num_chunks   INT NOT NULL DEFAULT 0,
  error        TEXT,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE INDEX IF NOT EXISTS idx_books_subject ON books(subject_id);

CREATE TABLE IF NOT EXISTS book_chunks (
  id           SERIAL PRIMARY KEY,
  book_id      INT NOT NULL REFERENCES books(id) ON DELETE CASCADE,
  subject_id   INT REFERENCES subjects(id) ON DELETE CASCADE,  -- denormalized for fast retrieval scoping
  module_id    INT REFERENCES modules(id) ON DELETE SET NULL,  -- set when chapter→module mapping runs (later phase)
  chapter      TEXT,
  section      TEXT,
  chunk_index  INT NOT NULL DEFAULT 0,
  content      TEXT NOT NULL,
  embedding    REAL[] NOT NULL,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE INDEX IF NOT EXISTS idx_book_chunks_subject ON book_chunks(subject_id);
CREATE INDEX IF NOT EXISTS idx_book_chunks_book ON book_chunks(book_id);
