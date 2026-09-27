// ─── Unified LLM provider abstraction ─────────────────────────────────────────
// Lets the rest of the app talk to Anthropic Claude, DeepSeek, or Google Gemini
// through one interface. DeepSeek and Gemini both expose OpenAI-compatible APIs,
// so they share a single OpenAI SDK client (different baseURL + key).

import Anthropic from '@anthropic-ai/sdk';
import OpenAI from 'openai';
import { GoogleGenAI } from '@google/genai';
import { db } from '../db';

export type Provider = 'anthropic' | 'deepseek' | 'gemini';

// Best-effort token usage logging for cost analytics. Never throws.
function logUsage(provider: string, model: string, feature: string | undefined, input: number, output: number): void {
  db.query(
    `INSERT INTO llm_usage (provider, model, feature, input_tokens, output_tokens) VALUES ($1, $2, $3, $4, $5)`,
    [provider, model, feature ?? null, input || 0, output || 0]
  ).catch(() => {});
}

export interface ModelDef {
  /** Stable id used by the API + persisted on the learner profile. */
  id: string;
  /** Human-friendly name shown in the UI dropdown. */
  label: string;
  provider: Provider;
  /** The provider-specific model identifier sent on the wire. */
  model: string;
  description: string;
}

export interface ChatMessage {
  role: 'user' | 'assistant';
  content: string;
}

export interface ChatOptions {
  modelId: string;
  system?: string;
  messages: ChatMessage[];
  maxTokens: number;
  /** Optional tag for usage analytics (e.g. 'course-gen', 'assessment', 'project-review'). */
  feature?: string;
}

// ─── Model registry ───────────────────────────────────────────────────────────
// Add/remove entries here to change what the selector offers.
export const MODELS: ModelDef[] = [
  {
    id: 'claude-sonnet',
    label: 'Claude Sonnet 4.5',
    provider: 'anthropic',
    model: 'claude-sonnet-4-5',
    description: 'Anthropic — balanced quality and speed (default).',
  },
  {
    id: 'claude-haiku',
    label: 'Claude Haiku 4.5',
    provider: 'anthropic',
    model: 'claude-haiku-4-5',
    description: 'Anthropic — fastest, most economical.',
  },
  {
    id: 'deepseek-chat',
    label: 'DeepSeek V3',
    provider: 'deepseek',
    model: 'deepseek-chat',
    description: 'DeepSeek — strong general-purpose chat model.',
  },
  {
    id: 'deepseek-reasoner',
    label: 'DeepSeek R1 (Reasoner)',
    provider: 'deepseek',
    model: 'deepseek-reasoner',
    description: 'DeepSeek — reasoning model for harder problems.',
  },
  {
    id: 'gemini-flash',
    label: 'Gemini 2.5 Flash',
    provider: 'gemini',
    model: 'gemini-2.5-flash',
    description: 'Google (Vertex AI) — fast and capable.',
  },
  {
    id: 'gemini-pro',
    label: 'Gemini 2.5 Pro',
    provider: 'gemini',
    model: 'gemini-2.5-pro',
    description: 'Google (Vertex AI) — highest quality Gemini model.',
  },
];

export const DEFAULT_MODEL_ID = 'claude-sonnet';

// ─── Provider availability (based on configured API keys) ─────────────────────
// A key counts as configured only if it's a real value — not blank and not one
// of the placeholder strings shipped in .env.example.
function isRealKey(value: string | undefined): boolean {
  if (!value) return false;
  const v = value.trim();
  if (v === '') return false;
  if (v.startsWith('your-')) return false;
  if (v.toLowerCase().includes('placeholder')) return false;
  return true;
}

function providerConfigured(provider: Provider): boolean {
  switch (provider) {
    case 'anthropic': return isRealKey(process.env.ANTHROPIC_API_KEY);
    case 'deepseek': return isRealKey(process.env.DEEPSEEK_API_KEY);
    // Gemini runs through Vertex AI using Application Default Credentials, so it's
    // "configured" when a GCP project is set (ADC is resolved by the Google libs).
    case 'gemini': return isRealKey(process.env.GOOGLE_CLOUD_PROJECT);
  }
}

/** Registry annotated with whether each model's provider has a key configured. */
export function listModels(): (ModelDef & { available: boolean })[] {
  return MODELS.map((m) => ({ ...m, available: providerConfigured(m.provider) }));
}

export function isValidModelId(id: string): boolean {
  return MODELS.some((m) => m.id === id);
}

/**
 * Resolve a requested model id to a usable model definition. Falls back to the
 * default when the id is unknown or its provider isn't configured, so a missing
 * key never breaks the learning flow.
 */
function resolveModel(modelId: string | null | undefined): ModelDef {
  const requested = MODELS.find((m) => m.id === modelId);
  if (requested && providerConfigured(requested.provider)) return requested;

  const fallback = MODELS.find((m) => m.id === DEFAULT_MODEL_ID);
  if (fallback && providerConfigured(fallback.provider)) return fallback;

  // Last resort: first model whose provider is configured.
  const anyAvailable = MODELS.find((m) => providerConfigured(m.provider));
  if (anyAvailable) return anyAvailable;

  // Nothing configured — return the default anyway; the SDK call will surface
  // a clear auth error rather than us throwing here.
  return fallback ?? MODELS[0];
}

// ─── Lazy client singletons ───────────────────────────────────────────────────
let anthropicClient: Anthropic | null = null;
let deepseekClient: OpenAI | null = null;
let vertexClient: GoogleGenAI | null = null;

function getAnthropic(): Anthropic {
  if (!anthropicClient) anthropicClient = new Anthropic({ apiKey: process.env.ANTHROPIC_API_KEY });
  return anthropicClient;
}

function getDeepSeek(): OpenAI {
  if (!deepseekClient) {
    deepseekClient = new OpenAI({
      apiKey: process.env.DEEPSEEK_API_KEY,
      baseURL: 'https://api.deepseek.com',
    });
  }
  return deepseekClient;
}

// Gemini through Vertex AI. Auth is Application Default Credentials — the Google
// libs read GOOGLE_APPLICATION_CREDENTIALS (the service-account JSON) and refresh
// OAuth tokens automatically, so there's no API key to manage.
export function getVertex(): GoogleGenAI {
  if (!vertexClient) {
    vertexClient = new GoogleGenAI({
      vertexai: true,
      project: process.env.GOOGLE_CLOUD_PROJECT,
      location: process.env.GOOGLE_CLOUD_LOCATION || 'us-central1',
    });
  }
  return vertexClient;
}

// Vertex/Gemini uses roles 'user' | 'model' and a separate systemInstruction.
// Reuse normalizeMessages so the first turn is always a user turn.
function toGeminiContents(messages: ChatMessage[]) {
  return normalizeMessages(messages).map((m) => ({
    role: m.role === 'assistant' ? 'model' : 'user',
    parts: [{ text: m.content }],
  }));
}

// Build the Gemini generation config. We cap output with maxOutputTokens, so on
// 2.5 Flash we disable "thinking" (thinkingBudget: 0) — otherwise thought tokens
// eat the budget and truncate the visible answer. Pro keeps its thinking (it
// can't be set to 0, and quality benefits).
function geminiConfig(opts: ChatOptions, wireModel: string) {
  const config: Record<string, unknown> = { maxOutputTokens: opts.maxTokens };
  if (opts.system) config.systemInstruction = opts.system;
  if (wireModel.includes('flash')) config.thinkingConfig = { thinkingBudget: 0 };
  return config;
}

// A conversation must start with a user turn (Anthropic requires it). When the
// tutor opens the lesson, history can begin with the assistant greeting — drop
// any leading assistant turns so every provider gets a valid sequence.
function normalizeMessages(messages: ChatMessage[]): ChatMessage[] {
  let start = 0;
  while (start < messages.length && messages[start].role === 'assistant') start++;
  return messages.slice(start);
}

// OpenAI-compatible message list: fold the system prompt into a leading message.
function toOpenAIMessages(opts: ChatOptions): OpenAI.Chat.ChatCompletionMessageParam[] {
  const msgs: OpenAI.Chat.ChatCompletionMessageParam[] = [];
  if (opts.system) msgs.push({ role: 'system', content: opts.system });
  for (const m of normalizeMessages(opts.messages)) msgs.push({ role: m.role, content: m.content });
  return msgs;
}

// ─── Non-streaming completion ─────────────────────────────────────────────────
export async function createChat(opts: ChatOptions): Promise<string> {
  const def = resolveModel(opts.modelId);

  if (def.provider === 'anthropic') {
    const res = await getAnthropic().messages.create({
      model: def.model,
      max_tokens: opts.maxTokens,
      ...(opts.system ? { system: opts.system } : {}),
      messages: opts.messages.map((m) => ({ role: m.role, content: m.content })),
    });
    logUsage(def.provider, def.model, opts.feature, res.usage?.input_tokens ?? 0, res.usage?.output_tokens ?? 0);
    return res.content[0]?.type === 'text' ? res.content[0].text : '';
  }

  if (def.provider === 'gemini') {
    const res = await getVertex().models.generateContent({
      model: def.model,
      contents: toGeminiContents(opts.messages),
      config: geminiConfig(opts, def.model),
    });
    const u = res.usageMetadata;
    logUsage(def.provider, def.model, opts.feature, u?.promptTokenCount ?? 0, u?.candidatesTokenCount ?? 0);
    return res.text ?? '';
  }

  // DeepSeek (OpenAI-compatible)
  const res = await getDeepSeek().chat.completions.create({
    model: def.model,
    max_tokens: opts.maxTokens,
    messages: toOpenAIMessages(opts),
  });
  logUsage(def.provider, def.model, opts.feature, res.usage?.prompt_tokens ?? 0, res.usage?.completion_tokens ?? 0);
  return res.choices[0]?.message?.content ?? '';
}

// ─── Streaming completion (yields text deltas) ────────────────────────────────
export async function* streamChat(opts: ChatOptions): AsyncGenerator<string> {
  const def = resolveModel(opts.modelId);

  if (def.provider === 'anthropic') {
    const stream = getAnthropic().messages.stream({
      model: def.model,
      max_tokens: opts.maxTokens,
      ...(opts.system ? { system: opts.system } : {}),
      messages: opts.messages.map((m) => ({ role: m.role, content: m.content })),
    });
    for await (const event of stream) {
      if (event.type === 'content_block_delta' && event.delta.type === 'text_delta') {
        yield event.delta.text;
      }
    }
    return;
  }

  if (def.provider === 'gemini') {
    const stream = await getVertex().models.generateContentStream({
      model: def.model,
      contents: toGeminiContents(opts.messages),
      config: geminiConfig(opts, def.model),
    });
    for await (const chunk of stream) {
      if (chunk.text) yield chunk.text;
    }
    return;
  }

  // DeepSeek (OpenAI-compatible)
  const stream = await getDeepSeek().chat.completions.create({
    model: def.model,
    max_tokens: opts.maxTokens,
    messages: toOpenAIMessages(opts),
    stream: true,
  });
  for await (const chunk of stream) {
    const token = chunk.choices[0]?.delta?.content;
    if (token) yield token;
  }
}
