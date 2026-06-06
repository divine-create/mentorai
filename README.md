# 🤖 The AI Academy (MentorAI)

**Learn anything with your AI tutor.**

> Mastery-based learning powered by Anthropic Claude. Start with Python — more subjects coming soon.

---

## 📖 Overview

The AI Academy is an AI-powered tutoring platform that replaces passive video courses with a one-on-one conversational tutor. It guides learners through structured modules using mastery-based progression: you don't advance until you genuinely understand each concept. The platform currently ships with eight Python modules (from Fundamentals through to a Capstone Project), with more subjects on the roadmap.

The core loop is simple: learners interact with an AI tutor in real-time chat, write and run Python code in a live browser-based coding environment, answer adaptive assessments, and unlock subsequent modules only after proving competency. The system tracks every interaction — quiz attempts, hint usage, session time, streak days — to compute a weighted mastery score and personalise the learning path.

The project is structured as a **monorepo** with two workspaces: a Next.js 16 frontend and an Express 5 backend, sharing PostgreSQL via `pg`, Redis for real-time adaptation state, Supabase for authentication, Anthropic Claude for tutoring, Stripe for subscriptions, and PostHog for product analytics.

---

## 🧱 Architecture

```
┌─────────────┐     ┌───────────────────┐     ┌──────────────┐
│  Next.js 16 │────▶│  Express 5 API    │────▶│  PostgreSQL  │
│  React 19   │     │  TypeScript       │     │  (pg pool)   │
│  Tailwind 4 │     │  Anthropic Claude │     └──────────────┘
└─────────────┘     │  Supabase Admin   │     ┌──────────────┐
       │            │  Stripe            │────▶│  Redis       │
       │            │  PostHog          │     └──────────────┘
       ▼            └───────────────────┘
┌─────────────┐
│  Pyodide    │  (browser-based Python runner — planned)
└─────────────┘
---

## ✅ Prerequisites

- **Node.js** ≥ 18 (workspaces support required)
- **PostgreSQL** ≥ 14
- **Redis** ≥ 6
- **npm** ≥ 9 (or equivalent package manager)
- **Docker** (optional — useful for spinning up local PostgreSQL and Redis)

---

## 🚀 Quick Start

### 1. Clone the repository

```bash
git clone https://github.com/your-org/ai-academy.git
cd ai-academy
```

### 2. Configure environment variables

Copy the example env files and fill in real values:

```bash
# Backend
cp backend/.env.example backend/.env

# Frontend
cp frontend/.env.example frontend/.env
```

### 3. Set required credentials

Update both `.env` files with working credentials. See the [Environment Variables](#-environment-variables) table below for details.

| Service     | Where to get it                                        |
|-------------|--------------------------------------------------------|
| Supabase    | [supabase.com](https://supabase.com) — project settings |
| Anthropic   | [console.anthropic.com](https://console.anthropic.com)  |
| Stripe      | [dashboard.stripe.com](https://dashboard.stripe.com)    |
| PostHog     | [app.posthog.com](https://app.posthog.com)               |

### 4. Start local infrastructure (Postgres + Redis)

The simplest path is the bundled `docker-compose.yml`:

```bash
docker compose up -d
```

This starts PostgreSQL 16 on `localhost:5432` and Redis 7 on `localhost:6379`. If you already have these running elsewhere, edit `backend/.env` to point at them.

### 5. Install dependencies

```bash
npm install
```

This installs dependencies for both `frontend/` and `backend/` workspaces (via npm workspaces).

### 6. Run database migrations

```bash
cd backend && npm run migrate && cd ..
```

This command applies all `.sql` migration files in `backend/src/db/migrations/` in order:

- **001_initial_schema.sql** — Creates all tables (`users`, `modules`, `concepts`, `learner_profiles`, `module_mastery`, `sessions`, `messages`, `questions`, `quiz_attempts`) plus indexes and the `updated_at` trigger.
- **002_seed_modules.sql** — Seeds 8 Python modules (Fundamentals → Capstone).
- **003_seed_concepts_and_questions.sql** — Seeds concepts and 60+ questions across all modules (multiple-choice, short-answer, coding, explanation).
- **004_subjects.sql** — Adds the `subjects` table, scopes modules to a subject, sets the learner's active subject, and introduces the `math_problem` question type.
- **005_seed_math_subject.sql** — Seeds a `mathematics` subject (`is_available = true`, no modules yet).

Migrations are tracked in a `_migrations` table and only run once.

### 7. Start development servers

```bash
npm run dev
```

This uses `concurrently` to start both servers:

| Service  | URL                          |
|----------|------------------------------|
| Frontend | http://localhost:3000        |
| Backend  | http://localhost:4000        |
| Health   | http://localhost:4000/health |

---

## 🔐 Environment Variables

### Backend (`backend/.env`)

| Variable                     | Purpose                                    | Example                                      |
|------------------------------|--------------------------------------------|----------------------------------------------|
| `PORT`                       | Backend server port                        | `4000`                                       |
| `FRONTEND_URL`               | Allowed CORS origin                        | `http://localhost:3000`                       |
| `DATABASE_URL`               | PostgreSQL connection string               | `postgresql://user:pass@localhost:5432/mentorai` |
| `REDIS_URL`                  | Redis connection string                    | `redis://localhost:6379`                      |
| `SUPABASE_URL`               | Supabase project URL                       | `https://your-project.supabase.co`            |
| `SUPABASE_SERVICE_ROLE_KEY`  | Supabase service role (admin bypass)       | `eyJhbGciOiJIUzI1NiIs...`                     |
| `ANTHROPIC_API_KEY`          | Anthropic Claude API key                   | `sk-ant-api03-...`                            |
| `STRIPE_SECRET_KEY`          | Stripe secret key                          | `sk_test_...`                                 |
| `STRIPE_WEBHOOK_SECRET`      | Stripe webhook signing secret              | `whsec_...`                                   |
| `STRIPE_PRICE_PRO_MONTHLY`   | Stripe price ID for Pro monthly            | `price_1Qz...`                                |
| `STRIPE_PRICE_PRO_ANNUAL`    | Stripe price ID for Pro annual             | `price_1Qz...`                                |
| `POSTHOG_API_KEY`            | PostHog project API key (server-side)      | `phc_...`                                     |

### Frontend (`frontend/.env`)

| Variable                         | Purpose                                    | Example                              |
|----------------------------------|--------------------------------------------|--------------------------------------|
| `NEXT_PUBLIC_SUPABASE_URL`       | Supabase project URL (public)              | `https://your-project.supabase.co`    |
| `NEXT_PUBLIC_SUPABASE_ANON_KEY`  | Supabase anon/public key                   | `eyJhbGciOiJIUzI1NiIs...`             |
| `NEXT_PUBLIC_API_URL`            | Backend API base URL                       | `http://localhost:4000`               |
| `NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY` | Stripe publishable key (public)        | `pk_test_...`                         |
| `NEXT_PUBLIC_POSTHOG_KEY`        | PostHog client-side API key                | `phc_...`                             |
| `NEXT_PUBLIC_POSTHOG_HOST`       | PostHog ingestion host                     | `https://app.posthog.com`             |

---

## 📁 Project Structure

```
mentorai/
├── package.json              # Root workspace config (npm workspaces)
├── frontend/
│   ├── .env.example          # Frontend env template
│   ├── package.json          # Next.js 16, React 19, Tailwind 4
│   ├── next.config.ts        # Next.js configuration
│   ├── middleware.ts          # Auth middleware (Supabase SSR)
│   ├── tsconfig.json
│   ├── app/
│   │   ├── layout.tsx        # Root layout with Geist fonts + ErrorBoundary
│   │   ├── page.tsx          # Landing page (hero, features, pricing)
│   │   ├── globals.css       # Tailwind CSS 4 entry point
│   │   ├── auth/
│   │   │   ├── login/        # Login page (email + Google OAuth)
│   │   │   ├── signup/       # Signup page
│   │   │   └── callback/     # OAuth callback handler
│   │   ├── dashboard/        # Learner dashboard (path, stats, modules)
│   │   ├── onboarding/       # Multi-step onboarding (goal → diagnostic → account)
│   │   ├── learn/
│   │   │   └── [moduleSlug]/ # Tutor chat page per module
│   │   └── upgrade/          # Pro/Annual subscription page
│   ├── components/
│   │   └── ErrorBoundary.tsx # React error boundary wrapper
│   └── lib/
│       ├── types.ts          # Shared TypeScript types (Module, LearnerProfile)
│       ├── supabase/
│       │   ├── client.ts     # Supabase browser client
│       │   └── server.ts     # Supabase server client
│       └── hooks/
│           ├── useAuth.ts    # Auth state hook + auto-sync to backend
│           └── useLearningPath.ts  # Learning path data hook
│
├── backend/
│   ├── .env.example          # Backend env template
│   ├── package.json          # Express 5, pg, redis, stripe, anthropic-sdk
│   ├── tsconfig.json
│   └── src/
│       ├── index.ts          # Express app entry, route mounting, CORS
│       ├── db/
│       │   ├── pool.ts       # PostgreSQL Pool (pg)
│       │   ├── redis.ts      # Redis client (createClient)
│       │   ├── supabase.ts   # Supabase admin client (service role)
│       │   ├── migrate.ts    # Migration runner (reads .sql files)
│       │   └── migrations/
│       │       ├── 001_initial_schema.sql
│       │       ├── 002_seed_modules.sql
│       │       └── 003_seed_concepts_and_questions.sql
│       ├── middleware/
│       │   ├── auth.ts       # requireAuth — verifies Supabase JWT
│       │   ├── tier.ts       # enforceFreeLimit — 5-session free tier cap
│       │   └── validate.ts   # Request validation helpers
│       ├── services/
│       │   ├── mastery.ts    # Mastery computation engine + module gating
│       │   └── adaptation.ts # Real-time adaptation state (Redis-backed)
│       └── routes/
│           ├── auth.ts       # /api/auth — user sync & profile
│           ├── path.ts       # /api/path — learning path & modules
│           ├── tutor.ts      # /api/tutor — chat, sessions, hints, code feedback
│           ├── sessions.ts   # /api/sessions — close & summarise sessions
│           ├── assessments.ts # /api/assessments — questions, submissions, mastery
│           ├── progress.ts   # /api/progress — learner stats & weekly email
│           └── billing.ts    # /api/billing — Stripe checkout, portal, webhooks
```

---

## 🗄️ Database Migrations

The migration system is a simple file-based runner (`backend/src/db/migrate.ts`) that:

1. Creates a `_migrations` tracking table if it doesn't exist
2. Reads all `.sql` files from `backend/src/db/migrations/` sorted alphabetically
3. Applies each unapplied migration inside a transaction
4. Records the filename in `_migrations` on success

### Running migrations

```bash
cd backend
npm run migrate
```

### Migration files

| File                                      | Purpose                                                                 |
|-------------------------------------------|-------------------------------------------------------------------------|
| `001_initial_schema.sql`                  | Creates all 9 tables: `users`, `modules`, `concepts`, `learner_profiles`, `module_mastery`, `sessions`, `messages`, `questions`, `quiz_attempts`. Adds indexes and `updated_at` auto-trigger. |
| `002_seed_modules.sql`                    | Seeds 8 Python modules (order_index 1–8): Python Fundamentals, Control Flow, Functions, Data Structures, OOP, File Handling & Exceptions, Working with APIs, Capstone Project. |
| `003_seed_concepts_and_questions.sql`    | Seeds 27 concepts across all modules and 60+ questions of types `multiple_choice`, `short_answer`, `coding`, and `explanation` at `foundational`, `applied`, and `advanced` difficulty levels. |

---

## 🌐 API Overview

All API routes (except Stripe webhooks) require a `Bearer` token from Supabase Auth, verified via the `requireAuth` middleware calling `supabase.auth.getUser()`.

### Auth — `/api/auth`

| Method | Endpoint          | Purpose                                               |
|--------|-------------------|-------------------------------------------------------|
| POST   | `/api/auth/sync`  | Create or update user row + learner_profile after sign-in. Unlocks module 1. Accepts `email`, `name`, `goal`, `experience`, `startingModule`. |
| GET    | `/api/auth/me`    | Return current user profile (email, name, subscription status, goal, current module, mastery, streak). |

### Learning Path — `/api/path`

| Method | Endpoint   | Purpose                                                                 |
|--------|------------|-------------------------------------------------------------------------|
| GET    | `/api/path` | Returns all 8 modules joined with the learner's mastery score, attempts, unlock state, plus the learner profile. |

### Tutor — `/api/tutor`

| Method | Endpoint                            | Purpose                                                                 |
|--------|-------------------------------------|-------------------------------------------------------------------------|
| POST   | `/api/tutor/session`                | Create a new tutoring session for a module. Enforces free-tier limit (5 sessions). Returns `sessionId`. |
| POST   | `/api/tutor/chat`                   | Stream an AI tutor response via SSE. Sends message + history to Claude with a personalised system prompt (learner context, goal, mastery, streak, session summary, gap detection). |
| GET    | `/api/tutor/session/:id/messages`   | Fetch all messages for a session (ordered by `created_at`). |
| POST   | `/api/tutor/code-feedback`          | Submit Python code + output for AI analysis. Detects errors or provides improvement suggestions. |
| POST   | `/api/tutor/hint`                   | Request a progressive hint (1 of 3) for a coding problem. Hints range from subtle to almost-explicit. |
| POST   | `/api/tutor/solution`               | Request the full solution code after all hints are exhausted. |
| POST   | `/api/tutor/feedback`               | Report a correct/wrong answer outcome. Triggers adaptation state updates. |

### Sessions — `/api/sessions`

| Method | Endpoint                     | Purpose                                                                 |
|--------|------------------------------|-------------------------------------------------------------------------|
| POST   | `/api/sessions/:id/close`    | Close a session: generates an AI summary via Claude, persists `summary_text`, updates `ended_at`, recalculates streak. |
| GET    | `/api/sessions/recent`       | Return the most recent closed session summary (used in tutor system prompt for continuity). |

### Assessments — `/api/assessments`

| Method | Endpoint                                | Purpose                                                                 |
|--------|-----------------------------------------|-------------------------------------------------------------------------|
| GET    | `/api/assessments/:moduleId/questions`  | Return all questions for a module, ordered by difficulty (foundational → applied → advanced). Correct answers/test cases omitted client-side. |
| POST   | `/api/assessments/submit`              | Submit an answer to a question. Multiple-choice is exact-matched; short-answer and explanation are AI-evaluated via Claude; coding uses `"passed"` flag. Returns `{ correct, feedback, nextDifficulty, needsTutor }`. |
| GET    | `/api/assessments/:moduleId/mastery`   | Compute and return the weighted mastery breakdown for a module. |
| POST   | `/api/assessments/:moduleId/complete`  | Finalise module mastery: persists score, updates overall mastery average, gates next module if score ≥ 80%. |

### Progress — `/api/progress`

| Method | Endpoint                              | Purpose                                                                 |
|--------|---------------------------------------|-------------------------------------------------------------------------|
| GET    | `/api/progress/summary`               | Return streak, overall mastery, weekly session count/minutes, per-module mastery, streak-at-risk flag, and a personalised notification message. |
| GET    | `/api/progress/weekly-email-content`  | Generate a warm AI-written weekly summary (intended for cron-driven email). |

### Billing — `/api/billing`

| Method | Endpoint                    | Purpose                                                                 |
|--------|-----------------------------|-------------------------------------------------------------------------|
| POST   | `/api/billing/checkout`     | Create a Stripe Checkout session for Pro monthly or annual. Creates a Stripe customer if new. |
| POST   | `/api/billing/portal`       | Redirect to the Stripe Customer Portal for subscription management. |
| GET    | `/api/billing/status`       | Return current subscription status (`free`, `pro`, `annual`, `cancelled`). |
| POST   | `/api/billing/webhook`      | Stripe webhook handler (raw body). Handles `checkout.session.completed`, `customer.subscription.deleted`, and `customer.subscription.updated`. |

---

## ✨ Key Features

- **🤖 AI Tutor** — Conversational one-on-one tutoring powered by Anthropic Claude. Teaches concepts, asks comprehension questions, and adapts in real-time.
- **⚡ Live Coding (Pyodide)** — Browser-based Python execution environment with AI-powered code feedback, hints, and solution reveal (planned).
- **🧠 Adaptation Engine** — Redis-backed real-time state tracking per session detects vague answers, fast responses, long pauses, and consecutive failures to adjust tutor behaviour dynamically.
- **📈 Mastery-Based Progression** — Weighted composite score (40% final assessment, 30% coding unaided, 20% explanation quality, 10% in-session comprehension). Modules gate at 80%.
- **🔒 Mastery Gating** — Unlock next module only after passing the current one. No skipping ahead.
- **📊 Learner Dashboard** — Streak tracking, weekly session count, per-module mastery bars, personalised notifications ("Your streak is at risk!").
- **🎯 Personalised Onboarding** — Multi-step flow captures goal, experience level, and a 5-question diagnostic to place learners at the right starting module.
- **📝 Adaptive Assessments** — Questions scale from foundational → applied → advanced. Two consecutive wrong answers trigger tutor intervention.
- **💬 SSE Streaming** — AI tutor responses stream token-by-token via Server-Sent Events for a real-time chat experience.
- **🔄 Session Continuity** — AI system prompt includes last session summary and detects 7+ day gaps to trigger review.
- **💰 Tiered Pricing** — Free tier (5 sessions), Pro ($29/mo), Annual ($199/yr) with Stripe Checkout, Customer Portal, and webhook sync.

---

## 💵 Pricing

| Plan      | Price   | Features                                                                 |
|-----------|---------|--------------------------------------------------------------------------|
| **Free**  | $0      | 5 tutor sessions · Module 1 access · Coding environment · Basic progress |
| **Pro**   | $29/mo  | Unlimited sessions · All 8 modules · Full analytics · 90-day memory · Certificate of mastery |
| **Annual**| $199/yr | Everything in Pro · Unlimited memory · Save 43% vs monthly               |

---

## 🧪 Testing

Not yet implemented. Tests will be added in a future iteration. The project currently relies on manual QA via `npm run dev`.

---

## 📄 License

ISC — see the project root for details.

