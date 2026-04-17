-- =====================================================================
-- Greyhawk — Acties (activiteiten binnen een sessie)
-- =====================================================================
-- Een "Actie" is een benoemde activiteit: gevecht, herbergbezoek,
-- rondtrekken, onderhandeling, etc. Per actie zijn er deelnemers.
-- Meerdere acties kunnen tegelijk actief zijn (party split).
-- =====================================================================

create table if not exists public.session_actions (
  id              uuid        primary key default gen_random_uuid(),
  session_id      uuid        not null references public.sessions(id) on delete cascade,
  name            text        not null,           -- "Gevecht in de grot", "Herbergbezoek"
  action_type     text        default 'other',    -- combat, travel, social, exploration, rest, other
  status          text        default 'active',   -- active, completed
  combat_round    integer     default 0,          -- alleen relevant als has_initiative=true
  has_initiative  boolean     default true,       -- true = initiative volgorde, false = vrije volgorde
  created_by      uuid        references public.players(id),
  created_at      timestamptz default now(),
  completed_at    timestamptz
);

-- Welke karakters doen mee aan welke actie
create table if not exists public.action_participants (
  action_id       uuid        not null references public.session_actions(id) on delete cascade,
  character_id    uuid        not null references public.characters(id) on delete cascade,
  initiative_roll integer,
  hp_combat       integer,
  status          text        default 'active',  -- active, dead, unconscious, fled
  controlled_by   text        default 'owner',
  primary key (action_id, character_id)
);

-- Acties-log (per karakter per ronde per actie)
-- Vervangt combat_actions voor het nieuwe systeem
create table if not exists public.action_log (
  id              uuid        primary key default gen_random_uuid(),
  action_id       uuid        not null references public.session_actions(id) on delete cascade,
  character_id    uuid        references public.characters(id) on delete cascade,
  character_name  text,
  round_number    integer,
  action_type     text,        -- attack, spell, defend, move, flee, use_item, social, other
  description     text,
  result          text,
  recorded_by     uuid        references public.players(id),
  created_at      timestamptz default now()
);

create index if not exists idx_session_actions on public.session_actions (session_id);
create index if not exists idx_action_participants on public.action_participants (action_id);
create index if not exists idx_action_log on public.action_log (action_id, round_number);

alter table public.session_actions disable row level security;
alter table public.action_participants disable row level security;
alter table public.action_log disable row level security;
grant all on public.session_actions to anon, authenticated;
grant all on public.action_participants to anon, authenticated;
grant all on public.action_log to anon, authenticated;
