import fs from 'fs';
import path from 'path';
import dotenv from 'dotenv';
import { db } from './pool';

dotenv.config({ path: path.join(__dirname, '..', '..', '.env') });

const MIGRATIONS_DIR = path.join(__dirname, 'migrations');

async function migrate() {
  // Create tracking table if it doesn't exist
  await db.query(`
    CREATE TABLE IF NOT EXISTS _migrations (
      filename TEXT PRIMARY KEY,
      applied_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
    )
  `);

  const applied = await db.query<{ filename: string }>('SELECT filename FROM _migrations');
  const appliedSet = new Set(applied.rows.map((r) => r.filename));

  const files = fs.readdirSync(MIGRATIONS_DIR)
    .filter((f) => f.endsWith('.sql'))
    .sort();

  for (const file of files) {
    if (appliedSet.has(file)) continue;

    const sql = fs.readFileSync(path.join(MIGRATIONS_DIR, file), 'utf8');
    console.log(`Applying migration: ${file}`);

    await db.query('BEGIN');
    try {
      await db.query(sql);
      await db.query('INSERT INTO _migrations (filename) VALUES ($1)', [file]);
      await db.query('COMMIT');
      console.log(`  ✓ ${file}`);
    } catch (err) {
      await db.query('ROLLBACK');
      console.error(`  ✗ ${file}:`, err);
      process.exit(1);
    }
  }

  console.log('Migrations complete.');
  await db.end();
}

migrate();
