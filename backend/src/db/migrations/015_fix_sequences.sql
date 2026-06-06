-- AI Academy — Resync SERIAL sequences
--
-- The early seed migrations inserted modules/concepts with explicit IDs, which
-- does NOT advance the underlying SERIAL sequences. As a result, the first
-- runtime INSERT (e.g. generating a course from a book) reuses id 1 and collides
-- with seeded rows. Realign each sequence to MAX(id)+1 so runtime inserts work.
-- Idempotent and safe to run repeatedly.

SELECT setval(pg_get_serial_sequence('modules',  'id'), (SELECT COALESCE(MAX(id), 0) + 1 FROM modules),  false);
SELECT setval(pg_get_serial_sequence('concepts', 'id'), (SELECT COALESCE(MAX(id), 0) + 1 FROM concepts), false);
SELECT setval(pg_get_serial_sequence('subjects', 'id'), (SELECT COALESCE(MAX(id), 0) + 1 FROM subjects), false);
SELECT setval(pg_get_serial_sequence('books',    'id'), (SELECT COALESCE(MAX(id), 0) + 1 FROM books),    false);
SELECT setval(pg_get_serial_sequence('book_chunks', 'id'), (SELECT COALESCE(MAX(id), 0) + 1 FROM book_chunks), false);
