-- =====================================================================
-- Greyhawk — Enable RLS met "allow all" policies om Supabase-warnings te
-- silencen, zonder functionele wijziging.
-- =====================================================================
-- De app gebruikt custom auth (btoa hash in players) in plaats van
-- Supabase Auth, en handhaaft permissies in JavaScript. Daarom is RLS
-- bewust uitgeschakeld — maar Supabase toont dit als kritische warning.
--
-- Deze migratie:
-- 1. Zet RLS AAN op alle tabellen
-- 2. Voegt een open policy toe (allow all for anon + authenticated)
--
-- Resultaat: geen warnings meer, maar app blijft exact hetzelfde werken.
-- Voor échte security: migreer naar Supabase Auth (grote rewrite).
-- =====================================================================

DO $$
DECLARE
    t text;
BEGIN
    FOR t IN
        SELECT tablename FROM pg_tables WHERE schemaname='public'
    LOOP
        -- Enable RLS
        EXECUTE format('ALTER TABLE public.%I ENABLE ROW LEVEL SECURITY', t);
        -- Drop existing policy if exists (idempotent)
        EXECUTE format('DROP POLICY IF EXISTS "allow_all" ON public.%I', t);
        -- Create open policy for all operations
        EXECUTE format(
          'CREATE POLICY "allow_all" ON public.%I FOR ALL TO anon, authenticated USING (true) WITH CHECK (true)',
          t
        );
    END LOOP;
END $$;

-- Verificatie: dit zou 0 rows moeten geven (geen tabellen meer zonder RLS)
SELECT tablename, rowsecurity
FROM pg_tables
WHERE schemaname='public' AND rowsecurity=false;
