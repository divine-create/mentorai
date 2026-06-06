// ─── Shared answer grading ────────────────────────────────────────────────────
// One place to grade a learner's answer to a question, used by both the formal
// assessment flow (routes/assessments.ts) and the spaced-repetition review flow
// (routes/review.ts). Multiple-choice and numeric/short answers are graded
// deterministically where possible; conceptual short-answer / explanation
// answers fall back to an LLM judge that also returns a short rubric note.

import { evaluate } from 'mathjs';
import { createChat } from './llm';

export interface GradableQuestion {
  type: string;                 // 'multiple_choice' | 'short_answer' | 'explanation' | 'coding'
  prompt: string;
  correct_answer: string | null;
}

export interface GradeResult {
  correct: boolean;
  feedback: string;
}

// Normalise a free-text answer: trim, lowercase, collapse whitespace, drop a
// trailing period.
export function normalizeAnswer(s: string): string {
  return s.trim().toLowerCase().replace(/\s+/g, ' ').replace(/\.$/, '');
}

// Reduce an answer to a finite number when it's a plain numeric expression
// (so "1/2", "0.5", "3/8" compare equal). Returns null otherwise.
export function numericValue(s: string): number | null {
  try {
    const v = evaluate(s);
    return typeof v === 'number' && Number.isFinite(v) ? v : null;
  } catch {
    return null;
  }
}

// Deterministic equivalence check for answers with a known correct value.
//   true  — confidently correct (exact text or numeric match)
//   false — confidently wrong (both sides numeric but differ)
//   null  — can't tell deterministically; let the AI decide
export function mathEquivalent(answer: string, correct: string): boolean | null {
  if (normalizeAnswer(answer) === normalizeAnswer(correct)) return true;
  const a = numericValue(answer);
  const b = numericValue(correct);
  if (a !== null && b !== null) return Math.abs(a - b) < 1e-9;
  return null;
}

/**
 * Grade a single answer. For coding questions, pass `testResults` (run by the
 * client in Pyodide); everything else is text-graded.
 */
export async function gradeAnswer(opts: {
  question: GradableQuestion;
  answer: string;
  modelId: string;
  testResults?: { passed: boolean }[] | undefined;
}): Promise<GradeResult> {
  const { question: q, answer, modelId, testResults } = opts;

  if (q.type === 'multiple_choice') {
    const correct = normalizeAnswer(answer) === normalizeAnswer(q.correct_answer ?? '');
    return {
      correct,
      feedback: correct ? 'Correct!' : `Not quite. The correct answer is: ${q.correct_answer}`,
    };
  }

  if (q.type === 'coding') {
    const correct = testResults?.length ? testResults.every((r) => r.passed) : answer === 'passed';
    return {
      correct,
      feedback: correct ? 'All test cases passed!' : 'Some test cases failed. Review the output below.',
    };
  }

  // short_answer / explanation — deterministic fast path, else LLM judge.
  const deterministic = q.correct_answer ? mathEquivalent(answer, q.correct_answer) : null;
  if (deterministic !== null) {
    return {
      correct: deterministic,
      feedback: deterministic ? 'Correct!' : `Not quite. The correct answer is: ${q.correct_answer}`,
    };
  }

  const raw = await createChat({
    modelId,
    maxTokens: 220,
    feature: 'assessment',
    messages: [{
      role: 'user',
      content:
        `Question: ${q.prompt}\n` +
        (q.correct_answer ? `Reference answer: ${q.correct_answer}\n` : '') +
        `Learner answer: ${answer}\n\n` +
        `Evaluate for conceptual accuracy (not keyword matching). If the answer is partly right, ` +
        `briefly name what's missing so the learner can fix it. ` +
        `Reply with JSON only: {"correct": true|false, "feedback": "one or two sentences"}`,
    }],
  });
  try {
    const parsed = JSON.parse(raw.match(/\{[\s\S]*\}/)?.[0] ?? '{}');
    return {
      correct: parsed.correct ?? false,
      feedback: typeof parsed.feedback === 'string' ? parsed.feedback : '',
    };
  } catch {
    return { correct: false, feedback: 'Could not evaluate answer.' };
  }
}
