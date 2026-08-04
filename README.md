# Bold Dragoon CC Hub — Professional Edition 10.0

Added:
- Secure Supabase email/password authentication
- Registration and sign-in screen
- Committee approval workflow
- Adult, junior, parent, coach, captain, committee and welfare roles
- Server-side Row Level Security policies
- Server-enforced junior messaging consent
- Committee account approval screen
- Live weather for Bold Dragoon CC at Rushmere Road, Northampton
- Current temperature, conditions, apparent temperature, rain, wind and gusts
- Weather warnings for rain and strong gusts
- Weather refreshed through a Netlify serverless function

Setup required:
1. Run SUPABASE_SECURE_AUTH.sql in Supabase SQL Editor.
2. In Supabase Authentication, enable Email provider.
3. Create the first account.
4. In Supabase SQL Editor, approve the first committee administrator manually:
   update public.club_profiles
   set approved=true, role='committee'
   where email='YOUR_EMAIL_ADDRESS';
5. Redeploy Netlify after uploading these files.

The weather uses Open-Meteo and does not require an API key.
