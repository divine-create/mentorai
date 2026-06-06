'use client';

import { useEffect, useState } from 'react';
import { createClient } from '@/lib/supabase/client';
import type { LearningPath } from '@/lib/types';

export function useLearningPath() {
  const supabase = createClient();
  const [data, setData] = useState<LearningPath | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    async function load() {
      const { data: { session } } = await supabase.auth.getSession();
      if (!session) { setLoading(false); return; }

      const res = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/path`, {
        headers: { Authorization: `Bearer ${session.access_token}` },
      });

      if (!res.ok) {
        setError('Failed to load learning path');
      } else {
        setData(await res.json());
      }
      setLoading(false);
    }
    load();
  }, [supabase]);

  return { data, loading, error };
}
