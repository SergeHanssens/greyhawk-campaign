-- =====================================================================
-- Greyhawk Campaign Manager — Database Schema (v3, authoritatief)
-- =====================================================================
-- Dit schema is een 1-op-1 consolidatie van de migraties die Serge op
-- zijn Supabase project heeft uitgevoerd:
--   e178e845  greyhawk_setup_sql
--   6faf4fc0  greyhawk_complete_sql
--   a27f33aa  disable_rls_and_grant_access_to_players
--   de451e71  disable_rls_and_grant_broad_access_to_roles
--   bc5332ad  disable_rls_and_grant_public_read_access
--   d1b6ba86  greyhawk_v_3_tables
--   107b4d0f  greyhawk_pwreset
--   e3bee988  greyhawk_final_setup
--
-- Run dit EERST in Supabase SQL Editor, dan 02_seed.sql.
-- Veilig om opnieuw uit te voeren (IF NOT EXISTS + ON CONFLICT).
-- =====================================================================

create extension if not exists "pgcrypto";

-- ---------------------------------------------------------------------
-- PLAYERS
-- ---------------------------------------------------------------------
create table if not exists public.players (
  id                      uuid        primary key default gen_random_uuid(),
  username                text        not null unique,
  password_hash           text        not null,
  is_dm                   boolean     default false,
  created_at              timestamptz default now(),
  last_login              timestamptz,
  must_change_password    boolean     default false,
  temp_password_hash      text,
  email                   text,
  security_question       text,
  security_answer_hash    text
);

-- ---------------------------------------------------------------------
-- CHARACTERS
-- ---------------------------------------------------------------------
-- NB: "int" is een PostgreSQL keyword, vandaar de quotes.
create table if not exists public.characters (
  id                  uuid        primary key default gen_random_uuid(),
  player_id           uuid        references public.players(id),
  name                text        not null,
  race                text,
  class               text,
  level               integer     default 1,
  alignment           text,
  sex                 text,
  player_name         text,
  str                 integer,   str_mod  text,
  dex                 integer,   dex_mod  text,
  "int"               integer,   int_mod  text,
  wis                 integer,   wis_mod  text,
  con                 integer,   con_mod  text,
  cha                 integer,   cha_mod  text,
  comeliness          integer,
  hp_current          integer,
  hp_max              integer,
  ac                  text,
  thac0               integer,
  xp                  integer     default 0,
  xp_next             integer,
  sv_pd               integer,
  sv_rsw              integer,
  sv_pp               integer,
  sv_bw               integer,
  sv_spell            integer,
  sv_poison           integer,
  pp                  integer     default 0,
  gp                  integer     default 0,
  sp                  integer     default 0,
  cp                  integer     default 0,
  special_abilities   jsonb       default '[]'::jsonb,
  notes               text,
  dm_notes            text,
  dm_session_notes    text,
  avatar_url          text,
  is_active           boolean     default true,
  created_at          timestamptz default now(),
  updated_at          timestamptz default now()
);

-- ---------------------------------------------------------------------
-- CHARACTER SUBTABLES
-- ---------------------------------------------------------------------
create table if not exists public.character_weapons (
  id                  serial      primary key,
  character_id        uuid        references public.characters(id),
  weapon_name         text        not null,
  attack_bonus        text,
  damage_bonus        text,
  thac0_mod           integer     default 0,
  attacks_per_round   text,
  speed_factor        integer,
  damage              text,
  notes               text
);

create table if not exists public.character_items (
  id                  serial      primary key,
  character_id        uuid        references public.characters(id),
  item_name           text        not null,
  category            text        default 'item',
  quantity            integer     default 1,
  notes               text
);

create table if not exists public.character_skills (
  id                  serial      primary key,
  character_id        uuid        references public.characters(id),
  skill_name          text        not null,
  skill_type          text,
  stat_modifier       text,
  notes               text
);

create table if not exists public.character_spells (
  id                  serial      primary key,
  character_id        uuid        references public.characters(id),
  spell_name          text        not null,
  spell_level         integer     default 1,
  spell_class         text,
  prepared            boolean     default true,
  notes               text,
  created_at          timestamptz default now()
);

-- ---------------------------------------------------------------------
-- LOGBOEK
-- ---------------------------------------------------------------------
create table if not exists public.character_log (
  id              serial      primary key,
  character_id    uuid        references public.characters(id),
  user_id         uuid        references public.players(id),
  username        text,
  is_dm           boolean     default false,
  beschrijving    text,
  type            text        default 'edit',
  oude_waarde     text        default '',
  nieuwe_waarde   text        default '',
  created_at      timestamptz default now()
);

create table if not exists public.character_opens (
  character_id    uuid        not null references public.characters(id),
  user_id         uuid        not null references public.players(id),
  last_opened_at  timestamptz default now(),
  primary key (character_id, user_id)
);

-- ---------------------------------------------------------------------
-- SESSIES (campagne-sessies met logboek per karakter)
-- ---------------------------------------------------------------------
create table if not exists public.sessions (
  id                 uuid        primary key default gen_random_uuid(),
  name               text        not null,
  session_date       date,
  location           text,
  summary            text,                              -- korte samenvatting (zichtbaar voor iedereen)
  dm_notes           text,                              -- DM-privé notities (onzichtbaar voor spelers)
  status             text        default 'planned',    -- planned | active | completed
  xp_awarded_total   integer     default 0,
  created_by         uuid        references public.players(id),
  created_at         timestamptz default now(),
  updated_at         timestamptz default now()
);

create table if not exists public.session_participants (
  session_id           uuid        not null references public.sessions(id)   on delete cascade,
  character_id         uuid        not null references public.characters(id) on delete cascade,
  xp_awarded           integer     default 0,           -- XP specifiek voor deze speler in deze sessie
  joined_at            timestamptz default now(),
  primary key (session_id, character_id)
);

create table if not exists public.session_logs (
  id              uuid        primary key default gen_random_uuid(),
  session_id      uuid        not null references public.sessions(id)   on delete cascade,
  character_id    uuid        not null references public.characters(id) on delete cascade,
  player_notes    text        default '',   -- vrije tekst door de speler
  encounters      text        default '',   -- tegen wie gevochten
  npcs_met        text        default '',   -- wie gesproken / ontmoet
  loot_found      text        default '',   -- wat opgepakt / verdiend
  dm_notes        text        default '',   -- DM-privé per speler per sessie
  created_at      timestamptz default now(),
  updated_at      timestamptz default now(),
  unique (session_id, character_id)
);

create index if not exists idx_session_logs_session on public.session_logs (session_id);
create index if not exists idx_session_logs_character on public.session_logs (character_id);
create index if not exists idx_session_participants_char on public.session_participants (character_id);

-- ---------------------------------------------------------------------
-- CSV IMPORT AUDIT
-- ---------------------------------------------------------------------
create table if not exists public.csv_imports (
  id            serial      primary key,
  table_name    text        not null,
  imported_by   uuid        references public.players(id),
  row_count     integer,
  imported_at   timestamptz default now()
);

-- ---------------------------------------------------------------------
-- ENCYCLOPEDIE
-- ---------------------------------------------------------------------
create table if not exists public.weapon_types (
  id          serial      primary key,
  name        text        not null unique,
  description text,
  source      text        default 'Greyhawk',
  image_url   text
);

create table if not exists public.weapons (
  id           serial      primary key,
  name         text        not null,
  damage       text,
  speed_factor integer,
  weight       real,
  type         text,
  description  text,
  source       text        default 'Greyhawk',
  weapon_type  text        default 'Other',
  image_url   text
);

create table if not exists public.spells (
  id          serial      primary key,
  name        text        not null,
  level       integer,
  class       text,
  range       text,
  duration    text,
  area        text,
  description text,
  source      text        default 'Greyhawk',
  image_url   text
);

create table if not exists public.items (
  id          serial      primary key,
  name        text        not null,
  category    text,
  weight      real,
  cost        text,
  description text,
  source      text        default 'Greyhawk',
  image_url   text
);

create table if not exists public.skills (
  id          serial      primary key,
  name        text        not null,
  type        text,
  base_stat   text,
  description text,
  source      text        default 'Greyhawk',
  image_url   text
);

create table if not exists public.races (
  id          serial      primary key,
  name        text        not null,
  description text,
  traits      jsonb,
  source      text        default 'Greyhawk',
  image_url   text
);

create table if not exists public.classes (
  id           serial      primary key,
  name         text        not null,
  description  text,
  hit_die      text,
  primary_stat text,
  source       text        default 'Greyhawk',
  image_url   text
);

create table if not exists public.monsters (
  id          serial      primary key,
  name        text        not null,
  ac          integer,
  hp_dice     text,
  thac0       integer,
  damage      text,
  move        integer,
  alignment   text,
  description text,
  source      text        default 'Greyhawk',
  image_url   text
);

-- ---------------------------------------------------------------------
-- PERMISSIONS (RLS bewust uitgeschakeld — app dwingt regels in JS af)
-- ---------------------------------------------------------------------
grant usage on schema public to anon, authenticated;
grant all on all tables    in schema public to anon, authenticated;
grant all on all sequences in schema public to anon, authenticated;
alter default privileges in schema public grant all on tables    to anon, authenticated;
alter default privileges in schema public grant all on sequences to anon, authenticated;

-- Klaar. Nu 02_seed.sql draaien voor de basis encyclopedie.
