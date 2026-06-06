# Backend (Express/TypeScript) — built for Cloud Run.
# BUILD CONTEXT = repo root (npm workspaces hoist deps to the root node_modules),
# so build with:  docker build -f backend/Dockerfile -t backend .

# ---- build stage: compile TS → dist and copy .sql migrations ----
FROM node:22-slim AS build
WORKDIR /app
COPY package.json package-lock.json ./
COPY backend/package.json backend/package.json
# Install the backend workspace's deps (incl. devDeps like tsc) into /app/node_modules.
RUN npm ci --workspace backend --include-workspace-root=false
COPY backend/ backend/
RUN npm run build --workspace backend   # tsc + postbuild (copies migrations into dist)

# ---- runtime stage: prod deps + compiled output only ----
FROM node:22-slim AS runtime
ENV NODE_ENV=production
WORKDIR /app
COPY package.json package-lock.json ./
COPY backend/package.json backend/package.json
RUN npm ci --workspace backend --include-workspace-root=false --omit=dev \
  && npm cache clean --force
COPY --from=build /app/backend/dist backend/dist
WORKDIR /app/backend
# Cloud Run sets $PORT (8080); index.ts reads process.env.PORT and binds 0.0.0.0.
EXPOSE 8080
CMD ["node", "dist/index.js"]
