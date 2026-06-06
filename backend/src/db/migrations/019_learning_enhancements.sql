-- AI Academy — Learning-experience enhancements
--
-- Adds the schema behind a set of pedagogy upgrades:
--   1. Per-concept mastery + spaced-repetition scheduling (concept_progress).
--   2. First-attempt tracking on formal questions (quiz_attempts.first_try) so
--      mastery can reward unaided first-try correctness, not just eventual-correct.
--   3. A rolling in-session summary (sessions.running_summary) so long chats stay
--      within the model's context window without losing continuity.
--   4. Re-engagement plumbing: last_weekly_email_at on the profile + a
--      notification_log of generated/sent messages.
-- All additive and idempotent.

-- ── 1. Per-concept mastery + spaced repetition ────────────────────────────────
-- One row per (learner, concept). `mastery` is a rolling 0..100 score; the rest
-- is SM-2 scheduling state used by the Review surface. Concepts become "due"
-- after a learner first demonstrates mastery in an assessment; reviewing them
-- pushes due_at out (or pulls it in on a lapse).
CREATE TABLE IF NOT EXISTS concept_progress (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id          UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  concept_id       INT  NOT NULL REFERENCES concepts(id) ON DELETE CASCADE,
  module_id        INT  REFERENCES modules(id) ON DELETE CASCADE,
  mastery          NUMERIC(5,2) NOT NULL DEFAULT 0,  -- rolling 0..100
  attempts         INT  NOT NULL DEFAULT 0,
  correct          INT  NOT NULL DEFAULT 0,
  -- SM-2 scheduling
  ease             REAL NOT NULL DEFAULT 2.5,
  interval_days    REAL NOT NULL DEFAULT 0,
  reps             INT  NOT NULL DEFAULT 0,
  lapses           INT  NOT NULL DEFAULT 0,
  due_at           TIMESTAMPTZ,
  last_reviewed_at TIMESTAMPTZ,
  created_at       TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at       TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE (user_id, concept_id)
);
CREATE INDEX IF NOT EXISTS idx_concept_progress_due  ON concept_progress(user_id, due_at);
CREATE INDEX IF NOT EXISTS idx_concept_progress_user ON concept_progress(user_id);

CREATE OR REPLACE TRIGGER trg_concept_progress_updated_at
  BEFORE UPDATE ON concept_progress
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();

-- ── 2. First-attempt tracking on formal questions ─────────────────────────────
-- TRUE when this was the learner's first-ever attempt at the question; NULL for
-- pre-existing rows (treated as unknown, not first-try, by the scorer).
ALTER TABLE quiz_attempts ADD COLUMN IF NOT EXISTS first_try BOOLEAN;

-- ── 3. Rolling in-session summary ─────────────────────────────────────────────
-- Older turns of a long session are folded into this summary so the tutor keeps
-- continuity while only the most recent messages are sent verbatim.
ALTER TABLE sessions ADD COLUMN IF NOT EXISTS running_summary TEXT;

-- ── 4. Re-engagement plumbing ─────────────────────────────────────────────────
ALTER TABLE learner_profiles ADD COLUMN IF NOT EXISTS last_weekly_email_at TIMESTAMPTZ;

CREATE TABLE IF NOT EXISTS notification_log (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id     UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  kind        TEXT NOT NULL,                       -- 'weekly_email' | 'streak_risk' | 'review_due'
  channel     TEXT NOT NULL DEFAULT 'email',
  subject     TEXT,
  body        TEXT,
  status      TEXT NOT NULL DEFAULT 'generated'    -- 'generated' | 'sent' | 'skipped' | 'failed'
    CHECK (status IN ('generated', 'sent', 'skipped', 'failed')),
  error       TEXT,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE INDEX IF NOT EXISTS idx_notification_log_user ON notification_log(user_id, created_at DESC);
