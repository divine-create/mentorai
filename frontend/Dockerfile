# Frontend (Next.js 16 standalone) — built for Cloud Run.
# BUILD CONTEXT = repo root (npm workspaces). Build with:
# NOTE: every NEXT_PUBLIC_* value is baked at BUILD time, so the backend URL must
# be known before this image is built.

# ---- build stage ----
FROM node:22-slim AS build
WORKDIR /app
ARG NEXT_PUBLIC_SUPABASE_URL
ARG NEXT_PUBLIC_SUPABASE_ANON_KEY
ARG NEXT_PUBLIC_POSTHOG_KEY
ARG NEXT_PUBLIC_POSTHOG_HOST
    NEXT_PUBLIC_SUPABASE_URL=$NEXT_PUBLIC_SUPABASE_URL \
    NEXT_PUBLIC_SUPABASE_ANON_KEY=$NEXT_PUBLIC_SUPABASE_ANON_KEY \
    NEXT_PUBLIC_POSTHOG_KEY=$NEXT_PUBLIC_POSTHOG_KEY \
    NEXT_PUBLIC_POSTHOG_HOST=$NEXT_PUBLIC_POSTHOG_HOST \
    NEXT_TELEMETRY_DISABLED=1
COPY package.json package-lock.json ./
COPY frontend/package.json frontend/package.json
RUN npm ci --workspace frontend --include-workspace-root=false
COPY frontend/ frontend/
RUN npm run build --workspace frontend

# ---- runtime stage ----
FROM node:22-slim AS runtime
ENV NODE_ENV=production NEXT_TELEMETRY_DISABLED=1 HOSTNAME=0.0.0.0
WORKDIR /app
# Standalone bundle (incl. its own node_modules subset); tracing root = repo root,
# so server.js lands at /app/frontend/server.js.
COPY --from=build /app/frontend/.next/standalone ./
# Static assets + public are not auto-copied into standalone — add them.
COPY --from=build /app/frontend/.next/static ./frontend/.next/static
COPY --from=build /app/frontend/public ./frontend/public
EXPOSE 8080
# server.js honors PORT (Cloud Run sets 8080) and HOSTNAME.
CMD ["node", "frontend/server.js"]
