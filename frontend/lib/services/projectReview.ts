// ─── Project submission review ────────────────────────────────────────────────
// Asks the LLM to judge a submission against each acceptance criterion and give
// encouraging overall feedback. Returns a structured result the UI renders.

import { createChat } from './llm';

export interface CriterionResult {
  criterion: string;
  met: boolean;
  note: string;
}

export interface ReviewResult {
  passed: boolean;
  feedback: string;
  criteriaResults: CriterionResult[];
}

export async function reviewWebSubmission(opts: {
  modelId: string;
  brief: string;
  criteria: string[];
  html: string;
  css: string;
}): Promise<ReviewResult> {
  const { modelId, brief, criteria, html, css } = opts;

  const prompt = `You are a supportive coding tutor reviewing a learner's HTML/CSS project.

PROJECT BRIEF:
${brief}

ACCEPTANCE CRITERIA — judge each ONLY from the submitted code below:
${criteria.map((c, i) => `${i + 1}. ${c}`).join('\n')}

SUBMISSION
--- HTML ---
${html || '(empty)'}
--- CSS ---
${css || '(empty)'}

For every criterion, decide whether it is met. Then write 2-3 sentences of warm, specific overall feedback: what they did well, and the single most important thing to fix if anything is unmet.
Reply with ONLY valid JSON in this exact shape, no prose outside it:
{"results":[{"criterion":"<exact criterion text>","met":true,"note":"<one short reason>"}],"feedback":"<2-3 sentences>"}`;

  const raw = await createChat({ modelId, maxTokens: 800, messages: [{ role: 'user', content: prompt }] });

  try {
    const parsed = JSON.parse(raw.match(/\{[\s\S]*\}/)?.[0] ?? '{}');
    const results: CriterionResult[] = Array.isArray(parsed.results)
      ? parsed.results.map((r: { criterion?: string; met?: boolean; note?: string }) => ({
          criterion: String(r.criterion ?? ''),
          met: Boolean(r.met),
          note: String(r.note ?? ''),
        }))
      : [];
    const passed = results.length > 0 && results.every((r) => r.met);
    return {
      passed,
      feedback: typeof parsed.feedback === 'string' ? parsed.feedback : '',
      criteriaResults: results,
    };
  } catch {
    return { passed: false, feedback: 'Could not evaluate the submission. Please try again.', criteriaResults: [] };
  }
}
