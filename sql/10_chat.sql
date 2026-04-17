-- =====================================================================
-- Greyhawk — Chat per sessie (algemeen + groep + privé)
-- =====================================================================
-- channel bepaalt wie het bericht ziet:
--   'all'         = iedereen in de sessie
--   'dm'          = alleen de DM (fluisteren naar DM)
--   'player:uuid' = alleen die specifieke speler + afzender + DM
--   'group:uuid1,uuid2,...' = groepje spelers + afzender + DM
-- =====================================================================

create table if not exists public.chat_messages (
  id              uuid        primary key default gen_random_uuid(),
  session_id      uuid        not null references public.sessions(id) on delete cascade,
  sender_id       uuid        not null references public.players(id),
  sender_name     text,
  channel         text        not null default 'all',
  channel_label   text,          -- display naam bv. "Fluister naar Bart", "Groep: Serge, Jan"
  message         text        not null,
  is_dm_message   boolean     default false,
  created_at      timestamptz default now()
);

create index if not exists idx_chat_session on public.chat_messages (session_id, created_at);

alter table public.chat_messages disable row level security;
grant all on public.chat_messages to anon, authenticated;
