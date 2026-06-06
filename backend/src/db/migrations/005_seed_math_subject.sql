-- MentorAI v1.1 — Mathematics subject (no modules yet)
--
-- Adds a second subject so the multi-subject UI (subject picker) has at least
-- one alternative to show. `is_available = true` so the frontend will render
-- it; the dashboard gracefully handles zero modules for a subject. No modules
-- or questions are seeded here — Mathematics content lands in a follow-up.

INSERT INTO subjects (slug, name, description, icon, order_index, is_available, practice_kind, mastery_weights)
VALUES (
  'mathematics',
  'Mathematics',
  'Build intuition for the math behind code — from arithmetic to linear algebra.',
  '➗',
  2,
  TRUE,
  'problem',
  '{"finalAssessment":0.4,"practiceUnaided":0.3,"explanation":0.2,"inSession":0.1,"practiceType":"math_problem"}'
)
ON CONFLICT (slug) DO NOTHING;
