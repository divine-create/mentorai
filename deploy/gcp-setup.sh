#!/usr/bin/env bash
# One-time Google Cloud setup for AI Academy (Cloud Run + Cloud Build).
# Idempotent-ish: safe to re-run. Requires: gcloud (authenticated).
#
# Provide the four required secret values via env before running, e.g.:
#   export DATABASE_URL='postgres://...pooler.supabase.com:6543/postgres'
#   export REDIS_URL='rediss://...upstash.io:6379'
#   export SUPABASE_URL='https://xxxx.supabase.co'
#   export SUPABASE_SERVICE_ROLE_KEY='eyJ...'
#   bash deploy/gcp-setup.sh
set -euo pipefail

PROJECT="${PROJECT:-ai-academy-498412}"
REGION="${REGION:-us-central1}"
AR_REPO="${AR_REPO:-app}"
RUNTIME_SA_NAME="${RUNTIME_SA_NAME:-mentorai-run}"
RUNTIME_SA="${RUNTIME_SA_NAME}@${PROJECT}.iam.gserviceaccount.com"

gcloud config set project "$PROJECT"
PROJECT_NUMBER="$(gcloud projects describe "$PROJECT" --format='value(projectNumber)')"
BUILD_SA="${PROJECT_NUMBER}@cloudbuild.gserviceaccount.com"

echo "▶ Enabling APIs…"
gcloud services enable run.googleapis.com cloudbuild.googleapis.com \
  artifactregistry.googleapis.com secretmanager.googleapis.com aiplatform.googleapis.com

echo "▶ Artifact Registry repo '$AR_REPO'…"
gcloud artifacts repositories describe "$AR_REPO" --location="$REGION" >/dev/null 2>&1 || \
  gcloud artifacts repositories create "$AR_REPO" --repository-format=docker --location="$REGION" \
    --description="AI Academy images"

echo "▶ Runtime service account '$RUNTIME_SA'…"
gcloud iam service-accounts describe "$RUNTIME_SA" >/dev/null 2>&1 || \
  gcloud iam service-accounts create "$RUNTIME_SA_NAME" --display-name="AI Academy Cloud Run runtime"

echo "▶ Runtime SA roles (Vertex + read secrets)…"
gcloud projects add-iam-policy-binding "$PROJECT" \
  --member="serviceAccount:${RUNTIME_SA}" --role="roles/aiplatform.user" --condition=None -q
gcloud projects add-iam-policy-binding "$PROJECT" \
  --member="serviceAccount:${RUNTIME_SA}" --role="roles/secretmanager.secretAccessor" --condition=None -q

echo "▶ Cloud Build SA roles (deploy + act-as runtime SA + push images + read secrets)…"
for ROLE in roles/run.admin roles/artifactregistry.writer roles/secretmanager.secretAccessor roles/logging.logWriter; do
  gcloud projects add-iam-policy-binding "$PROJECT" \
    --member="serviceAccount:${BUILD_SA}" --role="$ROLE" --condition=None -q
done
# Let the build SA deploy services that run AS the runtime SA.
gcloud iam service-accounts add-iam-policy-binding "$RUNTIME_SA" \
  --member="serviceAccount:${BUILD_SA}" --role="roles/iam.serviceAccountUser" -q

create_secret() {  # name value
  local name="$1" value="$2"
  [ -z "$value" ] && { echo "  • $name: (no value in env — skipping)"; return; }
  if gcloud secrets describe "$name" >/dev/null 2>&1; then
    printf '%s' "$value" | gcloud secrets versions add "$name" --data-file=- >/dev/null
    echo "  • $name: added new version"
  else
    printf '%s' "$value" | gcloud secrets create "$name" --data-file=- >/dev/null
    echo "  • $name: created"
  fi
}

echo "▶ Secrets…"
create_secret DATABASE_URL "${DATABASE_URL:-}"
create_secret REDIS_URL "${REDIS_URL:-}"
create_secret SUPABASE_URL "${SUPABASE_URL:-}"
create_secret SUPABASE_SERVICE_ROLE_KEY "${SUPABASE_SERVICE_ROLE_KEY:-}"
# Optional providers (set the env vars to create them, then add to cloudbuild.yaml --set-secrets):
create_secret ANTHROPIC_API_KEY "${ANTHROPIC_API_KEY:-}"
create_secret DEEPSEEK_API_KEY "${DEEPSEEK_API_KEY:-}"
create_secret RESEND_API_KEY "${RESEND_API_KEY:-}"
create_secret POSTHOG_API_KEY "${POSTHOG_API_KEY:-}"

cat <<EOF

✓ GCP setup complete.
  Project:      $PROJECT  (number $PROJECT_NUMBER)
  Region:       $REGION
  AR repo:      $REGION-docker.pkg.dev/$PROJECT/$AR_REPO
  Runtime SA:   $RUNTIME_SA
  Cloud Build:  $BUILD_SA

Next: follow deploy/DEPLOY.md §5 (first deploy) and §6 (seed content).
EOF
