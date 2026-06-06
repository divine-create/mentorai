-- Store each learner's selected AI model. NULL means "use the app default"
-- (resolved at runtime by the llm service), so no hard-coded default here.
ALTER TABLE learner_profiles ADD COLUMN IF NOT EXISTS preferred_model TEXT;
