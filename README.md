# Greyhawk Campaign Manager

Een gratis, open-source AD&D (Greyhawk-setting) campagne-manager. Spelers beheren hun karakter, de DM ziet alles, en de hele groep deelt één encyclopedie.

**Live demo:** zodra je deze repo deployed (zie hieronder) vind je 'm op `https://JOUW-USERNAME.github.io/greyhawk-campaign`.

---

## Inhoud

- [Wat je krijgt](#wat-je-krijgt)
- [Architectuur](#architectuur)
- [Snelstart — eigen campagne in 15 minuten](#snelstart--eigen-campagne-in-15-minuten)
- [Optioneel: scan-functie via Netlify](#optioneel-scan-functie-via-netlify)
- [CSV-import voor de encyclopedie](#csv-import-voor-de-encyclopedie)
- [Bestandsstructuur](#bestandsstructuur)
- [Onderhoud & updates](#onderhoud--updates)
- [Bekende beperkingen](#bekende-beperkingen)
- [Licentie](#licentie)

---

## Wat je krijgt

- 🧙 **Karakterbladen** — full AD&D character sheets met click-to-edit auto-save
- ⚔️ **Wapens, items, vaardigheden, spreuken** per karakter
- 📚 **Greyhawk encyclopedie** — 7 rassen, 13 klassen, ~40 wapens, ~60 spreuken, ~50 items, ~40 monsters (allemaal met rijke uitleg in de stijl van het Player's Handbook). Direct uitbreidbaar via DM-paneel of CSV-import.
- 👑 **DM Dashboard** — overzicht van alle karakters, HP-balken, privé notities
- 🔒 **DM-only velden** — privé notities, sessie-aantekeningen
- 📋 **Logboek** — automatisch wat veranderde en door wie
- 🖼️ **Profielfoto** per karakter
- 📄 **PDF export** van karakterblad
- 🔑 **Wachtwoord-reset** door DM (met veiligheidsvraag voor DM-account)
- 📷 **Scan handgeschreven karakterblad** — optioneel (vereist Netlify, zie verder)
- 📥 **CSV / JSON / Markdown import** voor encyclopedie (DM-only)
- 📤 **Export** karakter, sessie of encyclopedie als CSV / JSON / Markdown / PDF
- 📅 **Sessies** — DM plant sessies, kiest deelnemers; spelers vullen per-sessie log; XP-toekenning automatisch in karakter
- ★ **Feature-overzicht** in de app — knop rechtsboven

---

## Architectuur

| Component | Technologie | Kosten |
|---|---|---|
| Frontend | Vanilla HTML/CSS/JavaScript (split in `index.html`, `assets/styles.css`, `assets/app.js`) | — |
| Database | [Supabase](https://supabase.com) (PostgreSQL) | Gratis tier (500 MB) |
| Hosting | [GitHub Pages](https://pages.github.com) | Gratis, onbeperkt |
| Optionele scan | [Netlify Functions](https://www.netlify.com/products/functions/) + [Anthropic API](https://www.anthropic.com/api) | Gratis tier + ~€0,01 per scan |
| Auth | Custom (`btoa` hash in `players` tabel) | — |

**Totale kost zonder scan: €0.** Scan-functie kost alleen wat je effectief gebruikt.

Bewust géén framework — geen build step, geen `npm install`, geen lock files. Eén HTML opent direct in de browser, één SQL-bestand maakt de database. Onderhoud blijft mogelijk zonder dev-omgeving.

---

## Snelstart — eigen campagne in 15 minuten

### Stap 1: Gratis Supabase-database aanmaken

1. Ga naar [supabase.com](https://supabase.com) → **Start your project**
2. Account maken (Google of e-mail; geen creditcard nodig)
3. **New project**:
   - Name: `greyhawk-campaign`
   - Database password: kies een sterke (bewaar 'm)
   - Region: dichtst bij jou (Central EU – Frankfurt voor BE/NL)
4. **Create new project** → ~2 minuten wachten

> **Wat je gratis krijgt:** 500 MB opslag, onbeperkt API-calls, geen creditcard, gratis zolang het project actief blijft.

### Stap 2: Database-schema aanmaken

1. Linkermenu → **SQL Editor** (icoon `< >`)
2. **+ New query**
3. Open `sql/01_schema.sql` in deze repo, kopieer alles, plak in Supabase, klik **Run**
4. Verwacht: *"Success. No rows returned"* ✓

### Stap 3: Encyclopedie vullen

1. Nieuwe SQL query → run `sql/02_seed.sql`
2. Nieuwe SQL query → run `sql/03_seed_extra.sql` (extra spreuken lvl 4-9, magic items, dragons, devils, demons, ondoden)
3. *(Voor bestaande databases)* run `sql/04_add_images.sql` om `image_url` kolommen toe te voegen aan de encyclopedie. Niet nodig bij verse install (`01_schema.sql` heeft het al).
4. Verwacht: *"Success"* na elke run ✓

Je hebt nu 7 rassen, 13 klassen, ~70 wapens, ~110 spreuken (alle levels), ~100 items + magic items, ~85 monsters.

> Voor een **complete** Player's Handbook + Monster Manual moet je verder uitbreiden — dit kan via DM-paneel, CSV/JSON/MD import, of door een AI 100 entries in JSON te laten genereren en die te plakken in **📥 Importeren**.

### Stap 4: API-sleutels ophalen

1. Linkermenu → **Project Settings** (tandwiel, links onderaan) → **API**
2. Kopieer:
   - **Project URL** (`https://xxxxx.supabase.co`)
   - **Publishable key** (begint met `sb_publishable_…`)

> ℹ️ De publishable key is **bedoeld** om in browser-code te staan — geen geheim. Het beperkt enkel welke acties anonieme bezoekers mogen doen.

### Stap 5: App configureren

Open `index.html`. Onderaan, vlak voor `</body>`, vind je:

```javascript
const SB_URL='https://JOUW-PROJECT.supabase.co';
const SB_KEY='sb_publishable_JOUW-KEY';
const DM_CODE='KIES-EIGEN-CODE';
```

Vervang door jouw waarden. **Wijzig zeker de DM_CODE** naar iets dat alleen jij en de DM kennen — wie deze code intypt bij registratie krijgt DM-rechten.

### Stap 6: GitHub Pages activeren

1. [github.com](https://github.com) → **+** → **New repository** → naam `greyhawk-campaign` → Public → Create
2. **uploading an existing file** → upload de hele inhoud van deze map (sleep alle bestanden + de mappen `assets/`, `sql/`, `netlify/` erin)
3. **Commit changes**
4. **Settings** → **Pages** → Source: *Deploy from a branch* → Branch: `main`, Folder: `/ (root)` → **Save**
5. Na 1-2 min: `https://JOUW-USERNAME.github.io/greyhawk-campaign`

### Stap 7: Eerste gebruik

1. Open de URL
2. **Nieuw account aanmaken**
3. **DM:** vul de `DM_CODE` in → veiligheidsvraag instellen
4. **Spelers:** geef hen de URL → ze registreren met leeg DM Code-veld
5. Karakters aanmaken!

---

## Optioneel: scan-functie via Netlify

GitHub Pages serveert alleen statische bestanden — perfect voor de app, maar de **scan-functie** (foto van handgeschreven karakterblad → automatisch karakter aanmaken) heeft een serverless backend nodig om de Anthropic API te bevragen (CORS blokkeert de browser). Netlify is gratis en zonder gedoe.

### Setup (10 minuten)

1. **Anthropic API key** ophalen op [console.anthropic.com](https://console.anthropic.com) → Settings → API Keys (begint met `sk-ant-…`). Kosten: ~€0,01 per scan.
2. **Netlify account** aanmaken op [netlify.com](https://netlify.com) (gratis, geen creditcard)
3. **Add new site** → **Import an existing project** → kies GitHub → selecteer `greyhawk-campaign`
4. Build settings: laat alles standaard (`netlify.toml` regelt het)
5. **Site settings** → **Environment variables** → **Add a variable**:
   - Key: `ANTHROPIC_API_KEY`
   - Value: jouw `sk-ant-…` sleutel
6. **Deploys** → **Trigger deploy** → **Deploy site**

Je site staat nu op `https://random-name.netlify.app`. Geef die URL aan je spelers in plaats van de GitHub Pages URL — alle features werken plus de scan-knop.

> **Tip:** Op Netlify kan je ook GitHub Pages laten staan voor wie geen scan nodig heeft. Geen nadelen.

---

## CSV-import voor de encyclopedie

Wil je honderden monsters of spreuken in één keer toevoegen? De DM ziet op de Encyclopedie-pagina rechtsboven het + formulier een knop **📥 CSV importeren**.

**Format:** komma-gescheiden, eerste rij = kolomnamen. Tekst met komma's tussen `"…"`. Onbekende kolommen worden genegeerd. `name` is verplicht.

**Voorbeeld voor `monsters`:**

```csv
name,ac,hp_dice,thac0,damage,move,alignment,description
"Goblin Chief",4,3+1,18,"1d8+2",9,"Lawful Evil","Leider van een goblin-clan, draagt magische amulet"
"Wolf Pack Alpha",6,3+3,16,"1d6+2",18,"Neutral","Grootste wolf in een roedel"
```

Verwachte kolommen per categorie zie je live in het importvenster.

---

## Bestandsstructuur

```
greyhawk-campaign/
├── index.html                  ← markup + Supabase config
├── assets/
│   ├── styles.css              ← alle styling
│   └── app.js                  ← alle applicatie-logica
├── handleiding_speler.html     ← printbare speler-handleiding
├── handleiding_dm.html         ← vertrouwelijke DM-handleiding
├── sql/
│   ├── 01_schema.sql           ← tabellen aanmaken
│   └── 02_seed.sql             ← encyclopedie vullen
├── netlify/
│   └── functions/
│       └── scan-character.js   ← serverless scan-endpoint (optioneel)
├── netlify.toml                ← Netlify configuratie (optioneel)
├── README.md                   ← dit bestand
├── LICENSE                     ← MIT
└── .gitignore
```

---

## Onderhoud & updates

**App aanpassen:**
- Code wijzigen → committen → GitHub Pages of Netlify deployt automatisch binnen 1-2 minuten
- Geen build step, geen npm — gewoon HTML/CSS/JS bewerken

**Database wijzigen:**
- Supabase **Table Editor** voor losse rijen
- Supabase **SQL Editor** voor bulk
- DM-paneel in de app voor encyclopedie-entries
- CSV-import voor grote toevoegingen

**Backup:**
- Supabase Dashboard → **Database** → **Backups** (gratis tier: 1 dag retention)
- Voor manuele backup: SQL Editor → `pg_dump` of via Supabase CLI

---

## Bekende beperkingen

- **Wachtwoord-beveiliging is `btoa` (base64)** — voldoende voor een vertrouwde vriendenkring, niet voor publieke deployment. Voor productie: Supabase Auth met bcrypt.
- **RLS (Row Level Security) staat uit** — alle ingelogden mogen alle data wijzigen. De app dwingt de regels af in JavaScript. Voor publiek gebruik: RLS-policies schrijven.
- **Realtime sync** is er niet — wijzigingen worden zichtbaar bij refresh of bij openen van een karakter.
- **Offline gebruik** is niet ondersteund.
- **Scan-functie** vereist Netlify (niet GitHub Pages).

---

## Licentie

[MIT](LICENSE) — vrij te gebruiken, modificeren en distribueren voor persoonlijk niet-commercieel gebruik.

> AD&D, Dungeons & Dragons en Greyhawk zijn handelsmerken van Wizards of the Coast / Hasbro. Dit project is een onafhankelijke fan-tool, niet geaffilieerd met of onderschreven door WotC.

---

## Ontwikkelaar

Ontwikkeld door **[SHiftEDmake](https://shiftedmake.com)** — *van Droom naar Werkelijkheid*
