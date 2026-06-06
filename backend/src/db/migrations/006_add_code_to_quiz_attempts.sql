-- Add code column to quiz_attempts for storing actual code submissions
ALTER TABLE quiz_attempts ADD COLUMN IF NOT EXISTS code TEXT;