'use client';

import { useEffect, useState } from 'react';
import { createClient } from '@/lib/supabase/client';
import type { User } from '@supabase/supabase-js';

export function useAuth() {
  const supabase = createClient();
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    supabase.auth.getUser().then(({ data }) => {
      setUser(data.user);
      setLoading(false);
    });

    const { data: { subscription } } = supabase.auth.onAuthStateChange(async (event, session) => {
      setUser(session?.user ?? null);

      // Sync to backend on sign-in or page refresh with active session
      if ((event === 'SIGNED_IN' || event === 'INITIAL_SESSION') && session) {
        await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/auth/sync`, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            Authorization: `Bearer ${session.access_token}`,
          },
          body: JSON.stringify({
            email: session.user.email,
            name: session.user.user_metadata?.name,
          }),
        }).catch(() => {}); // Don't break UI if sync fails
      }
    });

    return () => subscription.unsubscribe();
  }, [supabase]);

  return { user, loading };
}
