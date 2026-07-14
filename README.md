# Bold Dragoon Cricket Club Hub

Installable club hub for Bold Dragoon Cricket Club.

## Shared database setup
1. In Supabase open **SQL Editor**.
2. Open `SUPABASE_SETUP.sql`, copy all of it, paste it into a new query and press **Run**.
3. In Netlify keep these environment variables:
   - `VITE_SUPABASE_URL`
   - `VITE_SUPABASE_ANON_KEY`
4. Deploy this folder/ZIP to Netlify.

The app will then load and save one shared club record in the Supabase `club_state` table.

## Security note
This first shared version allows anyone with the app link to edit club data. Add user login and role-based access before using it for sensitive player or junior information.
