'use client';

import { usePathname, useSearchParams } from 'next/navigation';
import { useEffect, Suspense } from 'react';
import posthog from 'posthog-js';

// Initialize PostHog once on mount
function PostHogInit() {
  useEffect(() => {
    const key = process.env.NEXT_PUBLIC_POSTHOG_KEY;
    if (!key || key === '') {
      console.warn('PostHog: NEXT_PUBLIC_POSTHOG_KEY not set, analytics disabled');
      return;
    }
    posthog.init(key, {
      api_host: process.env.NEXT_PUBLIC_POSTHOG_HOST || 'https://app.posthog.com',
      person_profiles: 'identified_only',
      capture_pageview: false,
    });
  }, []);
  return null;
}

// Track pageviews on route change (requires Suspense boundary in Next 16)
function PostHogPageView() {
  const pathname = usePathname();
  const searchParams = useSearchParams();

  useEffect(() => {
    const key = process.env.NEXT_PUBLIC_POSTHOG_KEY;
    if (!key || key === '') return; // PostHog not initialized

    if (pathname) {
      let url = window.origin + pathname;
      if (searchParams.toString()) {
        url += `?${searchParams.toString()}`;
      }
      posthog.capture('$pageview', { $current_url: url });
    }
  }, [pathname, searchParams]);

  return null;
}

export default function PostHogProvider({ children }: { children: React.ReactNode }) {
  return (
    <>
      <PostHogInit />
      <Suspense fallback={null}>
        <PostHogPageView />
      </Suspense>
      {children}
    </>
  );
}
