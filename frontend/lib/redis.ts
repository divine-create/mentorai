import { Redis } from '@upstash/redis';

// If running locally without Upstash, provide dummy fallbacks or throw early.
// For Next.js Edge, the URL and TOKEN must be provided.
export const redis = new Redis({
  url: process.env.UPSTASH_REDIS_REST_URL || '',
  token: process.env.UPSTASH_REDIS_REST_TOKEN || '',
});
