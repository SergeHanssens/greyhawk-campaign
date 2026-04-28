-- =====================================================================
-- Greyhawk — Extra rassen + spreuken voor karakter-imports
-- =====================================================================
-- Toegevoegd om imports zoals Nameless One (Saurial) volledig te
-- dekken in de encyclopedie.
-- Veilig om opnieuw te draaien (ON CONFLICT DO NOTHING).
-- =====================================================================

-- ---------------------------------------------------------------------
-- EXTRA RASSEN
-- ---------------------------------------------------------------------
insert into public.races (name, description) values
  ('Saurial',
   'Saurials zijn intelligente, hagedisachtige humanoiden uit een andere wereld. Lengte 2,5-3 m, gewicht 350-400 kg. Geen haar, donkere ogen. Vier subrassen: Hornhead (krijger-priesters), Bladeback (krijger-strijders), Flyer (bewakers/scouts), Finhead (denkers/diplomaten). Bonus: infravision 60ft. Hun vocale apparaat kan geen mensentaal vormen — ze begrijpen Common maar spreken alleen Saurial of via gebaren. Take damage as Large creature. Kwetsbaar voor koude: weerstaat 10 turns lange koude, daarna koude-slaap (1-2 dagen warmte = revival, langer = dood). Reactie-aanpassing -7 (mensen zijn vaak bang). Polymorph-talent bij sommigen. Niet-Saurial weapon proficiencies krijgen -1 to hit (vingers en klauwen verschillen). Natuurlijke wapens: 2 klauwen (1d4 elk), staart (2d4), evt. hoorn. Religie: vaak Greater Powers van hun thuisland, soms geadopteerde Greyhawk goden zoals Boccob.'),
  ('Half-Giant',
   'Half-Giants zijn nakomelingen van mensen en stone/hill giants — 3 tot 3,7 m hoog, 750+ kg. STR-bonus +4, CON +2, INT -2, DEX -2, WIS -2. Take damage als Large creature. Origineel uit Dark Sun, soms in Greyhawk als zeldzame bezoekers.'),
  ('Aarakocra',
   'Vogel-mensen — 2,3 m hoog met 6 m vleugelspan. Vliegt met 36" speed. Kan niet lopen op land lager dan 1" (staart en poten zijn vluchtgericht). Speerwerper meesters. CON 14+, DEX 10+ vereist. AC 7 natuurlijk. Vermijdt grond-conflicten.'),
  ('Centaur (PC)',
   'Mens-paard hybride als speelbare race in sommige campaigns. Lengte 2,7 m, gewicht 800-1000 kg. Movement 18". STR +1, CON +2, DEX -1. Take damage als Large. Kan niet door normale deuren of gangen kleiner dan 8 voet.')
on conflict (name) do nothing;

-- ---------------------------------------------------------------------
-- EXTRA MAGIC-USER SPREUKEN (level 1-6)
-- ---------------------------------------------------------------------
insert into public.spells (name, level, class, range, duration, area, description) values
  ('Fist of Stone', 1, 'Magic-User', '0', '1 rd/lvl', 'caster',
   'Caster''s vuist verandert in steen. +6 dmg op melee aanvallen, doet 1d6+6 schade. Geen wapens hanteren of components hanteren tijdens duration. Component: V, S, M (klein steen).'),
  ('Past Life', 2, 'Magic-User', '0', 'special', 'caster',
   'Caster ziet flits van vorige leven of incarnatie van zichzelf of doelwit. DM-tool voor verhaal-revelations. Save vs spell of zien een vorige leven (random). Component: V, S, M (zilveren spiegel).'),
  ('Firestaff', 2, 'Magic-User', 'touch', '1 turn/lvl', 'one staff',
   'Maakt een gewone staf magisch — doet 1d6 fire damage extra. Werkt alleen voor caster. Vereist een staff. Component: V, S, M (zwavel + ijzer).'),
  ('Wizard Sight', 3, 'Magic-User', '0', '1 rd/lvl', 'caster',
   'Caster ziet alle magie-auras + onzichtbare wezens + illusies in 30ft. Identificeert school van magie. Component: V, S, M (kristallen lens).'),
  ('Alustriel''s Fundamental Breakthrough', 3, 'Magic-User', 'touch', 'permanent', '1 spell',
   'Helpt een caster om een 4e-niveau spreuk te leren waar hij anders moeite mee heeft. Eénmalig. Component: V, S, M (juweel 500gp).'),
  ('Melf''s Minute Meteor', 3, 'Magic-User', '70ft + 10ft/lvl', '1 rd/lvl', '1 target/round',
   'Creëert kleine meteoren die per ronde één afgeschoten kan worden. Elk doet 1d4 fire damage. Tot caster level meteoren. Component: V, S, M (nitre + zwavel + pine tar).'),
  ('Wind Breath', 4, 'Magic-User', '0', '1 rd/lvl', '60ft cone',
   'Caster blaast krachtige windvlaag uit zijn mond. 30ft brede cone. Wezens push back, missile attacks deflected, kleine vlammen gedoofd. Component: V, S.'),
  ('Turn Pebble into Boulder', 4, 'Magic-User', '60ft', '1 rd/lvl', '1 pebble',
   'Vergroot een steen tot massieve rotsblok. Werpbaar of als hindernis. 4d6 dmg bij worp. Component: V, S, M (de steen zelf).'),
  ('Fire Aura', 4, 'Magic-User', '0', '1 rd/lvl', 'caster',
   'Vurig aureool rond caster. 1d6 fire dmg per ronde aan iedereen die in melee komt. Caster zelf onaangetast. Component: V, S, M (vlam-gem).'),
  ('Extension II', 4, 'Magic-User', '0', 'instant', '1 spell',
   'Verlengt een actieve spell van level 1-4 met 50%. Bv. Mirror Image van 3 rd/lvl wordt 4.5 rd/lvl. Component: V.'),
  ('Advanced Illusion', 5, 'Magic-User', '60ft + 10ft/lvl', '1 rd/lvl', '40ft cube + 10ft/lvl',
   'Verbeterde Phantasmal Force — illusoire scenes met geluid, geur en temperatuur. Beweegt zonder concentratie. Component: V, S, M (rabbit fur + glass rod).'),
  ('Dismissal', 5, 'Magic-User', '10ft', 'instant', '1 extraplanar creature',
   'Stuurt een buitenwereldlijk wezen terug naar zijn thuisplane. Save vs spell met +HD verschil. Devastating tegen demons/devils. Component: V, S, M.'),
  ('Passwall', 5, 'Magic-User', '30ft', '6 turns + 1/lvl', '5x8x10ft tunnel',
   'Creëert tijdelijke doorgang door steen. Caster en groep kunnen door. Component: V, S, M (sesame seed).'),
  ('Seeming', 5, 'Magic-User', '10ft', '12 hours', '2 persons/lvl',
   'Verandert het uiterlijk van meerdere wezens — illusoir. Zoals Disguise Self maar voor groep. Component: V, S, M.'),
  ('Contact Other Plane', 5, 'Magic-User', '0', '1 rd/lvl', 'caster',
   'Caster contacteert wezen op ander plane (Astral, Outer Plane, Inner Plane) voor ja/nee vragen. Risico: INT damage of insanity bij hoge planes. Component: V.'),
  ('Repulsion', 6, 'Magic-User', '60ft', '1 rd + 1/3 rd/lvl', '10ft path',
   'Wezens binnen path worden weggeduwd van caster. Geen save als zwakker dan caster. Component: V, S, M (ivoren staaf).'),
  ('Guards and Wards', 6, 'Magic-User', '0', '2 hr/lvl', '2500 sq ft area',
   'Beschermt een gebouw/dungeon met meerdere effecten: misty corridors, verwarrende doors, magic mouth, web in gangen, etc. Voor permanent maken: ook permanency. Component: V, S, M (uitgebreid).'),
  ('Mordenkainen''s Lucubration', 6, 'Magic-User', '0', 'instant', 'caster',
   'Caster recovers één level 1-5 spell die hij die dag al gecast heeft. Kost 1 turn meditatie. Component: V, S, M (3000gp gem).'),
  ('Tenser''s Transformation', 6, 'Magic-User', '0', '1 rd/lvl', 'caster',
   'Caster transformeert in superkrijger. HP verdubbelen, +4 to hit, save als Fighter, dmg als Fighter, alle wapens + pantsers. Verliest spreuken. Component: V, S, M (potion of bull''s strength + heroism).'),
  ('Continual Light', 2, 'Magic-User', '60ft', 'permanent until dispelled', '60ft radius',
   'Zoals Light maar permanent. Kan op object cast. Component: V, S, M.'),
  ('Wizard Lock', 2, 'Magic-User', 'touch', 'permanent', '30 sq ft door/portal',
   'Magisch vergrendelt een deur, kist of portal. Higher-level caster, knock, of dispel magic opent het. Component: V, S.')
on conflict do nothing;

-- ---------------------------------------------------------------------
-- EXTRA MAGISCHE ITEMS
-- ---------------------------------------------------------------------
insert into public.items (name, category, weight, cost, description) values
  ('Staff of Striking', 'magic', 60, 7500,
   'Magische staf, +3 to hit, doet 2d6+3 dmg. Heeft 25 charges. Geen charge gebruikt voor normale aanval, 1 charge voor double dmg, 2 charges voor triple. M-U/Cleric/Druid only. Re-charge mogelijk.'),
  ('Ring of Invisibility', 'magic', 0, 30000,
   'Drager wordt invisible bij wens. Bij aanvallen breekt invisibility. Onbeperkt aantal keer per dag (in sommige edities 15 charges). Klassiek magisch item.'),
  ('Ring of Regeneration', 'magic', 0, 90000,
   'Drager regenereert 1 HP per turn (10 minuten). Brengt drager terug van -10 HP als ring gedragen werd op moment van dood. Werkt niet op fire/acid damage. Onmisbaar voor frontlinkers.'),
  ('Hornhead Staff', 'magic', 60, 5000,
   'Saurial-specifieke staf, gemaakt uit hoorn-materiaal van Hornhead Saurial. Doet 2d6 bludgeoning. Niet-saurials hanteren met -1 to hit.'),
  ('Sholar Outfit', 'armor', 50, 100,
   'Robe + cloak van Sholar-orde. Geeft AC 8 base. Beschermt tegen koude (Saurial weakness). Insignia van Sagious Society.'),
  ('Silver Ring of Chrysobyl', 'magic', 0, 10000,
   'Zilveren ring met chrysobyl-edelsteen. Beschermt tegen petrification van cockatrices (immuun) en basilisks (+4 save). Custom magic item.'),
  ('Potion of Ereadn', 'potion', 5, 500,
   'Custom potion gemaakt door wizard Ereadn. Effect varieert per batch — check met DM. Vaak healing of buff voor 1 turn.')
on conflict do nothing;

-- ---------------------------------------------------------------------
-- KLAAR! Nu kan je Nameless One importeren zonder ⚠ warnings.
-- =====================================================================
