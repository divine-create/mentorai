import { NextResponse } from 'next/server';
import { requireAuth, handleApiError } from '@/lib/api-utils';

export async function POST() {
  try {
    await requireAuth();
    
    // The AssemblyAI temporary token logic. 
    // In a real app, you would exchange ASSEMBLYAI_API_KEY for a temp token.
    const res = await fetch('https://api.assemblyai.com/v2/realtime/token', {
      method: 'POST',
      headers: {
        'Authorization': process.env.ASSEMBLYAI_API_KEY || '',
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ expires_in: 3600 })
    });
    
    if (!res.ok) {
      throw new Error('Failed to fetch AssemblyAI token');
    }
    
    const data = await res.json();
    return NextResponse.json(data);
  } catch (err) {
    return handleApiError(err);
  }
}
