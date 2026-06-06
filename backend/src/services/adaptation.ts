import { redis } from '../db/redis';

export interface AdaptationState {
  consecutiveWrong: number;   // wrong answers in a row on current concept
  lastResponseMs: number;     // timestamp of last user message
  lastAssistantMs: number;    // timestamp the tutor finished its last reply
  currentConcept: string;     // concept being taught
  workedExampleMode: boolean; // switched to step-by-step after 2 failures
}

// Phrases that signal the learner is confused/lost, regardless of length. These
// are far more reliable than the word-count heuristic for spotting struggle.
const CONFUSION_RE =
  /\b(i (don'?t|do not|still don'?t) (get|understand|follow)|confus|i'?m lost|no idea|not sure what|what do you mean|makes no sense|too (hard|fast|confusing)|can you explain (it )?(again|differently|simpler))\b/i;

const TTL = 60 * 60 * 4; // 4 hours

function key(sessionId: string) {
  return `adapt:${sessionId}`;
}

// Redis backs adaptation memory only; it must never break the tutor. If Redis
// is unavailable, getState returns a fresh default and setState silently skips
// — the session just loses cross-message adaptation, not its ability to reply.
export async function getState(sessionId: string): Promise<AdaptationState> {
  try {
    const raw = await redis.get(key(sessionId));
    if (raw) return JSON.parse(raw);
  } catch (err) {
    console.error('adaptation.getState (Redis) failed, using default:', (err as Error).message);
  }
  return { consecutiveWrong: 0, lastResponseMs: Date.now(), lastAssistantMs: Date.now(), currentConcept: '', workedExampleMode: false };
}

export async function setState(sessionId: string, state: AdaptationState) {
  try {
    await redis.setEx(key(sessionId), TTL, JSON.stringify(state));
  } catch (err) {
    console.error('adaptation.setState (Redis) failed, skipping:', (err as Error).message);
  }
}

export async function recordUserMessage(sessionId: string, message: string): Promise<string> {
  const state = await getState(sessionId);
  const now = Date.now();

  // Think-time = time since the tutor FINISHED its last reply (not since the
  // learner's previous message). Measuring from the assistant turn excludes the
  // time the tutor spent generating + the learner spent reading, so a long gap
  // really does mean "stuck thinking", not "still reading".
  const sinceTutor = now - (state.lastAssistantMs || state.lastResponseMs);

  // Detect signals (most specific first).
  const isConfused = CONFUSION_RE.test(message);
  // A short reply only counts as "vague guessing" when it isn't a question and
  // doesn't look like a concrete answer (no digits / math symbols).
  const looksLikeAnswer = /[\d=+\-*/^<>]/.test(message);
  const isVague = message.trim().split(/\s+/).length < 4 && !/\?/.test(message) && !looksLikeAnswer;
  const isFast = sinceTutor < 5_000;
  const isStuck = sinceTutor > 90_000;

  let adaptationHint = '';

  if (isConfused) {
    adaptationHint = '[ADAPTATION: Learner has signalled they are confused or lost. Stop and re-explain the current point a different way — a simpler analogy or a concrete worked example — and check understanding with one small question before moving on.]';
  } else if (isStuck) {
    adaptationHint = '[ADAPTATION: Learner took a long time to respond — they may be stuck. Offer a gentle hint or rephrase your last question.]';
  } else if (isVague) {
    adaptationHint = '[ADAPTATION: Learner response is vague or very short — they may be guessing. Rephrase your question with more context before continuing.]';
  } else if (isFast && state.consecutiveWrong === 0) {
    adaptationHint = '[ADAPTATION: Learner answered very quickly — concept may already be known. Consider offering to advance or give a challenge exercise.]';
  }

  await setState(sessionId, { ...state, lastResponseMs: now });
  return adaptationHint;
}

// Stamp when the tutor finished a reply, so the next user message's think-time is
// measured from here. Call after a chat/start stream completes.
export async function recordAssistantTurn(sessionId: string): Promise<void> {
  const state = await getState(sessionId);
  await setState(sessionId, { ...state, lastAssistantMs: Date.now() });
}

export async function recordWrongAnswer(sessionId: string): Promise<string> {
  const state = await getState(sessionId);
  const consecutive = state.consecutiveWrong + 1;
  const workedExampleMode = consecutive >= 2;

  await setState(sessionId, { ...state, consecutiveWrong: consecutive, workedExampleMode });

  if (workedExampleMode) {
    return '[ADAPTATION: Learner has failed this concept twice. Switch to worked-example mode: walk through a complete step-by-step solution they can follow.]';
  }
  return '[ADAPTATION: Learner answered incorrectly. Re-explain using a different method — try an analogy or simpler language.]';
}

export async function recordCorrectAnswer(sessionId: string): Promise<string> {
  const state = await getState(sessionId);
  const wasStruggling = state.consecutiveWrong > 0;
  await setState(sessionId, { ...state, consecutiveWrong: 0, workedExampleMode: false });

  if (wasStruggling) {
    return '[ADAPTATION: Learner got it right after struggling — give specific positive reinforcement and confirm the concept is now understood before moving on.]';
  }
  return '';
}

export async function setCurrentConcept(sessionId: string, concept: string) {
  const state = await getState(sessionId);
  if (state.currentConcept !== concept) {
    await setState(sessionId, { ...state, currentConcept: concept, consecutiveWrong: 0, workedExampleMode: false });
  }
}
