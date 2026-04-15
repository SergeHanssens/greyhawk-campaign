-- =====================================================================
-- Greyhawk Campaign Manager — Database Schema
-- =====================================================================
-- Run dit bestand EERST in de Supabase SQL Editor.
-- Daarna: run 02_seed.sql voor de basis encyclopedie.
--
-- Veilig om meerdere keren te draaien (IF NOT EXISTS).
-- =====================================================================

-- Voor het genereren van UUIDs
create extension if not exists "pgcrypto";

-- =====================================================================
-- GEBRUIKERS / SPELERS
-- =====================================================================
create table if not exists public.players (
  id                       uuid primary key default gen_random_uuid(),
  username                 text unique not null,
  password_hash            text,
  is_dm                    boolean default false,
  security_question        text,
  security_answer_hash     text,
  temp_password_hash       text,
  must_change_password     boolean default false,
  last_login               timestamptz,
  created_at               timestamptz default now()
);

-- =====================================================================
-- KARAKTERS
-- =====================================================================
-- Let op: "int" is een gereserveerd PostgreSQL keyword, daarom met quotes.
create table if not exists public.characters (
  id                  uuid primary key default gen_random_uuid(),
  player_id           uuid references public.players(id) on delete set null,
  name                text not null,
  player_name         text,
  race                text,
  class               text,
  alignment           text,
  sex                 text,
  level               integer default 1,
  hp_current          integer default 10,
  hp_max              integer default 10,
  ac                  text default '10',
  thac0               integer default 20,
  xp                  integer default 0,
  xp_next             integer,
  -- Ability scores
  str                 integer,
  dex                 integer,
  "int"               integer,
  wis                 integer,
  con                 integer,
  cha                 integer,
  comeliness          integer,
  -- Modifiers (text — kan "+1/+2" of "18(00)" zijn)
  str_mod             text,
  dex_mod             text,
  int_mod             text,
  wis_mod             text,
  con_mod             text,
  cha_mod             text,
  -- Saves
  sv_pd               integer,
  sv_rsw              integer,
  sv_pp               integer,
  sv_bw               integer,
  sv_spell            integer,
  sv_poison           integer,
  -- Money
  pp                  integer default 0,
  gp                  integer default 0,
  sp                  integer default 0,
  cp                  integer default 0,
  -- Profielfoto (base64 data URL — kan groot zijn)
  avatar_url          text,
  -- Notities
  notes               text,
  dm_notes            text,
  dm_session_notes    text,
  -- State
  is_active           boolean default true,
  created_at          timestamptz default now(),
  updated_at          timestamptz default now()
);

-- =====================================================================
-- KARAKTER SUBTABELLEN
-- =====================================================================
create table if not exists public.character_weapons (
  id                  bigserial primary key,
  character_id        uuid references public.characters(id) on delete cascade,
  weapon_name         text not null,
  attacks_per_round   text default '1/1',
  damage              text,
  speed_factor        integer default 7,
  notes               text,
  created_at          timestamptz default now()
);

create table if not exists public.character_items (
  id                  bigserial primary key,
  character_id        uuid references public.characters(id) on delete cascade,
  item_name           text not null,
  category            text default 'item',
  quantity            integer default 1,
  notes               text,
  created_at          timestamptz default now()
);

create table if not exists public.character_skills (
  id                  bigserial primary key,
  character_id        uuid references public.characters(id) on delete cascade,
  skill_name          text not null,
  skill_type          text default 'Non-Weapon',
  stat_modifier       text,
  notes               text,
  created_at          timestamptz default now()
);

create table if not exists public.character_spells (
  id                  bigserial primary key,
  character_id        uuid references public.characters(id) on delete cascade,
  spell_name          text not null,
  spell_level         integer default 1,
  spell_class         text,
  prepared            boolean default false,
  notes               text,
  created_at          timestamptz default now()
);

-- =====================================================================
-- LOGBOEK
-- =====================================================================
create table if not exists public.character_log (
  id                  bigserial primary key,
  character_id        uuid references public.characters(id) on delete cascade,
  user_id             uuid,
  username            text,
  is_dm               boolean default false,
  beschrijving        text,
  type                text,
  oude_waarde         text,
  nieuwe_waarde       text,
  created_at          timestamptz default now()
);

create index if not exists idx_log_char_created
  on public.character_log (character_id, created_at desc);

create table if not exists public.character_opens (
  character_id        uuid references public.characters(id) on delete cascade,
  user_id             uuid,
  last_opened_at      timestamptz default now(),
  primary key (character_id, user_id)
);

-- =====================================================================
-- ENCYCLOPEDIE TABELLEN
-- =====================================================================
create table if not exists public.weapon_types (
  id                  bigserial primary key,
  name                text unique not null
);

create table if not exists public.weapons (
  id                  bigserial primary key,
  name                text not null,
  weapon_type         text,
  damage              text,
  speed_factor        integer,
  weight              text,
  type                text,
  description         text,
  source              text default 'Greyhawk'
);
create index if not exists idx_weapons_name on public.weapons (name);
create index if not exists idx_weapons_type on public.weapons (weapon_type);

create table if not exists public.spells (
  id                  bigserial primary key,
  name                text not null,
  level               integer,
  class               text,
  range               text,
  duration            text,
  area                text,
  description         text,
  source              text default 'Greyhawk'
);
create index if not exists idx_spells_name on public.spells (name);
create index if not exists idx_spells_class on public.spells (class);

create table if not exists public.items (
  id                  bigserial primary key,
  name                text not null,
  category            text,
  weight              text,
  cost                text,
  description         text,
  source              text default 'Greyhawk'
);
create index if not exists idx_items_name on public.items (name);

create table if not exists public.skills (
  id                  bigserial primary key,
  name                text not null,
  type                text,
  base_stat           text,
  description         text,
  source              text default 'Greyhawk'
);
create index if not exists idx_skills_name on public.skills (name);

create table if not exists public.races (
  id                  bigserial primary key,
  name                text unique not null,
  description         text,
  source              text default 'Greyhawk'
);

create table if not exists public.classes (
  id                  bigserial primary key,
  name                text unique not null,
  description         text,
  hit_die             text,
  primary_stat        text,
  source              text default 'Greyhawk'
);

create table if not exists public.monsters (
  id                  bigserial primary key,
  name                text not null,
  ac                  text,
  hp_dice             text,
  thac0               text,
  damage              text,
  move                text,
  alignment           text,
  description         text,
  source              text default 'Greyhawk'
);
create index if not exists idx_monsters_name on public.monsters (name);

-- =====================================================================
-- TOEGANGSRECHTEN
-- =====================================================================
-- Geen Row Level Security — dit project gebruikt eigen authenticatie.
-- De Supabase publishable key heeft enkel de 'anon' role.
-- Alles staat open voor 'anon' want we vertrouwen de groep gebruikers.
-- Als je dit publiek maakt: zet RLS aan en schrijf policies.

grant usage on schema public to anon;
grant all on all tables in schema public to anon;
grant all on all sequences in schema public to anon;
alter default privileges in schema public grant all on tables to anon;
alter default privileges in schema public grant all on sequences to anon;

-- Klaar! Nu 02_seed.sql draaien voor de basis encyclopedie.
