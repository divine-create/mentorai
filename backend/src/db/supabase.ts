import dotenv from 'dotenv';
import path from 'path';
import { createClient } from '@supabase/supabase-js';

// Load .env before reading Supabase credentials — see db/pool.ts for rationale.
dotenv.config({ path: path.join(__dirname, '..', '..', '.env') });

export const supabaseAdmin = createClient(
  process.env.SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!
);
