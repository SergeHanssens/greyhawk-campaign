-- =====================================================================
-- Greyhawk — Gedeeld dobbelsteen-log per sessie
-- =====================================================================
-- Elke worp wordt opgeslagen en is zichtbaar voor alle deelnemers.
-- Privé worpen (is_private=true) zijn enkel zichtbaar voor de
-- speler zelf en voor de DM.
-- =====================================================================

create table if not exists public.dice_rolls (
  id              uuid        primary key default gen_random_uuid(),
  session_id      uuid        references public.sessions(id) on delete cascade,
  player_id       uuid        references public.players(id),
  player_name     text,
  character_name  text,        -- optioneel: voor welk karakter gerold
  notation        text not null,   -- bv. "3d6+2", "1d20"
  dice_detail     text,            -- bv. "[4, 2, 5] + 2"
  total           integer not null,
  purpose         text,            -- bv. "Initiative", "Aanval Long Sword", "Save vs Spell"
  is_private      boolean default false,  -- true = alleen speler + DM ziet het
  combat_round    integer,         -- als gerolld tijdens gevecht
  created_at      timestamptz default now()
);

create index if not exists idx_dice_rolls_session on public.dice_rolls (session_id, created_at desc);

alter table public.dice_rolls disable row level security;
grant all on public.dice_rolls to anon, authenticated;
