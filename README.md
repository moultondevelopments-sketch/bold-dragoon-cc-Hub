# Bold Dragoon CC Hub — Version 11.0 Stable App

This release changes the app startup architecture.

Fixed:
- One broken page can no longer stop every other page or service
- Navigation, database, authentication and weather start independently
- Weather has Netlify and direct Open-Meteo fallbacks
- Weather timeout and Try Again control
- Visible system warning when a particular section fails
- Read-only use remains available before secure account setup
- Network-first loading for the main app and Netlify functions
- New service-worker and local-storage versions

Automated checks passed:
- JavaScript syntax
- Every clickable handler
- No duplicate IDs
- Required startup, navigation and weather functions
