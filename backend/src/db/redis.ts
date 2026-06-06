import dotenv from 'dotenv';
import path from 'path';
import { createClient } from 'redis';

// Load .env before reading REDIS_URL — see db/pool.ts for rationale.
dotenv.config({ path: path.join(__dirname, '..', '..', '.env') });

export const redis = createClient({
  url: process.env.REDIS_URL,
  // Redis backs best-effort adaptation state only — it must never hang or crash
  // the app. Keep retrying with capped backoff so a transient blip self-heals,
  // and fail commands fast (don't queue) while disconnected so callers — which
  // guard their Redis calls — degrade gracefully instead of stalling.
  socket: {
    connectTimeout: 5000,
    reconnectStrategy: (retries: number) => Math.min(retries * 200, 3000),
  },
  disableOfflineQueue: true,
});

// Log once per error, not on every reconnect attempt, to avoid log spam.
let loggedError = false;
redis.on('error', (err: Error) => {
  if (!loggedError) {
    console.error('Redis error (will keep retrying):', err.message);
    loggedError = true;
  }
});
redis.on('ready', () => { loggedError = false; });

export const connectRedis = () => redis.connect();
