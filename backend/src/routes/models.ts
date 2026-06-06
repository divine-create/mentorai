import { Router } from 'express';
import { requireAuth } from '../middleware/auth';
import { listModels, isValidModelId, DEFAULT_MODEL_ID } from '../services/llm';
import { getSettings } from '../services/settings';

const router = Router();

/**
 * Read the admin-configured default model (app_settings.defaultModel), falling
 * back to the hard-coded DEFAULT_MODEL_ID. Per-user model selection has been
 * removed — the AI model is now chosen by the admin via the Settings panel.
 */
export async function getUserModelId(_userId: string): Promise<string> {
  try {
    const { defaultModel } = await getSettings();
    return isValidModelId(defaultModel) ? defaultModel : DEFAULT_MODEL_ID;
  } catch {
    return DEFAULT_MODEL_ID;
  }
}

// ─── GET /api/models ──────────────────────────────────────────────────────────
// Lists available models (for reference / admin use).
router.get('/', requireAuth, async (_req, res) => {
  try {
    res.json({ models: listModels() });
  } catch (err) {
    console.error('models/list error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

export default router;
