import dotenv from 'dotenv';
import path from 'path';
import { Pool } from 'pg';

// Load .env from the backend root so any consumer of this module (server,
// migrate script, ad-hoc node REPL) gets the same env. Safe to call
// multiple times — dotenv is a no-op when the file is already loaded.
dotenv.config({ path: path.join(__dirname, '..', '..', '.env') });

export const db = new Pool({
  connectionString: process.env.DATABASE_URL,
  ssl: process.env.NODE_ENV === 'production' ? { rejectUnauthorized: false } : false,
});
