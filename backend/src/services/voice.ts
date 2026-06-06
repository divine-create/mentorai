// ─── Voice service (Gemini via Vertex AI) ─────────────────────────────────────
// Text-to-speech and speech-to-text through the same Vertex AI client as chat
// (Application Default Credentials — no API key). TTS returns raw PCM which we
// wrap in a WAV header so the browser can play it directly.

import { getVertex } from './llm';

const TTS_MODEL = 'gemini-2.5-flash-preview-tts';
const STT_MODEL = 'gemini-2.5-flash';
const DEFAULT_VOICE = 'Kore';

function isRealValue(value: string | undefined): boolean {
  if (!value) return false;
  const v = value.trim();
  return v !== '' && !v.startsWith('your-') && !v.toLowerCase().includes('placeholder');
}

// Voice runs on Vertex, so it's available whenever a GCP project is configured
// (ADC is resolved by the Google libs) — same gate as the gemini chat provider.
export function voiceConfigured(): boolean {
  return isRealValue(process.env.GOOGLE_CLOUD_PROJECT);
}

// Prepend a 44-byte WAV header to raw little-endian PCM samples.
function pcmToWav(pcm: Buffer, sampleRate: number, channels = 1, bitsPerSample = 16): Buffer {
  const byteRate = (sampleRate * channels * bitsPerSample) / 8;
  const blockAlign = (channels * bitsPerSample) / 8;
  const header = Buffer.alloc(44);
  header.write('RIFF', 0);
  header.writeUInt32LE(36 + pcm.length, 4);
  header.write('WAVE', 8);
  header.write('fmt ', 12);
  header.writeUInt32LE(16, 16);
  header.writeUInt16LE(1, 20); // PCM
  header.writeUInt16LE(channels, 22);
  header.writeUInt32LE(sampleRate, 24);
  header.writeUInt32LE(byteRate, 28);
  header.writeUInt16LE(blockAlign, 32);
  header.writeUInt16LE(bitsPerSample, 34);
  header.write('data', 36);
  header.writeUInt32LE(pcm.length, 40);
  return Buffer.concat([header, pcm]);
}

/** Synthesize speech for `text`. Returns WAV audio bytes. */
export async function synthesizeSpeech(text: string, voice = DEFAULT_VOICE): Promise<Buffer> {
  const res = await getVertex().models.generateContent({
    model: TTS_MODEL,
    contents: [{ role: 'user', parts: [{ text }] }],
    config: {
      responseModalities: ['AUDIO'],
      speechConfig: { voiceConfig: { prebuiltVoiceConfig: { voiceName: voice } } },
    },
  });

  const part = res.candidates?.[0]?.content?.parts?.[0];
  const b64 = part?.inlineData?.data;
  if (!b64) throw new Error('Gemini TTS returned no audio');

  const mime = part?.inlineData?.mimeType ?? '';
  const rate = parseInt(mime.match(/rate=(\d+)/)?.[1] ?? '24000', 10);
  return pcmToWav(Buffer.from(b64, 'base64'), rate);
}

/** Transcribe base64-encoded audio. Returns the transcript text. */
export async function transcribeAudio(audioBase64: string, mimeType: string): Promise<string> {
  const res = await getVertex().models.generateContent({
    model: STT_MODEL,
    contents: [{
      role: 'user',
      parts: [
        { text: 'Transcribe the following audio verbatim. Output only the transcript text, with no quotes, labels, or commentary. If there is no speech, output nothing.' },
        { inlineData: { mimeType, data: audioBase64 } },
      ],
    }],
  });

  return (res.text ?? '').trim();
}
