-- Disable RLS on all tables (the app handles permissions in JavaScript)
-- Run this if you get "violates row-level security policy" errors

alter table if exists public.players disable row level security;
alter table if exists public.characters disable row level security;
alter table if exists public.character_weapons disable row level security;
alter table if exists public.character_items disable row level security;
alter table if exists public.character_skills disable row level security;
alter table if exists public.character_spells disable row level security;
alter table if exists public.character_log disable row level security;
alter table if exists public.character_opens disable row level security;
alter table if exists public.weapons disable row level security;
alter table if exists public.spells disable row level security;
alter table if exists public.items disable row level security;
alter table if exists public.skills disable row level security;
alter table if exists public.races disable row level security;
alter table if exists public.classes disable row level security;
alter table if exists public.monsters disable row level security;
alter table if exists public.weapon_types disable row level security;
alter table if exists public.deities disable row level security;
alter table if exists public.sessions disable row level security;
alter table if exists public.session_participants disable row level security;
alter table if exists public.session_logs disable row level security;
alter table if exists public.app_settings disable row level security;
alter table if exists public.csv_imports disable row level security;
