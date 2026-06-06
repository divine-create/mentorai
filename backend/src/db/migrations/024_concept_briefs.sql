-- AI Academy — Per-concept teaching briefs
--
-- Each concept gets a compact, reviewed "teaching brief" that the live tutor
-- grounds in (key points it must convey, one canonical example, a misconception
-- to preempt, and a suggested hands-on exercise). The co-generation script
-- (scripts/cogenConcepts.ts) produces these alongside the concept's assessment
-- questions from a single spec, so what's taught and what's assessed can't drift.
-- One editable row per concept. Additive and idempotent.

CREATE TABLE IF NOT EXISTS concept_briefs (
  id             UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  concept_id     INT  NOT NULL UNIQUE REFERENCES concepts(id) ON DELETE CASCADE,
  key_points     JSONB NOT NULL DEFAULT '[]'::jsonb,  -- array of 3–6 must-convey points
  worked_example TEXT,                                 -- one canonical example to use
  misconception  TEXT,                                 -- a common misunderstanding to preempt
  exercise       TEXT,                                 -- suggested hands-on exercise prompt
  model          TEXT,                                 -- model id that generated this brief
  created_at     TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at     TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE OR REPLACE TRIGGER trg_concept_briefs_updated_at
  BEFORE UPDATE ON concept_briefs
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();
