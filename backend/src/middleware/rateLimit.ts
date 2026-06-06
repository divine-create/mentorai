import rateLimit from 'express-rate-limit';
import type { Request, Response } from 'express';

// In local dev/testing the whole app shares one IP (localhost) and React
// StrictMode double-mounts every page, so per-IP limits are exhausted almost
// immediately and block normal use. Skip the general/tutor limiters outside
// production; the auth limiter (brute-force protection) stays on everywhere.
const skipOutsideProd = () => process.env.NODE_ENV !== 'production';

/**
 * Shared handler that sends a standard 429 JSON response
 * with the retry-after timestamp included.
 */
function rateLimitExceededHandler(_req: Request, res: Response) {
  const retryAfter = Math.ceil(
    (res.getHeaders()['retry-after'] as number | undefined) ?? 60,
  );
  res.status(429).json({
    error: 'rate_limit_exceeded',
    message: 'Too many requests. Please slow down.',
    retryAfter, // seconds to wait before retrying
  });
}

// ─── General API limiter ──────────────────────────────────────────────────────
// Applied globally to all /api routes.
export const generalLimiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100,
  standardHeaders: true, // Return rate limit info in the `RateLimit-*` headers
  legacyHeaders: false,  // Disable the `X-RateLimit-*` headers
  handler: rateLimitExceededHandler,
  skip: skipOutsideProd,
});

// ─── Auth limiter ─────────────────────────────────────────────────────────────
// More restrictive — login/signup endpoints should be protected against brute
// force and credential stuffing.
export const authLimiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 20,
  standardHeaders: true,
  legacyHeaders: false,
  handler: rateLimitExceededHandler,
});

// ─── Tutor limiter ────────────────────────────────────────────────────────────
// AI-powered chat is expensive; keep this low.
export const tutorLimiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 30,
  standardHeaders: true,
  legacyHeaders: false,
  handler: rateLimitExceededHandler,
  skip: skipOutsideProd,
});

// ─── Assessment limiter ───────────────────────────────────────────────────────
// Assessment submission — moderate limit.
export const assessmentLimiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 60,
  standardHeaders: true,
  legacyHeaders: false,
  handler: rateLimitExceededHandler,
});
