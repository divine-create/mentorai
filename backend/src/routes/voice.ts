import { Router } from 'express';
import { requireAuth, AuthRequest } from '../middleware/auth';
import { requireFields, requireString, sendValidationErrors } from '../middleware/validate';
import { voiceConfigured, synthesizeSpeech, transcribeAudio } from '../services/voice';

const router = Router();

const MAX_TTS_CHARS = 1200;       // ~one or two sentences per request
const MAX_AUDIO_B64 = 12_000_000; // ~9 MB of audio, base64-encoded

// GET /api/voice/status — lets the client decide whether to show voice UI.
router.get('/status', requireAuth, (_req: AuthRequest, res) => {
  res.json({ available: voiceConfigured() });
});

// POST /api/voice/tts — { text, voice? } → WAV audio bytes.
router.post('/tts', requireAuth, async (req: AuthRequest, res) => {
  const { text, voice } = req.body as { text: string; voice?: string };

  const missing = requireFields(req.body, ['text']);
  if (missing) { res.status(400).json({ error: missing }); return; }
  if (sendValidationErrors(res, [requireString(text, 'text')])) return;
  if (!voiceConfigured()) { res.status(503).json({ error: 'voice_not_configured' }); return; }

  try {
    const audio = await synthesizeSpeech(text.slice(0, MAX_TTS_CHARS), voice);
    res.setHeader('Content-Type', 'audio/wav');
    res.setHeader('Cache-Control', 'no-store');
    res.send(audio);
  } catch (err) {
    console.error('voice/tts error:', err);
    res.status(502).json({ error: 'tts_failed' });
  }
});

// POST /api/voice/stt — { audio: base64, mimeType } → { text }.
router.post('/stt', requireAuth, async (req: AuthRequest, res) => {
  const { audio, mimeType } = req.body as { audio: string; mimeType: string };

  const missing = requireFields(req.body, ['audio', 'mimeType']);
  if (missing) { res.status(400).json({ error: missing }); return; }
  if (sendValidationErrors(res, [requireString(audio, 'audio'), requireString(mimeType, 'mimeType')])) return;
  if (audio.length > MAX_AUDIO_B64) { res.status(413).json({ error: 'audio_too_large' }); return; }
  if (!voiceConfigured()) { res.status(503).json({ error: 'voice_not_configured' }); return; }

  try {
    const text = await transcribeAudio(audio, mimeType);
    res.json({ text });
  } catch (err) {
    console.error('voice/stt error:', err);
    res.status(502).json({ error: 'stt_failed' });
  }
});

export default router;
