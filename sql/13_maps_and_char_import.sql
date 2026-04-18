-- =====================================================================
-- Greyhawk — Kaarten (met per-karakter zichtbaarheid) + karakter-import
-- =====================================================================

-- Kaarten tabel
create table if not exists public.maps (
  id              uuid        primary key default gen_random_uuid(),
  name            text        not null,
  description     text,
  image_data      text,           -- base64 encoded image (max ~5MB)
  image_url       text,           -- of externe URL
  visibility      text        default 'dm_only',  -- dm_only, all, selected
  visible_to      text[],         -- array van character_id's (bij visibility='selected')
  uploaded_by     uuid        references public.players(id),
  created_at      timestamptz default now()
);

alter table public.maps disable row level security;
grant all on public.maps to anon, authenticated;

-- Karakter-import log (bijhouden wat geïmporteerd werd)
create table if not exists public.character_imports (
  id              uuid        primary key default gen_random_uuid(),
  character_id    uuid        references public.characters(id),
  character_name  text,
  imported_by     uuid        references public.players(id),
  unknown_items   jsonb       default '[]',   -- items die niet in encyclopedie staan
  imported_at     timestamptz default now()
);

alter table public.character_imports disable row level security;
grant all on public.character_imports to anon, authenticated;
