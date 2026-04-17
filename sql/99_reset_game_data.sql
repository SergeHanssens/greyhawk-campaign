-- =====================================================================
-- Greyhawk — RESET: verwijder alle spel-data voor een frisse start
-- =====================================================================
-- ⚠️ LET OP: dit verwijdert ALLE spelers, karakters, sessies, logs!
-- De encyclopedie (wapens, spreuken, monsters, etc.) blijft BEHOUDEN.
--
-- Gebruik dit als de DM wil testen vanaf een schone lei.
-- Na het draaien: registreer opnieuw een DM-account via de app.
-- =====================================================================

-- Volgorde is belangrijk (foreign keys)
DELETE FROM public.action_log;
DELETE FROM public.action_participants;
DELETE FROM public.session_actions;
DELETE FROM public.dice_rolls;
DELETE FROM public.chat_messages;
DELETE FROM public.combat_actions;
DELETE FROM public.session_logs;
DELETE FROM public.session_participants;
DELETE FROM public.sessions;
DELETE FROM public.character_log;
DELETE FROM public.character_opens;
DELETE FROM public.character_weapons;
DELETE FROM public.character_items;
DELETE FROM public.character_skills;
DELETE FROM public.character_spells;
DELETE FROM public.characters;
DELETE FROM public.csv_imports;
DELETE FROM public.players;

-- Reset app_settings
UPDATE public.app_settings SET value='' WHERE key='dm_map_url';

-- =====================================================================
-- Klaar! Ga naar de app → klik het kleine "DM: eerste account aanmaken"
-- knopje onderaan het loginscherm → registreer met DM Code.
-- =====================================================================
