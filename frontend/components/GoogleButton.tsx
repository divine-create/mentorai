'use client';

import { GoogleLogin } from '@react-oauth/google';
import { createClient } from '@/lib/supabase/client';
import { useRouter } from 'next/navigation';
import { useState } from 'react';

interface GoogleButtonProps {
  redirectTo?: string;
  label?: string;
}

export default function GoogleButton({ redirectTo = '/dashboard' }: GoogleButtonProps) {
  const supabase = createClient();
  const router = useRouter();
  const [error, setError] = useState('');

  return (
    <div className="w-full space-y-2">
      {error && (
        <p className="text-sm text-red-600 bg-red-50 border border-red-200 rounded px-3 py-2">
          {error}
        </p>
      )}
      <div className="flex justify-center">
        <GoogleLogin
          onSuccess={async (credentialResponse) => {
            setError('');

            if (!credentialResponse.credential) {
              setError('No credential received from Google. Please try again.');
              return;
            }

            // credentialResponse.credential IS the id_token (JWT) that Supabase needs
            const { data, error: sbError } = await supabase.auth.signInWithIdToken({
              provider: 'google',
              token: credentialResponse.credential,
            });

            if (sbError) {
              setError(sbError.message);
              return;
            }

            // Sync user to our database
            await fetch('/api/auth/sync', {
              method: 'POST',
              headers: { 'Content-Type': 'application/json' },
              body: JSON.stringify({
                id: data.user?.id,
                email: data.user?.email,
                name: data.user?.user_metadata?.full_name ?? data.user?.user_metadata?.name,
                avatar_url: data.user?.user_metadata?.avatar_url,
              }),
            }).catch(() => {}); // non-blocking

            router.push(redirectTo);
            router.refresh();
          }}
          onError={() => setError('Google sign-in failed. Please try again.')}
          theme="outline"
          size="large"
          width="368"
          text="continue_with"
          shape="rectangular"
          logo_alignment="left"
        />
      </div>
    </div>
  );
}
