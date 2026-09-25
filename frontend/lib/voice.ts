// ─── Client voice helpers ──────────────────────────────────────────────────────
// TTSPlayer: queues sentences and plays them through /api/voice/tts so the tutor
// reads along as text streams in.
// VoiceInputController: listens (browser SpeechRecognition) for the wake word
// "speak", records the following speech, and sends it to /api/voice/stt (Whisper-
// style transcription via Gemini).

type GetToken = () => Promise<string | null>;

// ─── Extract newly-completed sentences from a growing text buffer ──────────────
// Returns sentences finished since `fromIdx`, and the new pointer. On `final`,
// flushes whatever remains even without terminal punctuation.
export function extractNewSentences(
  full: string,
  fromIdx: number,
  final: boolean
): { sentences: string[]; nextIdx: number } {
  const sentences: string[] = [];
  let lastEnd = fromIdx;

  for (let pos = fromIdx; pos < full.length; pos++) {
    const ch = full[pos];
    const isBoundary = (ch === '.' || ch === '!' || ch === '?' || ch === '\n');
    const endOrSpace = pos + 1 >= full.length || /\s/.test(full[pos + 1]);
    if (isBoundary && endOrSpace) {
      const sentence = full.slice(lastEnd, pos + 1).trim();
      if (sentence) sentences.push(sentence);
      lastEnd = pos + 1;
    }
  }

  if (final && lastEnd < full.length) {
    const tail = full.slice(lastEnd).trim();
    if (tail) sentences.push(tail);
    lastEnd = full.length;
  }

  return { sentences, nextIdx: lastEnd };
}

// ─── TTS playback queue ────────────────────────────────────────────────────────
export class TTSPlayer {
  private queue: Promise<string | null>[] = [];
  private playing = false;
  private audio: HTMLAudioElement | null = null;
  private enabled = false;

  constructor(private apiUrl: string, private getToken: GetToken) {}

  setEnabled(on: boolean) {
    this.enabled = on;
    if (!on) this.stop();
  }
  isEnabled() {
    return this.enabled;
  }

  enqueue(sentence: string) {
    if (!this.enabled) return;
    const s = sentence.trim();
    if (!s) return;
    
    // Start fetching audio immediately, don't wait for playback
    const fetchAudio = async () => {
      try {
        const token = await this.getToken();
        const res = await fetch(`${this.apiUrl}/api/voice/tts`, {
          method: 'POST',
          headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${token}` },
          body: JSON.stringify({ text: s }),
        });
        if (!res.ok) return null;
        const blob = await res.blob();
        return URL.createObjectURL(blob);
      } catch {
        return null;
      }
    };
    
    this.queue.push(fetchAudio());
    if (!this.playing) void this.playNext();
  }

  stop() {
    this.queue = [];
    this.playing = false;
    if (this.audio) {
      this.audio.pause();
      this.audio = null;
    }
  }

  private async playNext(): Promise<void> {
    if (!this.enabled || this.queue.length === 0) {
      this.playing = false;
      return;
    }
    this.playing = true;
    
    const urlPromise = this.queue.shift()!;
    const url = await urlPromise;
    
    if (!url || !this.enabled) {
      return void this.playNext();
    }
    
    const a = new Audio(url);
    a.playbackRate = 1.25; // Speed up the voice reading
    this.audio = a;
    const cont = () => {
      URL.revokeObjectURL(url);
      void this.playNext();
    };
    a.onended = cont;
    a.onerror = cont;
    await a.play().catch(cont);
  }
}

// ─── Wake-word voice input ─────────────────────────────────────────────────────
export type VoicePhase = 'off' | 'listening' | 'recording' | 'transcribing';

export class VoiceInputController {
  private rec: any = null;
  private mr: MediaRecorder | null = null;
  private chunks: Blob[] = [];
  private stream: MediaStream | null = null;
  private ctx: AudioContext | null = null;
  private silenceTimer: ReturnType<typeof setInterval> | null = null;
  private maxTimer: ReturnType<typeof setTimeout> | null = null;
  private phase: VoicePhase = 'off';

  constructor(
    private apiUrl: string,
    private getToken: GetToken,
    private onTranscript: (text: string) => void,
    private onPhase: (p: VoicePhase) => void
  ) {}

  static supported(): boolean {
    if (typeof window === 'undefined') return false;
    const w = window as any;
    return !!(w.SpeechRecognition || w.webkitSpeechRecognition) && !!navigator.mediaDevices?.getUserMedia;
  }

  async start(): Promise<void> {
    if (this.phase !== 'off') return;
    this.stream = await navigator.mediaDevices.getUserMedia({ audio: true });
    const w = window as any;
    const SR = w.SpeechRecognition || w.webkitSpeechRecognition;
    this.rec = new SR();
    this.rec.continuous = true;
    this.rec.interimResults = true;
    this.rec.lang = 'en-US';
    this.rec.onresult = (e: any) => this.onResult(e);
    this.rec.onend = () => {
      // Recognition auto-stops periodically; restart only while idly listening.
      if (this.phase === 'listening') {
        try { this.rec.start(); } catch { /* already started */ }
      }
    };
    this.setPhase('listening');
    try { this.rec.start(); } catch { /* noop */ }
  }

  private onResult(e: any) {
    if (this.phase !== 'listening') return;
    const transcript = Array.from(e.results)
      .map((r: any) => r[0].transcript)
      .join(' ')
      .toLowerCase();
    if (/\bspeak\b/.test(transcript)) this.beginRecording();
  }

  private beginRecording() {
    this.setPhase('recording');
    try { this.rec.stop(); } catch { /* noop */ }
    this.chunks = [];
    this.mr = new MediaRecorder(this.stream!);
    this.mr.ondataavailable = (ev) => { if (ev.data.size > 0) this.chunks.push(ev.data); };
    this.mr.onstop = () => void this.finishRecording();
    this.mr.start();
    this.startSilenceDetection();
    this.maxTimer = setTimeout(() => this.stopRecording(), 15000);
  }

  private startSilenceDetection() {
    const w = window as any;
    this.ctx = new (window.AudioContext || w.webkitAudioContext)();
    const src = this.ctx.createMediaStreamSource(this.stream!);
    const analyser = this.ctx.createAnalyser();
    analyser.fftSize = 512;
    src.connect(analyser);
    const data = new Uint8Array(analyser.fftSize);
    const started = Date.now();
    let lastLoud = Date.now();
    this.silenceTimer = setInterval(() => {
      if (this.phase !== 'recording') return;
      analyser.getByteTimeDomainData(data);
      let sum = 0;
      for (let i = 0; i < data.length; i++) {
        const v = (data[i] - 128) / 128;
        sum += v * v;
      }
      const rms = Math.sqrt(sum / data.length);
      const now = Date.now();
      if (rms > 0.04) lastLoud = now;
      // require ≥0.6s captured, then stop after ~1.4s of silence
      if (now - started > 600 && now - lastLoud > 1400) this.stopRecording();
    }, 100);
  }

  private stopRecording() {
    if (this.silenceTimer) { clearInterval(this.silenceTimer); this.silenceTimer = null; }
    if (this.maxTimer) { clearTimeout(this.maxTimer); this.maxTimer = null; }
    if (this.ctx) { void this.ctx.close(); this.ctx = null; }
    if (this.mr && this.mr.state !== 'inactive') this.mr.stop();
  }

  private async finishRecording() {
    this.setPhase('transcribing');
    const blob = new Blob(this.chunks, { type: this.mr?.mimeType || 'audio/webm' });
    try {
      const base64 = await blobToWavBase64(blob);
      const token = await this.getToken();
      const res = await fetch(`${this.apiUrl}/api/voice/stt`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${token}` },
        body: JSON.stringify({ audio: base64, mimeType: 'audio/wav' }),
      });
      if (res.ok) {
        const data = await res.json();
        const text = (data.text || '').trim();
        if (text) this.onTranscript(text);
      }
    } catch {
      /* swallow — resume listening below */
    }
    if (this.phase !== 'off') {
      this.setPhase('listening');
      try { this.rec.start(); } catch { /* noop */ }
    }
  }

  private setPhase(p: VoicePhase) {
    this.phase = p;
    this.onPhase(p);
  }

  stop() {
    this.setPhase('off');
    try { this.rec?.stop(); } catch { /* noop */ }
    this.stopRecording();
    if (this.stream) {
      this.stream.getTracks().forEach((t) => t.stop());
      this.stream = null;
    }
  }
}

// Decode a recorded audio blob and re-encode it as 16-bit mono PCM WAV (base64),
// because Gemini accepts wav reliably while browsers record webm/opus.
async function blobToWavBase64(blob: Blob): Promise<string> {
  const arrayBuf = await blob.arrayBuffer();
  const w = window as any;
  const ctx = new (window.AudioContext || w.webkitAudioContext)();
  const audioBuf = await ctx.decodeAudioData(arrayBuf);
  await ctx.close();

  const channels = audioBuf.numberOfChannels;
  const len = audioBuf.length;
  const mono = new Float32Array(len);
  for (let c = 0; c < channels; c++) {
    const cd = audioBuf.getChannelData(c);
    for (let i = 0; i < len; i++) mono[i] += cd[i] / channels;
  }

  const sampleRate = audioBuf.sampleRate;
  const buffer = new ArrayBuffer(44 + len * 2);
  const view = new DataView(buffer);
  const writeStr = (o: number, s: string) => { for (let i = 0; i < s.length; i++) view.setUint8(o + i, s.charCodeAt(i)); };
  writeStr(0, 'RIFF');
  view.setUint32(4, 36 + len * 2, true);
  writeStr(8, 'WAVE');
  writeStr(12, 'fmt ');
  view.setUint32(16, 16, true);
  view.setUint16(20, 1, true);
  view.setUint16(22, 1, true);
  view.setUint32(24, sampleRate, true);
  view.setUint32(28, sampleRate * 2, true);
  view.setUint16(32, 2, true);
  view.setUint16(34, 16, true);
  writeStr(36, 'data');
  view.setUint32(40, len * 2, true);

  let off = 44;
  for (let i = 0; i < len; i++) {
    const s = Math.max(-1, Math.min(1, mono[i]));
    view.setInt16(off, s < 0 ? s * 0x8000 : s * 0x7fff, true);
    off += 2;
  }

  const bytes = new Uint8Array(buffer);
  let bin = '';
  for (let i = 0; i < bytes.length; i++) bin += String.fromCharCode(bytes[i]);
  return btoa(bin);
}
