# ✅ Completed So Far

> Last updated: 2026-06-01

This document tracks everything that has been implemented and verified in The AI Academy project.

---

## 1. Infrastructure

- **Docker Compose** — PostgreSQL 16 and Redis 7 services defined
- Shared `cityconnect-*` compose stack running on host ports 5432 (Postgres) and 6379 (Redis)
- Database: `mentorai` with `postgres:postgres` credentials

## 2. Database (7 migrations, 11 tables)

| Migration | Description |
|-----------|-------------|
| 001 | Core schema: users, learner_profiles, modules, concepts, module_mastery, sessions, messages, questions, quiz_attempts |
| 002 | Seed 8 Python modules with titles, descriptions, and estimated hours |
| 003 | Seed concepts (27) and questions (63) for all Python modules |
| 004 | Multi-subject support: subjects table, module→subject FK, learner active_subject_id |
| 005 | Seed Mathematics subject (Python modules backfilled to subject_id=1) |
| 006 | Add `code` column to quiz_attempts for storing submitted code |
| 007 | Seed 8 Mathematics modules, 32 concepts, and 80 questions |

### Table Counts

| Table | Rows |
|-------|------|
| subjects | 2 (Python Development, Mathematics) |
| modules | 16 (8 Python + 8 Math) |
| concepts | 59 |
| questions | 143 |

## 3. Backend (Express + TypeScript)

**29 API endpoints** across 8 route files, zero TypeScript compilation errors.

### Routes

| Router | Endpoints | Description |
|--------|-----------|-------------|
| auth | `POST /sync`, `GET /me` | Sync Supabase user to backend DB, get profile |
| path | `GET /` | Learning path filtered by active subject |
| subjects | `GET /`, `GET /:id`, `POST /switch` | List subjects, get details, switch active |
| tutor | `POST /session`, `POST /chat` (SSE), `GET /session/:id/messages`, `POST /code-feedback`, `POST /feedback`, `POST /hint`, `POST /solution` | AI tutoring with Claude, streaming responses |
| assessments | `GET /:moduleId/questions`, `POST /:moduleId/complete`, `POST /submit`, `GET /:moduleId/mastery` | Assessment flow with mastery scoring |
| sessions | `GET /recent`, `POST /:id/close` | Session management |
| progress | `GET /summary`, `GET /weekly-email-content` | Progress analytics |
| billing | `GET /status`, `POST /checkout`, `POST /portal`, `POST /webhook` | **Stubbed** — returns 503 |
| models | `GET /`, `POST /select` | List available AI models + persist the learner's choice |

### Middleware

- **requireAuth** — Validates Supabase JWT via `supabaseAdmin.auth.getUser(token)`
- **enforceFreeLimit** — Blocks free-tier users after 5 tutor sessions
- **rateLimit** — General (100/15min), auth, tutor, assessment rate limiters
- **validate** — Request body validation helpers

### Services

- **mastery.ts** — Computes weighted mastery score (40% final assessment, 30% coding unaided, 20% explanation, 10% in-session). 80% threshold unlocks next module.
- **adaptation.ts** — Records user messages, wrong/correct answers, tracks streak days, sets current concept
- **llm.ts** — Unified multi-provider AI layer. One interface (`createChat`, `streamChat`) over **Anthropic Claude**, **DeepSeek**, and **Google Gemini** (the latter two via their OpenAI-compatible APIs using the `openai` SDK). Model registry with per-provider availability based on configured API keys; resolves unknown/unconfigured selections back to the default (Claude Sonnet). All AI calls — tutor chat (SSE), code feedback, hints, solutions, answer evaluation, session summaries, weekly email — route through it and honour the learner's selected model.

### Model Selection

- Learner picks the AI model from a dropdown in the tutor header (`ModelSelector` component).
- Choice persists to `learner_profiles.preferred_model` (migration 008) via `POST /api/models/select`.
- Models whose provider key isn't set on the server show as `(not configured)` and are disabled.
- Requires `DEEPSEEK_API_KEY` / `GEMINI_API_KEY` in `backend/.env` to enable those providers (Anthropic remains the default).

## 4. Frontend (Next.js + TypeScript + Tailwind)

**9 pages**, zero TypeScript compilation errors.

| Page | Route | Description |
|------|-------|-------------|
| Landing | `/` | Marketing homepage |
| Login | `/auth/login` | Supabase email/password login |
| Signup | `/auth/signup` | Supabase email/password signup |
| Auth callback | `/auth/callback` | Exchanges Supabase auth code for session |
| Onboarding | `/onboarding` | Collects name, goal, experience, starting module |
| Dashboard | `/dashboard` | Learning path, stats, subject selector, module cards |
| Tutor chat | `/learn/[moduleSlug]` | Real-time chat with AI tutor (SSE streaming) |
| Assessment | `/learn/[moduleSlug]/assessment` | Multiple choice, short answer, explanation questions |
| Code editor | `/learn/[moduleSlug]/code` | Pyodide in-browser Python execution with AI feedback |
| Upgrade | `/upgrade` | Pricing page (billing stubbed) |

### Key Libraries

- **Pyodide** — In-browser Python 3.x runtime for code execution
- **PostHog** — Analytics provider (lazy-loaded, error-boundary protected)
- **Supabase Client** — Browser and server-side Supabase auth helpers

## 5. Authentication Flow

1. User signs up/logs in via Supabase (email/password or Google)
2. Supabase returns JWT access token to frontend
3. Frontend calls `POST /api/auth/sync` with the token
4. Backend validates token via Supabase admin client
5. Backend creates/updates user record and learner profile with default active subject
6. All subsequent API calls include `Authorization: Bearer <token>`
7. Dashboard syncs on every page load (`INITIAL_SESSION` event)

## 6. Multi-Subject System

### Python Development (subject_id=1)
- 8 modules: Fundamentals → Control Flow → Functions → Data Structures → OOP → File Handling → APIs → Capstone
- 27 concepts, 63 questions
- practice_kind: `code` (Pyodide editor)

### Mathematics (subject_id=2)
- 8 modules: Numbers & Operations → Algebra → Linear Equations → Polynomials → Quadratics → Functions → Geometry/Trig → Statistics
- 32 concepts, 80 questions
- practice_kind: `problem` (math workspace)

### Subject Switching
- Dropdown selector in dashboard nav (shown only when multiple subjects exist)
- `POST /api/subjects/switch` updates `active_subject_id` in learner_profiles
- `/api/path` filters modules by active subject

## 7. Mastery Loop (End-to-End)

```
Tutor Chat → Assessment → Compute Mastery → If ≥80% → Unlock Next Module
     ↑                                                        │
     └────────────────────────────────────────────────────────┘
```

1. Learner chats with AI tutor, completing concept explanations
2. Learner takes assessment (multiple choice + short answer + explanation)
3. Backend calls `POST /api/assessments/:moduleId/complete`
4. `saveMasteryAndGate()` computes weighted score, stores in module_mastery
5. If score ≥ 80%, next module's `unlocked` flag is set to true
6. Dashboard refreshes showing the newly unlocked module

## 8. Fixes Applied During Development

| Issue | Fix |
|-------|-----|
| Backend TS error: `nextModuleSlug` not in return type | Updated `saveMasteryAndGate` return type to include `nextModuleSlug: string \| null` |
| Supabase URL placeholder in backend .env | Updated to real project URL `yjtvsmmixcgyrjrzkjnm.supabase.co` |
| Supabase service role key placeholder | Updated with real service role key |
| Auth sync not setting `active_subject_id` | Updated `POST /api/auth/sync` to assign default subject on user creation |
| Dashboard empty (0 modules) | Added sync call in dashboard `load()` function and `INITIAL_SESSION` event in `useAuth.ts` |
| `LearningPath` type missing `subject` field | Added `Subject` interface and field to `LearningPath` type in `types.ts` |
| Dashboard duplicate `Subject` interface | Consolidated into shared `types.ts` |

## 9. What's NOT Done (By Design)

| Feature | Status | Notes |
|---------|--------|-------|
| Stripe billing | Stubbed (503) | All billing routes return placeholder. Add real Stripe keys to enable. |
| PostHog analytics | Placeholder key | Replace `POSTHOG_API_KEY` in .env with real key to track events |
| Math practice UI | No dedicated workspace | Math questions display in the same assessment UI as Python |
| Spaced repetition | Not implemented | Could add review scheduling for forgotten concepts |
| Mobile responsive | Partial | Tailwind responsive classes used, not fully tested on mobile |

## 10. Running the Project

```bash
# Backend (port 4000)
cd backend && npm run dev

# Frontend (port 3000)
cd frontend && npm run dev
```

Open http://localhost:3000 in your browser.