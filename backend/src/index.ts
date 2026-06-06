import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import { PostHog } from 'posthog-node';
import { connectRedis } from './db/redis';
import { generalLimiter, authLimiter, tutorLimiter, assessmentLimiter } from './middleware/rateLimit';

dotenv.config();

export const posthog = new PostHog(process.env.POSTHOG_API_KEY || 'phc_placeholder', {
  host: process.env.POSTHOG_HOST || 'https://app.posthog.com',
});

const app = express();
const PORT = process.env.PORT || 4000;

app.use(cors({ origin: process.env.FRONTEND_URL || 'http://localhost:3000', credentials: true }));

// Raw body for Stripe webhook — must be before express.json()
app.use('/api/billing/webhook', express.raw({ type: 'application/json' }));

// Voice STT uploads base64 audio — needs a larger body limit than the default.
// Mounting it before the global parser makes only /api/voice use the big limit.
app.use('/api/voice', express.json({ limit: '20mb' }));

app.use(express.json());

connectRedis().catch(console.error);

// Health check (no rate limit)
app.get('/health', (_req, res) => res.json({ status: 'ok' }));

// ─── Global rate limiter for all /api routes ───────────────────────────────────
app.use('/api', generalLimiter);

// ─── Route-specific limiters ───────────────────────────────────────────────────
// Each route group gets its own limiter that stacks on top of the general limit.
// This means a single client is limited by BOTH the general 100/15min AND the
// specific per-route limit (stricter of the two wins).

import authRouter from './routes/auth';
import pathRouter from './routes/path';
import tutorRouter from './routes/tutor';
import sessionsRouter from './routes/sessions';
import assessmentsRouter from './routes/assessments';
import progressRouter from './routes/progress';
import billingRouter from './routes/billing';
import subjectsRouter from './routes/subjects';
import modelsRouter from './routes/models';
import voiceRouter from './routes/voice';
import projectsRouter from './routes/projects';
import reviewRouter from './routes/review';
import profileRouter from './routes/profile';
import feedbackRouter from './routes/feedback';
import adminRouter from './routes/admin';
import adminAnalyticsRouter from './routes/adminAnalytics';
import adminContentRouter from './routes/adminContent';
import adminUsersRouter from './routes/adminUsers';
import adminSettingsRouter from './routes/adminSettings';
import notificationsRouter from './routes/notifications';

app.use('/api/auth', authLimiter, authRouter);
app.use('/api/path', pathRouter);
app.use('/api/tutor', tutorLimiter, tutorRouter);
app.use('/api/sessions', sessionsRouter);
app.use('/api/assessments', assessmentLimiter, assessmentsRouter);
app.use('/api/progress', progressRouter);
app.use('/api/billing', billingRouter);
app.use('/api/subjects', subjectsRouter);
app.use('/api/models', modelsRouter);
app.use('/api/voice', voiceRouter);
app.use('/api/projects', projectsRouter);
app.use('/api/review', reviewRouter);
app.use('/api/profile', profileRouter);
app.use('/api/feedback', feedbackRouter);
app.use('/api/admin', adminRouter); // multer handles multipart on /books; other routes parse JSON
app.use('/api/admin', adminAnalyticsRouter);
app.use('/api/admin', adminContentRouter);
app.use('/api/admin', adminUsersRouter);
app.use('/api/admin', adminSettingsRouter);
app.use('/api/admin', notificationsRouter);

app.listen(PORT, () => console.log(`MentorAI backend running on port ${PORT}`));

// ─── PostHog graceful shutdown ──────────────────────────────────────────────
process.on('SIGTERM', async () => { await posthog.shutdown(); });
process.on('SIGINT', async () => { await posthog.shutdown(); });

export default app;
