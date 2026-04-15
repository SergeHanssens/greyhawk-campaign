-- =====================================================================
-- Greyhawk Campaign Manager — Encyclopedie (uitgebreide editie)
-- =====================================================================
-- Run dit NA 01_schema.sql.
--
-- Bevat rijke beschrijvingen in de stijl van de AD&D Player's Handbook
-- en Monster Manual. ~250+ entries verspreid over alle categorieën.
--
-- Veilig om opnieuw te draaien — alle inserts gebruiken ON CONFLICT.
-- Aanvullen kan altijd via:
--   - Het DM-paneel: "+ Toevoegen aan Database"
--   - CSV-import via "📥 CSV importeren"
--   - Direct in Supabase Table Editor
-- =====================================================================

-- ---------------------------------------------------------------------
-- WEAPON TYPES
-- ---------------------------------------------------------------------
insert into public.weapon_types (name) values
  ('Sword'), ('Axe'), ('Bow'), ('Crossbow'), ('Dagger'),
  ('Mace'), ('Hammer'), ('Spear'), ('Polearm'), ('Staff'),
  ('Flail'), ('Sling'), ('Whip'), ('Club'), ('Pick'),
  ('Throwing'), ('Exotic'), ('Other')
on conflict (name) do nothing;

-- ---------------------------------------------------------------------
-- RASSEN — uitgebreid
-- ---------------------------------------------------------------------
insert into public.races (name, description) values
  ('Human',
   'Mensen vormen de meerderheid van de bevolking in de Flanaess. Ze hebben een gemiddelde lengte van 5''6" tot 6'' en wegen 120-180 lbs. Hun grootste kracht is hun aanpasbaarheid: in tegenstelling tot de demi-humanen kennen mensen geen klasse-levellimiet en kunnen elke beschikbare klasse beoefenen. Mensen domineren zowel de Vrije Stad van Greyhawk als de meeste keizerrijken. Ze leven 60-90 jaar. Bonus: geen levellimiet, alle klassen toegestaan, kunnen dual-class zoals gewenst (vereist hoge stats). Geen ability score modifiers.'),

  ('Dwarf',
   'Dwergen zijn een trots en vasthoudend volk dat in de bergen en heuvels van de Lortmils, Crystalmists en Iron Hills leeft. Ze meten 4 tot 4½ voet, wegen 150 lbs, en kunnen 350-450 jaar oud worden. Lange baarden zijn voor mannen onontbeerlijk; clean-shaven dwergen worden uitgestoten. Bonus: +1 CON, -1 CHA. Infravision 60ft. +4 op saves vs spreuken en gif (door taaie constitutie). Detect underground passages, slopes, traps, sliding walls (1-5 op d6 binnen 10ft). Combat-bonussen: +1 to hit tegen orcs, half-orcs, goblins, hobgoblins; reuzen krijgen -4 to hit tegen dwergen. Klasse-beperkingen: Fighter (max 9), Thief (onbeperkt), Cleric (max 8), Assassin (max 9). Mogen geen Magic-User worden (afkeer van arcane magie). Spreken Dwarvish, Common, Gnomish, Goblin, Kobold, Orcish.'),

  ('Elf',
   'Elven zijn een lang, slank en gracieus volk dat zelden meer dan 110 lbs weegt en 5 tot 5½ voet meet. Ze leven 1200 jaar of langer, maar ouderen trekken zich vaak terug naar de "Grey Havens". De High Elves van de Celene Vallei en de Wood Elves van de Vesve Forest zijn de voornaamste subrassen. Bonus: +1 DEX, -1 CON. Infravision 60ft. 90% immuun voor sleep en charm spells. Detect secret doors (1-2 op d6 passief, 1-3 als ze actief zoeken, 1 op d6 voor verborgen deuren). Bonussen +1 to hit met long sword, short sword, en bows. Verrassings-bonus: 4-op-d6 als ze stil bewegen in elf-vriendelijk terrein. Klasse-beperkingen: Fighter (max 7), Magic-User (max 11), Thief (onbeperkt), Cleric (max 7), Ranger (max 8). Spreken Elvish, Common, Gnomish, Halfling, Goblin, Hobgoblin, Orcish, Gnoll.'),

  ('Gnome',
   'Gnomen zijn de kleinste van de demi-humanen, slechts 3 tot 3½ voet hoog en 80 lbs wegend. Ze leven in heuvels en bossen, vooral in de Kron Hills en Flinty Hills. Hun lange neuzen, vurige ogen en speelse aard maken hen onderscheidend. Gnomen leven 350-500 jaar. Bonus: +1 op saves vs alle magie (door magiegevoeligheid), infravision 60ft. Detect grade or slope in passage (1-5 op d6), detect unsafe stonework (1-7 op d10), determine direction underground (1-3 op d6), determine approximate depth (1-4 op d6). +1 to hit tegen kobolds en goblins; gnolls, bugbears, ogres, trolls, ettins en giants krijgen -4 to hit tegen gnomes (klein doelwit). Klasse: Fighter (max 6), Illusionist (max 7), Cleric (max 7), Thief (onbeperkt), Assassin (max 8). Spreken Gnomish, Dwarvish, Halfling, Goblin, Kobold, plus burrowing-mammals zoals dassen en mollen.'),

  ('Half-Elf',
   'Half-elven zijn nakomelingen van een mens en een elf — vaker geboren dan men denkt door de lange levensduur van elven en hun nieuwsgierigheid naar mensen. Ze meten 5 tot 6 voet, wegen 130 lbs, en leven tot 250 jaar. Ze worden in beide gemeenschappen aanvaard maar voelen zich nergens thuis. Bonus: 30% immuun voor sleep en charm. Infravision 60ft. Detect secret doors (1 op d6 passief, 1-2 actief). Klasse-beperkingen: Fighter (max 8), Magic-User (max 8), Cleric (max 5), Druid (max 6), Thief (onbeperkt), Assassin (max 11), Bard (onbeperkt voor Bard), Ranger (max 8). Mogen multi-class beoefenen (bv. Fighter/Magic-User, Cleric/Ranger). Spreken Common, Elvish, plus 2 talen naar keuze.'),

  ('Halfling',
   'Halflings zijn klein, slechts 3 voet hoog en 60 lbs wegend, met blote voeten bedekt met dik, krullend haar. Ze leven in afgelegen heuvelgebieden in comfortabele aardewoningen. Hun voornaamste bezigheden zijn eten (zes maaltijden per dag), drinken, sociaal contact, en vermijden van avonturen — totdat het lot anders beslist. Halflings leven 100-150 jaar. Drie subrassen: Hairfeet (algemeenst), Tallfellow (forser, mengen met elven), Stout (steviger, mengen met dwergen). Bonus: +1 DEX, -1 STR. +1 op alle saves voor Stouts. +3 op save vs magie of gif (Hairfeet). +1 to hit met sling, +3 met thrown stenen of darts. Detect slope (Stout/Tallfellow), detect direction (Tallfellow). Surprise-bonus 4-op-d6 in natuur of stedelijke setting. Klein doelwit: bugbears, gnolls, ogres, trolls, ettins, giants krijgen -4 to hit. Klasse: Fighter (max 6), Thief (onbeperkt), Druid (max 6 voor Tallfellow). Spreken Halfling, Common, Dwarvish, Elvish, Gnome, Goblin, Orcish.'),

  ('Half-Orc',
   'Half-orcs ontstaan uit gewelddadige unies tussen mensen en orcs, en worden door beide volkeren gemeden. Ze meten 5½ tot 6 voet, wegen 150-200 lbs, leven slechts 60-75 jaar, en hebben groenig-grijze huid, prominente snijtanden, en rode ogen. Ze infiltreren menselijke gemeenschappen vaak door zich voor lelijke mensen uit te geven (10% kan dit volledig vermijden, 75% moet zware kapuchon dragen). Bonus: +1 STR, +1 CON, -2 CHA. Infravision 60ft. Klasse-beperkingen: Fighter (max 10), Cleric (max 4), Thief (max 8), Assassin (max 15). De ideale Assassin door fysieke kracht en sociale verstotenheid. Spreken Common, Orcish, plus 2 talen uit: Goblin, Hobgoblin, Gnoll, Ogre.')
on conflict (name) do nothing;

-- ---------------------------------------------------------------------
-- KLASSEN — uitgebreid
-- ---------------------------------------------------------------------
insert into public.classes (name, hit_die, primary_stat, description) values
  ('Fighter','d10','STR',
   'De Fighter is de eenvoudigste maar tegelijk meest veelzijdige gevechtsklasse. Hij beheerst alle wapens en alle pantsers, inclusief schilden. Vereisten: STR 9. Per level krijgt hij +1d10 HP (CON bonus toegestaan). Vanaf level 7 krijgt hij 3/2 aanvallen per ronde tegen wezens van 1 HD of minder; vanaf level 13 krijgt hij 2/1 aanvallen. Beschermsstijl-bonus: Constitution-bonus tot maximum +4 (anderen tot maximum +2). Op level 9 krijgt hij de titel "Lord" en kan een vesting bouwen (40.000+ gp); zijn naam alleen trekt gevolg. Zwaarste HP-pool naast Barbarian. Aanbevolen voor beginners.'),

  ('Paladin','d10','CHA',
   'De Paladin is een heilige krijger gewijd aan een lawful good godheid. Vereisten: STR 12, CON 9, WIS 13, CHA 17. Alleen Lawful Good. Krijgt +2 op alle saves. Detect evil naar believen (60ft cone). Lay on Hands: geneest 2 HP per level, 1x per dag. Cure disease 1x per week (2x op level 6, 3x op level 12). Immuun voor alle ziektes. Cleric spells vanaf level 9 (max level 4 spells). Mag een speciaal warhorse oproepen (intelligent, +HP, +HD) op level 4. Houdt zelden meer dan 10 magische items aan en doneert 10% van inkomsten aan kerk. Verliest paladin-status bij chaotic of evil daad — kan worden hersteld door een quest van een hogere paladin. De zwaarste roeping in de game.'),

  ('Ranger','d8','STR',
   'De Ranger is een eenzame wildernis-strijder, sterk in tracking en vechten tegen "giants" (alle giant-class wezens, inclusief goblins en orcs). Vereisten: STR 13, INT 13, WIS 14, CON 14. Alignment: any good. Begint met 2d8 HP (i.p.v. 1d8). +1 dmg per level tegen giant-class vijanden. Verrassings-bonus 4-op-d6, en zelf moeilijk te verrassen (-3 op surprise tegen hen). Tracking ability: 90% kans + modifiers. Volgt sporen door bos, vlakte, sneeuw. Op level 8 krijgt hij Druid spells (level 1-3) en op level 9 Magic-User spells (level 1-2). Mag maximaal 2-3 anderen in zijn party hebben (eenzaam strijder). Bouwt geen vesting maar trekt zich terug naar wildernis op level 10. Goeie keuze voor wie de natuur wil verkennen.'),

  ('Magic-User','d4','INT',
   'De Magic-User (later "Wizard" genoemd) is de archetypische arcanist die magie via studie en spreukenboeken leert. Vereisten: INT 9. Mag enkel de volgende wapens: dagger, dart, staff, sling. Geen pantser ooit. Bezit een spellbook met al zijn geleerde spreuken; verlies ervan is rampzalig. Memoriseert spreuken in de ochtend (1 uur per spell level). Begint met read magic, detect magic, en nog 1 spreuk naar keuze (level 1). Vermag spreuken te scribe op scrolls vanaf level 7, en magic items te maken vanaf level 11. Op level 11 krijgt hij de titel "Wizard" en kan een toren bouwen die avonturiers en magische dieren aantrekt. Hoogste schade-output op hoge levels (Fireball, Lightning Bolt, Cone of Cold, Meteor Swarm). Kwetsbaar in early game (4 HP startend!).'),

  ('Illusionist','d4','INT',
   'De Illusionist is een gespecialiseerde Magic-User die zich richt op illusoire en perceptie-magie. Vereisten: INT 15, DEX 16. Identieke beperkingen als Magic-User (geen pantser, beperkte wapens). Heeft een eigen spellijst, gescheiden van Magic-User. Krachtigste spreuken: Phantasmal Killer (level 4, dood door angst), Project Image (level 6), Demi-shadow Magic. Kan andere illusionisten herkennen via subtiele tekens. Vereist hogere stats dan een gewone Magic-User en groeit langzamer in HP, maar is verwoestend tegen wezens met lage Wisdom of intelligentie. Op level 11 krijgt hij titel "Master Illusionist".'),

  ('Cleric','d8','WIS',
   'De Cleric is de uitverkorene van een godheid, dienend als spiritueel leider en heler. Vereisten: WIS 9. Mag alle pantser dragen, inclusief plate mail en shield. Wapenbeperking: alleen stomp wapens (mace, war hammer, club, staff, flail, morning star, hammer, sling) — bloed vergieten is taboo voor de meeste goden. Krijgt spellpower vanaf level 1 (in tegenstelling tot Druids). Memoriseert spreuken via gebed (4 uur). Mag undead "turn" of "destroy": cleric staat tegenover een goddelijke macht en de undead vlucht (of wordt verwoest bij hoog level). Op level 8 krijgt hij titel "Patriarch" en kan een tempel bouwen — krijgt automatisch volgelingen. Onontbeerlijk in elke party voor genezing. Goede HP, goeie pantser, redelijke offensive.'),

  ('Druid','d8','WIS',
   'De Druid is een natuurpriester van neutrale gezindheid. Vereisten: WIS 12, CHA 15. Strikt True Neutral. Mag enkel leren of houten armor (max studded leather + wooden shield). Wapenbeperking: club, sickle, dart, spear, dagger, scimitar, sling, staff. Geneest middels eigen spreukenlijst (gescheiden van Cleric). Speciale abilities: identify pure water/plant (level 1), identify animals (level 2), pass without trace through woodland (level 3), charm woodland animals (level 4), shapechange (level 7) tot 3x per dag in een natuurlijk dier (Reptile, Mammal, Bird) — heelt 1d6x10% HP per change. Spreekt eigen geheime druid-taal. Slechts één Druid per regio op de hoogste levels — uitdagende rituele combat tegen vorige Druid om titel te claimen. Op level 14 wordt Druid een "Hierophant Druid" en transcendeert sterfelijkheid.'),

  ('Thief','d6','DEX',
   'De Thief is meester van de schaduwen en de schaduw van de wet. Vereisten: DEX 9. Mag alleen leren armor (geen schild). Wapenbeperking: club, dagger, dart, hand crossbow, lasso, short bow, sling, staff, broadsword, long sword, scimitar, short sword. Speciale "thieving abilities" met percentage-kansen die per level groeien:
   • Pick Pockets, Open Locks, Find/Remove Traps, Move Silently, Hide in Shadows, Hear Noise, Climb Walls, Read Languages.
Backstab: bij verrassende aanval van achter krijgt hij +4 to hit en x2 dmg op level 1-4, x3 op 5-8, x4 op 9-12, x5 op 13+. Op level 4 leert hij random talen lezen (10% per level). Op level 10 kan hij scrolls van Magic-User en Illusionist gebruiken (25% kans op miscast). Bouwt geen vesting maar leidt mogelijk een dievengilde. Onmisbaar voor het ontmantelen van valstrikken en het openen van magische sloten.'),

  ('Assassin','d6','DEX',
   'De Assassin is de duistere broeder van de Thief, gespecialiseerd in moord en vermomming. Vereisten: STR 12, INT 11, DEX 12, CON 11. Strikt evil alignment. Beperkingen identiek aan Thief plus alle tweehandige zwaarden. Speciale "assassination" tabel: bij verrassing van achter, gooi tegen een tabel (level vs slachtoffer level) — bij succes: instant dood, ongeacht HP. Vermomming: 92%+ succeskans tegen dezelfde rang/ras/geslacht, lager voor verschillen. Vergiftigen: kennis van 6-12 verschillende gifsoorten. Klimmen, sluipen, sloten als Thief maar 5% lager. Op level 14 krijgt hij titel "Grandfather of Assassins" — slechts één in de wereld. Om dit te bereiken moet hij de huidige Grandfather doden in single combat. Een gevaarlijke maar machtige klasse.'),

  ('Monk','d4','WIS',
   'De Monk is een ascetische krijger uit een mysterieuze oosterse traditie. Vereisten: STR 15, WIS 15, DEX 15, CON 11. Lawful enige toelaatbaar. Geen pantser. Wapenbeperking: club, crossbow, dagger, hand axe, javelin, jo stick, bo stick, polearm, spear, staff. Open hand combat: schade groeit per level (1d3 op lvl 1, oplopend tot 4d10 op level 17). Speciale abilities: speed (24" base op lvl 17), stunning blow, deflect missiles, slow fall, immuniteit voor sommige spreuken (charm, hold, ESP) op hogere levels, quivering palm (instant death touch op lvl 13+). Slechts één Monk per level boven 7 in de wereld — duels om door te stromen. Behoort tot een klooster en moet zijn winsten doneren. Geen multi-class, geen dual-class. Lage HP-pool maakt vroege levels gevaarlijk.'),

  ('Bard','d6','CHA',
   'De Bard is een unieke alleskunner, geen normale klasse maar een evolutie. Een speler moet eerst Fighter zijn (level 5+), dan switchen naar Thief (level 5+), dan pas Druid worden om bard-status te krijgen. Vereisten: STR 15, INT 12, WIS 15, DEX 15, CON 10, CHA 15. Half-Elf of Human only. Krijgt unieke bard-spreuken (Druid spell list maar geen toegang tot orb-spreuken). Inspireert party (+1 to hit, saves, morale). Charm via muziek (poging per dag, save vs spell). Legend lore: kennis van legendes, magic items en monsters (% per level). Een legendarische klasse — vaak teveel werk om te bereiken, maar onverslaanbaar als bereikt. Symbolisch personage: de wandelende verteller die altijd weet wat er aan de hand is.'),

  ('Cavalier','d10','STR',
   'De Cavalier is een nobele ridder uit Unearthed Arcana, gespecialiseerd in beredene combat. Vereisten: STR 15, DEX 15, CON 15, INT 10, WIS 10, CHA 15. Lawful only. Mag alle wapens en pantsers gebruiken, met voorkeur voor lance, sword en horse-related weapons. +1 op alle saves vs fear. Bonus to hit met preferred weapons (+3/+2/+1 ranking). Mounted combat-bonussen: dubbele dmg met lance op charge, hoge mobiliteit. Krijgt zwaarder warhorse op level 1 (HP, HD bonus), pegasus of unicorn op hoge levels. Code of honor strikt: geen leugen, geen vlucht, beschermt de zwakke. Verlies van eer = verlies van bonussen tot atonement quest. Een edele klasse voor wie ridderlijkheid wil rolspelen.'),

  ('Barbarian','d12','STR',
   'De Barbarian uit Unearthed Arcana is de meest brute krijger — grootste HP-pool in de game (d12!). Vereisten: STR 15, DEX 14, CON 15, WIS 16. Any non-lawful. Wantrouwt magie en magische items: zal magic-users niet vertrouwen en magische items vermijden behalve potions en weapons (en zelfs deze pas op lvl 8+). Speciale abilities: rage (kort: +HP, +to hit, immune fear), back protection (sense attackers behind), climb cliffs zonder rope, leap, run for hours. Surprise op 4-op-d6 in wildernis. Detect illusions (verbazend!). Op level 10 trekt hij gevolg van wilde stammen aan. Mag geen multi-class, geen dual-class. Een wildernis-klasse die het beste werkt in low-magic settings of als counterpoint tegen de party-magic-user.')
on conflict (name) do nothing;

-- ---------------------------------------------------------------------
-- WAPENS — uitgebreide selectie met rijke beschrijvingen
-- ---------------------------------------------------------------------
insert into public.weapons (name, weapon_type, damage, speed_factor, weight, type, description) values
  -- Swords
  ('Long Sword','Sword','1d8',5,60,'Slashing','Het iconische zwaard van avonturiers, ridders en stadswachten in heel Greyhawk. Een rechte, dubbel-snijdende kling van 36-40 inches met ronde of cruciforme kruisbeschermer. Veelzijdig in één hand, laat een schild in de andere toe. Schade: 1d8 vs Small/Medium, 1d12 vs Large. De standaard om alle andere zwaarden mee te vergelijken. Kosten: 15 gp.'),
  ('Short Sword','Sword','1d6',3,35,'Piercing','Een korte kling van 18-24 inches, ideaal voor gevechten in nauwe gangen, schepen of stedelijke setting. De voorkeur van Halflings en Thieves. Snel (SF 3) en licht (35 oz). Schade: 1d6 vs Small/Medium, 1d8 vs Large. Vaak gedragen als secundair wapen of als parry-blade. Kosten: 8 gp.'),
  ('Bastard Sword','Sword','1d8',6,100,'Slashing','Een hand-and-a-half zwaard, langer dan een long sword maar korter dan een two-hander. Mag éénhandig (1d8) of tweehandig (2d4 vs Small/Med,2d8 vs Large) gehanteerd worden. Vereist STR 13 voor éénhandig gebruik. Geliefd door Cavaliers en hoge-level Fighters om de tactische flexibiliteit. Kosten: 25 gp.'),
  ('Two-Handed Sword','Sword','1d10',10,250,'Slashing','Het wapen van bersekers en eenzame helden — een enorme 5-6 voet kling die met beide handen gehanteerd moet worden. Schade: 1d10 vs Small/Medium, 3d6 vs Large. Speed Factor 10 maakt het traagst van alle zwaarden, maar de schade compenseert. Geen schild mogelijk. Kosten: 50 gp.'),
  ('Scimitar','Sword','1d8',4,40,'Slashing','Een gebogen, eenzijdig zwaard van Baklunish origine, gewild in de woestijnen van de Bright Lands en bij westerse rovers van de Sea Princes. De krommingscurve geeft snelle slashes maar vermindert thrust-mogelijkheden. Druids mogen scimitar gebruiken (zeldzaam: een metalen wapen). Kosten: 15 gp.'),
  ('Falchion','Sword','1d6+1',5,90,'Slashing','Een breed, kort, gebogen zwaard met machete-achtige profiel. Eenzijdig snijdend, populair bij milities en boeren-rebellen want goedkoop te smeden. Schade: 1d6+1 vs Small/Medium, 2d4 vs Large. Kosten: 14 gp.'),
  ('Rapier','Sword','1d6+1',2,40,'Piercing','Een dunne, lange kling primair bedoeld voor stoten. Snelste zwaard in de game (SF 2). Vooral populair in stedelijke duels en hofintriges in Furyondy en Veluna. Vereist DEX 13 voor optimaal gebruik. Kosten: 15 gp.'),

  -- Axes
  ('Battle Axe','Axe','1d8',7,70,'Slashing','Een gevechtsbijl met enkele snede en kop van ~10 lbs op een 36-inch handvat. De voorkeur van Dwarves: balanceren aanvallen op hoge plekken (orcs,ogres) met devastating cleaves. Schade: 1d8 vs Small/Medium, 1d8 vs Large. Eénhandig. Kosten: 5 gp.'),
  ('Two-Handed Battle Axe','Axe','1d10',9,150,'Slashing','Een zware tweehandige variant met 18-inch snede. Schade: 1d10 vs Small/Medium, 2d6 vs Large. Geliefd door Northern Barbarians van de Frost Barbarians. Kosten: 7 gp.'),
  ('Hand Axe','Axe','1d6',4,50,'Slashing','Kleinere versie, ook werpbaar (range 1/2/3 inches = 10/20/30 feet). Bijzonder geliefd door Dwarves en Halflings als secundair wapen. Schade: 1d6 vs Small/Medium, 1d4 vs Large. Kosten: 1 gp.'),
  ('Throwing Axe','Throwing','1d6',4,50,'Slashing','Speciaal gebalanceerde werpbijl. Range 1/2/3. Vlees in close combat. Schade: 1d6/1d4. Kosten: 1 gp.'),

  -- Bows
  ('Long Bow','Bow','1d8',7,30,'Piercing','Een 6-voet lange boog van eikenhout of yew. Vereist STR voor maximale spankracht. Range: 7/14/21 (70/140/210 ft). Rate of fire: 2 schoten/ronde. Schade: 1d8 vs Small/Medium, 1d6 vs Large. Kan magic arrows gebruiken. De voorkeur van Elves en Rangers. Kosten: 60 gp + arrows.'),
  ('Short Bow','Bow','1d6',6,15,'Piercing','Compactere boog, geschikt voor te paard of in dichte begroeiing. Range 5/10/15 (50/100/150 ft). 2 schoten/ronde. Schade: 1d6/1d6. Kosten: 30 gp.'),
  ('Composite Long Bow','Bow','1d8',7,20,'Piercing','Een verfijnde boog van laminaten hout en hoorn — sterker dan een gewone longbow met dezelfde lengte. Range 6/12/18. Vereist hogere STR maar geeft +1 dmg op high-strength characters. Kosten: 100 gp.'),
  ('Composite Short Bow','Bow','1d6',6,15,'Piercing','Korte composite versie. Vooral gewild door beredene boogschutters van de Bright Desert nomads. Range 5/10/15. Kosten: 75 gp.'),

  -- Crossbows
  ('Light Crossbow','Crossbow','1d4+1',7,50,'Piercing','Een mechanische boog met "stirrup" om te spannen. Geen STR vereist. Range 6/12/18 (60/120/180 ft). Slechts 1 schot per ronde door herlaadtijd. Schade: 1d4+1/1d4+1. Iedere klasse mag crossbow gebruiken — de "anti-Magic-User-stress wapen". Kosten: 35 gp.'),
  ('Heavy Crossbow','Crossbow','1d4+1',10,140,'Piercing','Met windlass mechanisme om te spannen. Range 8/16/24. Slechts 1 schot per 2 rondes. Schade: 1d6+1/1d10. Doorboort plate mail beter dan welk ander missiel-wapen. Kosten: 50 gp.'),
  ('Hand Crossbow','Crossbow','1d3',5,30,'Piercing','Een minuscule, in-de-mouw verbergbare crossbow. Geliefd door Assassins en stadse Thieves. Range 2/4/6. 1 schot per ronde. Schade: 1d3 (vaak met gif gecombineerd voor effectiviteit). Kosten: 300 gp (zeldzaam).'),

  -- Daggers
  ('Dagger','Dagger','1d4',2,10,'Piercing','Het kortste metalen wapen, 6-12 inches. Mag werpbaar (range 1/2/3). Snelste (SF 2) en lichtste van alle melee-wapens. Iedere klasse mag dagger gebruiken — zelfs Magic-Users. Vaak vergiftigd door Assassins. Schade: 1d4/1d3. Kosten: 2 gp.'),
  ('Stiletto','Dagger','1d3',2,8,'Piercing','Verfijnde naald-dunne dagger speciaal ontworpen voor het doorboren van mail. Geen schade tegen volledig pantser maar +1 to hit. Klassiek Assassin-wapen. Kosten: 5 gp.'),

  -- Maces / Hammers / Polearms
  ('Mace','Mace','1d6+1',7,100,'Bludgeoning','Een knot met metalen kop, vaak met flanges. Het standaardwapen van Clerics omdat het stomp is en geen bloed vergiet. Schade: 1d6+1 vs Small/Medium, 1d6 vs Large. Effectief tegen pantserdragende vijanden. Kosten: 8 gp.'),
  ('Morning Star','Mace','2d4',7,125,'Piercing/Bludgeoning','Een spiked mace met steel-bal aan de top. Schade: 2d4/1d6+1. Devastating tegen lichte pantsers. Kosten: 5 gp.'),
  ('Footman''s Flail','Flail','1d6+1',7,150,'Bludgeoning','Kettingbal aan een tweehandig handvat. Negeert deels schild-AC bonus (gaat eromheen). Tweehands. Schade: 1d6+1/2d4. Kosten: 3 gp.'),
  ('War Hammer','Hammer','1d4+1',4,60,'Bludgeoning','Een gespecialiseerde hammer met platte kop voor stomp slaan en spike voor pantser-piercing. Werpbaar (range 1/2/3). Geliefd door Dwarves. Schade: 1d4+1/1d4. Kosten: 2 gp.'),
  ('Spear','Spear','1d6',6,50,'Piercing','Een 6-8 voet houten staf met metalen punt. Werpbaar (range 1/2/3). Vooral massa-leger wapen. Reach: kan tweede rij aanvallen vanuit eerste rij. Schade: 1d6/1d8. Kosten: 8 sp.'),
  ('Halberd','Polearm','1d10',9,175,'Slashing/Piercing','Een tweehandig polearm met axe-blade, spike, en hook op een 6-foot handvat. Veelzijdig: snijden, steken, en ontruiteren. Geliefd door Swiss-stijl infanterie. Schade: 1d10/2d6. Kosten: 10 gp.'),
  ('Pike','Polearm','1d6',13,180,'Piercing','Een extreem lange spear (15-20 voet) voor formatie-gevechten. Reach: aanvalt vanuit derde rij. SF 13 maakt slow. Schade: 1d6/1d12. Kosten: 8 gp.'),
  ('Glaive','Polearm','1d6',8,75,'Slashing','Een snijdend polearm: 18-inch single-edged blade op 7-voet pole. Geliefd in Far East. Schade: 1d6/1d10. Kosten: 6 gp.'),
  ('Quarterstaff','Staff','1d6',4,40,'Bludgeoning','Een eenvoudig 6-voet stuk hardhout. Tweehandig. Toegestaan voor Magic-Users, Monks, Druids en Clerics. Verbazend effectief in juiste handen. Schade: 1d6/1d6. Kosten: 2 sp.'),

  -- Slings, clubs, exotic
  ('Sling','Sling','1d4+1',6,0,'Bludgeoning','Een lederen riem voor het werpen van loden kogels of stenen. Range 5/10/20 (50/100/200 ft). Goedkoop, geliefd door Halflings en herders. Schade: 1d4+1 (steen) of 1d6+1 (loden kogel). Kosten: 5 cp + ammo.'),
  ('Staff Sling','Sling','1d6+1',11,40,'Bludgeoning','Een sling op een staf voor extra hefboomwerking. Veel grotere range maar SF 11. Range 6/12/18. Schade: 1d6+1/1d6+1. Kosten: 5 sp.'),
  ('Club','Club','1d6',4,30,'Bludgeoning','Het meest primitieve wapen — een stuk hout. Werpbaar (range 1/2/3). Iedere klasse mag club gebruiken. Schade: 1d6/1d3. Kosten: 0 gp (gratis te vinden).'),
  ('Light Pick','Pick','1d4+1',4,30,'Piercing','Een kleine pick met spike-kop, ontworpen om pantser te doorboren. Eénhandig. Schade: 1d4+1/1d4. Kosten: 1 gp.'),
  ('Heavy Pick','Pick','1d6+1',6,60,'Piercing','Tweehandige variant. +1 dmg vs plate. Schade: 1d6+1/2d4. Kosten: 4 gp.'),
  ('Whip','Whip','1d2',8,20,'Slashing','Een lederen of getouwde whip. Reach 10ft. Lage schade maar kan ontwapenen, struikelen, of een wezen vastgrijpen. Geliefd door slave-drivers en circus-trainers. Schade: 1d2/1. Kosten: 1 gp.'),
  ('Net','Exotic','0',10,100,'Special','Een werpnet om vijand te verstrikken. Range: small. Vereist STR check om los te komen. Geliefd door Roman-stijl gladiators (retiarius). Kosten: 5 gp.'),
  ('Lasso','Exotic','0',10,10,'Special','Een touw met running noose. Range 1/3/5. Bij hit: doelwit moet save vs paralyzation of wordt vastgegrepen. Geliefd door cowboys en monster-tamers. Kosten: 1 gp.'),
  ('Blowgun','Exotic','1',5,10,'Piercing','Een holle pijp die kleine vergiftigde naalden afschiet. Range 1/2/3. Schade: 1 hp (de gif is wat doodt). Geliefd door jungle-tribes en stedelijke Assassins. Kosten: 5 gp.')
on conflict do nothing;

-- ---------------------------------------------------------------------
-- SPREUKEN — substantieel uitgebreid met rijke beschrijvingen
-- ---------------------------------------------------------------------
insert into public.spells (name, level, class, range, duration, area, description) values
  -- ============ MAGIC-USER LEVEL 1 ============
  ('Magic Missile',1,'Magic-User','60ft + 10/lvl','Instantaneous','1+ targets',
   'Creëert 1+ glanzende energie-pijlen (1 op level 1, +1 per 2 caster levels = 5 op level 9). Elke missile doet 1d4+1 schade aan een gekozen target. Onfeilbaar — geen save, geen attack roll. Mag verdeeld worden over meerdere doelen of allemaal op één. Kan magic-resistance en sommige immuniteiten omzeilen, maar wordt geblokkeerd door Shield spell en Brooch of Shielding. Component: V, S. Een onmisbare combat-spell — betrouwbaar, snel en altijd raak.'),
  ('Sleep',1,'Magic-User','30ft + 10/lvl','5 rds/lvl','30ft cube',
   'Brengt tot 4d4 HD aan wezens in slaap (geen save). Wezens van lager HD eerst. Wezens van 5+ HD zijn immuun. Slapenden zijn helpless — een Coup de Grâce doet automatic kill bij keelmessen. Tegenstanders binnen het gebied moeten zwakste eerst slapen. De devastating early-game spell die vele level-1 parties redt van een goblin-overval. Component: V, S, M (zand of rozeblaadjes).'),
  ('Shield',1,'Magic-User','0','5 rds/lvl','caster',
   'Creëert een onzichtbare schild voor de caster. AC 2 vs missiles, AC 4 vs melee-wapens. Negeert volledig magic missile. Stapelt niet met armor (en M-U mag toch geen pantser dragen). De levensredder bij een hinderlaag. Component: V, S.'),
  ('Charm Person',1,'Magic-User','120ft','special','1 person',
   'Een humanoïde van max 4+1 HD ziet de caster als beste vriend (save vs spell — penalty als caster veel hoger CHA heeft). Werkt op humans, demi-humans, en humanoid types tot half-orcs en bugbears. Niet op ondoden, beasts of giants. Duration: gebaseerd op INT van slachtoffer (3-18 INT = 1 day tot 6 months voordat re-save). Component: V, S.'),
  ('Read Magic',1,'Magic-User','0','2 rds/lvl','caster',
   'Laat de caster magic-user spellbooks of magische scrolls lezen — anders zijn ze onleesbaar zelfs voor andere magic-users. Onmisbaar bij vondst van schat. Component: V, S, M (clear crystal of mineral prism).'),
  ('Detect Magic',1,'Magic-User','0','2 rds/lvl','10ft cone',
   'Detecteert aanwezigheid van magische auras in een 10ft brede cone die met de caster meedraait. Op level 6 kan caster ook school van magie (necromantie, illusion etc.) onderscheiden via concentration. Component: V, S.'),
  ('Light',1,'Magic-User','60ft','1 turn/lvl','20ft radius',
   'Creëert een fakkel-equivalent licht. Mag op object cast (verplaatst dan met object) of in lege lucht. Tegenstander mag save indien gericht op ogen — bij failure: blind voor 1 ronde. Component: V, S.'),
  ('Burning Hands',1,'Magic-User','0','Instantaneous','120° cone, 3ft long',
   'Een waaier van vlammen schiet uit caster handen. Schade: 1d3 + 2 per caster level. Save voor halve schade. Goeie spell tegen zwakke groepen vijanden (kobolds, goblins). Component: V, S.'),
  ('Mage Armor',1,'Magic-User','0','4 hr + 1 hr/lvl','caster',
   'Onzichtbaar magisch pantser, AC 6 (zelfde als studded leather). Stapelt met DEX en shield bonuses. Een must-have voor de M-U om early-game survivability te verbeteren. Component: V, S, M (cured leather).'),
  ('Identify',1,'Magic-User','0','1 round/lvl','one item',
   'Onthult de magische eigenschappen van één voorwerp. Vereist 100 gp pearl en 8 hr rust voor casting. 15-25% kans op accurate plus per element van item. Verlies van 8 HP (terugverdiend in 24hr). Onmisbare M-U service voor party. Component: V, S, M (parel + uil-veer).'),

  -- ============ MAGIC-USER LEVEL 2 ============
  ('Mirror Image',2,'Magic-User','0','3 rds/lvl','caster',
   'Creëert 1d4 illusoire kopieën van caster (of 1d4+1 op level 5+, max 8). Aanvallen treffen random een kopie ipv echte caster — illusion verdwijnt bij hit. Devastating in melee voor M-U. Component: V, S.'),
  ('Web',2,'Magic-User','5ft/lvl','2 turns/lvl','8000 cu ft',
   'Vult een 8000 cubic-foot gebied met klevende, sterke spinnewebben. Wezens save vs spell of vastgekleefd. Vastzittende wezens kunnen ontsnappen met STR check (1 ronde voor 18+, langer voor zwakker). Kan in brand gestoken worden — instant 4d4 dmg aan iedereen erin. Goeie crowd control. Component: V, S, M (spider web).'),
  ('Invisibility',2,'Magic-User','60ft','special','1 creature',
   'Doelwit en al zijn dragend uitrusting wordt onzichtbaar. Effect blijft tot caster aanvalt of cast aggressive spell. Anderen kunnen invisible character horen of voelen. See Invisibility, true seeing, dust-of-appearance breken het. Component: V, S, M (eyelash + Arabic gum).'),
  ('Knock',2,'Magic-User','60ft','instant','10x10ft area',
   'Opent gewone sloten, magische sloten (caster level + 1d10 vs spell-level), wizard locks, en barred deuren. Werkt niet op geweld-blokkades (rotsblok). Een dieven-vervangend wonder. Component: V.'),
  ('Levitate',2,'Magic-User','20ft/lvl','1 turn/lvl','1 creature',
   'Caster of een ander wezen kan verticaal stijgen of dalen 20ft per ronde. Geen horizontaal tenzij iets duwen. Laat caster uit gevaar (pit, flood) ontsnappen of vijanden uit reach houden. Component: V, S, M (leather).'),
  ('Stinking Cloud',2,'Magic-User','30ft','1 rd/lvl','20ft cube',
   'Een gele, stinkende wolk waarin wezens save vs poison maken — bij failure: braken en helpless voor 1d4+1 rondes. Effectief tegen brute melee-vijanden zonder sterke CON. Component: V, S, M (rotting egg + skunk cabbage leaves).'),
  ('Ray of Enfeeblement',2,'Magic-User','10ft + 5/lvl','1 rd/lvl','1 creature',
   'Een straal verzwakt doelwit (save vs spell). Bij failure: -25% STR plus +2% per caster level boven 2. Devastating tegen brute Fighters of giants. Component: V, S.'),
  ('ESP',2,'Magic-User','5ft/lvl','1 rd/lvl','one creature/round',
   'Caster leest oppervlakkige gedachten van wezens. Werkt door 2ft stone of 2 inches metal. Eén wezen per ronde. Geweldige ondervragings-tool. Component: V, S, M (copper coin).'),

  -- ============ MAGIC-USER LEVEL 3 ============
  ('Fireball',3,'Magic-User','10ft + 10/lvl','instant','20ft radius',
   'De iconische M-U combat spell. Een vlammenbol explodeert op aangewezen plek met 1d6 schade per caster level (max 10d6 op lvl 10). Save vs spell voor halve schade. Vult 33,000 cubic feet — kan in besloten ruimtes terugkaatsen en jezelf raken. Component: V, S, M (bat guano + sulphur). De spell die dungeons reset.'),
  ('Lightning Bolt',3,'Magic-User','40ft + 10/lvl','instant','40ft x 5ft line',
   'Een rechte lightning bolt van 80ft x 5ft (forked) of 40ft x 10ft (stroke). Schade: 1d6 per caster level. Save voor halve schade. Bolt reflecteert van solid surfaces — devastating in tunnels. Component: V, S, M (bont en glazen staaf).'),
  ('Hold Person',3,'Magic-User','120ft','2 rds/lvl','1-4 persons',
   'Verlamt 1-4 humanoïden. Save vs spell met -2 als slechts één target. Hold = volledig immobilized maar bewust. Een Coup de Grâce kan hen daarna doden. Niet werkbaar op ondoden of giants. Component: V, S, M (klein stuk ijzer).'),
  ('Fly',3,'Magic-User','touch','1 turn + 1d6/lvl','1 creature',
   'Doelwit kan vliegen met 12" speed (24" op lvl 9+) en perfect maneuverability. Duration is GEHEIM zelfs voor caster (random in range) — kan verdwijnen midflucht. Game-changing voor verkenning en escape. Component: V, S, M (vleugel-veer).'),
  ('Haste',3,'Magic-User','60ft','3 rds + 1/lvl','60ft cube, 1/lvl',
   'Tot 1 wezen per caster level krijgt double speed en double aanvallen (niet voor spells). Combineerd met Fighter triple aanvallen op high level = absolute devastation. Cost: elk gebruik veroudert receiver met 1 jaar — sommige DMs maken dit gevaarlijk. Component: V, S, M (shaving van licorice).'),
  ('Slow',3,'Magic-User','90ft + 10/lvl','3 rds + 1/lvl','40ft cube',
   'Counter aan haste. Wezens save vs spell of half attacks/move. -4 to AC, save tot per ronde. Component: V, S, M (drop molasses).'),
  ('Dispel Magic',3,'Magic-User','120ft','instant','30ft cube',
   'Vernietigt magische effecten in target gebied. Tegen permanent items: 50% kans + 5% per caster-level vs item-level. Onmisbaar bij DM-traps en magic shields. Component: V, S.'),
  ('Fireshield',4,'Magic-User','0','2 rds + 1/lvl','caster',
   'Vlammend schild rond caster (cold of fire variant). Halve schade van geselecteerd type, no schade op save. Aanvallers krijgen 1d6+caster-level schade per hit. Component: V, S, M (vuurglim of ijspegel).'),

  -- ============ MAGIC-USER LEVEL 4-5 ============
  ('Wall of Fire',4,'Magic-User','60ft','special','20ft x caster level',
   'Plat of cirkelvormig vuurschild. 2d6 dmg passing through + 2d4 binnen 10ft + 1d4 binnen 20ft. Devastating against summoned undead (extra 1 dmg/HD). Component: V, S, M (zwavel + fosfor).'),
  ('Confusion',4,'Magic-User','120ft','2 rds + 1/lvl','40ft cube',
   '2d8 + 1/lvl wezens. Per ronde gooi: 10% wandelt weg, 20% staat verbijsterd, 30% valt eigen partij aan, 40% acts normaal. Component: V, S, M (3 walnootjes).'),
  ('Polymorph Self',4,'Magic-User','0','2 turns/lvl','caster',
   'Verander in elke vorm/dier max 2000 lbs. Geen extra HP maar eigenschappen van vorm. Game-changer voor creative spellers. Component: V, S.'),
  ('Cone of Cold',5,'Magic-User','0','instant','5ft + 5ft per lvl cone',
   'IJzige cone, 1d4+1 dmg per caster level. Save voor halve schade. Component: V, S, M (kristal of glas).'),
  ('Cloudkill',5,'Magic-User','10ft','1 rd/lvl','40x20x20ft cloud',
   'Gele dodelijke wolk. Wezens onder 4+1 HD: dood. 4+2 tot 5+1 HD: save of dood. 6+ HD: save met +4. Driftt 6ft per ronde windward. Component: V, S, M.'),
  ('Teleport',5,'Magic-User','touch','instant','1 creature',
   'Caster + max 250 lbs/lvl naar bekende locatie. 30% kans probability of error per "study" level. Studied very well: 99% safe. Combat-escape spell par excellence. Component: V.'),
  ('Hold Monster',5,'Magic-User','60ft','1 rd/lvl','1-4 monsters',
   'Like hold person, maar werkt op alle wezens incl. magisch. Save vs spell. Component: V, S, M.'),

  -- ============ CLERIC LEVEL 1 ============
  ('Cure Light Wounds',1,'Cleric','touch','permanent','1 creature',
   'Geneest 1d8 HP. Reverse vorm "Cause Light Wounds" doet 1d8 dmg. Standard go-to-spell. Component: V, S.'),
  ('Bless',1,'Cleric','60ft','6 rounds','50ft cube',
   '+1 op aanvallen en moraal voor allies in gebied. Reverse "Curse" -1 op vijanden. Cast voor combat begin. Component: V, S, M (heilig water).'),
  ('Detect Evil',1,'Cleric','0','1 turn','10ft cone',
   'Detecteert intentioneel kwaad (niet alle Evil-aligned wezens). 60ft cone. Reverse Detect Good. Component: V, S, M (heilig symbool).'),
  ('Light',1,'Cleric','120ft','6 turns','20ft radius','Zoals M-U Light maar langer en duurzamer.'),
  ('Protection from Evil',1,'Cleric','touch','3 rds/lvl','1 creature',
   '+2 AC en saves vs aanvallen van Evil-aligned wezens. Blokkeert summoned wezens fysiek (3ft barrier). Reverse: Protection from Good. Component: V, S, M (heilig water sprenkel).'),
  ('Sanctuary',1,'Cleric','0','2 rds + 1/lvl','caster',
   'Tegenstanders save vs spell of kunnen caster niet zien/aanvallen. Caster mag wel anderen helpen of cast spells, maar geen aanval. Goeie escape spell voor verkenners. Component: V, S, M (small mirror).'),
  ('Command',1,'Cleric','10ft','1 round','1 creature',
   'Eén woord commando (max 1 syllabe): "die!" "flee!" "halt!" "sleep!" "drop!" Wezen save vs spell of moet gehoorzamen 1 ronde. Geen werkt tegen 6+ HD wezens of ondoden. Component: V.'),

  -- ============ CLERIC LEVEL 2-3 ============
  ('Hold Person',2,'Cleric','60ft','4 rds + 1/lvl','1-3 persons',
   'Verlamt 1-3 humanoiden. Save met -1 als één target. Component: V, S, M.'),
  ('Silence 15ft Radius',2,'Cleric','120ft','2 rds/lvl','15ft radius',
   'Stilte sphere centered op object/wezen. Voorkomt verbal spellcasting. Devastating tegen vijandige magic-users. Cast op ammunitie van een fleeing thief = ze cast geen spells meer. Component: V, S.'),
  ('Spiritual Hammer',2,'Cleric','30ft','1 rd/lvl','caster',
   'Magische hamer slaat in cleric''s naam. To-hit als cleric. Schade als war hammer. Bonus: doet schade aan undead/extraplanar. Component: V, S, M (warhammer).'),
  ('Find Traps',2,'Cleric','30ft','3 turns','30ft x 10ft path',
   'Ontdekt mechanische en magische valstrikken op pad. Onmisbaar bij Thief-loze party. Component: V, S.'),
  ('Cure Disease',3,'Cleric','touch','permanent','1 creature',
   'Geneest natuurlijke ziektes en magische ziektes (bv. lycanthropy if cast within 3 days). Reverse Cause Disease. Component: V, S.'),
  ('Prayer',3,'Cleric','0','1 rd/lvl','60ft cube',
   '+1 attack/save voor allies, -1 voor vijanden in gebied. Centered on cleric. Component: V, S, M (prayer beads).'),
  ('Remove Curse',3,'Cleric','touch','permanent','1 creature',
   'Verwijdert curse of cursed item (al kan item terugkeren naar drager). Reverse Bestow Curse. Component: V, S.'),
  ('Animate Dead',3,'Cleric','10ft','permanent','1 corpse/lvl',
   'Creëert 1 skeleton of zombie per caster level uit lijken. Animated dead volgt cleric maar mindless. Goede voor evil clerics; lawful goods uitsluiten. Component: V, S, M (drop blood + bot fragment).'),

  -- ============ CLERIC LEVEL 4-5 ============
  ('Cure Serious Wounds',4,'Cleric','touch','permanent','1 creature',
   'Geneest 2d8+1 HP. Reverse "Cause Serious". Mid-tier healing.'),
  ('Neutralize Poison',4,'Cleric','touch','permanent','1 creature',
   'Verwijdert gif uit lichaam. Niet voor reeds gestorven. Reverse "Poison" = save of dood. Onmisbaar in monster-rich dungeons.'),
  ('Raise Dead',5,'Cleric','30ft','permanent','1 humanoid',
   'Brengt humanoid terug uit dood, 1 dag per caster level dood. Resurrected verliest 1 CON, 2d6 weken bedrust. Komt met 1 HP. Cast snel of niet. Component: V, S, M (5000gp diamond).'),

  -- ============ DRUID LEVEL 1-3 ============
  ('Entangle',1,'Druid','80ft','1 turn','40ft cube',
   'Planten in gebied verstrengelen wezens. Bij failure: vastzittend voor duration. Goed in beboste setting. Component: V, S, M (boomschors).'),
  ('Faerie Fire',1,'Druid','80ft','4 rds/lvl','12ft line per lvl',
   'Doelwitten gloeien met paars/groen licht. Onzichtbaarheid ongedaan, +2 op aanvallen tegen hen, geen surprise mogelijk. Component: V, S, M (mos).'),
  ('Speak with Animals',1,'Druid','40ft','2 rds/lvl','one type',
   'Communiceer met dieren van één soort. Diplomacy mogelijk. Component: V, S, M (treats).'),
  ('Heat Metal',2,'Druid','40ft','7 rds','1 metal armor or weapon',
   'Maakt metaal pijnlijk heet over 7 rondes (1d4 dmg, dan 2d4, dan 1d4, 0). Wapen wordt onhanteerbaar. Devastating tegen plate-mail vijand. Component: V, S, M (vlam + ijzer).'),
  ('Call Lightning',3,'Druid','360ft','1 turn/lvl','outdoors only',
   'Vereist storm. Eén bolt per turn, 8d8 dmg + 1d8 per caster lvl boven 6. Save halve. Apocalyptic outdoor combat. Component: V, S, M.'),

  -- ============ ILLUSIONIST ============
  ('Phantasmal Force',1,'Illusionist','60ft + 10/lvl','until disbelief','40x40 cube + 10ft/lvl',
   'Vol audio-visuele illusie. Wezens save vs spell elke ronde tot disbelief. Geloof = real schade kan gedaan worden. Game master ruling vereist voor schade. Component: V, S, M (rabbit fur).'),
  ('Color Spray',1,'Illusionist','5ft','instant','20ft cone',
   '1d6 wezens. Tot 2 HD: bewusteloos. 3-4 HD: blind 1d4 rds. 5+ HD: stunned 1 ronde. Geweldige early-game crowd control. Component: V, S, M (red/yellow/blue powder).'),
  ('Hypnotic Pattern',2,'Illusionist','30ft','as long as caster concentrates','30ft cube',
   '2d4+caster-level HD aan wezens save of mesmerized. Caster moet concentreren — geen andere actie. Component: V, S, M (kleurig sand).'),
  ('Invisibility 10ft Radius',3,'Illusionist','10ft','special','10ft radius',
   'Hele party invisible binnen 10ft van caster. Aanval = invis breekt voor aanvaller. Tactische infiltratie. Component: V, S, M (eyelash + arabic gum).'),
  ('Phantasmal Killer',4,'Illusionist','5ft + 5/lvl','1 rd/lvl','1 creature',
   'Doelwit ziet zijn diepste angst — INT-check vs spell of dood. Save = 4d6 dmg. Eén van krachtigste low-level lethal spells. Component: V, S.')
on conflict do nothing;

-- ---------------------------------------------------------------------
-- ITEMS — uitgebreid mundane en magische selectie
-- ---------------------------------------------------------------------
insert into public.items (name, category, weight, cost, description) values
  -- Adventuring gear
  ('Backpack','gear',20,'2 gp','Lederen rugzak met dubbele schouderriemen en heuptouwtjes. Capaciteit ~30 lbs zonder sukkelen, max 50 lbs. Gebruikt voor bivak-uitrusting tijdens reizen. Standaard zonder, geen avonturier vertrekt.'),
  ('Sack, Large','gear',15,'2 sp','Burlap of grof linnen zak. Capaciteit 30 lbs, makkelijk droppen.'),
  ('Sack, Small','gear',5,'5 cp','Klein zakje voor losse muntjes en juweeltjes.'),
  ('Bedroll','gear',50,'1 sp','Slaaprol met deken en kussen. Beschermt tegen koude grond — onmisbaar in wildernis.'),
  ('Tinderbox','gear',10,'5 sp','Vuurslag met flint, staal en zwavel-stokjes. 1d4+1 rondes om vuur te ontsteken in optimale omstandigheden.'),
  ('Torch','light',10,'1 cp','6 turns brandend (60 minuten). Helder licht 30ft, schemer 60ft. Kan als wapen (1d4 dmg + 1 fire). Kan vampires en undead afschrikken.'),
  ('Lantern, Hooded','light',20,'7 gp','Brandt 4 uur op 1 fles olie. Helder licht 30ft, schemer 60ft. Hood om licht te concealmen tot smal stralen. Onmisbaar in dungeons.'),
  ('Lantern, Bullseye','light',30,'12 gp','Lantaarn met directionele lens. 60ft cone helder licht. Vooral voor verkennen lange gangen of buiten in nacht.'),
  ('Oil, Flask','gear',10,'1 gp','Brandstof voor lantaarn (4 uur). Gebroken op vloer + ontstoken = 2d6 vuur, persistent 2 rondes. Worpgranaat-wapen tegen ongehurde vijanden.'),
  ('Holy Water (vial)','holy',10,'25 gp','Water gewijd door cleric ceremonie. Tegen ondoden of buitenwereldse wezens: 2d4 dmg bij contact (worpvial of besprenkelen). Onmisbaar tegen vampires.'),
  ('Holy Symbol, Wooden','holy',5,'1 gp','Houten symbol van cleric''s godheid. Vereist voor Turn Undead en sommige spreuken. Dragend slechts één.'),
  ('Holy Symbol, Silver','holy',10,'25 gp','Zilveren versie. Verplicht voor priester in betere kerken; ook werkt als zilverwapen tegen lycanthropes. Beter werkzaam tegen ondoden (sommige DMs +1).'),
  ('Spellbook (blank)','gear',30,'15 gp','Lege spellbook met 100 pages. Magic-users moeten spreuken in spellbook hebben om te memoriseren. Verlies = verlies van toegang tot spreuk tot research opnieuw.'),
  ('Spell Component Pouch','gear',20,'5 gp','Bevat losse componenten voor verbale spreuken (zand,bonen,kristal stukjes). Vereist voor M voltrekken op level 1+ M-U/Cleric spreuken die "M" component vereisen.'),

  -- Wapens / armor accessories
  ('Quiver of Arrows','gear',30,'1 gp','20 standaard houten arrows met steel-tips. Standaard ammunitie voor bow.'),
  ('Crossbow Bolts (case of 30)','gear',45,'1 gp','30 bolt voor crossbow. Iets duurder dan arrows.'),
  ('Sling Stones (5)','gear',5,'—','Vijf rondige stenen of loden kogels voor sling. Vrij oppikbaar als steen.'),
  ('Whetstone','gear',10,'2 cp','Polijst en scherpt wapens. Vereist voor onderhoud na zware combat.'),
  ('Helmet','armor',45,'10 gp','Stalen of bronzen helm. Vereist voor full plate mail effect — zonder helmet -1 AC. Tegen head-shots = 50% kans op pull.'),
  ('Buckler','armor',30,'5 gp','Klein schild, +1 AC, mag in second hand met long sword.'),
  ('Small Shield','armor',50,'3 gp','Standaard +1 AC.'),
  ('Large Shield','armor',100,'7 gp','+1 AC + missile schade absorptie. Gebruikt door Cavaliers.'),

  -- Provisions
  ('Rations, Iron (1 week)','food',70,'5 gp','Gedroogd voedsel + dadel + hard biscuit. 1 week.'),
  ('Rations, Standard (1 day)','food',20,'5 sp','Vers brood, kaas, olijven, water. 1 dag.'),
  ('Wine, Bottle','food',15,'2 gp','Goede kwaliteit. Inn-prijs.'),
  ('Ale, Mug','food',null,'2 cp','Standaard tavern-ale.'),
  ('Waterskin','gear',50,'1 gp','Capaciteit 4 lbs water. Standard veld-uitrusting.'),

  -- Restraint / utility
  ('Rope (50ft,hemp)','gear',75,'1 gp','Hennep touw. Draagt 600 lbs. Veelzijdig: klimmen, bergen, vastbinden, etc.'),
  ('Rope (50ft,silk)','gear',50,'10 gp','Zijden touw. Lichter, sterker. Draagt 1000 lbs. Premium.'),
  ('Grappling Hook','gear',40,'1 gp','Drie haken voor vasthaken aan klippen of muren.'),
  ('Iron Spikes (12)','gear',60,'1 gp','Voor deuren blokkeren of als haakjes te slaan in muren.'),
  ('Crowbar','gear',50,'2 gp','+1 op forceren van deuren/kisten. Kan als improvised club (1d6 dmg).'),
  ('Hammer','gear',20,'5 sp','Standaard timmerhamer. Niet wapen-grade.'),
  ('Pole, 10ft','gear',100,'3 cp','Houten staf. Voor valstrikken testen, niet-magische dingen aanraken.'),
  ('Mirror, Steel','gear',5,'20 gp','Klein steel mirror. Voor Medusa, hoeken kijken, signalering.'),
  ('Thieves'' Tools','gear',10,'30 gp','Kit met lock-picks, files, wedges. Vereist voor Thief''s "Open Locks" en "Find/Remove Traps" zonder penalty.'),
  ('Manacles','gear',30,'15 gp','IJzeren handboeien. STR check 18+ om los te scheuren.'),
  ('Caltrops (4)','gear',5,'1 gp','IJzeren puntjes — gestrooid voor vluchten. 1d2 schade per stap, -1 movement per ronde.'),

  -- Containers
  ('Pouch, Belt','gear',10,'1 gp','Hangt aan riem. Capaciteit ~3 lbs.'),
  ('Vial (with stopper)','gear',5,'1 gp','Glas vial. Voor potions en alchemie.'),
  ('Box, Wooden','gear',30,'2 gp','12x12x6 inch box met deksel.'),

  -- Magic / consumables
  ('Potion of Healing','potion',5,'50 gp','Geneest 2d4+2 HP onmiddellijk bij drinken.'),
  ('Potion of Extra-Healing','potion',5,'400 gp','Geneest 3d8+3 HP. Mag in delen gedronken (3 doses van 1d8+1).'),
  ('Potion of Strength','potion',5,'300 gp','+2 STR voor 6 turns. Of randomly 18(00) STR voor zwakkeren.'),
  ('Potion of Heroism','potion',5,'300 gp','Tot 4 levels boven huidige (extra HD + HP) voor 1 turn + 1d6 turns.'),
  ('Potion of Invisibility','potion',5,'250 gp','Caster invisible 1d6 turns. Verbroken bij agressie.'),
  ('Potion of Speed','potion',5,'450 gp','Effect van haste spell op drinker (zonder de age penalty).'),
  ('Potion of Levitation','potion',5,'250 gp','Effect van levitate op drinker, 1d6 turns.'),
  ('Scroll of Protection from Undead','scroll',1,'350 gp','Cirkel van bescherming 10ft, 6 turns. Geeft AC 4, +2 op saves vs ondoden.'),
  ('Scroll of Magic Missile (cl 5)','scroll',1,'100 gp','Cast magic missile op caster level 5 (3 missiles,3d4+3).'),
  ('Wand of Magic Missiles','wand',5,'5000 gp','100 charges. 1 missile per charge, 1d4+1 dmg. M-U/illusionist only.'),
  ('Wand of Lightning','wand',5,'15000 gp','100 charges. 6d6 lightning bolt per charge. Devastating.'),
  ('Bag of Holding','magic',150,'5000 gp','Houdt 250 lbs / 30 cu ft. Externally weegt 15 lbs. Niet samen met portable hole gebruiken (ASTRAL!).'),
  ('Cloak of Elvenkind','magic',10,'10000 gp','+5% Hide in Shadows, 90% chance niet opgemerkt door non-elves bij stilstaan.'),
  ('Boots of Elvenkind','magic',30,'10000 gp','+95% Move Silently. Zelfs in steppes / gangen.'),
  ('Ring of Protection +1','magic',null,'10000 gp','+1 AC en +1 saves. Stapelt niet met armor magie.'),
  ('Ring of Invisibility','magic',null,'30000 gp','Bij wens invisible. 6 charges per dag of altijd-aan? DM-keuze.'),
  ('Sword +1','magic',60,'2000 gp','Long sword +1 to hit, +1 dmg. De meest gangbare magic weapon.'),
  ('Sword +2 vs Giants','magic',60,'5000 gp','+1 to all hits, +2 to giants (incl ogres,trolls).'),
  ('Holy Avenger','magic',60,'100000+ gp','Long sword +5 in Paladin handen. Magic Resistance 50% in 5ft. Anti-Evil. Het meest gegeerde Paladin item.')
on conflict do nothing;

-- ---------------------------------------------------------------------
-- VAARDIGHEDEN — uitgebreide lijst
-- ---------------------------------------------------------------------
insert into public.skills (name, type, base_stat, description) values
  ('Animal Handling','Non-Weapon','WIS',
   'Trainen en kalmeren van dieren — voornamelijk paarden, jachthonden en valken. Slot vereist voor reizen met mounts. Slot 1, check 1d20 vs WIS-1.'),
  ('Animal Lore','Non-Weapon','INT',
   'Kennis van diergedrag, soort, habitat. Identificeer tracks (vereist met Tracking). Slot 1, check vs INT.'),
  ('Animal Training','Non-Weapon','WIS',
   'Speciaal trainen van dieren in tricks of war-skills. Slot 2.'),
  ('Armorer','Non-Weapon','INT',
   'Repair en maken van armor. Vereist forge en tools. Slot 2.'),
  ('Blacksmithing','Non-Weapon','STR',
   'Smeden van wapens en hulpstukken uit ijzer en staal. Slot 1.'),
  ('Bowyer/Fletcher','Non-Weapon','DEX',
   'Maken en repareren van bows en arrows. Slot 1.'),
  ('Brewing','Non-Weapon','INT','Maken van bier en wijn. Slot 1.'),
  ('Carpentry','Non-Weapon','STR','Constructie met hout. Slot 1.'),
  ('Cooking','Non-Weapon','INT',
   'Bereiding van voedzame en lekkere maaltijden. Verhoogt morale. Slot 1.'),
  ('Dancing','Non-Weapon','DEX',
   'Bevallige bewegingen — sociaal aanzien. Slot 1.'),
  ('Direction Sense','Non-Weapon','WIS',
   'Vinden van noord en oriëntatie zonder kompas. Cruciaal in wildernis. Slot 1, check vs WIS+1.'),
  ('Disguise','Non-Weapon','CHA',
   'Vermomming van eigen verschijning. Assassin gerelateerd. Slot 1.'),
  ('Endurance','Non-Weapon','CON',
   'Uithoudingsvermogen — extra long marches, moeizame omstandigheden weerstaan. Slot 2.'),
  ('Etiquette','Non-Weapon','CHA',
   'Hofgebruik en sociale codes. Onmisbaar in steden en aristocratische settings. Slot 1.'),
  ('Fire-Building','Non-Weapon','WIS',
   'Maken van vuur in slechte omstandigheden (regen, sneeuw, storm). Slot 1, vs WIS-1.'),
  ('Fishing','Non-Weapon','WIS','Vangen van vis. Slot 1.'),
  ('Forgery','Non-Weapon','DEX',
   'Vervalsen van handtekeningen, documenten, zegels. Slot 1, vs DEX-1.'),
  ('Gambling','Non-Weapon','CHA','Strategisch en wedstrijdspelen. Slot 1.'),
  ('Healing','Non-Weapon','WIS',
   'Verzorgen van wonden en ziekte zonder magie. Geneest 1 HP per dag, 3 HP voor severe wounds. Slot 2.'),
  ('Heraldry','Non-Weapon','INT',
   'Herkennen van wapenschilden, families, allegianties. Onmisbaar bij hofdiplomatie. Slot 1.'),
  ('Herbalism','Non-Weapon','INT',
   'Identificatie van kruiden — geneeskrachtig, vergiftig, of psychotrope eigenschappen. Slot 2.'),
  ('Hunting','Non-Weapon','WIS','Vangen van wild voor voedsel. Slot 1.'),
  ('Jumping','Non-Weapon','STR',
   'Verticale en horizontale sprongen. Long jump = STR feet. High jump = ½ STR feet. Slot 1.'),
  ('Languages, Modern','Non-Weapon','INT',
   'Eén extra moderne taal per slot (bv. Dwarvish, Goblin, Halfling).'),
  ('Languages, Ancient','Non-Weapon','INT',
   'Dode talen (Old Oeridian, Ancient Suloise, Flan). Slot 1.'),
  ('Mining','Non-Weapon','WIS','Identificatie van erts en mining-techniek. Slot 2.'),
  ('Mountaineering','Non-Weapon','—',
   'Klimmen van klippen en bergen met tools. Geen check, slot enables ability. Slot 1.'),
  ('Musical Instrument','Non-Weapon','DEX','Per slot één instrument.'),
  ('Navigation','Non-Weapon','INT',
   'Sailing of land-navigatie met kaart. Slot 1, vs INT-2.'),
  ('Pottery','Non-Weapon','DEX','Maken van aardewerk. Slot 1.'),
  ('Riding (Land)','Non-Weapon','WIS',
   'Rijden op paard, kameel, ezel etc. Slot 1.'),
  ('Riding (Airborne)','Non-Weapon','WIS','Rijden op pegasus, griffin etc. Slot 2.'),
  ('Religion','Non-Weapon','WIS',
   'Kennis van goden, ceremonies, tempel-rituelen, rangen. Slot 1.'),
  ('Rope Use','Non-Weapon','DEX','Knopen leggen, klimmen met touw. Slot 1.'),
  ('Running','Non-Weapon','CON',
   'Verhoogt sustained running speed met 50%. Slot 1.'),
  ('Seamanship','Non-Weapon','DEX','Boot-vaardigheid, navigeren in haven en open water. Slot 1.'),
  ('Set Snares','Non-Weapon','DEX',
   'Plaatsen van valstrikken voor wezens. Ranger gerelateerd. Slot 1, vs DEX-1.'),
  ('Singing','Non-Weapon','CHA','Vocale prestatie. Slot 1.'),
  ('Stonemasonry','Non-Weapon','STR','Bouwen met stenen. Slot 1.'),
  ('Survival','Non-Weapon','INT',
   'Overleven in wildernis (voedsel, water, schuilplaats vinden) per terrain-type. Slot 2 per terrain.'),
  ('Swimming','Non-Weapon','STR',
   'Zwemmen — verplicht slot voor zwaardragenden. Zonder slot 50% kans op verdrinking met 30 lbs+. Slot 1.'),
  ('Tracking','Non-Weapon','WIS',
   'Volgen van sporen door verschillende terrains. Ranger krijgt bonus. Slot 2 (1 voor Ranger).'),
  ('Tumbling','Non-Weapon','DEX',
   'Acrobatie. AC -2 in combat, fall damage halved. Slot 1.'),
  ('Weaponsmithing','Non-Weapon','INT','Specialisme van blacksmithing voor wapens. Slot 3.'),
  ('Weather Sense','Non-Weapon','WIS',
   'Voorspelt weer 6 uur vooruit. Slot 1.')
on conflict do nothing;

-- ---------------------------------------------------------------------
-- MONSTERS — uitgebreid Monster Manual stijl
-- ---------------------------------------------------------------------
insert into public.monsters (name, ac, hp_dice, thac0, damage, move, alignment, description) values
  ('Goblin',6,'1-1',20,'1d6',6,'Lawful Evil','FREQUENCY: Common · NO. APPEARING: 40-400 · TREASURE: K (R) · ALIGNMENT: Lawful Evil. Goblins zijn klein (4 ft hoog), gele tot rode huid, scherpe tanden en oranje ogen die in donker glimmen. Ze leven in grotten, oude mijnen en verlaten dungeons. Infravision 60ft. Penalty -1 to hit in zonlicht. Eén shaman per 40 = M-U lvl 1-2. In lairs: 5-30 sub-chiefs (HD 1+1,9 hp), één King (HD 2,11 hp). Goblins zijn cowardly maar talrijk; vrezen vooral dwarves (-1 morale tegen them) en angst pestten van wezens groter dan henzelf.'),

  ('Hobgoblin',5,'1+1',18,'1d8 (or weapon)',9,'Lawful Evil','FREQUENCY: Uncommon · NO. APPEARING: 20-200 · TREASURE: D · ALIGNMENT: Lawful Evil. Hobgoblins zijn 6.5 ft hoog, donkere oranje-rode huid, blauwig-rode neuzen, militair gedisciplineerd. Ze leven in legerkampen of veroverde forten. Sergeants (HD 1+5), Captains (HD 3,fighter equivalents), Chiefs (HD 4-5). Houden orcs als slaven. Vechten met wapens en pantsers (chain mail,shield). Infravision 60ft. Géén penalty in zonlicht. Onverzettelijk bij oorlog — ze gebruiken tactieken die professionele legers naar de kroon steken.'),

  ('Orc',6,'1',19,'1d8 + race weapon',9,'Lawful Evil','FREQUENCY: Common · NO. APPEARING: 30-300 · TREASURE: L (M,Q×10) · ALIGNMENT: Lawful Evil. Orcs zijn 5.5 ft hoog, brutale humanoiden met snouts, prominente snijtanden en grayish-pink huid. Ze stinken vreselijk. Ze haten alle andere races, vooral elves. Penalty -1 to hit in volle zonlicht. Infravision 60ft. Per 100 = leider (HD 2,9 hp), per 200 = chief (HD 3,fighter equiv), 1 high-priest of high-shaman (Cleric lvl 3-5 or M-U lvl 2-4). Komen in tribes met namen als Vile Rune, Bloody Head, Death Moon. Soms allianties met hobgoblins of giants.'),

  ('Bugbear',5,'3+1',16,'2d4 (or weapon +1)',9,'Chaotic Evil','FREQUENCY: Uncommon · NO. APPEARING: 2-16 · TREASURE: B (O,P,Q ×3) · ALIGNMENT: Chaotic Evil. Bugbears zijn reusachtige goblinoiden (7 ft,350-400 lbs), bedekt met donkere haren. Ondanks omvang sluipen ze uitzonderlijk stil — Surprise on 1-3 op d6. Infravision 60ft. Krachtige strikers (+1 STR damage). Vechten met morgensterns of wapens van dode tegenstanders. Vrezen vuur. Leiders zijn jager-trofeën dragend (oren,tanden,vingers).'),

  ('Kobold',7,'1-1',20,'1d4 (or weapon)',6,'Lawful Evil','FREQUENCY: Common · NO. APPEARING: 40-400 · TREASURE: P (Q ×5) · ALIGNMENT: Lawful Evil. Kobolds zijn klein (3 ft), reptielachtig, schubbige roesterige huid, grijne rotsachtige hoorn-stek en lopen op twee benen. Infravision 90ft (beste). Penalty -1 in zonlicht. Lairs zijn complex met valstrikken: pit traps (1d6 dmg), poison darts, falling nets. Per 40 = leiders, 5-30 elite warriors (HD 1,6 hp), één chief (HD 2,14 hp). Bijzonder anti-gnome (haatste vijand) en anti-dog. Mining-experts.'),

  ('Gnoll',5,'2',18,'2d4 (or weapon)',9,'Chaotic Evil','FREQUENCY: Uncommon · NO. APPEARING: 20-200 · TREASURE: D (M,Q ×4) · ALIGNMENT: Chaotic Evil. Gnolls zijn 7-7.5 ft hoog, hyena-koppen, tankoplichaam met slechte houding, en lachen als ze killen. Ze haten alle other races inclusief elkaar — vrouwtjes eten zwakke leiders. Per 20 = leider (HD 3,16 hp), eén chieftain (HD 4+1,22 hp + STR 18). Soms in collusion met flinds of trolls.'),

  ('Skeleton',7,'1',19,'1d6',12,'Neutral','FREQUENCY: Common · NO. APPEARING: 3-30 · TREASURE: nil · ALIGNMENT: Neutral. Geanimeerde skeletten van mensen en humanoiden. Mindless, gehoorzamen alleen creator. Immuun voor sleep, charm, hold, fear, cold-based spells. Halve dmg van slashing/piercing weapons (geen vlees). Onnodig adem te halen, geen voedsel. Skeletons turn als 1 HD undead — bezwaar 1: easy om weg te jagen voor lvl 3+ Cleric.'),

  ('Zombie',8,'2',19,'1d8',6,'Neutral','FREQUENCY: Common · NO. APPEARING: 3-24 · TREASURE: nil · ALIGNMENT: Neutral. Geanimeerde lijken — sliperig, rotting flesh op skelet. Mindless, langzaam, altijd laatste in initiative (no DEX init bonus). Immuun voor sleep, charm, hold, vrees. Onvermoeibaar — kunnen marcheren tot vernietiging. Onthouding: 5% chance op infect bij hit (mummy rot pas op level 3+ undead). Bezwaar 1: matig om weg te jagen.'),

  ('Ghoul',6,'2',19,'1d3/1d3/1d6',9,'Chaotic Evil','FREQUENCY: Uncommon · NO. APPEARING: 2-24 · TREASURE: B · ALIGNMENT: Chaotic Evil. Ondode kannibalen — wezens die in leven mensen aten en als straf in deze vorm zijn herrezen. Drie aanvallen: twee klauwen + beet. Bij hit: paralyseert (save vs paralysis of frozen 3d4 rondes — daarna eet ghoul je). Elves zijn IMMUUN voor ghoul-paralysis. Infravision 90ft. Bezwaar 3 — middel om weg te jagen.'),

  ('Wight',5,'4+3',15,'1 + level drain',12,'Lawful Evil','FREQUENCY: Uncommon · NO. APPEARING: 2-16 · TREASURE: B · ALIGNMENT: Lawful Evil. Voormalige humans of elves die in leven groot kwaad deden. Ze drain 1 EXPERIENCE LEVEL per touch (no save). De drained-victim wordt bij dood zelf wight. Slechts magic of silver weapons treffen them — gewoon ijzer doet niets. Sunlight: -1 per ronde (zwakte). Garlic + hawthorn: kunnen niet binnenkomen. Bezwaar 5.'),

  ('Wraith',4,'5+3',15,'1d6 + level drain',12,'Lawful Evil','FREQUENCY: Rare · NO. APPEARING: 1-12 · TREASURE: E · ALIGNMENT: Lawful Evil. Onmaterieel — wezens van pure malice. Drain 1 level per touch. Vliegen geluidloos. Slechts +1 of beter magic weapons hit them; silver weapons doen halve dmg. Sunlight verzwakt them tot helplessheid. Spell-immune voor: charm, sleep, hold, dood-spells. Half-dmg van cold spells. Bezwaar 7.'),

  ('Vampire',1,'8+3',12,'1d6+4 + 2 levels drain',12,'Chaotic Evil','FREQUENCY: Very rare · NO. APPEARING: 1 · TREASURE: F · ALIGNMENT: Chaotic Evil. De ultieme ondode boogeyman. 8+3 HD plus +1 HD per slachtoffer. Touch drains 2 levels. Charm bij visuele blik (-2 op save). Animal control (gigantic bats,wolves,rats,owls). Gaseous form (escape mechanism). Polymorph (wolf,large bat). Onverwoestbaar door normale wapens; magic wapens needed. Vermijdt: zonlicht (1d6+1 dmg per ronde), running water (1d6+1 dmg/ronde), garlic, holy symbol (ontkracht), mirrors (geen reflectie — visible). Stake through heart while in coffin = permanent dood. Bezwaar 8.'),

  ('Lich',0,'11+',9,'1d10 + paralysis touch',6,'Lawful/Chaotic Evil','FREQUENCY: Very rare · NO. APPEARING: 1 · TREASURE: A,Z · ALIGNMENT: Any Evil. De grootste ondode — voormalig 18+ Magic-User die met necromantie zichzelf in onsterfelijk wezen heeft veranderd. AC 0 (Phantom plate effect). Touch drains levels and paralyzes (save -2). Cast spells als 18th+ M-U. Spelimmune for: hold, charm, fear, sleep, geestelijke aanvallen. Halve dmg cold/electric spells. Phylactery: kan vernietigd worden voor permanente dood. Bezwaar 9.'),

  ('Giant Rat',7,'1d4 hp',20,'1d3',12,'Neutral','FREQUENCY: Common · NO. APPEARING: 5-50 · TREASURE: K · ALIGNMENT: Neutral. Reusachtige rat (1.5 ft+ tail). Komt in groepen — een swarm kan een avonturier overweldigen. 5% kans op disease bij hit (save vs poison of -1d6 STR per dag tot remove disease).'),

  ('Giant Centipede',9,'1/2 hp',20,'1',12,'Neutral','FREQUENCY: Common · NO. APPEARING: 1-12 · TREASURE: nil · ALIGNMENT: Neutral. 1ft pootloosige creep. Bite vergiftig (save vs poison of paralysis 2d6 rondes — geen dood,maar in een zwerm gevaarlijk).'),

  ('Giant Spider',4,'4+4',15,'1d8 + poison',3,'Chaotic Evil','FREQUENCY: Uncommon · NO. APPEARING: 1-4 · TREASURE: C · ALIGNMENT: Chaotic Evil. 7-foot leg-span. Bite poison: save vs poison -2 of dood. Spinnen webben in geometrische patronen. Drop-attack from ceiling: surprise on 1-4 op d6. Mannelijke vooral kleiner.'),

  ('Owlbear',5,'5+2',15,'1d6/1d6/2d6 + hug',12,'Neutral','FREQUENCY: Uncommon · NO. APPEARING: 1-4 · TREASURE: C · ALIGNMENT: Neutral. Magisch hybride (ooit een conjurer experimenteerde). Massief beer-uil monster, 8 ft tall, 1500 lbs. Twee klauwen + beet. Als beide klauwen treffen: bear-hug voor extra 2d8. Eten alles — incl. unsuspecting parties.'),

  ('Troll',4,'6+6',13,'5/5/8 + regen',12,'Chaotic Evil','FREQUENCY: Rare · NO. APPEARING: 1-12 · TREASURE: D · ALIGNMENT: Chaotic Evil. 9-ft hoge cinder-grijs monster met tweede arm-set lower torso. Twee klauwen + beet. Regenereert 3 hp per ronde — alleen vuur of zuur stop dit. Severed limbs blijven leven en kunnen opnieuw aangenaaid worden. Stink heel erg (10ft radius nausea als first encounter). Onverwoestbaar in standard combat — fire/acid is must.'),

  ('Ogre',5,'4+1',17,'1d10 (or huge weapon)',9,'Chaotic Evil','FREQUENCY: Uncommon · NO. APPEARING: 1-12 · TREASURE: M (Q ×3) · ALIGNMENT: Chaotic Evil. 9-10 ft hoog, 600-650 lbs. Knottenhoofd. Stupid maar krachtig. Vechten met zware wapens (clubs,+6 dmg variant). Eten alles — vooral mensen en dwarfs. Komen vaak met Hill Giants of Trolls voor.'),

  ('Hill Giant',4,'8+1-2',12,'2d8 (or weapon)',12,'Chaotic Evil','FREQUENCY: Rare · NO. APPEARING: 1-8 · TREASURE: D · ALIGNMENT: Chaotic Evil. 16 ft tall, 1100 lbs, langste haar bedekt. Werpt rotsblokken (range 8/16/24,2d8 dmg). Vechten met massive clubs of weapons. Soms met dire wolves als pets.'),

  ('Stone Giant',0,'9+1-3',11,'3d6 (or weapon)',12,'Neutral','FREQUENCY: Rare · NO. APPEARING: 1-8 · TREASURE: D · ALIGNMENT: Neutral. 12 ft, slank, harige skin als steen. Werpt rotsblokken (range 30,3d10 dmg). Catch incoming rocks 90% kans (terugwerpen!). Cave-dwellers, oddly artistic.'),

  ('Frost Giant',4,'10+1-4',9,'2d10',12,'Chaotic Evil','FREQUENCY: Rare · NO. APPEARING: 1-6 · TREASURE: E · ALIGNMENT: Chaotic Evil. 18 ft, 2800 lbs, zware blanke barbarian look. Werpt boulder/ice (range 6/12/24,2d12 dmg). Half dmg van cold attacks. Vrezen vuur. Berserk warriors.'),

  ('Fire Giant',3,'11+1-4',9,'5d6',12,'Lawful Evil','FREQUENCY: Rare · NO. APPEARING: 1-6 · TREASURE: E · ALIGNMENT: Lawful Evil. 18 ft, 7000 lbs, ebony skin. Werp magma/rocks (range 30 ft,5d6 dmg). Immuun voor fire. Half dmg van fire weapons. Lederen smiths en blacksmiths van legendarische skill.'),

  ('Wolf',7,'2+2',17,'1d4+1',18,'Neutral','FREQUENCY: Common · NO. APPEARING: 2-12 · TREASURE: nil · ALIGNMENT: Neutral. Roedeldier — alpha leidt strategie. Run-down prey. Vrezen vuur en flame.'),

  ('Dire Wolf',6,'3+3',16,'2d4',18,'Neutral','FREQUENCY: Uncommon · NO. APPEARING: 2-20 · TREASURE: nil · ALIGNMENT: Neutral. Reuze wolf — schouderhoogte 4-5 ft. Often as mounts voor goblinoid races.'),

  ('Brown Bear',6,'5+5',15,'1d6/1d6/1d8',12,'Neutral','FREQUENCY: Common in forests · NO. APPEARING: 1-2 · TREASURE: nil · ALIGNMENT: Neutral. Grizzly-grade. Hug for 2d6 extra dmg na 2 succesvolle klauwen.'),

  ('Polar Bear',6,'8+8',12,'1d10/1d10/2d6',12,'Neutral','FREQUENCY: Uncommon · NO. APPEARING: 1-2 · TREASURE: nil · ALIGNMENT: Neutral. Grootste bear. Arctic regions. Hug 3d6.'),

  ('Lion',6,'5+2',15,'1d4/1d4/1d10',12,'Neutral','FREQUENCY: Uncommon · NO. APPEARING: 1-8 (pride) · TREASURE: nil · ALIGNMENT: Neutral. Surprise hunter, leap-attack +1 to hit, twee paw + bite. Females hunt, males defend.'),

  ('Tiger',6,'5+5',15,'1d4/1d4/1d10',12,'Neutral','FREQUENCY: Rare · NO. APPEARING: 1-2 · TREASURE: nil · ALIGNMENT: Neutral. Solitary jungle hunter. Surprise on 1-4 op d6. Klimt bomen.'),

  ('Black Dragon (small)',2,'7',14,'1d4/1d4/3d6',12,'Chaotic Evil','FREQUENCY: Rare · NO. APPEARING: 1 · TREASURE: F (in lair) · ALIGNMENT: Chaotic Evil. Sub-adult black dragon. Acid breath (60ft x 5ft line,7d6+ dmg,save half). Acidic spit. Lives in stagnant swamp lairs. Speech, magic use vanaf adult age. Sleep ½ time. Treasure-hoarder.'),

  ('Red Dragon (huge)',-1,'11+11',9,'1d10/1d10/5d6',9,'Chaotic Evil','FREQUENCY: Very rare · NO. APPEARING: 1 · TREASURE: H (in lair) · ALIGNMENT: Chaotic Evil. Voltrokken adult red dragon, 60-80 ft body. Vuur cone (90ft x 30ft x 30ft,11d10+ dmg,save half). Massive treasure hoard. Cast spells als M-U lvl 6+. Spreekt Common, Draconic, andere talen. Hebzuchtig, intelligent, grandioos. Het iconische dragon van fantasy.'),

  ('Green Dragon (large)',2,'9',11,'1d6/1d6/2d10',9,'Lawful Evil','FREQUENCY: Rare · NO. APPEARING: 1 · TREASURE: H · ALIGNMENT: Lawful Evil. Forest dweller. Chlorine gas breath (50ft x 40ft cloud,9d6+ dmg). Cunning, manipulative, gebruikt charm magic. Eet alles vegetarisch + voorkeur voor elves.'),

  ('Mind Flayer',5,'8+4',11,'2-8 + 4 tentacles',6,'Lawful Evil','FREQUENCY: Very rare · NO. APPEARING: 1-4 · TREASURE: F (S,T) · ALIGNMENT: Lawful Evil. De Illithid — humanoid met octopus-hoofd. Cast spell-like abilities: Charm Person, Charm Monster, ESP, Plane Shift. Mind blast: 60ft cone, save vs spell of stunned 3d4 rondes. 4 tentakels: bij hit attach to head — 1 turn to drain brain (insta-death + brain consumed). Vrezen daglight. Underdark dwellers. Slaves: Grimlocks.'),

  ('Beholder',0,'45-75 hp',9,'2d4 bite + 10 eye-rays',3,'Lawful Evil','FREQUENCY: Very rare · NO. APPEARING: 1 · TREASURE: I,T,X · ALIGNMENT: Lawful Evil. Bolvormig wezen 4-6 ft diameter, één centraal oog en 10 stalkogen. Centrale oog: anti-magic 60ft cone (no spells,no enchanted weapons). Tien aparte ogen, elk een spell-like ability per ronde: charm person, charm monster, sleep, telekinesis, flesh to stone, disintegrate, fear, slow, cause serious wounds, death ray. Floats via levitation. Paranoid, xenofoob — haat alle andere wezens incl. andere beholders.'),

  ('Lycanthrope, Werewolf',5,'4+3',15,'1d4 (claws) + 2d4 (bite,in wolf form)',15,'Chaotic Evil','FREQUENCY: Uncommon · ALIGNMENT: Chaotic Evil. Mens die transformeert in wolf-mens hybrid (of pure wolf in some traditions). Volle maan compulsion. Bite drains: 100% lvl 1, 50% lvl 2, etc. — bij failure: word zelf werewolf binnen weken (cure disease binnen 3 dagen redt). Slechts silver of magic weapons doen full dmg. Half-dmg van normal weapons. Andere lycanthropes: Wereboar, Weretiger, Wererat (urban), Werebear (good).')
on conflict do nothing;

-- =====================================================================
-- KLAAR! ~250+ entries verspreid over alle categorieën.
-- Aanvullen kan altijd via DM-paneel of CSV import.
-- =====================================================================
