'use client';

import ReactMarkdown from 'react-markdown';
import remarkGfm from 'remark-gfm';
import remarkMath from 'remark-math';
import rehypeKatex from 'rehype-katex';
import 'katex/dist/katex.min.css';

// Renders tutor/learner message text as Markdown with embedded math.
// - GitHub-flavoured Markdown (headings, lists, bold, tables, fenced code).
// - Math via KaTeX: only `$$…$$` is treated as math (singleDollarTextMath is
//   off) so plain dollar amounts like "$75" in word problems aren't swallowed.
// - Fenced code keeps the copy button the old custom renderer had.

function CodeBlock({ text }: { text: string }) {
  return (
    <span className="relative my-2 block rounded-md bg-gray-900 font-mono text-xs text-gray-100 overflow-x-auto">
      <button
        onClick={() => navigator.clipboard.writeText(text)}
        className="absolute top-2 right-2 z-10 text-gray-400 hover:text-white text-xs"
        aria-label="Copy code"
      >
        Copy
      </button>
      <code className="block whitespace-pre-wrap p-4 pr-12">{text}</code>
    </span>
  );
}

export default function MessageContent({ text }: { text: string }) {
  return (
    <div className="space-y-2 leading-relaxed [&_p]:whitespace-pre-wrap">
      <ReactMarkdown
        remarkPlugins={[remarkGfm, [remarkMath, { singleDollarTextMath: false }]]}
        rehypePlugins={[rehypeKatex]}
        components={{
          p: ({ children }) => <p>{children}</p>,
          h1: ({ children }) => <p className="mt-1 text-base font-bold">{children}</p>,
          h2: ({ children }) => <p className="mt-1 text-sm font-bold">{children}</p>,
          h3: ({ children }) => <p className="mt-1 text-sm font-semibold">{children}</p>,
          ul: ({ children }) => <ul className="list-disc space-y-1 pl-5">{children}</ul>,
          ol: ({ children }) => <ol className="list-decimal space-y-1 pl-5">{children}</ol>,
          li: ({ children }) => <li className="whitespace-normal">{children}</li>,
          a: ({ children, href }) => (
            <a href={href} target="_blank" rel="noopener noreferrer" className="text-indigo-600 underline hover:no-underline">
              {children}
            </a>
          ),
          strong: ({ children }) => <strong className="font-semibold">{children}</strong>,
          blockquote: ({ children }) => (
            <blockquote className="border-l-2 border-gray-300 pl-3 text-gray-600">{children}</blockquote>
          ),
          table: ({ children }) => (
            <span className="block overflow-x-auto">
              <table className="my-1 border-collapse text-xs">{children}</table>
            </span>
          ),
          th: ({ children }) => <th className="border border-gray-300 px-2 py-1 text-left font-semibold">{children}</th>,
          td: ({ children }) => <td className="border border-gray-200 px-2 py-1">{children}</td>,
          code: ({ className, children }) => {
            const isBlock = /language-/.test(className || '');
            const value = String(children).replace(/\n$/, '');
            if (isBlock) return <CodeBlock text={value} />;
            return <code className="rounded bg-gray-100 px-1 py-0.5 font-mono text-[0.85em] text-indigo-700">{children}</code>;
          },
          // The `code` renderer above already wraps block code in its own
          // container, so collapse the surrounding <pre> to avoid double boxes.
          pre: ({ children }) => <>{children}</>,
        }}
      >
        {text}
      </ReactMarkdown>
    </div>
  );
}
