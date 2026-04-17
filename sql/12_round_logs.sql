-- Extra kolommen op action_log voor ronde-beheer
ALTER TABLE public.action_log ADD COLUMN IF NOT EXISTS is_dm_entry boolean default false;
ALTER TABLE public.action_log ADD COLUMN IF NOT EXISTS deferred boolean default false;
ALTER TABLE public.action_log ADD COLUMN IF NOT EXISTS extra_attack boolean default false;

-- Extra kolom op action_participants voor "uitgesteld" en "extra aanval"
ALTER TABLE public.action_participants ADD COLUMN IF NOT EXISTS deferred boolean default false;
ALTER TABLE public.action_participants ADD COLUMN IF NOT EXISTS extra_attack boolean default false;
