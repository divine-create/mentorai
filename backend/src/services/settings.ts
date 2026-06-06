// ─── Global app settings (key/value) ──────────────────────────────────────────
// Small typed accessor over the app_settings table with sane defaults, so admin
// can tune generation/ingestion/model behavior without code changes.

import { db } from '../db/pool';

export interface AppSettings {
  defaultModel: string;        // fallback model id when a user has none
  questionsPerChapter: number; // course generation
  chunkTargetChars: number;    // ingestion chunk size
}

export const SETTINGS_DEFAULTS: AppSettings = {
  defaultModel: 'gemini-flash', // Gemini via Vertex AI (ADC); DeepSeek is the fallback
  questionsPerChapter: 5,
  chunkTargetChars: 1500,
};

export async function getSettings(): Promise<AppSettings> {
  try {
    const { rows } = await db.query<{ key: string; value: unknown }>(`SELECT key, value FROM app_settings`);
    const map: Record<string, unknown> = {};
    for (const r of rows) map[r.key] = r.value;
    return {
      defaultModel: typeof map.defaultModel === 'string' ? map.defaultModel : SETTINGS_DEFAULTS.defaultModel,
      questionsPerChapter: Number(map.questionsPerChapter) || SETTINGS_DEFAULTS.questionsPerChapter,
      chunkTargetChars: Number(map.chunkTargetChars) || SETTINGS_DEFAULTS.chunkTargetChars,
    };
  } catch {
    return { ...SETTINGS_DEFAULTS };
  }
}

export async function setSetting(key: keyof AppSettings, value: unknown): Promise<void> {
  await db.query(
    `INSERT INTO app_settings (key, value, updated_at) VALUES ($1, $2, NOW())
     ON CONFLICT (key) DO UPDATE SET value = $2, updated_at = NOW()`,
    [key, JSON.stringify(value)]
  );
}
