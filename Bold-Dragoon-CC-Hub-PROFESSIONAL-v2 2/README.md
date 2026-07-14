# Bold Dragoon Cricket Club Hub — Professional Edition 2.0

A mobile-first installable club app using Netlify and Supabase.

## Improvements
- Personal player profile on each device
- One-tap self-service availability
- Live squad totals and player response list
- Fixtures, training, announcements and team selection
- Shared cloud data across devices
- Installable on iPhone and Android

## Update the existing live app
Upload the files in this package to the existing GitHub repository, replacing files when asked. Netlify will redeploy automatically.

Keep the existing Netlify environment variables:
- `VITE_SUPABASE_URL`
- `VITE_SUPABASE_ANON_KEY`

No new Supabase SQL is required. This release is compatible with the existing `club_state` table.
