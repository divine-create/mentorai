'use client';

import { useState } from 'react';

export interface Quiz {
  question: string;
  options: string[];
  answer: number; // 0-based index of the correct option
  explanation?: string;
}

// An inline multiple-choice quiz rendered inside the tutor chat. Tapping an
// option locks the card, reveals correct/incorrect + the explanation, and the
// answer is persisted (localStorage) so a reload doesn't re-ask or double-count.
export default function QuizCard({
  quiz,
  storageKey,
  onAnswer,
}: {
  quiz: Quiz;
  storageKey: string;
  onAnswer: (correct: boolean, chosen: string) => void;
}) {
  const [selected, setSelected] = useState<number | null>(() => {
    if (typeof window === 'undefined') return null;
    const saved = window.localStorage.getItem(storageKey);
    return saved === null ? null : Number(saved);
  });

  const answered = selected !== null;
  const gotItRight = selected === quiz.answer;

  function choose(i: number) {
    if (answered) return;
    setSelected(i);
    try {
      window.localStorage.setItem(storageKey, String(i));
    } catch {
      // localStorage may be unavailable (private mode) — answering still works.
    }
    onAnswer(i === quiz.answer, quiz.options[i]);
  }

  return (
    <div className="mt-3 rounded-xl border border-indigo-100 bg-indigo-50/40 p-3">
      <div className="mb-2 flex items-center gap-1.5 text-xs font-semibold uppercase tracking-wide text-indigo-500">
        <span>📝</span> Quick quiz
      </div>
      <p className="mb-3 text-sm font-medium text-gray-800">{quiz.question}</p>

      <div className="space-y-2">
        {quiz.options.map((opt, i) => {
          const isCorrect = i === quiz.answer;
          const isChosen = i === selected;

          let cls = 'border-gray-200 bg-white hover:bg-indigo-50';
          if (answered && isCorrect) cls = 'border-green-400 bg-green-50 text-green-800';
          else if (answered && isChosen) cls = 'border-red-400 bg-red-50 text-red-800';
          else if (answered) cls = 'border-gray-200 bg-white opacity-60';

          return (
            <button
              key={i}
              onClick={() => choose(i)}
              disabled={answered}
              className={`flex w-full items-center gap-2.5 rounded-lg border px-3 py-2 text-left text-sm transition ${cls} disabled:cursor-default`}
            >
              <span className="flex h-5 w-5 shrink-0 items-center justify-center rounded-full border border-current text-[11px] font-semibold">
                {String.fromCharCode(65 + i)}
              </span>
              <span className="flex-1">{opt}</span>
              {answered && isCorrect && <span className="text-green-600">✓</span>}
              {answered && isChosen && !isCorrect && <span className="text-red-500">✕</span>}
            </button>
          );
        })}
      </div>

      {answered && (
        <div
          className={`mt-3 rounded-lg px-3 py-2 text-sm ${
            gotItRight ? 'bg-green-100 text-green-800' : 'bg-amber-100 text-amber-900'
          }`}
        >
          <span className="font-semibold">{gotItRight ? 'Correct! ' : 'Not quite. '}</span>
          {quiz.explanation ||
            (gotItRight
              ? 'Nice work.'
              : `The correct answer is ${String.fromCharCode(65 + quiz.answer)}.`)}
        </div>
      )}
    </div>
  );
}
