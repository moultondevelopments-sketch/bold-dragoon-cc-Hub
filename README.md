# Bold Dragoon CC Hub — Version 10.1

This emergency fix resolves the issue where none of the navigation buttons worked.

Fixed:
- Duplicate JavaScript variable that stopped the entire script loading
- Supabase configuration key mismatch
- Safer screen navigation
- New read-only guest mode so the app can be tested before secure-auth setup
- Service-worker cache version increased so iPhones load the repaired code

After uploading:
1. Wait for Netlify to publish.
2. Open the app in Safari and refresh.
3. If installed on the Home Screen, close it completely and reopen it.
4. If the old broken version remains, remove the Home Screen app and add it again from Safari.
