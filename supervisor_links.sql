create table if not exists public.supervisor_links (
  id text primary key,
  token text not null unique,
  supervisor_name text not null,
  project text not null,
  created_at timestamptz not null default now(),
  active boolean not null default true
);

alter table public.supervisor_links enable row level security;

drop policy if exists "Public can validate active supervisor links" on public.supervisor_links;
create policy "Public can validate active supervisor links"
  on public.supervisor_links for select to anon, authenticated
  using (active = true);

drop policy if exists "Public can create supervisor links" on public.supervisor_links;
create policy "Public can create supervisor links"
  on public.supervisor_links for insert to anon, authenticated
  with check (true);

drop policy if exists "Public can revoke supervisor links" on public.supervisor_links;
create policy "Public can revoke supervisor links"
  on public.supervisor_links for delete to anon, authenticated
  using (true);

grant select, insert, delete on public.supervisor_links to anon, authenticated;