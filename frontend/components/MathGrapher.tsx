'use client';

import { useEffect, useRef } from 'react';
import { compile, type EvalFunction } from 'mathjs';

// Lightweight function plotter. Renders each expression (a function of x) onto a
// square canvas over the window x,y ∈ [-10, 10]. Uses mathjs to compile/evaluate
// — no charting dependency. Invalid expressions are skipped silently.

const COLORS = ['#818cf8', '#f472b6', '#34d399', '#fbbf24', '#22d3ee'];
const D = 10; // half-window: domain & range are [-D, D]

export default function MathGrapher({ expressions }: { expressions: string[] }) {
  const canvasRef = useRef<HTMLCanvasElement>(null);
  const wrapRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    const canvas = canvasRef.current;
    const wrap = wrapRef.current;
    if (!canvas || !wrap) return;

    function draw() {
      if (!canvas || !wrap) return;
      const avail = wrap.getBoundingClientRect().width || 320;
      const size = Math.max(220, Math.min(avail, 460));
      const dpr = window.devicePixelRatio || 1;
      canvas.width = size * dpr;
      canvas.height = size * dpr;
      canvas.style.width = `${size}px`;
      canvas.style.height = `${size}px`;
      const ctx = canvas.getContext('2d');
      if (!ctx) return;
      ctx.setTransform(dpr, 0, 0, dpr, 0, 0);
      ctx.clearRect(0, 0, size, size);

      const px = (x: number) => ((x + D) / (2 * D)) * size;
      const py = (y: number) => size - ((y + D) / (2 * D)) * size;

      // Grid
      ctx.lineWidth = 1;
      ctx.strokeStyle = '#1f2937';
      for (let i = -D; i <= D; i++) {
        ctx.beginPath(); ctx.moveTo(px(i), 0); ctx.lineTo(px(i), size); ctx.stroke();
        ctx.beginPath(); ctx.moveTo(0, py(i)); ctx.lineTo(size, py(i)); ctx.stroke();
      }
      // Axes
      ctx.lineWidth = 1.5;
      ctx.strokeStyle = '#6b7280';
      ctx.beginPath(); ctx.moveTo(0, py(0)); ctx.lineTo(size, py(0)); ctx.stroke();
      ctx.beginPath(); ctx.moveTo(px(0), 0); ctx.lineTo(px(0), size); ctx.stroke();
      // Tick labels (every 2 units)
      ctx.fillStyle = '#9ca3af';
      ctx.font = '10px sans-serif';
      for (let i = -D; i <= D; i += 2) {
        if (i === 0) continue;
        ctx.fillText(String(i), px(i) + 1, py(0) - 2);
        ctx.fillText(String(i), px(0) + 3, py(i) - 1);
      }

      // Plot
      expressions.forEach((expr, idx) => {
        let code: EvalFunction;
        try { code = compile(expr); } catch { return; }
        ctx.lineWidth = 2;
        ctx.strokeStyle = COLORS[idx % COLORS.length];
        ctx.beginPath();
        let drawing = false;
        let prevY = NaN;
        for (let s = 0; s <= size; s++) {
          const x = -D + (2 * D) * (s / size);
          let y: number;
          try { y = code.evaluate({ x }); } catch { drawing = false; continue; }
          if (typeof y !== 'number' || !Number.isFinite(y)) { drawing = false; continue; }
          if (drawing && Math.abs(y - prevY) > 4 * D) drawing = false; // skip asymptotes
          if (!drawing) { ctx.moveTo(px(x), py(y)); drawing = true; }
          else ctx.lineTo(px(x), py(y));
          prevY = y;
        }
        ctx.stroke();
      });
    }

    draw();
    const ro = new ResizeObserver(draw);
    ro.observe(wrap);
    return () => ro.disconnect();
  }, [expressions]);

  return (
    <div ref={wrapRef} className="flex w-full justify-center">
      <canvas ref={canvasRef} className="rounded-md border border-gray-700 bg-gray-950" />
    </div>
  );
}
