// =====================================================================
// Greyhawk Campaign Manager — Scan Karakter Serverless Function
// =====================================================================
// Wordt aangeroepen vanuit de browser om een foto van een handgeschreven
// karakterblad te laten lezen door Claude (Anthropic API).
//
// Vereist environment variable in Netlify:
//   ANTHROPIC_API_KEY = sk-ant-...
//
// Endpoint: /.netlify/functions/scan-character
// =====================================================================

const ALLOWED_MEDIA = ['image/jpeg', 'image/png', 'image/webp', 'image/gif'];
const MAX_BYTES = 5 * 1024 * 1024; // 5 MB

const PROMPT = `Je krijgt een foto van een handgeschreven AD&D (Greyhawk) karakterblad.
Lees alle zichtbare informatie en geef het terug als pure JSON (geen markdown, geen uitleg).

Schema (laat onbekende velden weg of zet op null):
{
  "name": "string",
  "player_name": "string",
  "race": "Human|Dwarf|Elf|Gnome|Half-Elf|Halfling|Half-Orc",
  "class": "Fighter|Paladin|Ranger|Magic-User|Illusionist|Cleric|Druid|Thief|Assassin|Monk|Bard|Cavalier|Barbarian",
  "alignment": "Lawful Good|Lawful Neutral|Lawful Evil|Neutral Good|True Neutral|Neutral Evil|Chaotic Good|Chaotic Neutral|Chaotic Evil",
  "sex": "Male|Female",
  "level": 1,
  "hp_current": 0, "hp_max": 0,
  "ac": "string", "thac0": 0,
  "xp": 0, "xp_next": 0,
  "str": 0, "dex": 0, "int": 0, "wis": 0, "con": 0, "cha": 0, "comeliness": 0,
  "str_mod": "string", "dex_mod": "string", "int_mod": "string",
  "wis_mod": "string", "con_mod": "string", "cha_mod": "string",
  "sv_pd": 0, "sv_rsw": 0, "sv_pp": 0, "sv_bw": 0, "sv_spell": 0, "sv_poison": 0,
  "pp": 0, "gp": 0, "sp": 0, "cp": 0,
  "notes": "string",
  "weapons": [{"weapon_name":"","attacks_per_round":"1/1","damage":"","speed_factor":7,"notes":""}],
  "items": [{"item_name":"","category":"item","quantity":1,"notes":""}],
  "skills": [{"skill_name":"","skill_type":"Non-Weapon","stat_modifier":"","notes":""}],
  "spells": [{"spell_name":"","spell_level":1,"spell_class":"","prepared":false,"notes":""}]
}

Geef enkel valide JSON terug.`;

exports.handler = async (event) => {
  // CORS preflight
  if (event.httpMethod === 'OPTIONS') {
    return {
      statusCode: 204,
      headers: {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': 'POST, OPTIONS',
        'Access-Control-Allow-Headers': 'Content-Type',
      },
      body: '',
    };
  }

  if (event.httpMethod !== 'POST') {
    return resp(405, { error: 'Method not allowed' });
  }

  const apiKey = process.env.ANTHROPIC_API_KEY;
  if (!apiKey) {
    return resp(500, {
      error: 'ANTHROPIC_API_KEY niet geconfigureerd in Netlify omgevingsvariabelen.',
    });
  }

  let body;
  try {
    body = JSON.parse(event.body || '{}');
  } catch {
    return resp(400, { error: 'Ongeldige JSON in request body.' });
  }

  const { imageBase64, mediaType } = body;
  if (!imageBase64 || !mediaType) {
    return resp(400, { error: 'imageBase64 en mediaType zijn vereist.' });
  }
  if (!ALLOWED_MEDIA.includes(mediaType)) {
    return resp(400, { error: `Ondersteunde formaten: ${ALLOWED_MEDIA.join(', ')}` });
  }
  // base64 -> bytes (rough)
  if (imageBase64.length * 0.75 > MAX_BYTES) {
    return resp(413, { error: 'Afbeelding te groot (max 5 MB).' });
  }

  try {
    const apiResp = await fetch('https://api.anthropic.com/v1/messages', {
      method: 'POST',
      headers: {
        'content-type': 'application/json',
        'x-api-key': apiKey,
        'anthropic-version': '2023-06-01',
      },
      body: JSON.stringify({
        model: 'claude-sonnet-4-5',
        max_tokens: 2000,
        messages: [
          {
            role: 'user',
            content: [
              {
                type: 'image',
                source: { type: 'base64', media_type: mediaType, data: imageBase64 },
              },
              { type: 'text', text: PROMPT },
            ],
          },
        ],
      }),
    });

    if (!apiResp.ok) {
      const errText = await apiResp.text();
      return resp(apiResp.status, {
        error: `Anthropic API fout (${apiResp.status})`,
        details: errText.substring(0, 500),
      });
    }

    const data = await apiResp.json();
    const text = data?.content?.[0]?.text || '';

    // Strip optional markdown fence
    const cleaned = text
      .replace(/^```json\s*/i, '')
      .replace(/^```\s*/i, '')
      .replace(/```\s*$/i, '')
      .trim();

    let parsed;
    try {
      parsed = JSON.parse(cleaned);
    } catch {
      return resp(502, {
        error: 'Claude gaf geen valide JSON terug.',
        raw: text.substring(0, 1000),
      });
    }

    return resp(200, { ok: true, character: parsed });
  } catch (e) {
    return resp(500, { error: 'Onverwachte fout', details: String(e).substring(0, 500) });
  }
};

function resp(statusCode, obj) {
  return {
    statusCode,
    headers: {
      'content-type': 'application/json',
      'Access-Control-Allow-Origin': '*',
    },
    body: JSON.stringify(obj),
  };
}
