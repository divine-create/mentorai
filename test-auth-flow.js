const API_BASE = 'http://localhost:4000';

async function testAuthFlow() {
  console.log('🧪 Testing authentication flow...\n');

  // Test 1: Health check
  console.log('1. Testing health endpoint...');
  const healthRes = await fetch(`${API_BASE}/health`);
  const healthData = await healthRes.json();
  console.log('   ✓ Health:', healthData.status === 'ok' ? 'PASS' : 'FAIL');

  // Test 2: Protected endpoint without auth (should fail)
  console.log('\n2. Testing protected endpoint without auth...');
  const noAuthRes = await fetch(`${API_BASE}/api/subjects`);
  const noAuthData = await noAuthRes.json();
  console.log('   ✓ Missing auth rejected:', noAuthData.error === 'Missing auth token' ? 'PASS' : 'FAIL');

  // Test 3: Sign up new user
  console.log('\n3. Testing user registration...');
  const email = `test${Date.now()}@example.com`;
  const signupRes = await fetch(`${API_BASE}/api/auth/signup`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ email, password: 'testpass123', name: 'Test User' })
  });
  const signupData = await signupRes.json();
  console.log('   ✓ Signup:', signupData.user ? 'PASS' : 'FAIL');
  
  if (!signupData.user) {
    console.log('   Error:', signupData);
    return;
  }

  // Test 4: Login
  console.log('\n4. Testing login...');
  const loginRes = await fetch(`${API_BASE}/api/auth/login`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ email, password: 'testpass123' })
  });
  const loginData = await loginRes.json();
  console.log('   ✓ Login:', loginData.token ? 'PASS' : 'FAIL');

  if (!loginData.token) {
    console.log('   Error:', loginData);
    return;
  }

  // Test 5: Access protected endpoint with auth
  console.log('\n5. Testing protected endpoint with auth...');
  const subjectsRes = await fetch(`${API_BASE}/api/subjects`, {
    headers: { 'Authorization': `Bearer ${loginData.token}` }
  });
  const subjectsData = await subjectsRes.json();
  console.log('   ✓ Subjects endpoint:', Array.isArray(subjectsData) ? 'PASS' : 'FAIL');
  console.log(`   Found ${Array.isArray(subjectsData) ? subjectsData.length : 0} subjects`);

  // Test 6: Get learning path
  console.log('\n6. Testing learning path endpoint...');
  const pathRes = await fetch(`${API_BASE}/api/learning-path`, {
    headers: { 'Authorization': `Bearer ${loginData.token}` }
  });
  const pathData = await pathRes.json();
  console.log('   ✓ Learning path:', pathData.modules ? 'PASS' : 'FAIL');
  console.log(`   Found ${pathData.modules?.length || 0} modules`);

  console.log('\n✅ All auth flow tests completed!');
}

testAuthFlow().catch(err => {
  console.error('❌ Test failed:', err);
  process.exit(1);
});
