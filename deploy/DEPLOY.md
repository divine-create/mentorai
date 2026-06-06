# Deploying AI Academy to Google Cloud (Cloud Run)

Frontend + backend run as two **Cloud Run** services, built by **Cloud Build** on push to
GitHub, with **Supabase Postgres** + **Upstash Redis** and **Vertex AI via the backend's
attached service account** (no JSON key in prod). Repo scaffolding (`Dockerfile`s,
`cloudbuild.yaml`, `content-seed.sql`) is already in the repo.

Prereqs on your machine: `gcloud` (install: https://cloud.google.com/sdk/docs/install),
`gh` (logged in), `psql`. Then `gcloud auth login` and `gcloud config set project ai-academy-498412`.

---

## 1. Provision managed data services

**Supabase** (existing project — the one used for auth):
- Project Settings → Database → Connection string. Grab two forms:
  - **Pooled** (Transaction, port 6543) → use as `DATABASE_URL` for the running app.
  - **Direct** (port 5432) → use for the one-time content seed load in step 6.
- Settings → API: `Project URL` (`SUPABASE_URL` / `NEXT_PUBLIC_SUPABASE_URL`),
  `anon` key (`NEXT_PUBLIC_SUPABASE_ANON_KEY`), `service_role` key (`SUPABASE_SERVICE_ROLE_KEY`).

**Upstash** (https://upstash.com) → create a Redis database → copy the **`rediss://`** URL
as `REDIS_URL`. (Redis is best-effort; the app still runs if it's down.)

---

## 2. One-time GCP setup

Run the helper (edit the vars at the top first), or do the equivalent by hand:

```bash
bash deploy/gcp-setup.sh
```

It: enables APIs (run, cloudbuild, artifactregistry, secretmanager); creates the Artifact
Registry repo `app`; creates the runtime SA `mentorai-run@…` with `roles/aiplatform.user`
+ `roles/secretmanager.secretAccessor`; grants the Cloud Build SA
`roles/run.admin` + `roles/iam.serviceAccountUser` + `roles/artifactregistry.writer`
+ `roles/secretmanager.secretAccessor`; and creates the required secrets from your values.

---

## 3. Create the secrets (if not using the script)

Required (the runtime SA must be able to read each — the script grants that):
```bash
printf '%s' "$DATABASE_URL"                | gcloud secrets create DATABASE_URL --data-file=-
printf '%s' "$REDIS_URL"                   | gcloud secrets create REDIS_URL --data-file=-
printf '%s' "$SUPABASE_URL"                | gcloud secrets create SUPABASE_URL --data-file=-
printf '%s' "$SUPABASE_SERVICE_ROLE_KEY"   | gcloud secrets create SUPABASE_SERVICE_ROLE_KEY --data-file=-
# optional: ANTHROPIC_API_KEY, DEEPSEEK_API_KEY, RESEND_API_KEY, POSTHOG_API_KEY
```
(To update a secret later: `printf '%s' "$NEW" | gcloud secrets versions add NAME --data-file=-`.)

---

## 4. Push the code to GitHub

```bash
git init && git add -A && git commit -m "Deploy scaffolding"
gh repo create ai-academy --private --source=. --remote=origin --push
```
Confirm the service-account JSON and `.env*` are NOT committed (`.gitignore` already covers
`ai-academy-*.json` and `.env*`): `git ls-files | grep -E 'ai-academy-.*json|\.env' || echo clean`.

---

## 5. First deploy (two-pass, to bake the backend URL into the frontend)

`NEXT_PUBLIC_API_URL` is compiled into the frontend, so the backend must exist first.

```bash
SUBS="_RUNTIME_SA=mentorai-run@ai-academy-498412.iam.gserviceaccount.com,\
_NEXT_PUBLIC_SUPABASE_URL=$SUPABASE_URL,\
_NEXT_PUBLIC_SUPABASE_ANON_KEY=$SUPABASE_ANON_KEY,\
_ADMIN_EMAILS=you@example.com"

# Pass 1 — builds backend, runs migrations, deploys both (frontend's API URL still blank).
gcloud builds submit --config cloudbuild.yaml --substitutions "$SUBS"

# Capture the service URLs:
BACKEND_URL=$(gcloud run services describe backend  --region us-central1 --format='value(status.url)')
FRONTEND_URL=$(gcloud run services describe frontend --region us-central1 --format='value(status.url)')

# Pass 2 — rebuild frontend with the real backend URL + set backend CORS origin.
gcloud builds submit --config cloudbuild.yaml \
  --substitutions "$SUBS,_API_URL=$BACKEND_URL,_FRONTEND_URL=$FRONTEND_URL"
```

(Optional: skip the two-pass by mapping **custom domains** `api.…`/`app.…` to the services up
front and using those as `_API_URL`/`_FRONTEND_URL` from the start.)

Then point Supabase auth at the frontend: **Supabase → Authentication → URL Configuration**,
set Site URL + redirect URLs to `$FRONTEND_URL`.

---

## 6. Seed course content into Supabase

Migrations (schema) run automatically in the pipeline. The course content
(`python-native` + others) lives only in dev, so load the generated seed **once**, using the
**direct** (5432) Supabase connection string:

```bash
psql "$SUPABASE_DIRECT_URL" -f deploy/content-seed.sql
# verify
psql "$SUPABASE_DIRECT_URL" -c "SELECT (SELECT count(*) FROM modules) modules,
  (SELECT count(*) FROM questions) questions, (SELECT count(*) FROM concept_briefs) briefs;"
# expect modules=74, questions=677, briefs=109
```
Only `python-native` is `is_available=true`, so only it shows to learners; the rest stay hidden.

---

## 7. Wire up push-to-deploy

Console → Cloud Build → Triggers → Create trigger: connect the GitHub repo, branch `^main$`,
config = `cloudbuild.yaml`, and add the same substitutions as Pass 2 (including `_API_URL`,
`_FRONTEND_URL`). From now on every push to `main` rebuilds and redeploys both services.

---

## 8. Verify

1. `curl $BACKEND_URL/health` → `{"status":"ok"}`.
2. Open `$FRONTEND_URL`, sign up, confirm the **Python full course** is visible.
3. Open a module: tutor streams (SSE), syllabus teaching works, coding env runs, assessment
   skip/navigator/finish-guard works and mastery gates the next module.
4. Vertex works with no JSON key (ADC via attached SA); `llm_usage` rows accrue.
5. Push a trivial commit → trigger auto-builds and redeploys.

## Notes
- Backend runs `--min-instances=1` (warm SSE; avoids any first-call model download).
- Stripe stays disabled (no Stripe secrets). PostHog/Resend optional.
- Local dev is unchanged (still uses the local `.env` + service-account JSON + Node 26).
- Re-seeding/regenerating questions later: run the co-gen as a Cloud Run Job from the backend
  image (`node dist/scripts/cogenConcepts.js`), or re-load an updated `content-seed.sql`.
