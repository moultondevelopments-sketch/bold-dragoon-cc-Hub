# Bold Dragoon CC Hub — Version 10.3

Verified fixes:
- Replaced the legacy seven-button menu with a professional five-tab navigation
- Correct iPhone safe-area spacing and unclipped labels
- Live weather now falls back directly to Open-Meteo if the Netlify function fails
- Weather includes a retry button rather than loading forever
- Database connection now changes to Local mode if Supabase is not ready
- Old fixtures are also removed from real-time Supabase updates
- Service-worker cache bumped

Automated checks passed:
- JavaScript syntax
- All button handlers
- No duplicate IDs
- Exactly five main navigation tabs
