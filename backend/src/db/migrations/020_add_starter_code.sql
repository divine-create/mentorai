-- AI Academy — Add starter_code column for coding questions
--
-- The coding environment can pre-populate the editor with starter code
-- when a learner opens an assessment coding question from the assessment
-- page, just like the tutor's [[EXERCISE]] directive hands off starter code.

ALTER TABLE questions ADD COLUMN IF NOT EXISTS starter_code TEXT;
