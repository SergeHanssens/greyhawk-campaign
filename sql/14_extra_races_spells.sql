-- =====================================================================
-- Greyhawk — Extra rassen + spreuken voor karakter-imports
-- =====================================================================
-- Toegevoegd om imports zoals Nameless One (Saurial) volledig te
-- dekken in de encyclopedie.
-- Idempotent: gebruikt WHERE NOT EXISTS om duplicaten te voorkomen.
-- =====================================================================

-- ---------------------------------------------------------------------
-- EXTRA RASSEN
-- ---------------------------------------------------------------------
INSERT INTO public.races (name, description)
SELECT v.name, v.description FROM (VALUES
  ('Saurial',
   'Saurials zijn intelligente, hagedisachtige humanoiden uit een andere wereld. Lengte 2,5-3 m, gewicht 350-400 kg. Geen haar, donkere ogen. Vier subrassen: Hornhead (krijger-priesters), Bladeback (krijger-strijders), Flyer (bewakers/scouts), Finhead (denkers/diplomaten). Bonus: infravision 60ft. Hun vocale apparaat kan geen mensentaal vormen — ze begrijpen Common maar spreken alleen Saurial of via gebaren. Take damage as Large creature. Kwetsbaar voor koude. Reactie-aanpassing -7. Natuurlijke wapens: 2 klauwen (1d4), staart (2d4), evt. hoorn.'),
  ('Half-Giant',
   'Half-Giants zijn nakomelingen van mensen en stone/hill giants — 3 tot 3,7 m hoog, 750+ kg. STR-bonus +4, CON +2, INT -2, DEX -2, WIS -2. Take damage als Large creature.'),
  ('Aarakocra',
   'Vogel-mensen — 2,3 m hoog met 6 m vleugelspan. Vliegt met 36" speed. AC 7 natuurlijk. Speerwerper meesters.'),
  ('Centaur (PC)',
   'Mens-paard hybride als speelbare race. Lengte 2,7 m, gewicht 800-1000 kg. Movement 18". STR +1, CON +2, DEX -1. Take damage als Large.')
) AS v(name, description)
WHERE NOT EXISTS (SELECT 1 FROM public.races r WHERE r.name = v.name);

-- ---------------------------------------------------------------------
-- EXTRA MAGIC-USER SPREUKEN
-- ---------------------------------------------------------------------
INSERT INTO public.spells (name, level, class, range, duration, area, description)
SELECT v.name, v.level, v.class, v.range, v.duration, v.area, v.description FROM (VALUES
  ('Fist of Stone', 1, 'Magic-User', '0', '1 rd/lvl', 'caster',
   'Caster''s vuist verandert in steen. +6 dmg op melee aanvallen, doet 1d6+6 schade. Geen wapens hanteren tijdens duration.'),
  ('Past Life', 2, 'Magic-User', '0', 'special', 'caster',
   'Caster ziet flits van vorige leven of incarnatie. DM-tool voor verhaal-revelations.'),
  ('Firestaff', 2, 'Magic-User', 'touch', '1 turn/lvl', 'one staff',
   'Maakt een gewone staf magisch — doet 1d6 fire damage extra.'),
  ('Wizard Sight', 3, 'Magic-User', '0', '1 rd/lvl', 'caster',
   'Caster ziet alle magie-auras + onzichtbare wezens + illusies in 30ft.'),
  ('Alustriel''s Fundamental Breakthrough', 3, 'Magic-User', 'touch', 'permanent', '1 spell',
   'Helpt een caster om een 4e-niveau spreuk te leren. Eénmalig. Component: V, S, M (juweel 500gp).'),
  ('Melf''s Minute Meteor', 3, 'Magic-User', '70ft + 10ft/lvl', '1 rd/lvl', '1 target/round',
   'Creëert kleine meteoren — per ronde één afgeschoten. Elk doet 1d4 fire damage.'),
  ('Wind Breath', 4, 'Magic-User', '0', '1 rd/lvl', '60ft cone',
   'Caster blaast krachtige windvlaag. Wezens push back, missile attacks deflected.'),
  ('Turn Pebble into Boulder', 4, 'Magic-User', '60ft', '1 rd/lvl', '1 pebble',
   'Vergroot een steen tot massieve rotsblok. Werpbaar of als hindernis. 4d6 dmg bij worp.'),
  ('Fire Aura', 4, 'Magic-User', '0', '1 rd/lvl', 'caster',
   'Vurig aureool rond caster. 1d6 fire dmg per ronde aan iedereen die in melee komt.'),
  ('Extension II', 4, 'Magic-User', '0', 'instant', '1 spell',
   'Verlengt een actieve spell van level 1-4 met 50%.'),
  ('Advanced Illusion', 5, 'Magic-User', '60ft + 10ft/lvl', '1 rd/lvl', '40ft cube + 10ft/lvl',
   'Verbeterde Phantasmal Force — illusoire scenes met geluid, geur en temperatuur. Beweegt zonder concentratie.'),
  ('Dismissal', 5, 'Magic-User', '10ft', 'instant', '1 extraplanar creature',
   'Stuurt een buitenwereldlijk wezen terug naar zijn thuisplane. Devastating tegen demons/devils.'),
  ('Passwall', 5, 'Magic-User', '30ft', '6 turns + 1/lvl', '5x8x10ft tunnel',
   'Creëert tijdelijke doorgang door steen.'),
  ('Seeming', 5, 'Magic-User', '10ft', '12 hours', '2 persons/lvl',
   'Verandert het uiterlijk van meerdere wezens — illusoir.'),
  ('Contact Other Plane', 5, 'Magic-User', '0', '1 rd/lvl', 'caster',
   'Caster contacteert wezen op ander plane voor ja/nee vragen. Risico: INT damage.'),
  ('Repulsion', 6, 'Magic-User', '60ft', '1 rd + 1/3 rd/lvl', '10ft path',
   'Wezens binnen path worden weggeduwd van caster.'),
  ('Guards and Wards', 6, 'Magic-User', '0', '2 hr/lvl', '2500 sq ft area',
   'Beschermt een gebouw met meerdere effecten: misty corridors, magic mouth, web in gangen.'),
  ('Mordenkainen''s Lucubration', 6, 'Magic-User', '0', 'instant', 'caster',
   'Caster recovers één level 1-5 spell die hij die dag al gecast heeft.'),
  ('Tenser''s Transformation', 6, 'Magic-User', '0', '1 rd/lvl', 'caster',
   'Caster transformeert in superkrijger. HP verdubbelen, +4 to hit, save als Fighter. Verliest spreuken.'),
  ('Continual Light', 2, 'Magic-User', '60ft', 'permanent until dispelled', '60ft radius',
   'Zoals Light maar permanent. Kan op object cast.'),
  ('Wizard Lock', 2, 'Magic-User', 'touch', 'permanent', '30 sq ft door/portal',
   'Magisch vergrendelt een deur, kist of portal.')
) AS v(name, level, class, range, duration, area, description)
WHERE NOT EXISTS (SELECT 1 FROM public.spells s WHERE s.name = v.name AND s.level = v.level);

-- ---------------------------------------------------------------------
-- EXTRA MAGISCHE ITEMS
-- ---------------------------------------------------------------------
INSERT INTO public.items (name, category, weight, cost, description)
SELECT v.name, v.category, v.weight, v.cost, v.description FROM (VALUES
  ('Staff of Striking', 'magic', 60, '7500',
   'Magische staf, +3 to hit, doet 2d6+3 dmg. Heeft 25 charges. M-U/Cleric/Druid only.'),
  ('Ring of Invisibility', 'magic', 0, '30000',
   'Drager wordt invisible bij wens. Bij aanvallen breekt invisibility.'),
  ('Ring of Regeneration', 'magic', 0, '90000',
   'Drager regenereert 1 HP per turn (10 minuten). Werkt niet op fire/acid damage.'),
  ('Hornhead Staff', 'magic', 60, '5000',
   'Saurial-specifieke staf, gemaakt uit hoorn-materiaal. Doet 2d6 bludgeoning. Niet-saurials -1 to hit.'),
  ('Sholar Outfit', 'armor', 50, '100',
   'Robe + cloak van Sholar-orde. Geeft AC 8 base. Beschermt tegen koude.'),
  ('Silver Ring of Chrysobyl', 'magic', 0, '10000',
   'Zilveren ring met chrysobyl-edelsteen. Beschermt tegen petrification van cockatrices/basilisks.'),
  ('Potion of Ereadn', 'potion', 5, '500',
   'Custom potion gemaakt door wizard Ereadn. Effect varieert per batch.')
) AS v(name, category, weight, cost, description)
WHERE NOT EXISTS (SELECT 1 FROM public.items i WHERE i.name = v.name);

-- =====================================================================
-- KLAAR! Veilig om opnieuw te draaien.
-- =====================================================================
