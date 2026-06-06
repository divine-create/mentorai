-- MentorAI v1.0 — Initial schema
-- Entities: users, learner_profiles, modules, concepts, module_mastery,
--           sessions, messages, questions, quiz_attempts

-- ─── Users ───────────────────────────────────────────────────────────────────
-- Mirrors Supabase auth.users; extended with app-level fields.
CREATE TABLE IF NOT EXISTS users (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email           TEXT NOT NULL UNIQUE,
  name            TEXT,
  subscription_status TEXT NOT NULL DEFAULT 'free'
    CHECK (subscription_status IN ('free', 'pro', 'annual', 'cancelled')),
  stripe_customer_id TEXT,
  goal            TEXT,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ─── Modules ─────────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS modules (
  id              SERIAL PRIMARY KEY,
  slug            TEXT NOT NULL UNIQUE,
  title           TEXT NOT NULL,
  description     TEXT,
  order_index     INT NOT NULL,
  estimated_hours_min INT,
  estimated_hours_max INT
);

-- ─── Concepts ────────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS concepts (
  id              SERIAL PRIMARY KEY,
  module_id       INT NOT NULL REFERENCES modules(id) ON DELETE CASCADE,
  title           TEXT NOT NULL,
  description     TEXT,
  order_index     INT NOT NULL
);

-- ─── Learner profiles ────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS learner_profiles (
  id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id             UUID NOT NULL UNIQUE REFERENCES users(id) ON DELETE CASCADE,
  current_module_id   INT REFERENCES modules(id),
  overall_mastery     NUMERIC(5,2) NOT NULL DEFAULT 0,
  weak_concept_ids    INT[] NOT NULL DEFAULT '{}',
  strong_concept_ids  INT[] NOT NULL DEFAULT '{}',
  streak_days         INT NOT NULL DEFAULT 0,
  last_session_at     TIMESTAMPTZ,
  created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at          TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ─── Module mastery ──────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS module_mastery (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id         UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  module_id       INT NOT NULL REFERENCES modules(id) ON DELETE CASCADE,
  mastery_score   NUMERIC(5,2) NOT NULL DEFAULT 0,
  attempts        INT NOT NULL DEFAULT 0,
  last_assessed_at TIMESTAMPTZ,
  unlocked        BOOLEAN NOT NULL DEFAULT FALSE,
  UNIQUE (user_id, module_id)
);

-- ─── Sessions ────────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS sessions (
  id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id           UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  module_id         INT REFERENCES modules(id),
  started_at        TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  ended_at          TIMESTAMPTZ,
  concepts_covered  INT[] NOT NULL DEFAULT '{}',
  summary_text      TEXT,
  duration_seconds  INT GENERATED ALWAYS AS (
    EXTRACT(EPOCH FROM (ended_at - started_at))::INT
  ) STORED
);

-- ─── Messages ────────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS messages (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  session_id  UUID NOT NULL REFERENCES sessions(id) ON DELETE CASCADE,
  role        TEXT NOT NULL CHECK (role IN ('user', 'assistant')),
  content     TEXT NOT NULL,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ─── Questions ───────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS questions (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  module_id       INT NOT NULL REFERENCES modules(id) ON DELETE CASCADE,
  concept_id      INT REFERENCES concepts(id),
  type            TEXT NOT NULL CHECK (type IN ('multiple_choice', 'short_answer', 'coding', 'explanation')),
  difficulty      TEXT NOT NULL CHECK (difficulty IN ('foundational', 'applied', 'advanced')),
  prompt          TEXT NOT NULL,
  options         JSONB,          -- for multiple_choice: [{label, text, correct}]
  correct_answer  TEXT,
  test_cases      JSONB,          -- for coding: [{input, expected_output}]
  created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ─── Quiz attempts ───────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS quiz_attempts (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id         UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  question_id     UUID NOT NULL REFERENCES questions(id) ON DELETE CASCADE,
  session_id      UUID REFERENCES sessions(id),
  answer          TEXT,
  is_correct      BOOLEAN,
  hint_used       BOOLEAN NOT NULL DEFAULT FALSE,
  solution_revealed BOOLEAN NOT NULL DEFAULT FALSE,
  time_taken_ms   INT,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ─── Indexes ─────────────────────────────────────────────────────────────────
CREATE INDEX IF NOT EXISTS idx_messages_session     ON messages(session_id);
CREATE INDEX IF NOT EXISTS idx_sessions_user        ON sessions(user_id);
CREATE INDEX IF NOT EXISTS idx_module_mastery_user  ON module_mastery(user_id);
CREATE INDEX IF NOT EXISTS idx_quiz_attempts_user   ON quiz_attempts(user_id);
CREATE INDEX IF NOT EXISTS idx_concepts_module      ON concepts(module_id);

-- ─── updated_at trigger ──────────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION set_updated_at()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN NEW.updated_at = NOW(); RETURN NEW; END;
$$;

CREATE OR REPLACE TRIGGER trg_users_updated_at
  BEFORE UPDATE ON users
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();

CREATE OR REPLACE TRIGGER trg_learner_profiles_updated_at
  BEFORE UPDATE ON learner_profiles
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();
