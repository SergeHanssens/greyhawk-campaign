-- =====================================================================
-- Greyhawk Campaign Manager — Encyclopedie uitbreiding (extra)
-- =====================================================================
-- Run dit NA 02_seed.sql.
--
-- Voegt ~200 extra entries toe: Magic-User spreuken lvl 4-9, hogere
-- Cleric/Druid spreuken, magische items (rings, wands, weapons, armor),
-- exotische wapens, en een veel uitgebreider bestiarum (devils, demons,
-- dragons, ondoden, jungle/aquatic monsters).
--
-- Veilig om opnieuw te draaien.
-- =====================================================================

-- ---------------------------------------------------------------------
-- WAPENS — uitbreiding (oriental, exotic, antieke, missile)
-- ---------------------------------------------------------------------
insert into public.weapons (name, weapon_type, damage, speed_factor, weight, type, description) values
  ('Katana','Sword','1d10',4,75,'Slashing',
   'Oosters tweehands zwaard met enkele snede van 28-30 inches. Vereist hoge skill — gebruikers krijgen +1 to hit met training. Schade: 1d10/1d12. Geliefd door samurai en ronin uit het Oosten.'),
  ('Wakizashi','Sword','1d8',3,40,'Slashing',
   'Korte companion-blade van 16-22 inches die met de katana de daisho vormt. Symboliseert eer voor samurai. Schade: 1d8/1d8.'),
  ('Tanto','Dagger','1d4',2,15,'Piercing',
   'Oosterse dolk met enkele snede. Snel en discreet. Schade: 1d4/1d3.'),
  ('Naginata','Polearm','1d8',8,80,'Slashing',
   'Oosters polearm met gebogen blade op 6-voet handvat. Mounted-friendly. Schade: 1d8/1d10.'),
  ('Sai','Exotic','1d4',4,12,'Piercing',
   'Driepuntige metalen knuppel — gebruikt in pairs. Defensief, kan zwaard parry of breken (save vs item). Schade: 1d4/1d4.'),
  ('Nunchaku','Exotic','1d6',3,30,'Bludgeoning',
   'Twee houten staafjes verbonden met ketting. Vereist training. Negeert deels schild. Schade: 1d6/1d6.'),
  ('Kama','Axe','1d6',3,30,'Slashing',
   'Sikkel op kort handvat — boerenwapen door de eeuwen tot oosters wapen geëvolueerd. Schade: 1d6/1d4.'),
  ('Bo Staff','Staff','1d6',2,40,'Bludgeoning',
   '6-voet houten staaf, oosterse martial-arts variant. Snelste melee tweehands wapen. Schade: 1d6/1d4.'),
  ('Jo Stick','Staff','1d4',2,30,'Bludgeoning',
   '4-voet variant — gespecialiseerd in disarming en grappling. Schade: 1d4/1d4.'),
  ('Shuriken','Throwing','1',2,2,'Piercing',
   'Werpster — vaak vergiftigd. Range 1/2/3. Per ronde tot 3 shuriken werpbaar. Schade: 1 hp (gif doet rest).'),
  ('Scourge','Whip','1d4',6,30,'Slashing',
   'Multi-tail whip met metalen punten. Reach 5ft. Schade: 1d4/1d2. Beul-wapen.'),
  ('Bola','Throwing','1d3',8,30,'Special',
   'Drie verzwaarde ballen aan touwen. Range 2/4/6. Bij hit: doelwit moet save vs paralysis of vallen + benen geketend. Schade: 1d3/1d2.'),
  ('Javelin','Spear','1d6',4,20,'Piercing',
   'Lichte werpspeer. Range 2/4/6. Schade: 1d6/1d6. Geliefd door Romeins-stijl infanterie en velites.'),
  ('Trident','Spear','1d6+1',7,50,'Piercing',
   'Driepuntige speer. Werpbaar (range 1/2/3). Geliefd door visser-strijders en gladiators. Schade: 1d6+1/3d4.'),
  ('Boomerang','Throwing','1d4',5,15,'Bludgeoning',
   'Gebogen werp-stok die terugkeert (bij gemis). Range 3/6/9. Schade: 1d4/1d4. Aboriginal/Australian origins.'),
  ('Atlatl + Dart','Throwing','1d6',6,5,'Piercing',
   'Spear-thrower hefboom voor extra range. Range 4/8/12. Schade: 1d6/1d4.'),
  ('Greatsword (Claymore)','Sword','2d6',8,150,'Slashing',
   'Schotse tweehands variant met basket-hilt. Schade: 2d6/2d8. Vereist STR 15.'),
  ('Estoc','Sword','1d8',4,80,'Piercing',
   'Lange rapier-variant ontworpen om mail te doorboren met thrust. Schade: 1d8/2d4.'),
  ('Mancatcher','Polearm','0',8,80,'Special',
   'Polearm met scharen-kop om vijand vast te grijpen zonder schade. Voor arrestatie. Save vs paralysis of vastzitten.'),
  ('Lance','Polearm','1d8',7,150,'Piercing',
   'Lange ridder-spear voor mounted charge. Schade: 1d6+1 unmounted, 2d4 mounted, 3d6 op charge. Geliefd door Cavaliers.'),
  ('Hand Hammer (Maul)','Hammer','2d4',9,200,'Bludgeoning',
   'Reuze tweehands hamer. Schade: 2d4/3d4. Geliefd door Dwarves en pionniers.'),
  ('Garrot','Exotic','1d6',2,2,'Piercing',
   'Wire of cord voor stranguleren vanuit hinderlaag. Vereist surprise. Schade: 1d6/dood na 1d6 rondes als grip behouden. Assassin-favoriet.')
on conflict do nothing;

-- ---------------------------------------------------------------------
-- SPREUKEN — UITBREIDING (Magic-User Lv 4-9, Cleric Lv 4-7, Druid Lv 4-7)
-- ---------------------------------------------------------------------
insert into public.spells (name, level, class, range, duration, area, description) values
  -- ============ MAGIC-USER LEVEL 4 ============
  ('Charm Monster',4,'Magic-User','60ft','special','varies',
   'Werkt zoals Charm Person maar op alle wezens incl. monsters. Aantal HD beïnvloed: 3 HD wezens (bv. 2d4 bugbears) of 1 wezen van 4+ HD. Save vs spell. Duration baseert op INT van slachtoffer (1d6 dagen tot maanden). Component: V, S.'),
  ('Dimension Door',4,'Magic-User','0','instant','caster + cargo',
   'Caster + max 500 lbs teleporteert tot 30ft per caster level naar gekozen punt. Geen save, kan binnenshuis. Levensreddend voor oorlog of verkenning. Component: V.'),
  ('Polymorph Other',4,'Magic-User','5ft/lvl','permanent','1 creature',
   'Verandert doelwit in elke vorm tot 2x grootte. Slachtoffer save vs spell of permanente vorm. Bij failure: System Shock check (CON%) of dood. Krachtige maar gevaarlijke spell. Component: V, S, M.'),
  ('Wall of Ice',4,'Magic-User','10ft/lvl','1 turn/lvl','1000 sq ft per lvl',
   'IJsmuur 1ft dik per caster level. HP per inch x caster level. Cold dmg: 4d6 om door te gaan. Schade aan fire-creatures: 1d10. Component: V, S, M (rock crystal).'),
  ('Stoneskin',4,'Magic-User','touch','1 hr/lvl','1 creature',
   'Doelwit immuun voor 1d4+caster-level fysieke aanvallen — elk steelt 1 lading. Magic damage gaat door. Levensbehoeder voor M-U in melee. Component: V, S, M (granite chip + diamond dust).'),

  -- ============ MAGIC-USER LEVEL 5 ============
  ('Wall of Force',5,'Magic-User','30ft','1 turn + 1 rd/lvl','20 sq ft per lvl',
   'Onzichtbare, onvernietigbare muur (behalve disintegrate). Stopt vrijwel alle aanvallen + spreuken. Maximum redder. Component: V, S, M (poeder van diamant).'),
  ('Conjure Elemental',5,'Magic-User','60ft','1 turn/lvl','one elemental',
   'Roept Air/Earth/Fire/Water Elemental (8/12/16 HD). Concentratie vereist — verlies = elemental keert tegen caster. Voor advanced caster only. Component: V, S, M (verschillend per element).'),
  ('Magic Jar',5,'Magic-User','10ft/lvl','special','caster',
   'Caster sleutelt zijn ziel in een gem. Kan dan een levend wezen mentaal overnemen (save vs spell met INT-penalty). Macabre maar krachtig. Component: V, S, M (gem 100+ gp).'),
  ('Animate Dead',5,'Magic-User','10ft','permanent','1 corpse/lvl',
   'Zoals cleric versie maar met M-U flair. Skeletons en zombies onder caster controle.'),

  -- ============ MAGIC-USER LEVEL 6 ============
  ('Disintegrate',6,'Magic-User','5ft + 5/lvl','instant','1 creature/object',
   'Doelwit save vs spell of TOTAAL vernietigd (tot 10x10x10 ft of 1 wezen). Werkt op dragons, walls, anything material. De ultieme delete-spell. Component: V, S, M (magnet + venijn).'),
  ('Project Image',6,'Magic-User','5ft + 5/lvl','1 rd/lvl','double of caster',
   'Creëert visueel dubbel van caster tot 240ft afstand. Cast spells via image, maar zonder kracht. Mooi voor angst en misleiding. Component: V, S, M.'),
  ('Death Spell',6,'Magic-User','10ft + 10/lvl','instant','60ft cube/lvl',
   'Tot 4d20 levels aan wezens onder 9 HD: dood (geen save). Apocalyptic crowd-clear. Geen ondoden, geen extraplanar. Component: V, S, M (skull powder).'),
  ('Stone to Flesh',6,'Magic-User','10ft/lvl','permanent','1 cu yd / lvl',
   'Verandert steen in vlees — kan petrified karakter genezen (CON% check). Of barricade openen. Component: V, S, M (clay + water).'),

  -- ============ MAGIC-USER LEVEL 7 ============
  ('Limited Wish',7,'Magic-User','unlimited','special','varies',
   'Beperkte wens — kleine veranderingen aan realiteit. Genees dodelijke wonden, herstel verwoest item, redder van character van zekere dood. DM ruling. Veroudert caster 1 jaar. Component: V.'),
  ('Power Word, Stun',7,'Magic-User','5ft/lvl','varies','1 creature',
   'Eén woord verlamt wezen onder 35 HP voor 4d4 rondes, 35-65 HP voor 2d4 rondes, 66-95 HP voor 1d4 rondes. Boven 95 HP: geen effect. Geen save. Component: V.'),
  ('Mass Invisibility',7,'Magic-User','120ft','special','300 sq ft area',
   'Tot 240 mannen in 30x30ft gebied invisible. Voor oorlogs-verassingen. Component: V, S, M (eyelash + gum).'),

  -- ============ MAGIC-USER LEVEL 8 ============
  ('Power Word, Blind',8,'Magic-User','5ft/lvl','varies','15ft radius',
   'Eén woord verblindt wezens in gebied. Onder 100 HP: permanent. 100+ HP: 1d4+1 turns. Geen save. Component: V.'),
  ('Mind Blank',8,'Magic-User','30ft','1 day','1 creature',
   'Doelwit immuun voor ALLE mentale aanvallen: charm, fear, confusion, ESP, magic jar, telepathy, suggest, mass charm, possession. De ultieme bescherming tegen psionic of mentaal. Component: V, S.'),
  ('Polymorph Any Object',8,'Magic-User','5ft/lvl','varies','1 object/wezen',
   'Verander elk in elk: stenen in olifanten, vijand in muis, jezelf in wolf. Duration en realisme afhankelijk van afstand tussen origine en target. Veelzijdigste M-U spell. Component: V, S, M.'),

  -- ============ MAGIC-USER LEVEL 9 ============
  ('Wish',9,'Magic-User','unlimited','special','varies',
   'De ultieme spell. Alles binnen redelijkheid mogelijk. Veroudert caster 3 jaar + 1d4 dagen bedrust + STR -3 gedurende 2d4 dagen. Verwacht: een DM die letterlijk leest wat je wenst (monkey paw style). Component: V.'),
  ('Meteor Swarm',9,'Magic-User','40ft + 10/lvl','instant','varies',
   'Vier giant fireballs (10d4 dmg each) of acht kleine (5d4 each). Save halve. Apocalyptic op massas vijanden. Component: V, S.'),
  ('Time Stop',9,'Magic-User','0','1d3 rounds','caster',
   'Tijd staat stil voor iedereen behalve caster. Cast 1d3 rondes aan spells / acties. Niets doet schade aan anderen tijdens — maar je kan voorbereiding maken. Component: V.'),
  ('Imprisonment',9,'Magic-User','touch','permanent','1 creature',
   'Touch + woord — doel verdwijnt naar magische kerker diep onder de aarde, eeuwig wachtend tot Freedom spell. Save vs spell op -4. Te krachtig voor casual gebruik. Reverse: Freedom. Component: V, S.'),
  ('Gate',9,'Magic-User','30ft','until creature returns','1 specific entity',
   'Roep een specifieke godheid of entiteit van een ander vlak. ZEER GEVAARLIJK — entiteit kan eisen, slachtofferen, of caster doden. Voor episch spelmoment. Component: V, S.'),

  -- ============ CLERIC LEVEL 4-7 ============
  ('Cure Serious Wounds',4,'Cleric','touch','permanent','1 creature',
   'Geneest 2d8+1 HP. Reverse Cause Serious. De middel-tier healing spell.'),
  ('Neutralize Poison',4,'Cleric','touch','permanent','1 creature',
   'Verwijdert gif uit lichaam. Niet voor reeds gestorven. Reverse: Poison (save vs poison of dood).'),
  ('Tongues',4,'Cleric','0','1 turn','caster',
   'Versta en spreek elke taal in 30ft cirkel. Onmisbaar bij diplomatie of contact met nieuw ras. Reverse: confuses speakers. Component: V, S, M (klein bronzen tongetje).'),
  ('Protection from Evil 10ft',4,'Cleric','touch','1 turn/lvl','10ft radius',
   'Iedereen binnen 10ft krijgt +2 AC + saves vs Evil-aligned wezens. Blokkeert summoned wezens fysiek (3ft barrier). Combined effect met Magic Circle.'),
  ('Raise Dead',5,'Cleric','30ft','permanent','1 humanoid',
   'Brengt humanoid terug tot 1 dag dood per caster level. Resurrected verliest 1 CON, 2d6 weken bedrust. Komt met 1 HP. CON 0 = sterf opnieuw permanent. Component: V, S, M (5000gp diamond).'),
  ('Quest',5,'Cleric','60ft','until completed','1 creature',
   'Dwingt doelwit tot een specifieke taak. Save vs spell. Bij failure: kan geen spreuken meer casten en moet quest beginnen. Reverse Remove Quest.'),
  ('Heal',6,'Cleric','touch','permanent','1 creature',
   'Geneest ALLE HP, ziektes, mentale ziekten. De ultieme cure. Reverse Harm: alle HP behalve 1 weg. Component: V, S.'),
  ('Word of Recall',6,'Cleric','0','instant','caster',
   'Teleport caster naar zijn gewijde tempel. Gegoten in advance. Levensreddend escape. Component: V.'),
  ('Resurrection',7,'Cleric','touch','permanent','1 humanoid',
   'Brengt humanoid terug uit dood, tot 10 jaar per caster level. CON -1, geen bedrust. Veel beter dan Raise Dead. Reverse Destruction (touch = dood, save vs spell). Component: V, S, M (10000 gp diamond).'),
  ('Earthquake',7,'Cleric','120ft','1 round','5 sq ft/lvl',
   'Trillingen openen aarde, gebouwen storten, water vlucht. Voor cataclysmic moment. Component: V, S, M.'),

  -- ============ DRUID LEVEL 4-7 ============
  ('Animal Summoning I',4,'Druid','1 mile/lvl','special','3 normal animals',
   'Roept 3 normale dieren tot 4 HD. Animal-friendly enviro vereist. Onmisbaar voor wildernis-druid.'),
  ('Hallucinatory Forest',4,'Druid','80ft','permanent','1 acre',
   'Creëert illusoir bos onzichtbaar voor druiden, gnomes, halflings. Misleidt vijanden 1 uur. Component: V, S, M.'),
  ('Insect Plague',5,'Druid','360ft','1 day','180ft cube',
   'Massieve insectenwolk. 1 HD vluchten automatisch, 1+ HD save vs spell of vluchten + 1d4 dmg per ronde. Devastating crowd control. Outdoor only.'),
  ('Pass Plant',5,'Druid','touch','instant','caster',
   'Druid stapt in een grote boom en verschijnt uit een andere binnen 10 mijl. Ultieme wildernis-mobiliteit.'),
  ('Animal Summoning III',6,'Druid','1 mile/lvl','special','1-2 large animals',
   'Roept 1-2 grote dieren of monsters (8 HD elk).'),
  ('Reincarnation',6,'Druid','touch','instant','1 corpse',
   'Bring back a recently dead — random new body (1d12 op tabel: badger, bear, boar, centaur, faun, fox, hawk, lynx, owl, weasel, wolf, wolverine). Surprise! Component: V, S, M.'),
  ('Creeping Doom',7,'Druid','10ft','1 rd/lvl','100ft x 100ft',
   'Roept 1000 giftige insecten/spinnen die langzaam vooruit kruipen. Aanraking = 1 dmg + save vs poison. Crowd-control nightmare. Component: V, S.'),
  ('Reincarnate',7,'Druid','touch','instant','1 corpse',
   'Verbeterde versie — roll on table inclusief dwarf/elf/half-elf/halfling/human/ent. Kan dus mens-naar-elf veranderen na dood.'),
  ('Confusion',7,'Druid','80ft','1 rd/lvl','40ft cube',
   'Like M-U Confusion. Wezens random gedrag.'),
  ('Animate Rock',7,'Druid','40ft','1 rd/lvl','2 cu ft / lvl',
   'Stenen worden levend. Aanvallen als 8 HD wezen. Voor druiden in steengrotten.')
on conflict do nothing;

-- ---------------------------------------------------------------------
-- ITEMS — UITBREIDING (rings, wands, scrolls, magic weapons, armors)
-- ---------------------------------------------------------------------
insert into public.items (name, category, weight, cost, description) values
  -- Rings
  ('Ring of Protection +2','magic',0,15000,'+2 AC en +2 op alle saves. Stapelt niet met armor magie. Standaard begin-magic-ring.'),
  ('Ring of Protection +3','magic',0,30000,'+3 AC en +3 saves.'),
  ('Ring of Fire Resistance','magic',0,30000,'Immuun voor non-magisch fire. Magisch fire: -2 dmg per die. Onmisbaar tegen red dragons en fire elementals.'),
  ('Ring of Free Action','magic',0,40000,'Immuun voor hold person, slow, web, paralysis. Beweegt normaal in water. Onmisbaar voor frontline.'),
  ('Ring of Telekinesis','magic',0,80000,'Move 25 lbs per dag aan objecten. Of throw small objects in combat.'),
  ('Ring of Wishes (3 wishes)','magic',0,200000,'Drie wishes — als de Wish spell. Slechts één per dag. Gevaarlijk maar levensveranderend.'),
  ('Ring of Regeneration','magic',0,90000,'Regenerate 1 HP per turn. Brengt karakter terug van -10 HP als ring gedragen werd.'),
  ('Ring of Spell Storing','magic',0,30000,'Houdt 4-5 specifieke spreuken (random gevonden). Caster reproduceert.'),
  -- Wands
  ('Wand of Fireballs','wand',5,15000,'100 charges. Cast Fireball op level 6 (6d6) per charge.'),
  ('Wand of Cold','wand',5,18000,'100 charges. 1d4+1 dmg per charge per target, of cone of cold modus.'),
  ('Wand of Polymorphing','wand',5,25000,'100 charges. Polymorph other per charge.'),
  ('Wand of Negation','wand',5,30000,'100 charges. Negate ANY active spell within 60ft.'),
  -- Scrolls
  ('Scroll of Cure Light Wounds','scroll',1,150,'1 cure light wounds spell.'),
  ('Scroll of Fireball','scroll',1,500,'1 fireball spell. M-U only.'),
  ('Scroll of Haste','scroll',1,400,'1 haste spell. M-U only.'),
  ('Scroll of Resurrection','scroll',1,5000,'1 resurrection. Cleric only — tijd kritisch.'),
  -- Magic weapons
  ('Sword +3','magic',60,15000,'+3 to hit en damage. Verlicht zichzelf op commando (30ft).'),
  ('Frostbrand','magic',60,40000,'Sword +3, +6 vs fire creatures. 50% kans bekleed in vlam-doof aura (negate fireball).'),
  ('Flametongue','magic',60,40000,'Sword +1, +2 vs regenerating, +3 vs cold/water creatures, +4 vs undead. Brandend aura: 2 ft licht.'),
  ('Defender Sword +3','magic',60,40000,'Bezitter kan +3 op AC of +3 to-hit kiezen elke ronde — flexibel.'),
  ('Sword of Sharpness','magic',60,80000,'+3, op natural 18-20: amputatie van ledematen of kop.'),
  ('Vorpal Sword','magic',60,150000,'+3, op natural 20: instant decapitation. Voor de DM die wreed wil zijn.'),
  ('Mace of Disruption','magic',100,50000,'+1 vs all, save vs spell on hit voor undead — bij failure: vernietigd. Cleric special.'),
  ('Bow of Accuracy +2','magic',30,8000,'+2 to hit + dmg met arrows. Range +50%.'),
  ('Arrow +1 (per dozen)','magic',1,150,'+1 to hit/dmg. Verbruikbaar.'),
  ('Arrow of Slaying (specific)','magic',1,2500,'Specific creature type. Bij hit: save vs death of dood. Eén shot.'),
  -- Magic armor
  ('Plate Mail +1','magic',450,2000,'AC 2 (vs AC 3 for normaal). +1 op saves vs phys aanval.'),
  ('Plate Mail +3','magic',450,12000,'AC 0!'),
  ('Chain Mail +1','magic',300,1500,'AC 4.'),
  ('Shield +2','magic',100,4000,'+2 AC bovenop normale shield.'),
  ('Cloak of Protection +1','magic',10,5000,'+1 AC en saves. Stapelt met armor en ring.'),
  ('Cloak of Displacement','magic',10,40000,'Kijk vager — eerste aanval per ronde mist automatisch. Daarna -2 to hit op aanvaller.'),
  -- Wonderous items
  ('Bag of Tricks','magic',5,5000,'2-8 random small animals per dag.'),
  ('Boots of Striding and Springing','magic',30,12000,'Speed 12, sprongen 30ft horizontaal / 15ft verticaal.'),
  ('Boots of Speed','magic',30,30000,'24" speed in combat, 12 turns/dag.'),
  ('Belt of Giant Strength (Hill)','magic',20,40000,'STR 19 (+3 to hit, +7 dmg).'),
  ('Belt of Giant Strength (Storm)','magic',20,200000,'STR 25 (+7 to hit, +14 dmg).'),
  ('Helm of Telepathy','magic',45,35000,'ESP at will, telepathy met willing creature.'),
  ('Manual of Bodily Health','magic',5,28000,'Read over 6 dagen, dan +1 CON permanent. Slechts 1 per persoon.'),
  ('Tome of Clear Thought','magic',5,30000,'+1 INT permanent.'),
  ('Crystal Ball','magic',100,50000,'Scry distant locations. Familiar required for max range.'),
  ('Carpet of Flying','magic',80,75000,'4-zits vliegend tapijt. Speed 24". 4000 lbs capaciteit.'),
  ('Robe of the Archmagi','magic',120,200000,'White (good), gray (neutral), black (evil). +5 saves vs spells, +20% MR, AC 5.'),
  -- Mundane uitrusting extra
  ('Tent (small)','gear',200,3,'2-persoons tent.'),
  ('Compass','gear',5,150,'Magnetisch — wijst noord. Gnome-uitvinding.'),
  ('Spyglass','gear',10,1000,'Kijk 5x verder. Gnome optics.'),
  ('Lock','gear',10,20,'Padlock. Goeie Thief skill = open in 1 ronde.'),
  ('Chain (10ft)','gear',10,30,'IJzeren ketting.'),
  ('Sealing Wax','gear',1,1,'Wax + signet ring voor brieven.'),
  ('Quill + Ink + Paper','gear',2,2,'Schrijf-set.'),
  ('Healing Salve','gear',2,50,'Geneest 1d4 HP via topical application + bandage.')
on conflict do nothing;

-- ---------------------------------------------------------------------
-- MONSTERS — UITBREIDING (devils, demons, dragons, undead, beasts)
-- ---------------------------------------------------------------------
insert into public.monsters (name, ac, hp_dice, thac0, damage, move, alignment, description) values
  -- More humanoids
  ('Goblin Shaman','7','2','19','1d6','6','Lawful Evil',
   'Goblin met clerical magie. Cast als Cleric lvl 2-4. Per stam 1 shaman. Nimmer alleen — beschermd door bodyguards.'),
  ('Orc Chieftain','5','5','15','1d8+2','9','Lawful Evil',
   'Per orc tribe één chieftain (Fighter lvl 5). HD 5+1. STR 18. Vaak met magic weapon van vorige slachtoffer. Lijst-uitvallen-eind van de tribe-pyramide.'),
  ('Hobgoblin Captain','3','5','15','1d8+1','9','Lawful Evil',
   'Officier in hobgoblin leger. Banded mail + shield. Tactisch slim — ranger-like ervaring.'),
  ('Drow Elf','6','3+1','17','1d8','12','Chaotic Evil',
   'Donkere oppervlakte-elf. Cleric of Wizard skills. Magic resistance 50% + 2% per level. Daglicht: -1 to hit. Onderaards in Erelhei-Cinlu.'),
  ('Duergar','3','2','19','1d6','6','Lawful Evil',
   'Grijze dwergen — donkere keldercousins. Enlarge spell + invisibility 1x/dag. Magic resistance 20%. Gehate dwarven kin.'),
  -- More giants
  ('Cloud Giant','-1','12+2-7','9','6d4','15','Neutral',
   '24 ft, 11000 lbs. Levitate at will. Werpt rotsblokken (range 60). Telkens 1d4 chance op musical instrument bezit.'),
  ('Storm Giant','-2','15+1-7','7','7d6','15 / 15 swim','Chaotic Good',
   '26 ft. Levitate, lightning bolt 1x/dag. Onderwater-thuis. Schoonheid en intelligentie van mensen, kracht van giants.'),
  -- Undead extra
  ('Mummy','3','6+3','13','1d12','6','Lawful Evil',
   'Wrap-bedekt undead. Zicht alleen veroorzaakt fear (save vs spell of paralyzed 1d4 rondes). Touch: rotting disease (geen healing, langzaam dood). Vuurkwetsbaar.'),
  ('Spectre','2','7+3','13','1d8 + 2 levels drain','15 / 30 fly','Lawful Evil',
   'Blauwig glanzende undead. 2 LEVEL DRAIN per touch — devastating. Magic weapons only. Sunlight: vluchten. Bezwaar 7 turn.'),
  ('Banshee','0','7','13','1d8','15','Chaotic Evil',
   'Wail death — wezens binnen 30ft save vs spell of dood. Onmaterieel. Slechts s nachts. +1 magic weapons hit.'),
  ('Lich, Demilich','-2','9+','9','touch / dust','6','Lawful Evil',
   'Lich na duizend jaar. Zelfs schedel kan nog level drain en soul trap doen. Devastating final boss.'),
  -- Demons (Chaotic Evil)
  ('Demon, Type I (Vrock)','0','8','12','1d4/1d4/1d8/1d8','12 / 18 fly','Chaotic Evil',
   'Vulturen-demon. 50% MR. Spells: Detect invisible, gate (other vrock 35%). Flight, claws en bite.'),
  ('Demon, Type II (Hezrou)','-2','9','11','1d3/1d3/4d4','6 / 12 swim','Chaotic Evil',
   'Pad-achtige demon. 55% MR. Stinking aura - save or weak. Tongue-grab.'),
  ('Demon, Type III (Glabrezu)','-4','10','11','2d6/2d6/1d3/1d3/1d4+1','9','Chaotic Evil',
   'Vier armen — twee scharen, twee menselijke. 60% MR. Power Word: Stun + Mirror Image.'),
  ('Demon, Type IV (Nalfeshnee)','-1','11','9','1d4/1d4/2d8','9 / 15 fly','Chaotic Evil',
   'Boar-headed demon-noble. 65% MR. Slow, Talisman, gate.'),
  ('Demon, Type V (Marilith)','-9','7+7','11','2/2/2/2/2/2/3d4','12','Chaotic Evil',
   'Slang-onder met 6 armen. 80% MR. Charm, fear, magic missile, polymorph self. Tactische generaal van de Abyss.'),
  ('Demon, Type VI (Balor)','-2','8+8','7','1d4+9 (sword)','6 / 15 fly','Chaotic Evil',
   'Vlam-omhuld krijger. 75% MR. +3 sword + whip pulls victim near. Fireball, telekinesis. Major demon — death whirl op kill.'),
  -- Devils (Lawful Evil)
  ('Devil, Lemure','7','3','17','1d3','3','Lawful Evil',
   'Laagste lawful-evil devil. Bewust niets. Regenerate 1 HP/round. Holy water dmg.'),
  ('Devil, Spinagon','5','4+1','15','1d3 + spike','6 / 15 fly','Lawful Evil',
   'Spike-bedekt devil. Throws spikes (range 6/12/18, 1d4 dmg).'),
  ('Devil, Cornugon (Horned)','-2','10','9','1d3/1d3/2d4','9 / 15 fly','Lawful Evil',
   'Horned devil. 50% MR. Vlam-aanval, fear gaze, suggestion.'),
  ('Devil, Pit Fiend','-3','13','7','5d6 (bite + hug)','9 / 15 fly','Lawful Evil',
   'Generaal van Hell. 65% MR. Spells lvl 8+ caster. Wish 1x/maand. Symbool van pure tyranny.'),
  -- Dragons additional
  ('White Dragon','3','6','15','1d6/1d6/2d8','12 / 30 fly','Chaotic Evil',
   'IJsdraak. Cold breath (70 ft cone, 6d6+ dmg). Half-dmg cold creatures. Treasure laag voor dragon.'),
  ('Blue Dragon','2','9','11','1d8/1d8/3d8','9 / 24 fly','Lawful Evil',
   'Lightning bolt breath (5x80ft line, 9d6+). Burrows in zand-woestijnen. Telepathie met andere blue.'),
  ('Gold Dragon','-2','11','9','1d8/1d8/6d6','12 / 30 fly','Lawful Good',
   'Wijste en machtigste good dragon. Two breath (chlorine + fire). Polymorph, tongues, suggestion. Allies to good.'),
  ('Silver Dragon','0','10','11','1d6/1d6/5d6','9 / 24 fly','Lawful Good',
   'Cold breath OR paralysis breath (frost cone of paralysis). Polymorph, tongues. Cloud-dwelling.'),
  -- Beasts extra
  ('Hippogriff','5','3+3','15','1d6/1d6/1d10','18 / 36 fly','Neutral',
   'Eagle-horse hybrid. Mountable maar wild. Eet alleen vlees. Mounts voor advanced cavaliers.'),
  ('Pegasus','6','2+2','17','1d8/1d8','24 / 48 fly','Chaotic Good',
   'Wit gevleugelde paard. Goede uitlijning — alleen mountable door pure (paladin etc.).'),
  ('Unicorn','2','4+4','15','1d8/1d8/1d12','24','Chaotic Good',
   'Wit paard met regenerative horn. Touch: cure light wounds, neutralize poison. Allows only chaste maidens to touch.'),
  ('Griffon','3','7','13','1d4/1d4/2d8','12 / 30 fly','Neutral',
   'Lion-eagle hybrid. Wilde mounts after long taming. Eat horses.'),
  ('Wyvern','3','7+7','13','2d8 + sting (poison)','6 / 24 fly','Neutral Evil',
   'Two-legged dragon-cousin. Tail sting: save vs poison or death.'),
  -- Aquatic
  ('Sahuagin','5','2+2','17','1d2/1d2/1d4','12 / 24 swim','Lawful Evil',
   'Shark-mensen. Trident + javelins. Frenzy in bloed. Underwater warrior race.'),
  ('Locathah','6','2','19','1d6 (weapon)','3 / 12 swim','Neutral',
   'Vis-mensen. Vredevol meestal. Live in coral cities.'),
  ('Kraken','0','20','7','5d4 (8 tentacles)','3 / 21 swim','Lawful Evil',
   'Reusachtige inktvis met 8 tentakels en intelligent. 80 ft body. Spell-caster (Magic-User lvl 9). Schrik der oceanen.'),
  -- Misc
  ('Centaur','5','4','15','1d6/1d6/2 (weapon)','18','Neutral Good',
   'Mens-paard hybride. Vredevol meestal. Geweldige bondgenoten in wildernis. 8-12 in groepen.'),
  ('Satyr','5','5','15','butt + weapon','12','Chaotic Neutral',
   'Geit-mens. Pipes can charm (save vs spell), sleep, fear. Hobby: drinking + chasing nymphs.'),
  ('Dryad','9','2','19','1d4 (dagger)','12','Neutral',
   'Boom-nymph. Charm 1x/dag. Cannot leave their tree (dies if tree dies).'),
  ('Naga, Spirit','3','9','11','1d3 + poison','12','Chaotic Evil',
   'Snake-bodied with woman-head. Spell-caster. Charm gaze.'),
  ('Doppleganger','5','4','15','1d12','9','Neutral',
   'Shape-shifter. Mimic any humanoid perfectly. Saves as 10th lvl Fighter. Surprise on 1-4 op d6.'),
  ('Rust Monster','2','5','15','rust','18','Neutral',
   'Touch any iron-equipment: instantly rust to nothing. Magic items get save. Fighter''s nightmare.'),
  ('Gelatinous Cube','8','4','15','2d4','6','Neutral',
   'Transparent ooze 10x10x10ft. Engulfs victim — paralysis + slowly digest. Can carry treasure inside.'),
  ('Gray Ooze','8','3+3','15','2d8','1','Neutral',
   'Looks like wet stone. Eats metal (sword, armor in 1 hit).'),
  ('Black Pudding','6','10','11','3d8','6 / 6 climb','Neutral',
   'Devastating blob — splits in two when hit (each smaller). Eats wood, leather, metal. Acid corrosion.'),
  ('Stirge','8','1+1','19','1d3 + drain blood','3 / 18 fly','Neutral',
   'Mosquito-bat. After hit: attaches and drains 1d4 HP per round automatically.'),
  ('Mimic','7','7-10','13','3d4 + glue','3','Neutral',
   'Disguised as chest, door, statue. Glue grip = victim cannot withdraw. Surprise on 1-4 op d6.'),
  ('Otyugh','3','7','13','1d8/1d8/2d6 + disease','6','Neutral',
   'Sewer-dweller. Disease + grappling tentacles. Eat trash and adventurers.'),
  ('Roper','0','10','11','5d4 + drain str','3','Chaotic Evil',
   'Cave fungus look. 6 tentakels grip enemies — drains STR until paralysis.'),
  ('Basilisk','4','6+1','13','1d10 + petrification gaze','6','Neutral',
   'Eight-legged lizard. Eye contact = save vs petrification of stone forever.'),
  ('Cockatrice','6','5','15','1d3 + petrification','6 / 18 fly','Neutral',
   'Rooster-snake hybrid. Touch save vs petrification.'),
  ('Medusa','5','6','13','1d4 (snake hair)','9','Lawful Evil',
   'Snake-haired woman. Eye contact = stone. Mirror reverse against herself = stone herself.'),
  ('Sphinx, Andro','-2','12','9','2d6/2d6','18 / 36 fly','Lawful Neutral',
   'Lion body + man head + wings. Cleric spell-caster lvl 8. Riddles guard treasure.')
on conflict do nothing;

-- ---------------------------------------------------------------------
-- SKILLS — extra (Oriental + UA non-weapon proficiencies)
-- ---------------------------------------------------------------------
insert into public.skills (name, type, base_stat, description) values
  ('Calligraphy','Non-Weapon','DEX','Schrijfkunst — vereist in Oriental hofcontext.'),
  ('Meditation','Non-Weapon','WIS','Concentratie-techniek. +1 op saves vs charm/fear.'),
  ('Iaijutsu','Weapon','DEX','Snelle zwaard-trekking. +2 op initiative met zwaard.'),
  ('Martial Arts','Non-Weapon','DEX','Vechten zonder wapens — slot-based dmg increase.'),
  ('Lock-picking','Non-Weapon','DEX','Sloten openen zonder thieves'' tools — half effectief.'),
  ('Trap Setting','Non-Weapon','DEX','Eigen valstrikken plaatsen.'),
  ('Spellcraft','Non-Weapon','INT','Identificeer spell wordt gecast door observatie.'),
  ('Arcane Lore','Non-Weapon','INT','Kennis van magic-user gilden, towers, magische geschiedenis.'),
  ('Astrology','Non-Weapon','INT','Voorspellingen via sterren.'),
  ('Ventriloquism','Non-Weapon','CHA','Stem werpen — misleiding.'),
  ('Acting','Non-Weapon','CHA','Rol-spel andere personage.'),
  ('Bargaining','Non-Weapon','CHA','-10% prijzen op koop, +10% op verkoop.'),
  ('Local Lore','Non-Weapon','INT','Kennis van regio waar character woont.'),
  ('Mapping','Non-Weapon','INT','Maakt accurate kaarten van verkende gebieden.'),
  ('Engineering','Non-Weapon','INT','Bouw bruggen, machines, fortifications.'),
  ('Alchemy','Non-Weapon','INT','Mix non-magical potions (acid, etc.). Slot 2.')
on conflict do nothing;

-- =====================================================================
-- KLAAR! Encyclopedie heeft nu ~150 wapens/spreuken/items/monsters extra.
-- Voor verdere uitbreiding: gebruik 📥 CSV/JSON/MD import in de DM panel.
-- =====================================================================
