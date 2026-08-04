-- Bold Dragoon CC secure accounts and permissions
-- Run this in Supabase SQL Editor after the original SUPABASE_SETUP.sql.

create table if not exists public.club_profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  email text,
  full_name text not null default '',
  member_type text not null default 'Adult member',
  team text,
  role text not null default 'pending',
  approved boolean not null default false,
  junior_messaging_consent boolean not null default false,
  guardian_user_id uuid references auth.users(id),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.club_profiles enable row level security;

drop policy if exists "Profiles readable by authenticated members" on public.club_profiles;
create policy "Profiles readable by authenticated members"
on public.club_profiles for select
to authenticated
using (true);

drop policy if exists "Users update own basic profile" on public.club_profiles;
create policy "Users update own basic profile"
on public.club_profiles for update
to authenticated
using (auth.uid() = id)
with check (
  auth.uid() = id
  and role = (select role from public.club_profiles p where p.id = auth.uid())
  and approved = (select approved from public.club_profiles p where p.id = auth.uid())
);

drop policy if exists "Users insert own profile" on public.club_profiles;
create policy "Users insert own profile"
on public.club_profiles for insert
to authenticated
with check (auth.uid() = id and role = 'pending' and approved = false);

create or replace function public.is_committee_admin()
returns boolean
language sql stable security definer
set search_path = public
as $$
  select exists (
    select 1 from public.club_profiles
    where id = auth.uid()
      and approved = true
      and role in ('committee','admin','welfare')
  );
$$;

drop policy if exists "Committee manages profiles" on public.club_profiles;
create policy "Committee manages profiles"
on public.club_profiles for all
to authenticated
using (public.is_committee_admin())
with check (public.is_committee_admin());

create table if not exists public.club_channels (
  id text primary key,
  name text not null,
  audience text,
  icon text default '💬',
  required_role text,
  juniors_allowed boolean not null default false,
  created_at timestamptz not null default now()
);

create table if not exists public.club_messages (
  id uuid primary key default gen_random_uuid(),
  channel_id text not null references public.club_channels(id) on delete cascade,
  author_id uuid not null references auth.users(id) on delete cascade,
  author_name text not null,
  message_text text not null,
  pinned boolean not null default false,
  created_at timestamptz not null default now()
);

alter table public.club_channels enable row level security;
alter table public.club_messages enable row level security;

drop policy if exists "Approved members read channels" on public.club_channels;
create policy "Approved members read channels"
on public.club_channels for select
to authenticated
using (
  exists(select 1 from public.club_profiles p where p.id=auth.uid() and p.approved=true)
);

drop policy if exists "Approved members read messages" on public.club_messages;
create policy "Approved members read messages"
on public.club_messages for select
to authenticated
using (
  exists(select 1 from public.club_profiles p where p.id=auth.uid() and p.approved=true)
);

drop policy if exists "Permitted members post messages" on public.club_messages;
create policy "Permitted members post messages"
on public.club_messages for insert
to authenticated
with check (
  author_id = auth.uid()
  and exists (
    select 1
    from public.club_profiles p
    join public.club_channels c on c.id = channel_id
    where p.id = auth.uid()
      and p.approved = true
      and (
        p.member_type <> 'Junior member'
        or (
          c.juniors_allowed = true
          and p.junior_messaging_consent = true
        )
      )
      and (
        c.required_role is null
        or p.role = c.required_role
        or p.role in ('committee','admin','welfare')
      )
  )
);

insert into public.club_channels(id,name,audience,icon,required_role,juniors_allowed) values
('whole-club','Whole club','All approved members','📣',null,false),
('senior-cricket','Senior cricket','Senior players, captains and coaches','🏏',null,false),
('junior-cricket','Junior cricket','Juniors, parents and coaches','🧒',null,true),
('parents','Parents & guardians','Parents and guardians','👨‍👩‍👧','parent',false),
('committee','Committee','Committee members','📋','committee',false),
('ground-team','Ground team','Ground staff and volunteers','🚜',null,false)
on conflict (id) do nothing;
