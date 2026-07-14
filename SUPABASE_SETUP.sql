-- Run this once in Supabase: SQL Editor > New query > paste > Run

create table if not exists public.club_state (
  id text primary key,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.club_state enable row level security;

grant select, insert, update on table public.club_state to anon, authenticated;

drop policy if exists "club state public read" on public.club_state;
create policy "club state public read"
on public.club_state for select
to anon, authenticated
using (true);

drop policy if exists "club state public insert" on public.club_state;
create policy "club state public insert"
on public.club_state for insert
to anon, authenticated
with check (id = 'main');

drop policy if exists "club state public update" on public.club_state;
create policy "club state public update"
on public.club_state for update
to anon, authenticated
using (id = 'main')
with check (id = 'main');

-- Enable live updates. If this line says the table is already in the publication, that is harmless.
alter publication supabase_realtime add table public.club_state;
