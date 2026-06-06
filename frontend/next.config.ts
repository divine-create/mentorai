import type { NextConfig } from "next";
import path from "path";

const nextConfig: NextConfig = {
  // Emit a self-contained server (.next/standalone + server.js) so the Docker
  // runtime image needs no node_modules install. See
  // node_modules/next/dist/docs/.../next-config-js/output.md
  output: "standalone",
  // This is an npm-workspaces monorepo with multiple lockfiles; pin the file-
  // tracing root to the repo root so the standalone bundle includes the right
  // (hoisted) dependencies instead of guessing the workspace root.
  outputFileTracingRoot: path.join(__dirname, ".."),
};

export default nextConfig;
