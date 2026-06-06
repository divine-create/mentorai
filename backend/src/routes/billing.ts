import { Router } from 'express';

// ─── Stripe billing is temporarily disabled ────────────────────────────────────
//
// The Stripe SDK v22 ships its TypeScript types only in its `exports` map,
// which the project's current `module: "commonjs"` + default
// `moduleResolution: "node"` cannot resolve. Until we move to `node16`
// resolution (or pin an older Stripe with top-level `types`) the original
// route handlers in this file are commented out below. All endpoints are
// stubbed with 503 so the frontend's /upgrade page receives a clean
// response instead of a network error.
//
// To re-enable:
//   1. Switch backend/tsconfig.json to "module": "node16" +
//      "moduleResolution": "node16".
//   2. Add `.js` extensions to all relative imports in this file.
//   3. Uncomment the original handler bodies below.

const router = Router();

router.post('/checkout', (_req, res) => {
  res.status(503).json({ error: 'billing_disabled', message: 'Stripe billing is not enabled in this build.' });
});

router.post('/portal', (_req, res) => {
  res.status(503).json({ error: 'billing_disabled', message: 'Stripe billing is not enabled in this build.' });
});

router.get('/status', (_req, res) => {
  res.json({ status: 'free' });
});

router.post('/webhook', (_req, res) => {
  res.status(503).json({ error: 'billing_disabled' });
});

export default router;

/* ─── Original Stripe-backed implementation (disabled) ─────────────────────
import Stripe from 'stripe';
import { db } from '../db/pool';
import { requireAuth, AuthRequest } from '../middleware/auth';
import { requireFields, requireString, requireOneOf, sendValidationErrors } from '../middleware/validate';

const router = Router();
const stripe = new Stripe(process.env.STRIPE_SECRET_KEY!, { apiVersion: '2025-05-28.basil' });

const PRICES: Record<string, string> = {
  pro_monthly: process.env.STRIPE_PRICE_PRO_MONTHLY!,
  pro_annual:  process.env.STRIPE_PRICE_PRO_ANNUAL!,
};

// POST /api/billing/checkout — create Stripe checkout session
router.post('/checkout', requireAuth, async (req: AuthRequest, res) => {
  const { plan } = req.body as { plan: 'pro_monthly' | 'pro_annual' };
  // ... original handler body ...
});

// POST /api/billing/portal — customer portal for managing subscription
router.post('/portal', requireAuth, async (req: AuthRequest, res) => {
  // ... original handler body ...
});

// GET /api/billing/status
router.get('/status', requireAuth, async (req: AuthRequest, res) => {
  // ... original handler body ...
});

// POST /api/billing/webhook — Stripe webhook handler (raw body required)
router.post('/webhook', async (req: Request, res) => {
  // ... original handler body ...
});

export default router;
───────────────────────────────────────────────────────────────────────── */
