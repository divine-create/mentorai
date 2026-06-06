-- AI Academy — Course generation from a book
--
-- A book can be turned into a real learning path: its chapters become modules
-- (one concept each) and an LLM generates a question bank per chapter, stored in
-- the existing `questions` table. Generated modules are tagged with book_id so a
-- rebuild — or deleting the book — cleanly removes the whole derived course
-- (concepts, questions, and module_mastery cascade from modules).

ALTER TABLE modules ADD COLUMN IF NOT EXISTS book_id INT REFERENCES books(id) ON DELETE CASCADE;
CREATE INDEX IF NOT EXISTS idx_modules_book ON modules(book_id);

ALTER TABLE books ADD COLUMN IF NOT EXISTS course_status TEXT NOT NULL DEFAULT 'none'
  CHECK (course_status IN ('none', 'building', 'built', 'failed'));
ALTER TABLE books ADD COLUMN IF NOT EXISTS course_error TEXT;
ALTER TABLE books ADD COLUMN IF NOT EXISTS num_modules INT NOT NULL DEFAULT 0;
ALTER TABLE books ADD COLUMN IF NOT EXISTS num_questions INT NOT NULL DEFAULT 0;
