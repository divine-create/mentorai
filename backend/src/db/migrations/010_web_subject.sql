-- AI Academy — Web Development (HTML & CSS) subject
--
-- Introduces a third subject and a new practice surface: 'web' drives an
-- in-browser HTML/CSS live-preview playground (the counterpart to Python's
-- Pyodide editor and Math's grapher). practiceUnaided weight is 0 because the
-- playground is exploratory, not auto-graded — the mastery engine redistributes
-- that weight over the present components.

ALTER TABLE subjects DROP CONSTRAINT IF EXISTS subjects_practice_kind_check;
ALTER TABLE subjects ADD CONSTRAINT subjects_practice_kind_check
  CHECK (practice_kind IN ('code', 'problem', 'web', 'none'));

INSERT INTO subjects (slug, name, description, icon, order_index, is_available, practice_kind, mastery_weights)
VALUES (
  'html-css',
  'Web Development: HTML & CSS',
  'Build and style real web pages — from HTML structure to responsive CSS layouts.',
  '🌐',
  3,
  TRUE,
  'web',
  '{"finalAssessment":0.5,"practiceUnaided":0.0,"explanation":0.25,"inSession":0.25,"practiceType":"none"}'
)
ON CONFLICT (slug) DO NOTHING;
