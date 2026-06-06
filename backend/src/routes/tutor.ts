import { Router } from 'express';
import { db } from '../db/pool';
import { requireAuth, AuthRequest } from '../middleware/auth';
import { requireFields, requireString, requireNumber, requireBoolean, requireOneOf, sendValidationErrors } from '../middleware/validate';
import { recordUserMessage, recordWrongAnswer, recordCorrectAnswer, setCurrentConcept, recordAssistantTurn } from '../services/adaptation';
import { isFreeLimitReached, FREE_SESSION_LIMIT } from '../middleware/tier';
import { streamChat, createChat, ChatMessage } from '../services/llm';
import { getUserModelId } from './models';
import { subjectHasChunks, retrieveChunks } from '../services/embeddings';

const router = Router();

// ─── Helpers for the coding-support endpoints ─────────────────────────────────
// hint / code-feedback / solution share the same needs: know which subject the
// session belongs to, and (if that subject has an uploaded book) ground the help
// in the most relevant passages so advice matches how the concept was taught.
async function subjectIdForSession(sessionId: string): Promise<number | null> {
  try {
    const { rows } = await db.query<{ subject_id: number | null }>(
      `SELECT m.subject_id FROM sessions s JOIN modules m ON m.id = s.module_id WHERE s.id = $1`,
      [sessionId]
    );
    return rows[0]?.subject_id ?? null;
  } catch {
    return null;
  }
}

async function groundingFor(sessionId: string | undefined, query: string): Promise<string> {
  if (!sessionId) return '';
  try {
    const subjectId = await subjectIdForSession(sessionId);
    if (!subjectId || !(await subjectHasChunks(subjectId))) return '';
    const chunks = await retrieveChunks(subjectId, query || '', 4);
    if (chunks.length === 0) return '';
    const passages = chunks.map((c, i) => `[${i + 1}] ${c.content}`).join('\n\n');
    return `\n\nReference knowledge (internal use only — NEVER mention it, a book, a source, or a figure):\n${passages}\n\nGround your help in the reference knowledge above where relevant.`;
  } catch {
    return '';
  }
}

// ─── Conversation-window management ───────────────────────────────────────────
// A long session would otherwise re-send its entire transcript to the model every
// turn — growing cost and eventually truncating the start of the lesson. Once a
// session passes SUMMARIZE_THRESHOLD turns we fold everything older than the last
// KEEP_RECENT into sessions.running_summary (which the system prompt surfaces) and
// only send the recent turns verbatim.
const KEEP_RECENT = 12;
const SUMMARIZE_THRESHOLD = 20;

async function manageContext(
  sessionId: string,
  history: ChatMessage[],
  modelId: string
): Promise<ChatMessage[]> {
  if (history.length <= SUMMARIZE_THRESHOLD) return history;

  const recent = history.slice(-KEEP_RECENT);
  const older = history.slice(0, history.length - KEEP_RECENT);

  try {
    const { rows } = await db.query<{ running_summary: string | null }>(
      `SELECT running_summary FROM sessions WHERE id = $1`,
      [sessionId]
    );
    const prev = rows[0]?.running_summary ?? '';
    const transcript = older.map((m) => `${m.role.toUpperCase()}: ${m.content}`).join('\n');
    const summary = await createChat({
      modelId,
      maxTokens: 320,
      feature: 'context-summary',
      messages: [{
        role: 'user',
        content:
          `${prev ? `Existing summary of even earlier turns:\n${prev}\n\n` : ''}` +
          `Summarise the earlier part of this tutoring conversation so it can serve as context for continuing the lesson. ` +
          `Capture what was taught, what the learner understood or struggled with, and any decisions made. 4-6 sentences.\n\n` +
          `Conversation:\n${transcript}`,
      }],
    });
    await db.query(`UPDATE sessions SET running_summary = $1 WHERE id = $2`, [summary, sessionId]);
  } catch (err) {
    console.error('manageContext summary failed:', (err as Error).message);
  }

  return recent;
}

// ─── Build system prompt from learner context ─────────────────────────────────
// `opening` is true only for the very first turn of a session (the auto-start
// greeting). On later turns we omit the recap instruction so the tutor doesn't
// re-greet and re-recap on every reply.
async function buildSystemPrompt(userId: string, sessionId: string, opening = false, latestMessage = ''): Promise<string> {
  const [userRow, sessionRow, profileRow] = await Promise.all([
    db.query(
      `SELECT u.name, u.goal, lp.overall_mastery, lp.streak_days, lp.last_session_at,
              m.title AS current_module_title
       FROM users u
       LEFT JOIN learner_profiles lp ON lp.user_id = u.id
       LEFT JOIN modules m ON m.id = lp.current_module_id
       WHERE u.id = $1`,
      [userId]
    ),
    db.query(
      `SELECT s.summary_text, s.running_summary, m.id AS module_id, m.title AS module_title, m.description AS module_description,
              subj.id AS subject_id, subj.name AS subject_name, subj.slug AS subject_slug, subj.practice_kind
       FROM sessions s
       LEFT JOIN modules m ON m.id = s.module_id
       LEFT JOIN subjects subj ON subj.id = m.subject_id
       WHERE s.id = $1`,
      [sessionId]
    ),
    // Last completed session summary — scoped to THIS session's subject so each
    // subject keeps its own continuity (a Python lesson recaps the last Python
    // session, not whatever subject the learner touched most recently).
    db.query(
      `SELECT s.summary_text, s.ended_at
       FROM sessions s
       JOIN modules m ON m.id = s.module_id
       WHERE s.user_id = $1 AND s.ended_at IS NOT NULL
         AND s.id <> $2
         AND s.summary_text IS NOT NULL AND s.summary_text <> ''
         AND m.subject_id = (
           SELECT cm.subject_id FROM sessions cur
           JOIN modules cm ON cm.id = cur.module_id
           WHERE cur.id = $2
         )
       ORDER BY s.ended_at DESC LIMIT 1`,
      [userId, sessionId]
    ),
  ]);

  const user = userRow.rows[0];
  const session = sessionRow.rows[0];
  const lastSession = profileRow.rows[0];

  // 7-day gap detection
  const daysSinceLastSession = lastSession?.ended_at
    ? Math.floor((Date.now() - new Date(lastSession.ended_at).getTime()) / 86_400_000)
    : null;
  const gapNote = daysSinceLastSession !== null && daysSinceLastSession >= 7
    ? `\n[NOTE: The learner has not logged in for ${daysSinceLastSession} days. Begin with a light review of the last concept before continuing.]`
    : '';

  // ── Subject-aware framing ──────────────────────────────────────────────────
  // The practice surface and teaching style differ per subject. `practice_kind`
  // comes from the session's module → subject: 'code' = in-browser Python editor,
  // 'problem' = pencil-and-paper math, 'web' = live HTML/CSS playground,
  // 'none' = chat + quizzes only.
  const subjectName = session?.subject_name ?? 'Python Development';
  const practiceKind = session?.practice_kind ?? 'code';

  const practiceSection = practiceKind === 'problem'
    ? `## How to teach mathematics
Math is learned by working problems step by step — not by reading answers. When the learner would benefit from practice:
- Pose ONE concrete problem and guide them to solve it themselves; ask for the next step rather than handing over the full solution.
- When you introduce a technique, first work through one fully-worked example, showing every step and the reasoning behind it.
- Ask the learner to show their working. When they slip, pinpoint the exact step that went wrong and re-explain just that step.
- Write mathematical expressions in LaTeX wrapped in DOUBLE dollar signs so they render: e.g. $$x^2 + 3x - 4 = 0$$, $$\\frac{a}{b}$$, $$\\sqrt{x}$$. Use $$...$$ for both inline and standalone formulas. Do NOT use single $ (it is reserved for currency like $5.00), and do not write LaTeX outside of $$...$$.`
    : practiceKind === 'web'
    ? `## Hands-on HTML & CSS playground
This module has an interactive in-browser playground where the learner writes HTML and CSS and sees the page render live. When the learner would learn best by doing, give them a concrete building task in prose (e.g. "Build a card with a heading, an image and a button, then add a border and some padding"). They build it in the playground and can send their HTML/CSS back with the "Discuss with tutor" button — when they do, review it: what works, one thing to improve, and the next step.
- Show short HTML/CSS examples in fenced code blocks (\`\`\`html and \`\`\`css) so they render as formatted code.
- Keep examples minimal and focused on the one concept at hand.
- There is no auto-grading here; rely on quizzes, comprehension questions, and reviewing the code the learner sends back.`
    : `## Hands-on coding environment
This module has an interactive in-browser Python environment where the learner writes and runs real code. When the learner would learn best by doing — practicing a concept you just taught, applying an idea, or debugging — hand them a tailored exercise by emitting ONE directive on its own line, in this EXACT format:

[[EXERCISE]]{"title": "<short title>", "instructions": "<what to do, 1-3 sentences>", "starter": "<starter Python code>"}[[/EXERCISE]]

Directive rules:
- It must be a single line of VALID JSON. Escape newlines inside "starter" as \\n and double-quotes as \\". Do not wrap it in a code fence.
- Write one short natural sentence just before it (e.g. "Great — let's practice this hands-on:"). The directive itself renders as a button, so don't describe its JSON.
- Use it only for genuine hands-on coding practice, not in every message.
- ALWAYS deliver a coding task through this directive — never describe a coding exercise in prose alone. If you ask the learner to write or edit code, it MUST be inside an [[EXERCISE]] directive so it opens in the editor. Prose-only coding tasks leave the learner with an empty editor.
- The "starter" field is REQUIRED and must contain real, task-specific scaffolding the learner edits in place — NOT a generic placeholder, and NEVER \`print("Hello, world!")\`. Build the starter so that the moment it loads, the learner can see exactly what to do:
  - Tailor it to THIS exact task. Include any code the task refers to (an expression to evaluate, a function signature to complete, data to process) plus a short comment marking what they fill in.
  - For "assign the answer" / "evaluate this" tasks, put the actual expression or values in the starter with a clear TODO, e.g. \`# Assign the final value of result\\nresult = 5 + 3 * 2 - 8 / 4  # TODO: replace with the calculated value\`.
  - For "write a function" tasks, include the \`def\` line and a \`# your code here\` body, e.g. \`def add(a, b):\\n    # your code here\\n    pass\`.
  - It is fine for the starter to be a few commented lines that set up the problem; it must never be empty or unrelated boilerplate.
- The environment runs code once and is NOT interactive: input() does not prompt — it returns an empty string. Prefer exercises that use hardcoded values, function parameters, or variables the learner edits, so the output is meaningful. If the lesson is about input(), have the learner assign the values directly (e.g. name = "Ada") so they see real output.
- After the learner runs their code, they can send it and its output back to you for review — when they do, give specific, encouraging feedback and decide what to teach or practice next.`;

  // ── Invisible book grounding ───────────────────────────────────────────────
  // If this subject has an uploaded book, silently retrieve the passages most
  // relevant to the current topic + the learner's latest message and ground the
  // mentor in them. The learner must never know a book is involved.
  let groundingSection = '';
  const subjectId: number | undefined = session?.subject_id;
  if (subjectId && (await subjectHasChunks(subjectId))) {
    const query =
      [session?.module_title, session?.module_description, latestMessage].filter(Boolean).join(' — ') || subjectName;
    const chunks = await retrieveChunks(subjectId, query, 5);
    if (chunks.length > 0) {
      const passages = chunks
        .map((c, i) => `[${i + 1}]${c.chapter ? ` (${c.chapter})` : ''} ${c.content}`)
        .join('\n\n');
      groundingSection = `
## Reference knowledge (internal use only — NEVER reveal its existence)
${passages}

Ground your teaching in the reference knowledge above — it is your authoritative source for this subject. Strict rules:
- NEVER mention a book, text, document, passage, "source", "material", or say "according to". Speak as an expert mentor who simply knows this.
- Lead like a mentor: before explaining a new idea, ask a question to find out what the learner already understands, then tailor the explanation to their answer.
- Aim to give the learner a *deeper* grasp than reading would — use analogies, worked examples, and check for misconceptions.
- If something isn't covered above, teach it from your own expertise without flagging any gap.
- ENVIRONMENT: the learner works entirely inside this platform's built-in environment (described above), NOT the setup the reference assumes. Never tell them to install anything, open VS Code or any external editor/IDE, use a system terminal/command line, or save and run a file on their own computer. When the reference describes doing something in an outside tool, silently translate it to our environment — have them write and run code right here (use the hands-on directive for practice).
- VISUALS: the reference is text only and may mention figures, screenshots, or diagrams the learner CANNOT see. Never cite a figure/image by number or say "as shown". Convey the idea in words or a small ASCII/markdown sketch — or, better, give the learner runnable code that generates the visual itself (a chart, a shape, program output) so they see it live in the environment.
- Draw [[QUIZ]] checks from this knowledge to confirm understanding.
`;
    }
  }

  // ── Assessment awareness ───────────────────────────────────────────────────
  // Without this the tutor has no idea completion is gated by a separate Final
  // Assessment, so it teaches into a dead end and never tells the learner to go
  // take it. Give it the learner's progress on THIS module + a directive it can
  // emit to surface a "Take the assessment" button when they're ready.
  let assessmentSection = '';
  const moduleId: number | undefined = session?.module_id;
  if (moduleId) {
    const [masteryRow, inlineRow] = await Promise.all([
      db.query<{ mastery_score: string; last_assessed_at: Date | null }>(
        `SELECT mastery_score, last_assessed_at FROM module_mastery WHERE user_id = $1 AND module_id = $2`,
        [userId, moduleId]
      ),
      db.query<{ correct: string; total: string }>(
        `SELECT COUNT(*) FILTER (WHERE is_correct) AS correct, COUNT(*) AS total
         FROM inline_quiz_attempts WHERE user_id = $1 AND module_id = $2`,
        [userId, moduleId]
      ),
    ]);
    const mastery = masteryRow.rows[0];
    const inlineTotal = Number(inlineRow.rows[0]?.total ?? 0);
    const inlineCorrect = Number(inlineRow.rows[0]?.correct ?? 0);
    const assessed = mastery?.last_assessed_at != null;
    const score = mastery ? Math.round(Number(mastery.mastery_score)) : 0;
    const passed = assessed && score >= 80;
    const finalStatus = !assessed
      ? 'not taken yet'
      : passed
      ? `passed at ${score}% ✓`
      : `attempted — ${score}%, below the 80% needed to complete`;

    assessmentSection = `
## Progress & assessment (you can see this; use it to guide the learner)
- In-session quick-checks on this module: ${inlineCorrect}/${inlineTotal} correct
- Module mastery so far: ${assessed ? `${score}%` : 'not assessed yet'}
- Final assessment: ${finalStatus}

This module is marked complete — and the next one unlocks — only when the learner passes its Final Assessment (≥80%). They reach it via a "Take the assessment" button; your job is to get them ready, then tell them to take it.
- Offer the assessment only once you have taught EVERY concept in the Module syllabus above and the learner has shown solid understanding of each (e.g. a correct quick-check or a confident explanation per concept) and has NOT yet passed. If any syllabus concept is still untaught or shaky, keep teaching — do not offer the assessment yet. When they are genuinely ready, tell them and offer it by emitting ONE directive on its own line, in this EXACT format:
[[ASSESSMENT]]{"label": "I'm ready — start the assessment"}[[/ASSESSMENT]]
  Write one short encouraging sentence just before it (e.g. "You've got this down — time to make it official:"). It renders as a button, so don't describe its JSON, and emit it at most once, only when readiness genuinely warrants it.
${passed
  ? '- The learner has already passed this module. Congratulate them and offer to either go deeper on a tricky part or move on to the next module.'
  : '- Do not nag: raise the assessment only when the learner is genuinely ready or asks about their progress, not in every message.'}
`;
  }

  // ── Module syllabus (authoritative teaching scope) ──────────────────────────
  // The module's concepts ARE the syllabus and exactly what the final assessment
  // covers. Without this the tutor improvises scope from a one-line description
  // and can leave the learner assessed on material it never taught. Each concept
  // carries an optional teaching brief (key points / canonical example /
  // misconception) the tutor grounds in. Brief fields render only when present,
  // so this degrades gracefully for concepts that haven't been co-generated yet.
  let syllabusSection = '';
  if (moduleId) {
    const { rows: concepts } = await db.query<{
      title: string; description: string | null;
      key_points: string[] | null; worked_example: string | null; misconception: string | null;
    }>(
      `SELECT c.title, c.description, cb.key_points, cb.worked_example, cb.misconception
       FROM concepts c
       LEFT JOIN concept_briefs cb ON cb.concept_id = c.id
       WHERE c.module_id = $1
       ORDER BY c.order_index`,
      [moduleId]
    );
    if (concepts.length > 0) {
      const items = concepts.map((c, i) => {
        const lines = [`${i + 1}. ${c.title}${c.description ? ` — ${c.description}` : ''}`];
        const kp = Array.isArray(c.key_points) ? c.key_points : [];
        if (kp.length) lines.push(`   Key points to convey: ${kp.join('; ')}`);
        if (c.worked_example) lines.push(`   Use this worked example: ${c.worked_example}`);
        if (c.misconception) lines.push(`   Preempt this misconception: ${c.misconception}`);
        return lines.join('\n');
      }).join('\n');
      syllabusSection = `
## Module syllabus (your authoritative teaching scope)
Teach EVERY concept below, in order, one at a time — explaining each and checking it with a quick comprehension question or quiz before moving on. The final assessment covers exactly these concepts: do NOT skip any, and do NOT teach or quiz on material beyond them. Only offer the assessment once you've covered all of them.
${items}
`;
    }
  }

  return `You are a tutor at The AI Academy — a warm, expert teacher of ${subjectName}. Your job is to teach, not just answer questions.

## Tutor rules
- Introduce each concept with a clear explanation and at least one concrete example.
- After explaining a concept, ask a comprehension question — do not wait for the learner to ask.
- If the learner answers incorrectly or vaguely, re-explain using a different method (analogy, simpler language, worked example).
- After two failed attempts on the same concept, switch to a step-by-step worked example.
- Periodically ask the learner to explain the concept back in their own words.
- Celebrate genuine progress. Be encouraging, never condescending.
- Keep explanations under 150 words unless the concept requires more.
- Never say "That's wrong" — prefer "Not quite — let me show you another way to think about it."

## Learner profile
- Name: ${user?.name ?? 'Learner'}
- Goal: ${user?.goal ?? `Learn ${subjectName}`}
- Current module: ${user?.current_module_title ?? session?.module_title ?? subjectName}
- Overall mastery: ${user?.overall_mastery ?? 0}%
- Streak: ${user?.streak_days ?? 0} days

## Current session
- Subject: ${subjectName}
- Module: ${session?.module_title ?? subjectName}
- Topic: ${session?.module_description ?? ''}
- Last session summary: ${lastSession?.summary_text ?? 'This is the first session.'}
${session?.running_summary ? `- Earlier in this session: ${session.running_summary}` : ''}
${gapNote}
${syllabusSection}
${practiceSection}
${groundingSection}
## Quick quizzes
To check understanding with a multiple-choice question, emit ONE directive on its own line, in this EXACT format:

[[QUIZ]]{"question": "<the question>", "options": ["<option A>", "<option B>", "<option C>", "<option D>"], "answer": <0-based index of the correct option>, "explanation": "<one short sentence explaining the answer>"}[[/QUIZ]]

Quiz rules:
- It must be a single line of VALID JSON. Provide 2-4 options. "answer" is the integer index (0-based) of the correct option. Escape quotes and newlines.
- Write one short natural sentence before it (e.g. "Let's check that with a quick quiz:"). The quiz renders as an interactive card — do NOT also list the options as plain text, and do NOT reveal the answer in your prose (the card shows the learner whether they were right, plus your explanation).
- Use a quiz to check a concept you just taught — not in every message. A plain comprehension question is also fine.
${assessmentSection}${opening
  ? 'Start by briefly recapping what was covered last time (if any) and introducing what you will cover today.'
  : 'Continue the lesson naturally — respond directly to the learner\'s latest message. Do NOT re-greet or recap the whole session; only refer back when it genuinely helps.'}`;
}

// ─── POST /api/tutor/chat ─────────────────────────────────────────────────────
// Body: { sessionId, message, history: [{role, content}] }
// Streams SSE tokens back to the client.
router.post('/chat', requireAuth, async (req: AuthRequest, res) => {
  const { sessionId, message, history = [] } = req.body as {
    sessionId: string;
    message: string;
    history: { role: 'user' | 'assistant'; content: string }[];
  };

  // --- Validation ---
  const missing = requireFields(req.body, ['sessionId', 'message']);
  if (missing) { res.status(400).json({ error: missing }); return; }
  if (sendValidationErrors(res, [
    requireString(sessionId, 'sessionId'),
    requireString(message, 'message'),
  ])) return;
  if (Array.isArray(history)) {
    for (let i = 0; i < history.length; i++) {
      const entry = history[i];
      if (!entry.role || !['user', 'assistant'].includes(entry.role)) {
        res.status(400).json({ error: `history[${i}].role must be 'user' or 'assistant'` });
        return;
      }
      if (typeof entry.content !== 'string' || entry.content.trim().length === 0) {
        res.status(400).json({ error: `history[${i}].content must be a non-empty string` });
        return;
      }
    }
  }

  // Persist user message
  await db.query(
    `INSERT INTO messages (session_id, role, content) VALUES ($1, 'user', $2)`,
    [sessionId, message]
  );

  // Get adaptation hint based on timing/content signals
  const adaptationHint = await recordUserMessage(sessionId, message);

  // Set up SSE
  res.setHeader('Content-Type', 'text/event-stream');
  res.setHeader('Cache-Control', 'no-cache');
  res.setHeader('Connection', 'keep-alive');
  res.flushHeaders();

  const modelId = await getUserModelId(req.userId!);

  // Fold older turns into a rolling summary (persisted) and keep only recent
  // turns verbatim. Must run BEFORE buildSystemPrompt so the prompt picks up the
  // freshly-updated running_summary.
  const trimmed = await manageContext(sessionId, history as ChatMessage[], modelId);

  const basePrompt = await buildSystemPrompt(req.userId!, sessionId, false, message);
  const systemPrompt = adaptationHint ? `${basePrompt}\n\n${adaptationHint}` : basePrompt;

  const messages: ChatMessage[] = [
    ...trimmed.map((m) => ({ role: m.role, content: m.content })),
    { role: 'user' as const, content: message },
  ];

  // The very first turn of a session is the tutor's auto-opening (from /start),
  // whose kickoff user-prompt is intentionally never persisted. That leaves the
  // conversation starting with an assistant turn — which providers require to
  // begin with a user turn, so it gets dropped (see normalizeMessages in llm.ts).
  // The result: on the learner's first reply the tutor loses its own opening and
  // re-greets/restarts the lesson. Reconstruct the implicit kickoff user turn so
  // the opening stays in context.
  if (messages[0]?.role === 'assistant') {
    messages.unshift({ role: 'user', content: 'Begin the lesson.' });
  }

  let fullResponse = '';

  try {
    for await (const token of streamChat({
      modelId,
      // Room for a full explanation PLUS a long exercise directive (multi-line
      // starter code) without truncating before the directive completes.
      maxTokens: 1536,
      system: systemPrompt,
      messages,
    })) {
      fullResponse += token;
      res.write(`data: ${JSON.stringify({ token })}\n\n`);
    }

    // Persist assistant message
    await db.query(
      `INSERT INTO messages (session_id, role, content) VALUES ($1, 'assistant', $2)`,
      [sessionId, fullResponse]
    );
    // Stamp the tutor turn so the next message's think-time is measured from here.
    await recordAssistantTurn(sessionId);

    res.write(`data: ${JSON.stringify({ done: true })}\n\n`);
  } catch (err) {
    console.error('tutor/chat error:', err);
    res.write(`data: ${JSON.stringify({ error: 'AI error' })}\n\n`);
  } finally {
    res.end();
  }
});

// ─── POST /api/tutor/start ────────────────────────────────────────────────────
// Body: { sessionId }
// Streams the tutor's opening message so teaching begins without the learner
// having to type first. Idempotent: if the session already has any messages,
// it does nothing (prevents a duplicate greeting on remount/StrictMode).
router.post('/start', requireAuth, async (req: AuthRequest, res) => {
  const { sessionId } = req.body as { sessionId: string };

  // --- Validation ---
  const missing = requireFields(req.body, ['sessionId']);
  if (missing) { res.status(400).json({ error: missing }); return; }
  if (sendValidationErrors(res, [requireString(sessionId, 'sessionId')])) return;

  // Skip if this session already has a conversation.
  const existing = await db.query<{ count: string }>(
    `SELECT COUNT(*) AS count FROM messages WHERE session_id = $1`,
    [sessionId]
  );
  if (Number(existing.rows[0].count) > 0) {
    res.json({ alreadyStarted: true });
    return;
  }

  const systemPrompt = await buildSystemPrompt(req.userId!, sessionId, true);

  // Internal kickoff turn — not persisted or shown; it just prompts the tutor
  // to take the first turn following the rules in the system prompt.
  const kickoff: ChatMessage = {
    role: 'user',
    content:
      'Begin the lesson now. Greet me, briefly recap the last session if there was one, ' +
      'then introduce the FIRST concept in the Module syllabus with a clear explanation and one ' +
      'concrete example, and finish with a comprehension question.',
  };

  res.setHeader('Content-Type', 'text/event-stream');
  res.setHeader('Cache-Control', 'no-cache');
  res.setHeader('Connection', 'keep-alive');
  res.flushHeaders();

  let fullResponse = '';
  try {
    const modelId = await getUserModelId(req.userId!);
    for await (const token of streamChat({
      modelId,
      maxTokens: 1536,
      system: systemPrompt,
      messages: [kickoff],
    })) {
      fullResponse += token;
      res.write(`data: ${JSON.stringify({ token })}\n\n`);
    }

    // Persist only the tutor's greeting (the kickoff turn is internal).
    await db.query(
      `INSERT INTO messages (session_id, role, content) VALUES ($1, 'assistant', $2)`,
      [sessionId, fullResponse]
    );
    await recordAssistantTurn(sessionId);

    res.write(`data: ${JSON.stringify({ done: true })}\n\n`);
  } catch (err) {
    console.error('tutor/start error:', err);
    res.write(`data: ${JSON.stringify({ error: 'AI error' })}\n\n`);
  } finally {
    res.end();
  }
});

// ─── POST /api/tutor/session ──────────────────────────────────────────────────
// Get-or-create a session for a module. Reuses the learner's MOST RECENT session
// for this module — even a previously-closed one — and reopens it (clears
// ended_at), so reopening a module continues the same conversation instead of
// starting fresh. Leaving the module still closes it (summary/streak); the next
// visit simply resumes that thread. A brand-new session is only created the very
// first time a module is opened, and the free-tier cap is enforced only then.
router.post('/session', requireAuth, async (req: AuthRequest, res) => {
  const { moduleId } = req.body as { moduleId: number };

  // --- Validation ---
  const missing = requireFields(req.body, ['moduleId']);
  if (missing) { res.status(400).json({ error: missing }); return; }
  if (sendValidationErrors(res, [
    requireNumber(moduleId, 'moduleId'),
  ])) return;

  try {
    // Resume the most recent session for this module (open OR closed), reopening
    // it so its conversation is restored on the client.
    const existing = await db.query<{ id: string; ended_at: Date | null }>(
      `SELECT id, ended_at FROM sessions
       WHERE user_id = $1 AND module_id = $2
       ORDER BY started_at DESC LIMIT 1`,
      [req.userId, moduleId]
    );
    if (existing.rows[0]) {
      if (existing.rows[0].ended_at !== null) {
        await db.query(`UPDATE sessions SET ended_at = NULL WHERE id = $1`, [existing.rows[0].id]);
      }
      res.json({ sessionId: existing.rows[0].id, reused: true });
      return;
    }

    // Creating a new session — enforce the free-tier cap here.
    if (await isFreeLimitReached(req.userId!)) {
      res.status(402).json({
        error: 'free_limit_reached',
        message: `Free plan includes ${FREE_SESSION_LIMIT} sessions. Upgrade to Pro to continue.`,
      });
      return;
    }

    const result = await db.query<{ id: string }>(
      `INSERT INTO sessions (user_id, module_id) VALUES ($1, $2) RETURNING id`,
      [req.userId, moduleId]
    );
    res.json({ sessionId: result.rows[0].id, reused: false });
  } catch (err) {
    console.error('tutor/session error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// ─── GET /api/tutor/session/:sessionId/messages ───────────────────────────────
router.get('/session/:sessionId/messages', requireAuth, async (req: AuthRequest, res) => {
  try {
    const result = await db.query(
      `SELECT role, content, created_at FROM messages
       WHERE session_id = $1 ORDER BY created_at`,
      [req.params.sessionId]
    );
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: 'Internal server error' });
  }
});

// ─── POST /api/tutor/code-feedback ───────────────────────────────────────────
router.post('/code-feedback', requireAuth, async (req: AuthRequest, res) => {
  const { sessionId, code, output, hasError, instructions } = req.body as {
    sessionId?: string; code: string; output: string; hasError: boolean; instructions?: string;
  };

  // --- Validation ---
  const missing = requireFields(req.body, ['code', 'output', 'hasError']);
  if (missing) { res.status(400).json({ error: missing }); return; }
  if (sendValidationErrors(res, [
    requireString(code, 'code'),
    requireString(output, 'output'),
    requireBoolean(hasError, 'hasError'),
  ])) return;

  // Tell the model what the exercise was asking for (if known), so it judges the
  // code against the actual task instead of guessing intent from the code alone.
  const brief = instructions ? `The exercise asked the learner to: ${instructions}\n\n` : '';
  const grounding = await groundingFor(sessionId, instructions || code);

  const prompt = hasError
    ? `${brief}The learner wrote this Python code:\n\`\`\`python\n${code}\n\`\`\`\nIt produced this error:\n${output}\n\nIdentify the exact issue, explain what it means in plain language, and show the corrected syntax. Be concise.${grounding}`
    : `${brief}The learner wrote this Python code:\n\`\`\`python\n${code}\n\`\`\`\nOutput: ${output}\n\nIf it meets the task: confirm it works, explain why the approach is correct, suggest one improvement. If logically wrong or off-task: explain the gap without giving away the solution. Keep it under 100 words.${grounding}`;

  try {
    const feedback = await createChat({
      modelId: await getUserModelId(req.userId!),
      maxTokens: 300,
      feature: 'code-feedback',
      messages: [{ role: 'user', content: prompt }],
    });
    res.json({ feedback });
  } catch {
    res.status(500).json({ error: 'AI error' });
  }
});

// ─── POST /api/tutor/hint ─────────────────────────────────────────────────────
router.post('/hint', requireAuth, async (req: AuthRequest, res) => {
  const { sessionId, code, hintNumber, instructions } = req.body as {
    sessionId?: string; code: string; hintNumber: number; instructions?: string;
  };

  // --- Validation ---
  const missing = requireFields(req.body, ['code', 'hintNumber']);
  if (missing) { res.status(400).json({ error: missing }); return; }
  if (sendValidationErrors(res, [
    requireString(code, 'code'),
    requireNumber(hintNumber, 'hintNumber'),
  ])) return;

  // The exercise brief lets the hint point toward the *intended* solution rather
  // than reverse-engineering intent from half-written code.
  const brief = instructions ? `The exercise asks the learner to: ${instructions}\n` : '';
  const grounding = await groundingFor(sessionId, instructions || code);

  try {
    const hint = await createChat({
      modelId: await getUserModelId(req.userId!),
      maxTokens: 150,
      feature: 'hint',
      messages: [{
        role: 'user',
        content: `${brief}The learner is working on this Python code:\n\`\`\`python\n${code}\n\`\`\`\nProvide hint #${hintNumber} of 3 toward completing the task. Each hint reveals one more step without giving the full solution. Hint ${hintNumber} should be ${hintNumber === 1 ? 'very subtle' : hintNumber === 2 ? 'more direct' : 'almost explicit'}. One sentence only.${grounding}`,
      }],
    });
    res.json({ hint });
  } catch {
    res.status(500).json({ error: 'AI error' });
  }
});

// ─── POST /api/tutor/solution ─────────────────────────────────────────────────
router.post('/solution', requireAuth, async (req: AuthRequest, res) => {
  const { code, instructions } = req.body as { sessionId?: string; code: string; instructions?: string };

  // --- Validation ---
  const missing = requireFields(req.body, ['code']);
  if (missing) { res.status(400).json({ error: missing }); return; }
  if (sendValidationErrors(res, [
    requireString(code, 'code'),
  ])) return;

  const brief = instructions ? `The exercise asks the learner to: ${instructions}\n` : '';

  try {
    const raw = await createChat({
      modelId: await getUserModelId(req.userId!),
      maxTokens: 400,
      feature: 'solution',
      messages: [{
        role: 'user',
        content: `${brief}The learner has used all hints on this Python code:\n\`\`\`python\n${code}\n\`\`\`\nProvide a correct, clean solution that satisfies the task. Return ONLY the Python code, no explanation.`,
      }],
    });
    const solution = raw.replace(/^```python\n?/, '').replace(/```$/, '').trim();
    res.json({ solution });
  } catch {
    res.status(500).json({ error: 'AI error' });
  }
});

// ─── POST /api/tutor/feedback ─────────────────────────────────────────────────
// Body: { sessionId, outcome: 'correct' | 'wrong', concept? }
router.post('/feedback', requireAuth, async (req: AuthRequest, res) => {
  const { sessionId, outcome, concept, chosen } = req.body as {
    sessionId: string;
    outcome: 'correct' | 'wrong';
    concept?: string;
    chosen?: string;
  };

  // --- Validation ---
  const missing = requireFields(req.body, ['sessionId', 'outcome']);
  if (missing) { res.status(400).json({ error: missing }); return; }
  if (sendValidationErrors(res, [
    requireString(sessionId, 'sessionId'),
    requireString(outcome, 'outcome'),
    requireOneOf(outcome, 'outcome', ['correct', 'wrong']),
  ])) return;
  if (concept !== undefined && sendValidationErrors(res, [requireString(concept, 'concept')])) return;

  if (concept) await setCurrentConcept(sessionId, concept);
  const hint = outcome === 'correct'
    ? await recordCorrectAnswer(sessionId)
    : await recordWrongAnswer(sessionId);

  // Record the inline quiz answer so it feeds the `inSession` component of module
  // mastery (see services/mastery.ts). Best-effort: never block the tutor reply.
  try {
    const sessRow = await db.query<{ module_id: number | null }>(
      `SELECT module_id FROM sessions WHERE id = $1`,
      [sessionId]
    );
    const moduleId = sessRow.rows[0]?.module_id;
    if (moduleId != null) {
      await db.query(
        `INSERT INTO inline_quiz_attempts (user_id, session_id, module_id, is_correct, chosen)
         VALUES ($1, $2, $3, $4, $5)`,
        [req.userId, sessionId, moduleId, outcome === 'correct', chosen ?? null]
      );
    }
  } catch (err) {
    console.error('tutor/feedback inline-quiz record failed:', (err as Error).message);
  }

  res.json({ adaptationHint: hint });
});

export default router;
