-- AI Academy — Fix: de-duplicate Mathematics questions
--
-- The Mathematics seed (007) has no idempotency guard on its question INSERTs,
-- so applying it twice inserted every question a second time (160 rows for the
-- intended 80). This collapses each (module, concept, type, prompt) group back
-- to a single row, keeping the earliest copy. Scoped to subject_id = 2; the
-- Python seed is unaffected. Idempotent: re-running is a no-op once deduped.

BEGIN;

DELETE FROM questions q
USING (
  SELECT id,
         ROW_NUMBER() OVER (
           PARTITION BY module_id, concept_id, type, prompt
           ORDER BY created_at, id
         ) AS rn
  FROM questions
  WHERE module_id IN (SELECT id FROM modules WHERE subject_id = 2)
) d
WHERE q.id = d.id AND d.rn > 1;

COMMIT;
