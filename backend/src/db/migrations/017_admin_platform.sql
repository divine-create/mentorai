-- AI Academy — Admin platform
--
-- Adds the schema behind the expanded admin section: a draft/publish gate for
-- generated content, per-book licensing, per-subject teaching model override,
-- question groundedness scoring, key/value app settings, an in-app admin
-- allowlist, an admin audit log, and LLM usage logging for cost visibility.
-- All additive and idempotent.

-- Draft/publish gate: learners only see published modules. Existing modules stay
-- visible (default true); newly generated course modules will be inserted as drafts.
ALTER TABLE modules ADD COLUMN IF NOT EXISTS published BOOLEAN NOT NULL DEFAULT TRUE;

-- Per-book licensing / provenance (copyright is the legal soft spot).
ALTER TABLE books ADD COLUMN IF NOT EXISTS license TEXT;
ALTER TABLE books ADD COLUMN IF NOT EXISTS source_url TEXT;

-- Optional per-subject teaching model override (e.g. pin DeepSeek for a subject).
ALTER TABLE subjects ADD COLUMN IF NOT EXISTS teach_model TEXT;

-- Faithfulness: how well a generated question is supported by the source chunks
-- (max cosine of prompt+answer vs the chapter's chunks), 0..1; NULL if unscored.
ALTER TABLE questions ADD COLUMN IF NOT EXISTS groundedness REAL;

-- Global key/value settings (default model, questions-per-chapter, chunk size…).
CREATE TABLE IF NOT EXISTS app_settings (
  key        TEXT PRIMARY KEY,
  value      JSONB NOT NULL,
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- In-app admin allowlist (supplements the ADMIN_EMAILS env var).
CREATE TABLE IF NOT EXISTS admin_users (
  email      TEXT PRIMARY KEY,
  added_by   TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Audit log of admin mutations.
CREATE TABLE IF NOT EXISTS admin_audit_log (
  id          SERIAL PRIMARY KEY,
  actor_email TEXT,
  action      TEXT NOT NULL,
  detail      JSONB,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE INDEX IF NOT EXISTS idx_audit_created ON admin_audit_log(created_at DESC);

-- LLM usage for cost analytics (recorded on non-streaming completions).
CREATE TABLE IF NOT EXISTS llm_usage (
  id            SERIAL PRIMARY KEY,
  provider      TEXT NOT NULL,
  model         TEXT NOT NULL,
  feature       TEXT,
  input_tokens  INT NOT NULL DEFAULT 0,
  output_tokens INT NOT NULL DEFAULT 0,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE INDEX IF NOT EXISTS idx_llm_usage_created ON llm_usage(created_at DESC);
