-- In-chat (inline) quiz attempts.
--
-- The conversational tutor emits [[QUIZ]] checks that are generated on the fly
-- and have no row in `questions`, so they can't be recorded in `quiz_attempts`
-- (which requires a question_id). This table captures those formative in-session
-- answers so they can feed the `inSession` component of module mastery — letting
-- the live tutoring experience count toward completion, while the formal Final
-- Assessment (quiz_attempts) remains the dominant gate.
CREATE TABLE IF NOT EXISTS inline_quiz_attempts (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id     UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  session_id  UUID REFERENCES sessions(id) ON DELETE SET NULL,
  module_id   INT  NOT NULL REFERENCES modules(id) ON DELETE CASCADE,
  is_correct  BOOLEAN NOT NULL,
  chosen      TEXT,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_inline_quiz_user_module
  ON inline_quiz_attempts(user_id, module_id);
