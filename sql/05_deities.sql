-- =====================================================================
-- Greyhawk Campaign Manager — Migratie: Goden & Deities
-- =====================================================================
-- Voegt deities tabel + Greyhawk pantheon toe.
-- Run na 01_schema.sql (of voor bestaande DB: gewoon draaien).
-- =====================================================================

create table if not exists public.deities (
  id           serial      primary key,
  name         text        not null,
  title        text,          -- bv. "God of War" of "Goddess of Agriculture"
  alignment    text,
  domains      text,          -- bv. "War, Strength, Protection"
  symbol       text,          -- bv. "A silver hand" of "Crossed swords"
  worshippers  text,          -- wie vereert deze godheid
  description  text,
  image_url    text,
  source       text        default 'Greyhawk'
);

grant all on public.deities to anon, authenticated;
grant all on public.deities_id_seq to anon, authenticated;

-- Greyhawk Greater Deities
insert into public.deities (name, title, alignment, domains, symbol, worshippers, description) values
  ('Boccob','God of Magic, Arcane Knowledge, Balance, Foresight','True Neutral','Magic, Knowledge, Trickery','An eye in a pentagram','Wizards, sages, diviners, sorcerers',
   'Boccob is de god van de magie zelf — niet van een specifiek doel of alignering. Hij is de Uncaring, de Arch-Mage of the Gods. Zijn priesters dragen paarse gewaden en verzamelen arcane kennis. Boccob is strikt neutraal: hij grijpt nooit in in sterfelijke zaken tenzij de balans van magie zelf bedreigd wordt. Zijn heiligdom in Greyhawk City is een bibliotheek-tempel vol verboden kennis. Hij wordt het meest vereerd door Magic-Users en sages die kennis boven alles plaatsen.'),

  ('Pelor','God of the Sun, Light, Strength, Healing','Neutral Good','Sun, Strength, Healing, Good','A sun face','Farmers, healers, rangers, bards, paladins',
   'Pelor is de zonneGod en een van de meest vereerde goden in de Flanaess. Zijn priesters genezen de zieken, verdrijven ondoden en prediken mededogen. Pelor staat voor hoop in donkere tijden. Zijn grootste tempel staat in de Vrije Stad Greyhawk. Paladins en clerics van Pelor dragen gouden gewaden en worden gezien als beschermers van het volk. Hij is de vijand van alle ondoden en necromantie.'),

  ('Nerull','God of Death, Darkness, Murder, the Underworld','Neutral Evil','Death, Trickery, Evil','A skull and scythe','Assassins, necromancers, evil clerics',
   'Nerull de Reaper is de god van de dood en moord. Zijn volgelingen zijn gevreesd — vaak opereren ze in het geheim. Nerull is niet de dood als natuurlijk proces (dat is Wee Jas) maar als wreedheid en moord. Zijn priesters dragen zwarte gewaden en doen bloedige offers. Hij is de aartsvijand van Pelor. Zijn symbool wordt vaak teruggevonden op giftige dolken en moordwapens.'),

  ('Heironeous','God of Chivalry, Justice, Honor, War, Valor','Lawful Good','War, Good, Law','A silver lightning bolt','Paladins, fighters, monks, judges, nobles',
   'Heironeous is de God van eer in gevecht en ridderlijke deugd. Hij is de aartsrivaal (en halfbroer) van Hextor, god van tirannie. Zijn volgelingen zijn paladins en nobele krijgers die zweren nooit te liegen en de zwakken te beschermen. Zijn clerics dragen zilveren wapenrusting en zijn aanwezig bij elke belangrijke rechtszaak in de Flanaess.'),

  ('Hextor','God of War, Discord, Massacres, Conflict, Fitness, Tyranny','Lawful Evil','War, Destruction, Evil, Law','A fist holding 6 arrows','Tyrants, conquerors, evil fighters, monks',
   'Hextor is de god van oorlog als vernietiging — niet van eer, maar van terreur. Hij is de halfbroer van Heironeous en beiden zijn eeuwige vijanden. Zijn volgelingen zijn tirannen, dictators en militaristen. Hextor eist absolute gehoorzaamheid. Zijn clerics dragen zwart-en-rood pantser en leiden vaak slavenlegers.'),

  ('St. Cuthbert','God of Common Sense, Wisdom, Zeal, Honesty, Truth, Discipline','Lawful Neutral','Strength, Protection, Law','A starburst','Common folk, fighters, monks, paladins',
   'Sint Cuthbert is de volksgod — vereerd door boeren, ambachtslui en soldaten. Hij staat voor gezond verstand, eerlijkheid en discipline. Zijn clerics zijn de "Chapeaux" (koperen-hoed-dragend) en slaan met hun houten knuppels op hoofden van leugenaars. Hij is een van de weinige goden die daadwerkelijk een sterfelijk leven heeft geleid voor zijn apotheose.'),

  ('Obad-Hai','God of Nature, Woodlands, Freedom, Hunting, Beasts','True Neutral','Animal, Plant, Fire, Water','An oak leaf and acorn','Druids, rangers, barbarians, farmers',
   'Obad-Hai is de god van de natuur en de wildernis — de Shalm. Hij is de voornaamste godheid van druiden. Zijn volgelingen leven in bossen en moerassen en verdedigen de wildernis tegen beschaving. Hij is neutraal: de natuur kent geen goed of kwaad. Zijn heiligdommen zijn heilige bosjes, niet gebouwen. Obad-Hai is de rivaal van Ehlonna (die de getemde natuur vertegenwoordigt).'),

  ('Ehlonna','Goddess of Forests, Woodlands, Flora & Fauna, Fertility','Neutral Good','Animal, Plant, Good, Sun','A unicorn horn','Rangers, druids, hunters, elves, gnomes, halflings',
   'Ehlonna van de Bossen is de godin van de getemde natuur — bossen waar elfensteden staan, tuinen, vruchtbare velden. Ze is geliefder dan Obad-Hai bij half-elven en wood elves. Haar priesters planten bomen, genezen dieren en beschermen heilige wouden. Ze verschijnt vaak als een schitterende elf-vrouw met een unicorn als metgezel.'),

  ('Moradin','God of Dwarves, Smithing, Engineering, War','Lawful Good','Earth, Good, Law, Protection','A hammer and anvil','Dwarves, smiths, engineers, miners',
   'Moradin de Zielsmeder is de maker-god van de dwergen. Hij heeft de dwergen persoonlijk geschapen op zijn goddelijke aambeeld en hen de bergen als thuis gegeven. Zijn clerics zijn de bewakers van dwergse tradities: smeedkunst, mijnbouw, eer, bier. Moradin is ook de rechter over dwergse zielen na de dood. Zijn tempel in elke dwergse vestingstad bevat een altijd-brandende smidse.'),

  ('Corellon Larethian','God of Elves, Magic, Music, Arts, Crafts, War','Chaotic Good','Chaos, Good, Protection, War','A crescent moon','Elves, half-elves, bards, artists',
   'Corellon Larethian is de schepper-god van de elven en de Protector. Hij verloor zijn linkeroog in een gevecht met Gruumsh (orkengod) maar overwon. Zijn volgelingen vieren muziek, magie en schoonheid. Corellon wordt vereerd door kunstenaars, Magic-Users en alle elven bij festiviteiten. Zijn clerics dragen lichtblauwe en zilveren gewaden.'),

  ('Gruumsh','God of Orcs, Storms, War, Territory','Chaotic Evil','Chaos, Evil, Strength, War','A single unblinking eye','Orcs, half-orcs, orc shamans',
   'Gruumsh Eénoog is de god van de orcs — verloor zijn oog aan Corellon Larethian en zweert eeuwige wraak op alle elven. Zijn volgelingen offeren gevangenen en vereren brute kracht boven alles. Orc shamans kanaliseren zijn woede in battle-chants die orcs berserker-rage geven. Gruumsh eist dat elke orc ten minste één elf doodt in zijn leven.'),

  ('Lolth','Goddess of Spiders, Evil, Darkness, Chaos, Assassins, Drow','Chaotic Evil','Chaos, Destruction, Evil, Trickery','A spider','Drow elves, assassins, evil clerics',
   'Lolth de Spinnenkoningin is de godin van de Drow — donkere elven die diep ondergronds in de Underdark leven. Zij is de belichaming van verraad, manipulatie en wreedheid. Haar priesteressen (altijd vrouwen — mannen zijn ondergeschikt) leiden de Drow-maatschappij als absolute heerseressen. Lolth verschijnt als een reusachtige spin of als een schitterende Drow-vrouw. Haar grootste stad is Erelhei-Cinlu.'),

  ('Wee Jas','Goddess of Magic, Death, Vanity, Law','Lawful Neutral','Death, Magic, Law','A red skull on fire','Wizards, necromancers (lawful), undertakers',
   'Wee Jas is de godin van de dood als wet — niet als moord (dat is Nerull). Zij beheert de overgang van leven naar dood en houdt de regels van necromantie in balans. Haar volgelingen zijn vaak lawful necromancers die ondoden creëren als dienaren (niet als monsters). Wee Jas is ook de godin van vanity en schoonheid in de dood.'),

  ('Iuz','Demigod of Deceit, Pain, Oppression, Evil','Chaotic Evil','Chaos, Evil, Trickery','A grinning skull','Iuz worshippers, evil humanoids of the Empire of Iuz',
   'Iuz de Oude is een halfgod — zoon van de demonkoningin Iggwilv en de demoon Graz''zt. Hij heerst als tiran over het Keizerrijk van Iuz in het noordwesten van de Flanaess. Zijn onderdanen zijn orcs, ogres en menselijke slaven. Iuz is een van de belangrijkste vijanden in de Greyhawk-campagne en centraal in de Greyhawk Wars.'),

  ('Istus','Goddess of Fate, Destiny, Divination, Future, Honesty','True Neutral','Knowledge, Law, Luck','A spindle','Monks, seers, oracles, the fatalistic',
   'Istus is de godin van het lot — zij spint de draden van het leven. Zij is absoluut neutraal want het lot treft goed en kwaad gelijk. Haar priesters voorspellen de toekomst en weigeren te oordelen over moraal. Zij is de patronesse van Baklunish-landen in het westen van de Flanaess.'),

  ('Vecna','God of Destructive and Evil Secrets, Magic, Hidden Knowledge, Intrigue','Neutral Evil','Evil, Knowledge, Magic','A hand with an eye in the palm','Liches, evil wizards, conspirators',
   'Vecna was ooit een sterfelijke Magic-User die door necromantie een lich werd en vervolgens godheid bereikte. Zijn Hand en Oog zijn legendarische artifacts die immense kracht geven maar de gebruiker corrumperen. Vecna is de god van verboden kennis en duistere geheimen. Zijn cultus opereert vanuit de schaduwen — weinigen weten dat ze bestaan, maar hun invloed reikt tot in de hoogste machtscentra.')
on conflict do nothing;
