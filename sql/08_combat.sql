-- =====================================================================
-- Greyhawk — Combat management (geïntegreerd in sessies)
-- =====================================================================
-- Voegt combat-gerelateerde kolommen toe aan session_participants
-- en een nieuwe tabel voor actie-declaraties per ronde.
-- =====================================================================

-- Extra kolommen op session_participants
alter table public.session_participants
  add column if not exists initiative_roll    integer,
  add column if not exists controlled_by      text default 'owner',  -- 'owner' = eigen speler, 'DM', of andere spelernaam
  add column if not exists extra_attacks      integer default 0,     -- extra aanvallen aan einde ronde (bv. Fighter 3/2)
  add column if not exists is_enemy           boolean default false,  -- true = vijand/NPC door DM gespeeld
  add column if not exists hp_combat          integer,               -- tijdelijke HP tijdens combat (los van characters.hp_current)
  add column if not exists status             text default 'active'; -- active, dead, fled, unconscious

-- Combat rondes en acties (log per karakter per ronde)
create table if not exists public.combat_actions (
  id              uuid        primary key default gen_random_uuid(),
  session_id      uuid        not null references public.sessions(id)   on delete cascade,
  character_id    uuid        references public.characters(id) on delete cascade,
  enemy_name      text,           -- voor vijanden zonder character record
  round_number    integer     not null default 1,
  action_type     text,           -- attack, spell, move, defend, flee, other
  description     text,           -- vrije tekst: wat doet het karakter
  result          text,           -- uitkomst (raak/mis, schade, effect)
  recorded_by     uuid        references public.players(id),
  created_at      timestamptz default now()
);

create index if not exists idx_combat_actions_session on public.combat_actions (session_id, round_number);

-- Combat rond-status op sessie zelf
alter table public.sessions
  add column if not exists combat_round   integer default 0,    -- 0 = geen actief gevecht
  add column if not exists combat_active  boolean default false;

-- Permissions
alter table public.combat_actions disable row level security;
grant all on public.combat_actions to anon, authenticated;

-- Klaar. De app's Sessie-detail view wordt nu het combat-centrum.
