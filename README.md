# Bold Dragoon CC Hub — Version 10.2

This release was fully checked after reports that old fixtures were still showing.

Fixed:
- Removed every hard-coded demonstration fixture
- Added a migration that removes old bundled fixtures from Supabase shared state
- Preserves manually-added fixtures and Play-Cricket-synced fixtures
- Removes duplicate fixtures
- Uses a new local-storage and service-worker cache version
- Improved empty-fixture wording

Automated checks passed:
- JavaScript syntax
- Every clickable button has a matching function
- Required screens exist
- No duplicate HTML IDs
- No old bundled opponent names remain

Until the Play-Cricket API token arrives, the fixture page will show only
fixtures added manually. Once the token is added, Sync now will populate live fixtures.
