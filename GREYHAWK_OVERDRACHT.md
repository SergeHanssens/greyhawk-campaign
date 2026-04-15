# Greyhawk D&D Campaign Manager — Volledige Projectoverdracht

## Voor Claude Code of Cowork

Dit document bevat alle informatie om het Greyhawk D&D Campaign Manager project verder te zetten.
Aanbeveling: gebruik **Claude Code** (terminal-gebaseerd) voor verdere ontwikkeling omdat het project
uit één HTML-bestand + een Supabase database bestaat — ideaal voor Code.

---

## Projectoverzicht

Een volledig functionele AD&D (Advanced Dungeons & Dragons — Greyhawk setting) campaign manager webapp.
Gebouwd als **één enkel HTML-bestand** met Supabase als backend database.

### Wat het kan
- Meerdere spelers kunnen inloggen en hun eigen karakter beheren
- DM (Dungeon Master) heeft toegang tot alle karakters en extra functies
- Volledig bewerkbare character sheets (click-to-edit)
- Greyhawk encyclopedie: 170+ monsters, 250+ spreuken, 80+ wapens, 150+ items
- Logboek van alle wijzigingen per karakter
- Profielfoto per karakter
- PDF export van karakterblad
- Wachtwoord-reset systeem via DM
- Veiligheidsvraag voor DM-account

---

## Tech Stack

| Component | Technologie | Details |
|-----------|-------------|---------|
| Frontend | Vanilla HTML/CSS/JS | Één enkel bestand, geen framework |
| Database | Supabase (PostgreSQL) | gratis tier |
| Hosting | GitHub Pages (gratis, onbeperkt deploys) | |
| Fonts | Google Fonts: Cinzel + Crimson Text | |
| Auth | Custom (btoa hash in players tabel) | Geen Supabase Auth |

---

## Supabase Configuratie

- **Project URL:** `https://otyubyxzvwlaazoszcgi.supabase.co`
- **Publishable key:** `sb_publishable_hbiG9tLK1tsVx7hlOxHbzw_YYDkjw08`
- **Regio:** Central EU (Frankfurt)
- **Project naam:** greyhawk-dnd

### Database tabellen

```
players           — gebruikersaccounts (username, password_hash, is_dm, security_question...)
characters        — karakterbladen (name, race, class, stats, hp, ac, thac0, xp, avatar_url...)
character_weapons — wapens per karakter
character_items   — items per karakter
character_skills  — vaardigheden per karakter
character_spells  — spreuken per karakter
character_log     — logboek van alle wijzigingen
character_opens   — bijhouden wanneer karakter geopend werd (voor log-notificaties)
weapons           — Greyhawk wapendatabase (80+)
spells            — Greyhawk spreuken (250+)
items             — Greyhawk items (150+)
skills            — Greyhawk vaardigheden (80+)
races             — Greyhawk rassen (10)
classes           — Greyhawk klassen (15)
monsters          — Greyhawk monsters (170+)
weapon_types      — Wapentypes voor filtering (Sword, Axe, Bow...)
```

### Alle tabellen hebben RLS uitgeschakeld

Alle tabellen zijn open via `grant all on public.<tabel> to anon` — geen Row Level Security.
Dit is bewust gekozen voor eenvoud (kleine groep vertrouwde gebruikers).

---

## Authenticatie

Geen Supabase Auth — eigen systeem:
- Wachtwoord opgeslagen als `btoa(password)` in `players.password_hash`
- DM krijgt `is_dm = true` via DM-code bij registratie
- **DM Code:** `GREYHAWK_DM_2025`
- Tijdelijk wachtwoord: DM zet `temp_password_hash` + `must_change_password = true`
- Bij login: controleer `password_hash` of `temp_password_hash`
- Veiligheidsvraag: `security_question` + `security_answer_hash` (btoa van antwoord lowercase)

⚠️ btoa is base64, niet echt veilig. Voor productie: upgrade naar bcrypt via Supabase Edge Function.

---

## GitHub Pages Setup (gewenste hosting)

### Repository structuur
```
greyhawk-campaign/
├── index.html          ← de volledige app (greyhawk_app.html hernoemd)
├── README.md           ← installatie-instructies voor anderen
├── sql/
│   ├── 01_setup.sql    ← tabellen aanmaken
│   └── 02_data.sql     ← Greyhawk data (greyhawk_COMPLETE.sql)
└── docs/
    ├── handleiding_speler.html
    └── handleiding_dm.html
```

### Stappen om GitHub Pages te activeren
1. Maak repository `greyhawk-campaign` aan (Public)
2. Upload `index.html` (de app), SQL bestanden, handleidingen
3. Settings → Pages → Deploy from branch → main → / (root) → Save
4. App bereikbaar op: `https://[gebruikersnaam].github.io/greyhawk-campaign`

### Iemand anders die het wil gebruiken (fork & setup)
1. Fork de repository
2. Maak een gratis Supabase account aan op supabase.com
3. Nieuw project aanmaken (regio: Central EU Frankfurt voor BE/NL)
4. SQL Editor: voer `sql/01_setup.sql` uit (tabellen)
5. SQL Editor: voer `sql/02_data.sql` uit (Greyhawk encyclopedie data)
6. In `index.html`: vervang de 2 constanten bovenaan het script:
   ```javascript
   const SB_URL = 'https://JOUW-PROJECT.supabase.co';
   const SB_KEY = 'JOUW-PUBLISHABLE-KEY';
   ```
7. GitHub Pages activeren → klaar!

---

## Bestanden die beschikbaar zijn

Na dit gesprek zijn de volgende bestanden beschikbaar in de outputs:

| Bestand | Inhoud |
|---------|--------|
| `greyhawk_app.html` | De volledige webapp (hernoom naar `index.html`) |
| `greyhawk_final_setup.sql` | Extra kolommen + weapon_types + RLS fix |
| `greyhawk_COMPLETE.sql` | Volledige Greyhawk encyclopedie data |
| `greyhawk_setup.sql` | Basis tabellen aanmaken |
| `handleiding_speler.html` | Printbare spelerhandleiding |
| `handleiding_dm.html` | Printbare DM-handleiding (vertrouwelijk) |

---

## Huidige Situatie (status bij overdracht)

### Wat werkt
- ✅ Login / registratie / wachtwoord wijzigen
- ✅ DM wachtwoord reset voor spelers
- ✅ Veiligheidsvraag bij DM-registratie
- ✅ Karakters aanmaken / bewerken / verwijderen / inactief zetten
- ✅ Profielfoto uploaden (base64 in database)
- ✅ Wapens/items/vaardigheden/spreuken toevoegen via zoekmodal
- ✅ Wapens filteren op type (Sword, Axe, Bow...)
- ✅ Encyclopedie volledig met 750+ items
- ✅ DM kan encyclopedie bewerken/verwijderen/toevoegen
- ✅ Logboek van wijzigingen
- ✅ Automatische log-notificatie bij opening
- ✅ PDF export
- ✅ DM Dashboard (alle karakters overzicht)
- ✅ DM privé notities (onzichtbaar voor spelers)
- ✅ DM sessie-aantekeningen (voor XP-planning)
- ✅ Karakter inactief/actief wisselen
- ✅ Bevestigingsvenster bij verwijderen
- ✅ Rode sterretjes bij verplichte velden
- ✅ Help-functie (? knop + modal)
- ✅ Dobbelstenen gids
- ✅ Encyclopedie bewerkbaar door DM (✏ knop)

### Nog te doen (volgende versie)
- ❌ Scan/foto van handgeschreven karakterblad → automatisch inlezen
  → Vereist Netlify/Vercel serverless function (gratis) voor Anthropic API aanroep
  → CORS blokkeert directe API aanroepen vanuit browser
- ❌ CSV/Excel import van karakters of database items
- ❌ Realtime sync tussen DM en spelers (nu: refresh nodig)
- ❌ Nieuwe weapon_types kunnen aanmaken in de UI (nu alleen via Supabase)
- ❌ Handleidingen bijwerken met profielfoto, sessie-aantekeningen, nieuwe DM functies
- ❌ Supabase Auth (echte email/wachtwoord authenticatie met wachtwoord-vergeten via mail)

---

## Scan-functie implementeren (volgende prioriteit)

De scan van handgeschreven karakterbladen werkt niet vanuit de browser omdat
Anthropic CORS-headers blokkeert. Oplossing: Netlify serverless function.

### Stap 1: Netlify Functions gratis activeren
```
Repository structuur toevoegen:
netlify/
  functions/
    scan-character.js   ← serverless function
netlify.toml            ← configuratie
```

### scan-character.js
```javascript
const Anthropic = require('@anthropic-ai/sdk');

exports.handler = async (event) => {
  const { imageBase64, mediaType } = JSON.parse(event.body);
  const client = new Anthropic({ apiKey: process.env.ANTHROPIC_API_KEY });
  
  const response = await client.messages.create({
    model: 'claude-sonnet-4-20250514',
    max_tokens: 1000,
    messages: [{
      role: 'user',
      content: [
        { type: 'image', source: { type: 'base64', media_type: mediaType, data: imageBase64 } },
        { type: 'text', text: 'Extract D&D character sheet data. Return ONLY JSON: {"name":"","race":"","class":"","level":1,...}' }
      ]
    }]
  });
  
  return {
    statusCode: 200,
    body: response.content[0].text
  };
};
```

### netlify.toml
```toml
[build]
  command = "echo 'No build needed'"
  publish = "."
  functions = "netlify/functions"
```

### In de app: vervang de fetch URL
```javascript
// In plaats van directe Anthropic API aanroep:
const resp = await fetch('/.netlify/functions/scan-character', {
  method: 'POST',
  body: JSON.stringify({ imageBase64: base64, mediaType: file.type })
});
```

### Netlify env var instellen
Dashboard → Site → Environment variables → `ANTHROPIC_API_KEY` = jouw sleutel

---

## Spelersgroep

- **Serge** (eigenaar project, heeft Supabase + GitHub account)
- **Bart** (DM) — nog geen account, maakt aan met DM code
- **6+ spelers** in de groep
- Karakter Blorf Foghorn (Dwarf Fighter lv9, True Neutral) is reeds aangemaakt

---

## Specifieke AD&D Greyhawk Regels Ingebakken

### Ras → Klasse beperkingen
```javascript
const RACE_CLASSES = {
  Human: [alle klassen],
  Dwarf: ['Fighter','Thief','Assassin','Cleric'],
  Elf: ['Fighter','Magic-User','Thief','Cleric','Assassin','Ranger'],
  Gnome: ['Fighter','Thief','Assassin','Cleric','Illusionist'],
  'Half-Elf': ['Fighter','Magic-User','Cleric','Thief','Assassin','Ranger','Druid','Bard'],
  Halfling: ['Fighter','Thief','Assassin'],
  'Half-Orc': ['Fighter','Thief','Assassin','Cleric']
};
```

### Gezindheidssysteem
9 gezindheden: Lawful/Neutral/Chaotic × Good/Neutral/Evil

### THAC0 systeem
`AC geraakt = THAC0 − D20 worp − bonussen`

---

## README.md voor GitHub (voor anderen die willen opzetten)

```markdown
# Greyhawk D&D Campaign Manager

Een gratis, open-source AD&D (Greyhawk) campaign manager webapp.
Één HTML-bestand + gratis Supabase database.

## Features
- Meerdere karakters per speler
- DM heeft toegang tot alle karakters
- Volledige Greyhawk encyclopedie (750+ items)
- Logboek van wijzigingen
- Profielfoto per karakter
- PDF export

## Zelf opzetten (15 minuten)

### 1. Supabase database
1. Maak gratis account op [supabase.com](https://supabase.com)
2. Nieuw project → regio: Central EU (Frankfurt)
3. SQL Editor → voer `sql/01_setup.sql` uit
4. SQL Editor → voer `sql/02_data.sql` uit (groot bestand, even wachten)

### 2. App configureren
Open `index.html` en vervang bovenaan het `<script>` blok:
```javascript
const SB_URL = 'https://JOUW-PROJECT-ID.supabase.co';
const SB_KEY = 'JOUW-PUBLISHABLE-KEY';
const DM_CODE = 'KIES-EEN-EIGEN-DM-CODE';
```

### 3. Hosting via GitHub Pages
1. Fork deze repository
2. Settings → Pages → Deploy from branch → main
3. Je app staat op `https://jouwgebruikersnaam.github.io/greyhawk-campaign`

## Eerste gebruik
1. Ga naar de app-URL
2. Klik "Nieuw account aanmaken"
3. **DM:** vul de DM Code in bij registratie
4. **Spelers:** laat DM Code leeg
5. Start met karakters aanmaken!

## DM Code
Kies een eigen code in `index.html` bij `const DM_CODE`.
Verander de standaard code vóór je de app publiek zet!

## Licentie
MIT — vrij te gebruiken en aan te passen
```

---

## Vragen / Verdere Ontwikkeling

Bij vragen aan Claude Code of Cowork: geef dit document mee als context.
De app staat in één bestand (`index.html`) — alle logica, stijl en functionaliteit zit erin.

Supabase URL en key staan bovenaan het script als constanten:
```javascript
const SB_URL = '...';
const SB_KEY = '...';
const DM_CODE = 'GREYHAWK_DM_2025';
```

