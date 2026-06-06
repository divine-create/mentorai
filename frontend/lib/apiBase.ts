// Validated API base URL helper
// Ensures NEXT_PUBLIC_API_URL is set and provides a safe default

const getApiBaseUrl = (): string => {
  const url = process.env.NEXT_PUBLIC_API_URL;
  if (!url || url.trim() === '') {
    console.warn('API: NEXT_PUBLIC_API_URL not set, using default http://localhost:3000');
    return 'http://localhost:3000';
  }
  return url;
};

export const API_BASE_URL = getApiBaseUrl();

export const getApiUrl = (path: string): string => {
  return `${API_BASE_URL}${path.startsWith('/') ? path : '/' + path}`;
};
