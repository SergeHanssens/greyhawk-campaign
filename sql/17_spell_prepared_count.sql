-- =====================================================================
-- Greyhawk — Spreuken meerdere keren memoriseren
-- =====================================================================
-- In AD&D 2E mag je dezelfde spreuk meerdere keren memoriseren; elke
-- keer kost één slot en geeft één cast. 'prepared' blijft de schakelaar
-- (bereid ja/nee), 'prepared_count' telt hoe vaak de spreuk vandaag
-- gememoriseerd is.
--
-- Veilig om meerdere keren uit te voeren.
-- =====================================================================

ALTER TABLE public.character_spells
  ADD COLUMN IF NOT EXISTS prepared_count integer NOT NULL DEFAULT 0;

-- Bestaande bereide spreuken: 1 keer gememoriseerd
UPDATE public.character_spells SET prepared_count = 1 WHERE prepared = true  AND prepared_count < 1;
UPDATE public.character_spells SET prepared_count = 0 WHERE prepared IS NOT TRUE AND prepared_count <> 0;

-- Laat de API de nieuwe kolom meteen zien
NOTIFY pgrst, 'reload schema';
