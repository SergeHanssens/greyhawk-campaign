-- =====================================================================
-- Greyhawk — Admin rol toevoegen
-- =====================================================================
-- Admin = app-onderhoud (encyclopedie, accounts, imports) maar GEEN
-- DM-privileges (geen DM notities, geen geplande sessies, etc.)
-- =====================================================================

ALTER TABLE public.players ADD COLUMN IF NOT EXISTS is_admin boolean default false;

-- Maak Serge admin (vervang 'serge' door je echte gebruikersnaam)
UPDATE public.players SET is_admin = true WHERE username = 'serge';
