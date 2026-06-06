-- AI Academy — Restrict to a single Python course
--
-- The platform currently exposes six subjects (Python Development,
-- Mathematics, Web Development, Pratical Python, Python Crash Course,
-- Python full course). For now we want learners to see only the
-- "Python full course" (slug `python-native`) — the others stay in the
-- database so admins can re-enable them, but they no longer show up
-- on the dashboard, the subject picker, or any user-facing route.
--
-- Concrete effects:
--   1. Mark every other subject `is_available = false`.
--   2. Re-point every existing learner's `active_subject_id` at
--      `python-native` so they land on a valid course after the change.
--   3. Make sure the python-native subject's first module is unlocked for
--      any learner whose resume position was tied to a hidden subject.
--
-- Idempotent — safe to re-run.

BEGIN;

-- 1. Hide every subject except python-native.
UPDATE subjects
SET is_available = false
WHERE slug <> 'python-native'
  AND is_available = true;

-- 2. Re-point existing learners to python-native. Order_index keeps the
--    intended slot in case we later unhide other courses; the
--    python-native row's id is referenced via the slug so we don't have
--    to hard-code it.
UPDATE learner_profiles lp
SET active_subject_id = (SELECT id FROM subjects WHERE slug = 'python-native')
WHERE lp.active_subject_id IS NULL
   OR lp.active_subject_id IN (SELECT id FROM subjects WHERE slug <> 'python-native');

-- 3. Unlock python-native's first module for every learner, and point
--    `current_module_id` at their most-advanced unlocked module inside it
--    (or the first module if they have none). Idempotent ON CONFLICT.
INSERT INTO module_mastery (user_id, module_id, unlocked)
SELECT lp.user_id, m.id, true
FROM learner_profiles lp
CROSS JOIN LATERAL (
  SELECT id FROM modules
  WHERE subject_id = (SELECT id FROM subjects WHERE slug = 'python-native')
  ORDER BY order_index ASC LIMIT 1
) m
ON CONFLICT (user_id, module_id) DO UPDATE SET unlocked = true;

-- 4. Bump current_module_id to a real python-native module so the
--    dashboard's "Continue" button has somewhere to go. Picks the most
--    advanced unlocked module in the python-native subject, falling back
--    to its first module.
UPDATE learner_profiles lp
SET current_module_id = COALESCE(
  (SELECT m.id FROM modules m
     JOIN module_mastery mm ON mm.module_id = m.id AND mm.user_id = lp.user_id
    WHERE m.subject_id = (SELECT id FROM subjects WHERE slug = 'python-native')
      AND mm.unlocked = true
    ORDER BY m.order_index DESC LIMIT 1),
  (SELECT id FROM modules
    WHERE subject_id = (SELECT id FROM subjects WHERE slug = 'python-native')
    ORDER BY order_index ASC LIMIT 1)
)
WHERE lp.current_module_id IS NULL
   OR lp.current_module_id NOT IN (
     SELECT id FROM modules
     WHERE subject_id = (SELECT id FROM subjects WHERE slug = 'python-native')
   );

COMMIT;
