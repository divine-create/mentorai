-- MentorAI v1.1 — Multi-subject support
--
-- Introduces a first-class `subjects` entity, scopes modules to a subject,
-- makes the learner's active subject explicit, and adds the `math_problem`
-- question type. Existing Python content is backfilled as the first subject.

-- ─── Subjects ────────────────────────────────────────────────────────────────
-- mastery_weights drives the mastery engine per subject. `practiceType` names
-- the question type that counts toward the "unaided practice" component
-- (`coding` for Python, `math_problem` for Mathematics). practice_kind drives
-- the frontend practice surface ('code' = Pyodide editor, 'problem' = math
-- workspace, 'none' = chat + assessments only).
CREATE TABLE IF NOT EXISTS subjects (
  id              SERIAL PRIMARY KEY,
  slug            TEXT NOT NULL UNIQUE,
  name            TEXT NOT NULL,
  description     TEXT,
  icon            TEXT,
  order_index     INT NOT NULL DEFAULT 0,
  is_available    BOOLEAN NOT NULL DEFAULT TRUE,
  practice_kind   TEXT NOT NULL DEFAULT 'none'
    CHECK (practice_kind IN ('code', 'problem', 'none')),
  mastery_weights JSONB NOT NULL DEFAULT
    '{"finalAssessment":0.4,"practiceUnaided":0.3,"explanation":0.2,"inSession":0.1,"practiceType":"coding"}'
);

-- Seed the Python subject for all existing content.
INSERT INTO subjects (slug, name, description, icon, order_index, is_available, practice_kind, mastery_weights)
VALUES (
  'python', 'Python Development',
  'Learn Python from fundamentals to building real projects.',
  '🐍', 1, TRUE, 'code',
  '{"finalAssessment":0.4,"practiceUnaided":0.3,"explanation":0.2,"inSession":0.1,"practiceType":"coding"}'
)
ON CONFLICT (slug) DO NOTHING;

-- ─── Modules → subject ───────────────────────────────────────────────────────
ALTER TABLE modules ADD COLUMN IF NOT EXISTS subject_id INT REFERENCES subjects(id);

UPDATE modules
SET subject_id = (SELECT id FROM subjects WHERE slug = 'python')
WHERE subject_id IS NULL;

CREATE INDEX IF NOT EXISTS idx_modules_subject ON modules(subject_id);

-- ─── Learner active subject ──────────────────────────────────────────────────
ALTER TABLE learner_profiles
  ADD COLUMN IF NOT EXISTS active_subject_id INT REFERENCES subjects(id);

UPDATE learner_profiles
SET active_subject_id = (SELECT id FROM subjects WHERE slug = 'python')
WHERE active_subject_id IS NULL;

-- ─── Question type: add 'math_problem' ───────────────────────────────────────
ALTER TABLE questions DROP CONSTRAINT IF EXISTS questions_type_check;
ALTER TABLE questions ADD CONSTRAINT questions_type_check
  CHECK (type IN ('multiple_choice', 'short_answer', 'coding', 'math_problem', 'explanation'));
