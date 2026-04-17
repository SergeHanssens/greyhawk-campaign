-- App-instellingen (key-value store voor VTT-link, DM-kaart, etc.)
create table if not exists public.app_settings (
  key         text primary key,
  value       text,
  updated_at  timestamptz default now()
);
grant all on public.app_settings to anon, authenticated;

-- Standaard VTT link
insert into public.app_settings (key, value) values
  ('vtt_url', 'https://fp.mythictable.com/play/69cbef67e01772a8ad6db8dc/debug'),
  ('dm_map_url', '')
on conflict (key) do nothing;
