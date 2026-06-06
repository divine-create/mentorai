-- AI Academy — Explicit user feedback collection
--
-- Adds surfaces for learners to tell us what's working, all consumed by the
-- admin analytics dashboard:
--   1. message_feedback  — 👍/👎 (+ optional comment) on tutor replies, hints,
--      and solutions. Keyed by session/module/index rather than messages.id,
--      because the assistant message id is never sent to the client over SSE.
--   2. module_feedback   — end-of-module ratings (difficulty/clarity/helpfulness).
--      One editable row per (learner, module).
--   3. nps_response      — periodic in-app Net Promoter Score (0..10 + comment).
--   4. Persist the onboarding `experience` level (previously discarded) and a
--      throttle column so the NPS prompt only fires occasionally.
-- All additive and idempotent.

-- ── 1. Per-message feedback on AI output ──────────────────────────────────────
CREATE TABLE IF NOT EXISTS message_feedback (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id       UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  session_id    UUID REFERENCES sessions(id) ON DELETE SET NULL,
  module_id     INT  REFERENCES modules(id) ON DELETE SET NULL,
  kind          TEXT NOT NULL CHECK (kind IN ('chat', 'hint', 'solution')),
  rating        TEXT NOT NULL CHECK (rating IN ('up', 'down')),
  comment       TEXT,
  excerpt       TEXT,             -- snapshot of the AI text, for admin context
  message_index INT,             -- ordinal within the session's chat, when known
  created_at    TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE INDEX IF NOT EXISTS idx_message_feedback_module ON message_feedback(module_id, kind, rating);
CREATE INDEX IF NOT EXISTS idx_message_feedback_recent ON message_feedback(created_at DESC);

-- ── 2. End-of-module ratings ──────────────────────────────────────────────────
-- One row per (learner, module); re-rating updates in place.
CREATE TABLE IF NOT EXISTS module_feedback (
  id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id      UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  module_id    INT  NOT NULL REFERENCES modules(id) ON DELETE CASCADE,
  difficulty   INT  CHECK (difficulty   BETWEEN 1 AND 5),
  clarity      INT  CHECK (clarity      BETWEEN 1 AND 5),
  helpfulness  INT  CHECK (helpfulness  BETWEEN 1 AND 5),
  comment      TEXT,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at   TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE (user_id, module_id)
);
CREATE INDEX IF NOT EXISTS idx_module_feedback_module ON module_feedback(module_id);

CREATE OR REPLACE TRIGGER trg_module_feedback_updated_at
  BEFORE UPDATE ON module_feedback
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();

-- ── 3. Net Promoter Score ─────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS nps_response (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id     UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  score       INT  NOT NULL CHECK (score BETWEEN 0 AND 10),
  comment     TEXT,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE INDEX IF NOT EXISTS idx_nps_response_recent ON nps_response(created_at DESC);

-- ── 4. Profile additions ──────────────────────────────────────────────────────
-- Persist the onboarding experience level (was collected then dropped) and a
-- throttle so the NPS prompt only resurfaces occasionally.
ALTER TABLE users ADD COLUMN IF NOT EXISTS experience TEXT;
ALTER TABLE learner_profiles ADD COLUMN IF NOT EXISTS last_nps_prompt_at TIMESTAMPTZ;
