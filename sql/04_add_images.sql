-- =====================================================================
-- Greyhawk Campaign Manager — Migratie: image_url op encyclopedie
-- =====================================================================
-- Voeg image_url text-kolom toe aan alle encyclopedie-tabellen.
--
-- Het veld accepteert:
--   - een externe URL (bv. https://fan-wiki/dwarf.jpg)
--   - een data-URL met base64 inline (bv. "data:image/jpeg;base64,...")
--   - NULL (geen afbeelding)
--
-- Veilig om opnieuw te draaien.
-- =====================================================================

alter table public.weapons      add column if not exists image_url text;
alter table public.spells       add column if not exists image_url text;
alter table public.items        add column if not exists image_url text;
alter table public.monsters     add column if not exists image_url text;
alter table public.races        add column if not exists image_url text;
alter table public.classes      add column if not exists image_url text;
alter table public.skills       add column if not exists image_url text;
alter table public.weapon_types add column if not exists image_url text;

-- Klaar. Refresh de app — DM kan nu in de edit/add modal een afbeelding
-- toevoegen via URL of upload (max ~2 MB voor base64).
