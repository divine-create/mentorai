import { createServerClient } from '@supabase/ssr';
import { NextResponse, type NextRequest } from 'next/server';

// Rate limiting is only active in production with real Upstash credentials
const hasUpstash =
  !!process.env.UPSTASH_REDIS_REST_URL &&
  process.env.UPSTASH_REDIS_REST_URL.startsWith('https://') &&
  !process.env.UPSTASH_REDIS_REST_URL.includes('mock') &&
  !!process.env.UPSTASH_REDIS_REST_TOKEN &&
  process.env.UPSTASH_REDIS_REST_TOKEN !== 'mock_token';



const skipOutsideProd = () => process.env.NODE_ENV !== 'production';

export async function middleware(request: NextRequest) {
  // --- Rate Limiting (production only, requires real Upstash credentials) ---
  if (hasUpstash && request.nextUrl.pathname.startsWith('/api')) {
    const { Ratelimit } = await import('@upstash/ratelimit');
    const { Redis } = await import('@upstash/redis');
    const redis = new Redis({
      url: process.env.UPSTASH_REDIS_REST_URL!,
      token: process.env.UPSTASH_REDIS_REST_TOKEN!,
    });
    const ip = request.ip ?? '127.0.0.1';
    let limiter;

    if (request.nextUrl.pathname.startsWith('/api/auth')) {
      limiter = new Ratelimit({ redis, limiter: Ratelimit.slidingWindow(20, '15 m'), prefix: '@upstash/ratelimit/auth' });
    } else if (request.nextUrl.pathname.startsWith('/api/tutor')) {
      limiter = new Ratelimit({ redis, limiter: Ratelimit.slidingWindow(30, '15 m'), prefix: '@upstash/ratelimit/tutor' });
    } else if (request.nextUrl.pathname.startsWith('/api/assessments')) {
      limiter = new Ratelimit({ redis, limiter: Ratelimit.slidingWindow(60, '15 m'), prefix: '@upstash/ratelimit/assessment' });
    } else {
      limiter = new Ratelimit({ redis, limiter: Ratelimit.slidingWindow(100, '15 m'), prefix: '@upstash/ratelimit/general' });
    }

    const { success, reset } = await limiter.limit(ip);
    if (!success) {
      return NextResponse.json(
        { error: 'rate_limit_exceeded', message: 'Too many requests. Please slow down.', retryAfter: Math.ceil((reset - Date.now()) / 1000) },
        { status: 429 }
      );
    }
  }

  // --- Supabase SSR Auth & Route Protection ---
  if (!process.env.NEXT_PUBLIC_SUPABASE_URL || !process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY) {
    return NextResponse.next({ request });
  }

  let supabaseResponse = NextResponse.next({ request });

  const supabase = createServerClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY,
    {
      cookies: {
        getAll: () => request.cookies.getAll(),
        setAll: (cookiesToSet) => {
          cookiesToSet.forEach(({ name, value, options }) => {
            supabaseResponse.cookies.set(name, value, options);
          });
        },
      },
    }
  );

  const { data: { user } } = await supabase.auth.getUser();

  const protectedPaths = ['/dashboard', '/learn', '/onboarding'];
  const isProtected = protectedPaths.some((p) => request.nextUrl.pathname.startsWith(p));

  // Also protect all /api routes except webhooks
  const isProtectedApi = request.nextUrl.pathname.startsWith('/api') && 
                         !request.nextUrl.pathname.startsWith('/api/billing/webhook');

  if ((isProtected || isProtectedApi) && !user) {
    if (isProtectedApi) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
    }
    return NextResponse.redirect(new URL('/auth/login', request.url));
  }

  return supabaseResponse;
}

export const config = {
  matcher: ['/((?!_next/static|_next/image|favicon.ico).*)'],
};
