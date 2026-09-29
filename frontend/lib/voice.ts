import { RealtimeTranscriber } from 'assemblyai';
import RecordRTC from 'recordrtc';

// ─── Client voice helpers ──────────────────────────────────────────────────────
// TTSPlayer: queues sentences and plays them through /api/voice/tts so the tutor
// reads along as text streams in.
// VoiceInputController: listens via RecordRTC and streams PCM audio to AssemblyAI
// for real-time transcription.

type GetToken = () => Promise<string | null>;

// ─── Extract newly-completed sentences from a growing text buffer ──────────────
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
    a.playbackRate = 1.25;
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

// ─── AssemblyAI Real-Time Voice Input ──────────────────────────────────────────
export type VoicePhase = 'off' | 'listening' | 'recording' | 'transcribing';

export class VoiceInputController {
  private transcriber: RealtimeTranscriber | null = null;
  private stream: MediaStream | null = null;
  private recorder: RecordRTC | null = null;
  private silenceTimer: ReturnType<typeof setInterval> | null = null;
  private ctx: AudioContext | null = null;
  private phase: VoicePhase = 'off';
  private transcriptBuffer = '';

  constructor(
    private apiUrl: string,
    private getToken: GetToken,
    private onFinalTranscript: (text: string) => void,
    private onPhase: (p: VoicePhase) => void,
    // Add a way to report partial transcripts to UI if we want to
    private onPartialTranscript?: (text: string) => void
  ) {}

  static supported(): boolean {
    if (typeof window === 'undefined') return false;
    return !!navigator.mediaDevices?.getUserMedia;
  }

  async start(): Promise<void> {
    if (this.phase !== 'off') return;
    this.setPhase('recording');
    this.transcriptBuffer = '';

    try {
      this.stream = await navigator.mediaDevices.getUserMedia({ audio: true });

      // Fetch the temp token from our backend route
      const res = await fetch('/api/assemblyai/token', { method: 'POST' });
      const data = await res.json();
      if (!data.token) {
        throw new Error('No AssemblyAI token provided');
      }

      this.transcriber = new RealtimeTranscriber({
        token: data.token,
        sampleRate: 16000,
      });

      this.transcriber.on('transcript', (message: any) => {
        if (message.message_type === 'PartialTranscript') {
          if (this.onPartialTranscript) {
            this.onPartialTranscript(this.transcriptBuffer + ' ' + message.text);
          }
        } else if (message.message_type === 'FinalTranscript') {
          this.transcriptBuffer += ' ' + message.text;
          if (this.onPartialTranscript) {
            this.onPartialTranscript(this.transcriptBuffer);
          }
        }
      });

      this.transcriber.on('error', (err: any) => {
        console.error('AssemblyAI Error:', err);
        this.stop();
      });

      await this.transcriber.connect();

      this.recorder = new RecordRTC(this.stream, {
        type: 'audio',
        mimeType: 'audio/webm;codecs=pcm', 
        recorderType: RecordRTC.StereoAudioRecorder,
        timeSlice: 250,
        desiredSampRate: 16000,
        numberOfAudioChannels: 1,
        bufferSize: 4096,
        audioBitsPerSecond: 128000,
        ondataavailable: async (blob: Blob) => {
          if (this.transcriber) {
             const buffer = await blob.arrayBuffer();
             const pcmData = new Int16Array(buffer);
             // WebM/PCM wrap needs to be sent as raw Int16Array?
             // Actually StereoAudioRecorder with type: 'audio' returns raw PCM ArrayBuffer? No, it returns a blob.
             // We can just use the AssemblyAI standard approach, but let's send base64 or binary data
             
             // Wait, RecordRTC returns WAV format when using StereoAudioRecorder! 
             // We need to strip the 44-byte WAV header and send just the raw PCM.
             const rawData = buffer.slice(44);
             this.transcriber.sendAudio(rawData);
          }
        },
      });

      this.recorder.startRecording();
      this.startSilenceDetection();

    } catch (err) {
      console.error(err);
      this.stop();
    }
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
      
      // Auto-stop after ~2 seconds of silence, or maximum 15s
      if ((now - started > 1000 && now - lastLoud > 2000) || now - started > 15000) {
        this.finishRecording();
      }
    }, 100);
  }

  private async finishRecording() {
    this.setPhase('transcribing');
    
    if (this.silenceTimer) { clearInterval(this.silenceTimer); this.silenceTimer = null; }
    if (this.recorder) { this.recorder.stopRecording(); }
    
    // Give AssemblyAI a moment to process the last FinalTranscript
    setTimeout(async () => {
      if (this.transcriber) {
        await this.transcriber.close();
        this.transcriber = null;
      }
      
      const final = this.transcriptBuffer.trim();
      if (final) {
        this.onFinalTranscript(final);
      }
      this.stop(); // fully stop and return to 'off'
    }, 1000);
  }

  private setPhase(p: VoicePhase) {
    this.phase = p;
    this.onPhase(p);
  }

  stop() {
    this.setPhase('off');
    if (this.silenceTimer) { clearInterval(this.silenceTimer); this.silenceTimer = null; }
    if (this.ctx) { void this.ctx.close(); this.ctx = null; }
    if (this.recorder) { this.recorder.destroy(); this.recorder = null; }
    if (this.transcriber) { void this.transcriber.close(); this.transcriber = null; }
    if (this.stream) {
      this.stream.getTracks().forEach((t) => t.stop());
      this.stream = null;
    }
  }
}
