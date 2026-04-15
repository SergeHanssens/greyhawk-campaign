let CU=null, CC=null, encData=[], encTable='weapons', encAllData=[];
let addData=[], addTable='', addCallback=null, pendingDelCharId=null;
let dbEditTable='', dbEditId=null;

const RACE_CLASSES={
  Human:['Fighter','Paladin','Ranger','Magic-User','Illusionist','Cleric','Druid','Thief','Assassin','Monk','Bard','Cavalier','Barbarian'],
  Dwarf:['Fighter','Thief','Assassin','Cleric'],
  Elf:['Fighter','Magic-User','Thief','Cleric','Assassin','Ranger'],
  Gnome:['Fighter','Thief','Assassin','Cleric','Illusionist'],
  'Half-Elf':['Fighter','Magic-User','Cleric','Thief','Assassin','Ranger','Druid','Bard'],
  Halfling:['Fighter','Thief','Assassin'],
  'Half-Orc':['Fighter','Thief','Assassin','Cleric']
};

const HELP_CONTENT={
  ras:`<p>Je ras bepaalt welke klassen je kan kiezen en geeft je speciale bonussen en beperkingen.</p>
<div class="tt-dice">Dwarf: +1 CON, -1 DEX, infravision 60ft, magieresistentie, gifweerstand
Elf: +1 DEX, -1 CON, infravision 60ft, immuun voor slaap/charm
Gnome: infravision 60ft, illusionistenbonus, spreek met dieren
Half-Elf: infravision 30ft, gedeelde elfbonussen
Halfling: +1 DEX, -1 STR, uitzonderlijk geluk, klein en moeilijk te raken
Half-Orc: +1 STR, +1 CON, -2 CHA
Human: geen levellimieten, alle klassen beschikbaar</div>`,
  klasse:`<p>Je klasse bepaalt je vaardigheden, HP per level en je groeipotentieel.</p>
<div class="tt-dice">Fighter d10: meester in gevecht, alle wapens/pantsers toegestaan
Paladin d10: heilige krijger, geneest, detecteert kwaad, immuniteit voor ziektes
Ranger d8: wildernisstrijder, volgt sporen, favoriete vijanden
Magic-User d4: arcanist, kwetsbaar maar verwoestend op hoog niveau
Illusionist d4: illusiespecialist met unieke spreukenlijst
Cleric d8: goddelijke healer, keert ondoden, pantsers toegestaan
Druid d8: natuurpriester, verandert van vorm op hoog niveau
Thief d6: steekpartijen vanuit schaduw, sluipen, sloten forceren
Assassin d6: moord, vermomming, gifgebruik
Monk d4: ongewapende meester, snelle beweging, meditatie
Bard d6: alleskunner — magie + gevecht + diefstal
Barbarian d12: grootste HP, woede-aanvallen, wantrouwen van magie</div>`,
  gezindheid:`<p>Gezindheid beschrijft je moreel kompas op twee assen: Orde vs Chaos, en Goed vs Kwaad.</p>
<div class="tt-dice">Lawful Good: ridderlijk, eerlijk, beschermt zwakken (Paladin)
Neutral Good: doet goed zonder strikte regels (Ranger)
Chaotic Good: vrijgevochten held, volgt eigen morele code (Bard)
Lawful Neutral: orde boven moreel oordeel
True Neutral: balans in alles (Druid)
Chaotic Neutral: vrijheid boven alles, onvoorspelbaar
Lawful Evil: gebruikt regels voor eigen voordeel
Neutral Evil: puur eigenbelang zonder code
Chaotic Evil: vernietiging en chaos (Demon, Assassin)</div>`,
  thac0:`<p><strong>THAC0</strong> = "To Hit Armor Class 0" — de D20 waarde die je moet gooien om AC 0 te raken.</p>
<div class="tt-dice">Formule: AC geraakt = THAC0 − D20 worp − bonussen
Voorbeeld: THAC0 12, gooi 15 → raakt AC -3
Ander voorbeeld: THAC0 12, gooi 8 → raakt AC 4

Hoe LAGER je THAC0, hoe beter je aanvalt!
Fighter lv1: 20 → lv5: 16 → lv9: 12 → lv13: 8
Cleric lv1: 20 → lv7: 16 → lv13: 12
Magic-User lv1: 20 → lv7: 17 → lv13: 14</div>`,
  ac:`<p><strong>Armor Class (AC)</strong> — hoe lager, hoe beter. Bepaalt hoe moeilijk je te raken bent.</p>
<div class="tt-dice">AC 10: geen pantser
AC 8: gewatteerd of leren pantser
AC 7: leren pantser + schild
AC 5: kettinghemd
AC 4: gesegmenteerd pantser
AC 3: vol plaatpantser
AC 2: plaatpantser + schild
AC 0 of lager: magisch pantser of uitzonderlijke bescherming

DEX van 16+ geeft AC bonus. DEX van 5 of minder geeft AC straf.</div>`,
  hp:`<p><strong>Hit Points</strong> = je levensenergie. Bij 0 HP bewusteloos, bij -10 HP dood.</p>
<div class="tt-dice">HP per level (dobbelsteen per klasse):
Fighter/Paladin: d10 | Cavalier/Barbarian: d10/d12
Ranger/Cleric/Druid: d8 | Thief/Bard/Assassin: d6
Magic-User/Illusionist/Monk: d4

Bij 0 tot -9 HP: bewusteloos, verliest 1 HP/ronde
Bij -10 HP: dood

Na level 9/10: vaste HP per level (geen dobbelsteen meer)</div>`,
  saving_throws:`<p><strong>Saving Throws</strong> — gooi D20 ≥ de waarde om te slagen.</p>
<div class="tt-dice">Paralyzation/Death: giftige aanvallen, verlamming, dood-magie
Rod/Staff/Wand: magische staven en staafwapens  
Petrification/Polymorph: verstening, gedaantewisseling
Breath Weapon: drakenademstoot, gifwolk, koude-adem
Spell: directe toverspeuken op het karakter
Poison: apart getal — Dwergen en Halflingen krijgen grote bonus!

Hoe LAGER het getal, hoe makkelijker te slagen.</div>`,
  xp:`<p><strong>Experience Points (XP)</strong> — de brandstof voor je groei als avonturier.</p>
<div class="tt-dice">Verdienen:
• Monsters verslaan (HP × level factor)
• Schatten vinden (1 GP = 1 XP voor meeste klassen)
• Quests voltooien (DM-bepaald)
• Goed rollenspel (DM-bonus)

Fighter levelbereiken:
Lv2: 2.000 | Lv3: 4.000 | Lv4: 8.000
Lv5: 18.000 | Lv6: 35.000 | Lv7: 70.000
Lv8: 125.000 | Lv9: 250.000 | Lv10+: +250.000/lv</div>`,
  ability_scores:`<p>De 6 basisstatistieken bepalen je capaciteiten. Gegenereerd door 3d6 te gooien per stat.</p>
<div class="tt-dice">STR: aanvalsbonus, schadebonus, draagvermogen
DEX: AC bonus/malus, aanval met afstandswapens, initiatiefbonus
INT: max spreukniveau (Magic-User), talen leren
WIS: kans op goddelijke spreuken, mentale saves
CON: HP bonus per level, overlevingskansen
CHA: reactie NPC's, max aantal volgers

Score effecten:
3: -3 penalty | 4-5: -2 | 6-8: -1 | 9-12: geen effect
13-15: +1 | 16-17: +2 | 18: +3 (of meer voor STR fighter)</div>`,
  wapen:`<p>Wapenproficiëntie bepaalt of je straf krijgt bij het gebruik van een wapen.</p>
<div class="tt-dice">Zonder proficiëntie: -2 aanval (Fighter), -3 (Cleric/Thief), -5 (Magic-User)

Wapen statistieken uitgelegd:
• Damage: schade dobbelsteen (bv. 1d8 = gooi 8-zijdige dobbelsteen)
• SF (Speed Factor): hoe snel het wapen is — LAGER = SNELLER
• Type: bepaalt bonus vs bepaald type pantser

Proficiënties per klasse:
Fighter: 4 start + 1/3 levels | Ranger/Paladin: 3 + 1/3
Cleric/Druid: 2 + 1/4 | Thief/Assassin: 2 + 1/4
Magic-User: 1 + 1/6</div>`,
  spells:`<p>Spreuken zijn klasse-specifiek en moeten bereid worden na rust.</p>
<div class="tt-dice">Magic-User: bereid spreuken uit spellbook na 8u rust
Cleric: ontvangt spreuken van godheid na gebed
Druid: natuur-gebaseerde goddelijke spreuken  
Illusionist: specialisatie in illusies

Bereid = spreuk die je die dag kan gebruiken
Spellbook = je kent de spreuk maar hebt hem vandaag niet bereid

Eenmaal gebruikt: weg tot volgende rust!

MU level 1: 1/dag | Level 5: 4/2/1 | Level 9: 5/5/4/3/1
Cleric level 1: 1/dag | Level 5: 3/3/1 | Level 9: 4/4/3/2/1</div>`,
  dobbelstenen:`<p>AD&D gebruikt 7 soorten dobbelstenen voor verschillende situaties.</p>
<div class="tt-dice">d4: kleine schade (dolk, pijl, MU/Monk HP)
d6: standaard schade, Thief/Bard HP
d8: zwaard/bijl schade, Cleric/Ranger HP
d10: grote wapens, Fighter HP
d12: grote bijlen, Barbarian HP
d20: aanvalsrol, saving throw
d100 (2×d10): percentage, vaardigheidscontroles

Aanvalssequentie per ronde:
1. Initiatiefrol (d6, lager gaat eerst)
2. Aanvalsrol (d20 ≥ benodigde waarde = raak)
3. Schaderol (wapen-dobbelsteen + bonussen)
4. Saving throw indien van toepassing</div>`
};

// UI HELPERS
function openM(id){document.getElementById(id).classList.add('open');}
function closeM(id){document.getElementById(id).classList.remove('open');}
document.querySelectorAll('.modal-overlay').forEach(m=>m.addEventListener('click',e=>{if(e.target===m)m.classList.remove('open');}));
function showHelp(k){
  const titles={ras:'Rassen in AD&D',klasse:'Klassen in AD&D',gezindheid:'Gezindheid',thac0:'THAC0 uitgelegd',ac:'Armor Class',hp:'Hit Points',saving_throws:'Saving Throws',xp:'Experience Points',ability_scores:'Ability Scores',wapen:'Wapens & Proficiënties',spells:'Spreuken',dobbelstenen:'Dobbelstenen Gids'};
  document.getElementById('tt-title').textContent=titles[k]||k;
  document.getElementById('tt-body').innerHTML=HELP_CONTENT[k]||'<p>Geen uitleg beschikbaar.</p>';
  document.getElementById('tt-overlay').classList.add('open');
}
function closeTT(){document.getElementById('tt-overlay').classList.remove('open');}
function toast(msg,ok=true){
  const el=document.getElementById('toast');
  el.textContent=msg;el.className='status-toast '+(ok?'ok':'err');
  el.style.display='block';setTimeout(()=>el.style.display='none',3500);
}
function showPage(p){
  document.querySelectorAll('.page').forEach(x=>x.classList.remove('active'));
  document.querySelectorAll('.nav-tab').forEach(x=>x.classList.remove('active'));
  document.getElementById('page-'+p).classList.add('active');
  const tabs=['characters','sheet','sessions','encyclopedia','dm'];
  document.querySelectorAll('.nav-tab')[tabs.indexOf(p)]?.classList.add('active');
  if(p==='dm')loadDMDash();
  if(p==='sessions')loadSessions();
}
function efKey(e,el){if(e.key==='Enter'){e.preventDefault();el.blur();}}

// AUTH
async function doLogin(){
  const u=document.getElementById('lu').value.trim();
  const p=document.getElementById('lp').value;
  if(!u||!p){document.getElementById('le').textContent='Vul alle velden in.';return;}
  const{data,error}=await sb.from('players').select('*').eq('username',u).single();
  if(error||!data){document.getElementById('le').textContent='Gebruiker niet gevonden.';return;}
  if(data.password_hash!==btoa(p)&&(!data.temp_password_hash||data.temp_password_hash!==btoa(p))){
    document.getElementById('le').textContent='Verkeerd wachtwoord.';return;
  }
  CU=data;
  await sb.from('players').update({last_login:new Date().toISOString()}).eq('id',CU.id);
  document.getElementById('login-screen').style.display='none';
  document.getElementById('app').style.display='flex';
  document.getElementById('t-user').textContent=CU.username;
  if(CU.is_dm){
    document.getElementById('t-dm').style.display='inline';
    document.getElementById('t-dmreset').style.display='inline';
    document.querySelectorAll('.dm-only').forEach(e=>e.style.display='block');
  }
  loadChars();
  if(data.must_change_password){
    document.getElementById('cpw-title').textContent='Verplicht: Wachtwoord Wijzigen';
    document.getElementById('cpw-msg').style.display='block';
    openM('cpw-modal');
  }
}

async function doRegister(){
  const u=document.getElementById('ru').value.trim();
  const p=document.getElementById('rp').value;
  const dm=document.getElementById('rd').value.trim();
  const sq=document.getElementById('rsq').value.trim();
  const sa=document.getElementById('rsa').value.trim().toLowerCase();
  const isDM=dm===DM_CODE;
  if(!u||!p){document.getElementById('re').textContent='Vul naam en wachtwoord in.';return;}
  if(p.length<6){document.getElementById('re').textContent='Wachtwoord min. 6 tekens.';return;}
  if(isDM&&(!sq||!sa)){document.getElementById('re').textContent='DM moet een veiligheidsvraag en antwoord instellen.';return;}
  const obj={username:u,password_hash:btoa(p),is_dm:isDM};
  if(isDM){obj.security_question=sq;obj.security_answer_hash=btoa(sa);}
  const{error}=await sb.from('players').insert(obj);
  if(error){document.getElementById('re').textContent=error.message.includes('unique')?'Naam al in gebruik.':'Fout: '+error.message;return;}
  closeM('reg-modal');toast('Account aangemaakt! Log nu in.');
}

document.getElementById('rd').addEventListener('input',function(){
  document.getElementById('reg-sq-wrap').style.display=this.value===DM_CODE?'block':'none';
});

async function doChangePw(){
  const cur=document.getElementById('cpw-cur').value;
  const nw=document.getElementById('cpw-new').value;
  const conf=document.getElementById('cpw-conf').value;
  const err=document.getElementById('cpw-err');
  if(!cur||!nw||!conf){err.textContent='Vul alle velden in.';return;}
  if(nw.length<6){err.textContent='Min. 6 tekens.';return;}
  if(nw!==conf){err.textContent='Wachtwoorden komen niet overeen.';return;}
  const{data:pl}=await sb.from('players').select('*').eq('id',CU.id).single();
  if(btoa(cur)!==pl.password_hash&&btoa(cur)!==pl.temp_password_hash){err.textContent='Huidig wachtwoord klopt niet.';return;}
  await sb.from('players').update({password_hash:btoa(nw),temp_password_hash:null,must_change_password:false}).eq('id',CU.id);
  CU.must_change_password=false;
  closeM('cpw-modal');toast('✓ Wachtwoord gewijzigd!');
}

async function openDMReset(){
  const{data:pls}=await sb.from('players').select('id,username,is_dm').order('username');
  const sel=document.getElementById('dmr-player');
  sel.innerHTML=pls.filter(p=>p.id!==CU.id).map(p=>`<option value="${p.id}">${p.username}${p.is_dm?' (DM)':''}</option>`).join('');
  document.getElementById('dmr-pw').value='';
  document.getElementById('dmr-err').textContent='';
  openM('dmreset-modal');
}

async function doDMReset(){
  const pid=document.getElementById('dmr-player').value;
  const pw=document.getElementById('dmr-pw').value.trim();
  if(!pw||pw.length<4){document.getElementById('dmr-err').textContent='Min. 4 tekens.';return;}
  await sb.from('players').update({temp_password_hash:btoa(pw),must_change_password:true}).eq('id',pid);
  const nm=document.getElementById('dmr-player').options[document.getElementById('dmr-player').selectedIndex].text;
  closeM('dmreset-modal');toast('✓ Tijdelijk wachtwoord ingesteld voor '+nm);
}

function doLogout(){CU=null;CC=null;document.getElementById('app').style.display='none';document.getElementById('login-screen').style.display='flex';}

// CHARACTERS
function updateClasses(){
  const race=document.getElementById('nc-race').value;
  const cls=RACE_CLASSES[race]||RACE_CLASSES.Human;
  document.getElementById('nc-class').innerHTML=cls.map(c=>`<option>${c}</option>`).join('');
}

function openNewChar(){
  document.getElementById('nc-name').value='';
  document.getElementById('nc-player').value='';
  document.getElementById('nc-race').value='Human';
  document.getElementById('nc-align').value='True Neutral';
  document.getElementById('nc-sex').value='Male';
  document.getElementById('nc-err').textContent='';
  updateClasses();
  openM('nc-modal');
}

async function createChar(){
  const name=document.getElementById('nc-name').value.trim();
  if(!name){document.getElementById('nc-err').textContent='Naam is verplicht.';return;}
  const{data,error}=await sb.from('characters').insert({
    player_id:CU.id,name,
    player_name:document.getElementById('nc-player').value,
    race:document.getElementById('nc-race').value,
    class:document.getElementById('nc-class').value,
    alignment:document.getElementById('nc-align').value,
    sex:document.getElementById('nc-sex').value,
    level:1,hp_current:10,hp_max:10,ac:'10',thac0:20,xp:0,is_active:true
  }).select().single();
  if(error){document.getElementById('nc-err').textContent='Fout: '+error.message;return;}
  await logChange(data.id,'Karakter aangemaakt','system');
  closeM('nc-modal');toast('Karakter '+name+' aangemaakt!');
  loadChars();openChar(data.id);
}

async function loadChars(){
  let q=sb.from('characters').select('*');
  if(!CU.is_dm)q=q.eq('player_id',CU.id);
  const{data}=await q.order('is_active',{ascending:false}).order('created_at');
  const grid=document.getElementById('chars-grid');
  if(!data?.length){grid.innerHTML=`<div class="new-char-card" onclick="openNewChar()"><div class="new-char-card-inner"><span class="plus">+</span><span>Nieuw karakter</span></div></div>`;return;}
  grid.innerHTML=data.map(c=>{
    const pct=c.hp_max?Math.round((c.hp_current/c.hp_max)*100):100;
    const hpClass=pct>50?'hp-good':pct>25?'hp-med':'hp-low';
    const initials=(c.name||'?').substring(0,2).toUpperCase();
    return`<div class="char-card ${c.is_active===false?'char-inactive':''}" onclick="openChar('${c.id}')">
      <div class="char-card-banner">
        ${c.avatar_url?`<img src="${c.avatar_url}" alt="${c.name}">`:`<div class="char-initials">${initials}</div>`}
      </div>
      <div class="char-card-body">
        <div class="char-card-name">${c.name}${c.is_active===false?' <span class="badge badge-inactive">Inactief</span>':''}</div>
        <div class="char-card-meta">${c.race||''} ${c.class||''} — Level ${c.level||1}</div>
        <div class="char-card-stats">HP: ${c.hp_current||0}/${c.hp_max||0} · AC: ${c.ac||'—'} · THAC0: ${c.thac0||'—'}</div>
        <div class="hp-bar"><div class="hp-fill ${hpClass}" style="width:${pct}%"></div></div>
      </div>
    </div>`;
  }).join('')+`<div class="new-char-card" onclick="openNewChar()"><div class="new-char-card-inner"><span class="plus">+</span><span>Nieuw karakter</span></div></div>`;
}

async function openChar(id){
  showPage('sheet');
  document.getElementById('sheet-content').innerHTML=`<div style="padding:60px;text-align:center;color:var(--gold);font-style:italic;">Laden...</div>`;
  try{
    const{data:c,error}=await sb.from('characters').select('*').eq('id',id).single();
    if(error||!c){document.getElementById('sheet-content').innerHTML=`<div style="padding:40px;text-align:center;color:var(--rust2);">Karakter niet gevonden: ${error?.message||''}</div>`;return;}
    CC=c;
    try{await checkLog(id);}catch(e){}
    const[r1,r2,r3,r4]=await Promise.all([
      sb.from('character_weapons').select('*').eq('character_id',id),
      sb.from('character_items').select('*').eq('character_id',id),
      sb.from('character_skills').select('*').eq('character_id',id),
      sb.from('character_spells').select('*').eq('character_id',id)
    ]);
    renderSheet(c,r1.data||[],r2.data||[],r3.data||[],r4.data||[]);
  }catch(e){
    document.getElementById('sheet-content').innerHTML=`<div style="padding:40px;text-align:center;color:var(--rust2);">Fout: ${e.message}</div>`;
  }
}

async function logChange(charId,desc,type='edit',old='',nw=''){
  try{
    await sb.from('character_log').insert({
      character_id:charId,user_id:CU.id,username:CU.username,
      is_dm:CU.is_dm,beschrijving:desc,type,
      oude_waarde:String(old),nieuwe_waarde:String(nw)
    });
  }catch(e){}
}

async function checkLog(charId){
  const{data:op}=await sb.from('character_opens').select('*').eq('character_id',charId).eq('user_id',CU.id).single();
  const last=op?.last_opened_at||'1970-01-01';
  const{data:changes}=await sb.from('character_log').select('*').eq('character_id',charId).gt('created_at',last).neq('user_id',CU.id).order('created_at',{ascending:false});
  await sb.from('character_opens').upsert({character_id:charId,user_id:CU.id,last_opened_at:new Date().toISOString()},{onConflict:'character_id,user_id'});
  if(changes?.length){showLog(changes,true);}
}

function showLog(changes,isNew=false){
  const el=document.getElementById('log-body');
  if(!changes?.length){el.innerHTML='<div style="padding:20px;text-align:center;color:var(--ink3);font-style:italic;">Geen wijzigingen gevonden.</div>';openM('log-modal');return;}
  if(isNew){
    const t=document.getElementById('log-modal').querySelector('h2');
    if(t)t.textContent=`📋 ${changes.length} nieuwe wijzigingen!`;
  }
  el.innerHTML=changes.map(c=>`<div class="log-item">
    <div style="display:flex;justify-content:space-between;align-items:baseline;">
      <span class="log-who ${c.is_dm?'dm':''}">${c.is_dm?'🔒 DM ('+c.username+')':c.username}</span>
      <span class="log-when">${new Date(c.created_at).toLocaleString('nl-BE')}</span>
    </div>
    <div class="log-what">${c.beschrijving}</div>
    ${c.oude_waarde&&c.nieuwe_waarde&&c.oude_waarde!=='undefined'?`<div class="log-change">"${c.oude_waarde}" → "${c.nieuwe_waarde}"</div>`:''}
  </div>`).join('');
  openM('log-modal');
}

async function showFullLog(){
  if(!CC)return;
  document.getElementById('log-modal').querySelector('h2').textContent='📋 Logboek';
  const{data}=await sb.from('character_log').select('*').eq('character_id',CC.id).order('created_at',{ascending:false}).limit(100);
  showLog(data,false);
}

// RENDER SHEET
function renderSheet(c,weapons,items,skills,spells){
  const canEdit=CU.is_dm||CC.player_id===CU.id;
  const isDM=CU.is_dm;
  const hasSpells=['Magic-User','Illusionist','Cleric','Druid','Bard','Ranger','Paladin'].includes(c.class);
  const pct=c.hp_max?Math.round((c.hp_current/c.hp_max)*100):100;
  const hpClass=pct>50?'hp-good':pct>25?'hp-med':'hp-low';
  const initials=(c.name||'?').substring(0,2).toUpperCase();

  const ef=(key,val,sz)=>canEdit
    ?`<span class="ef" contenteditable="true" data-key="${key}" data-id="${c.id}" style="font-size:${sz||14}px" onblur="saveField(this)" onkeydown="efKey(event,this)">${val!=null&&val!==''?val:'—'}</span>`
    :`<span style="font-size:${sz||14}px">${val!=null&&val!==''?val:'—'}</span>`;
  const h=key=>`<button class="help-btn" onclick="showHelp('${key}')" tabindex="-1">?</button>`;
  const req='<span class="req">*</span>';

  document.getElementById('sheet-content').innerHTML=`
  <!-- HERO BANNER -->
  <div class="sheet-hero">
    <div class="avatar-wrap">
      <div class="avatar-img" id="avatar-display">
        ${c.avatar_url?`<img src="${c.avatar_url}" alt="${c.name}">`:`<div class="av-placeholder">${initials}</div>`}
      </div>
      ${canEdit?`<div class="avatar-upload" onclick="document.getElementById('avatar-input').click()" title="Profielfoto uploaden">📷</div>
      <input type="file" id="avatar-input" accept="image/*" style="display:none" onchange="uploadAvatar(this)">`:''}
    </div>
    <div class="sheet-hero-info">
      <div class="sheet-name">${c.name}</div>
      <div class="sheet-subtitle">${c.player_name?'Speler: '+c.player_name:''} ${c.is_active===false?'— <span style="color:var(--ink3)">Inactief</span>':''}</div>
      <div class="sheet-badges">
        <span class="badge badge-race">${c.race||'—'}</span>
        <span class="badge badge-class">${c.class||'—'}</span>
        <span class="badge badge-align">${c.alignment||'—'}</span>
        <span class="badge badge-level">Level ${c.level||1}</span>
      </div>
    </div>
    <div style="display:flex;flex-direction:column;gap:6px;align-items:flex-end;">
      <button class="btn btn-ghost btn-sm" onclick="showPage('characters');loadChars()">← Terug</button>
      <button class="btn btn-ghost btn-sm" onclick="showFullLog()">📋 Logboek</button>
      <button class="btn btn-ghost btn-sm" onclick="exportPDF()">📄 PDF</button>
      <button class="btn btn-ghost btn-sm" onclick="openExportModal('character')">📤 Export</button>
      ${canEdit?`<button class="btn btn-success btn-sm">✓ Auto-opslaan</button>`:''}
      ${canEdit?`<button class="btn btn-danger btn-sm" onclick="askDeleteChar('${c.id}','${c.name.replace(/'/g,"\\'")}')">🗑 Verwijderen</button>`:''}
      ${canEdit?`<button class="btn btn-ghost btn-sm" onclick="toggleActive('${c.id}',${c.is_active!==false})">${c.is_active===false?'✓ Activeren':'⏸ Inactief'}</button>`:''}
    </div>
  </div>

  <!-- VITALS -->
  <div class="vital-bar">
    <div class="vital-box">
      <span class="vital-label">Level</span>
      <div class="vital-val">${ef('level',c.level,24)}</div>
    </div>
    <div class="vital-box">
      <span class="vital-label">HP ${h('hp')} huidig / max</span>
      <div class="vital-val">${ef('hp_current',c.hp_current,20)} / ${ef('hp_max',c.hp_max,20)}</div>
      <div style="margin-top:6px;"><div class="hp-bar" style="height:8px;"><div class="hp-fill ${hpClass}" style="width:${pct}%;height:8px;"></div></div></div>
    </div>
    <div class="vital-box">
      <span class="vital-label">Armor Class ${h('ac')}</span>
      <div class="vital-val blue">${ef('ac',c.ac,24)}</div>
      <div class="vital-sub">Lager = beter</div>
    </div>
    <div class="vital-box">
      <span class="vital-label">THAC0 ${h('thac0')}</span>
      <div class="vital-val">${ef('thac0',c.thac0,24)}</div>
      <div class="vital-sub">Lager = beter</div>
    </div>
  </div>

  <!-- XP BAR -->
  <div class="card" style="padding:12px 18px;margin-bottom:16px;">
    <div style="display:flex;align-items:center;gap:16px;flex-wrap:wrap;">
      <div style="display:flex;align-items:center;gap:8px;">
        <span style="font-family:'Cinzel',serif;font-size:10px;color:var(--ink3);letter-spacing:.5px;">XP ${h('xp')}</span>
        <span style="font-size:16px;font-weight:600;">${ef('xp',c.xp,16)}</span>
        <span style="color:var(--ink3);">/</span>
        <span style="font-size:14px;color:var(--ink3);">${ef('xp_next',c.xp_next,14)}</span>
      </div>
      <div style="flex:1;min-width:100px;">
        <div class="hp-bar" style="height:6px;background:rgba(196,160,96,.2);">
          <div style="height:6px;background:var(--gold);border-radius:3px;width:${c.xp_next?Math.min(100,Math.round((c.xp/c.xp_next)*100)):0}%;transition:width .3s;"></div>
        </div>
      </div>
    </div>
  </div>

  <!-- STATS + SAVES -->
  <div class="g2" style="margin-bottom:16px;">
    <div class="card" style="margin:0;">
      <div class="card-header">Ability Scores ${h('ability_scores')}</div>
      <div class="g3" style="margin-bottom:8px;">
        <div class="stat-box"><span class="stat-name">Strength</span><span class="stat-val">${ef('str',c.str,22)}</span><span class="stat-mod">${ef('str_mod',c.str_mod,11)}</span></div>
        <div class="stat-box"><span class="stat-name">Dexterity</span><span class="stat-val">${ef('dex',c.dex,22)}</span><span class="stat-mod">${ef('dex_mod',c.dex_mod,11)}</span></div>
        <div class="stat-box"><span class="stat-name">Intelligence</span><span class="stat-val">${ef('int',c.int,22)}</span><span class="stat-mod">${ef('int_mod',c.int_mod,11)}</span></div>
        <div class="stat-box"><span class="stat-name">Wisdom</span><span class="stat-val">${ef('wis',c.wis,22)}</span><span class="stat-mod">${ef('wis_mod',c.wis_mod,11)}</span></div>
        <div class="stat-box"><span class="stat-name">Constitution</span><span class="stat-val">${ef('con',c.con,22)}</span><span class="stat-mod">${ef('con_mod',c.con_mod,11)}</span></div>
        <div class="stat-box"><span class="stat-name">Charisma</span><span class="stat-val">${ef('cha',c.cha,22)}</span><span class="stat-mod">${ef('cha_mod',c.cha_mod,11)}</span></div>
      </div>
      <div style="font-size:12px;display:flex;align-items:center;gap:8px;padding-top:6px;border-top:1px dotted var(--divider);">
        <span style="font-family:'Cinzel',serif;font-size:9px;color:var(--ink3);">COMELINESS</span>
        ${ef('comeliness',c.comeliness,14)}
      </div>
    </div>
    <div class="card" style="margin:0;">
      <div class="card-header">Saving Throws ${h('saving_throws')}</div>
      <div class="save-row"><span class="save-label">Paralyzation/Death</span><span class="save-val">${ef('sv_pd',c.sv_pd,18)}</span></div>
      <div class="save-row"><span class="save-label">Rod/Staff/Wand</span><span class="save-val">${ef('sv_rsw',c.sv_rsw,18)}</span></div>
      <div class="save-row"><span class="save-label">Pet./Polymorph</span><span class="save-val">${ef('sv_pp',c.sv_pp,18)}</span></div>
      <div class="save-row"><span class="save-label">Breath Weapon</span><span class="save-val">${ef('sv_bw',c.sv_bw,18)}</span></div>
      <div class="save-row"><span class="save-label">Spell</span><span class="save-val">${ef('sv_spell',c.sv_spell,18)}</span></div>
      <div class="save-row"><span class="save-label">Poison</span><span class="save-val">${ef('sv_poison',c.sv_poison,18)}</span></div>
      <div style="margin-top:10px;text-align:center;">
        <button class="btn btn-ghost btn-sm" onclick="showHelp('dobbelstenen')">🎲 Dobbelstenen gids</button>
      </div>
    </div>
  </div>

  <!-- IDENTITY -->
  <div class="card" style="margin-bottom:16px;">
    <div class="card-header">Identiteitsgegevens</div>
    <div class="g2">
      <div>
        <div class="field-row"><span class="field-label">Naam ${req}</span>${ef('name',c.name,14)}</div>
        <div class="field-row"><span class="field-label">Ras ${h('ras')}</span>${ef('race',c.race,14)}</div>
        <div class="field-row"><span class="field-label">Klasse ${h('klasse')}</span>${ef('class',c.class,14)}</div>
        <div class="field-row"><span class="field-label">Gezindheid ${h('gezindheid')}</span>${ef('alignment',c.alignment,14)}</div>
      </div>
      <div>
        <div class="field-row"><span class="field-label">Geslacht</span>${ef('sex',c.sex,14)}</div>
        <div class="field-row"><span class="field-label">Speler</span>${ef('player_name',c.player_name,14)}</div>
      </div>
    </div>
  </div>

  <!-- WEAPONS -->
  <div class="card" style="margin-bottom:16px;">
    <div class="card-header">Wapens ${h('wapen')}</div>
    <div id="weapons-list">
      ${weapons.length?weapons.map(w=>`<div class="list-item">
        <div class="list-bullet">⚔</div>
        <div class="list-content">
          <div class="list-name">${w.weapon_name}</div>
          <div class="list-meta">${w.attacks_per_round||'1/1'} aanvallen · SF ${w.speed_factor||'—'} · Dmg: ${w.damage||'—'}</div>
          ${w.notes?`<div class="list-note">${w.notes}</div>`:''}
        </div>
        ${canEdit?`<button class="del-btn" onclick="delWeapon(${w.id})">✕</button>`:''}
      </div>`).join(''):`<div style="padding:12px 0;font-style:italic;color:var(--ink3);font-size:13px;">Nog geen wapens toegevoegd.</div>`}
    </div>
    ${canEdit?`<div class="add-btn" onclick="openAdd('weapons')">+ wapen toevoegen</div>`:''}
  </div>

  ${hasSpells?`<!-- SPELLS -->
  <div class="card" style="margin-bottom:16px;">
    <div class="card-header">Spreuken ${h('spells')}</div>
    ${spells.length?`
      ${spells.filter(s=>s.prepared).length?`<div style="margin-bottom:8px;"><div style="font-family:'Cinzel',serif;font-size:10px;color:var(--green2);letter-spacing:.5px;margin-bottom:6px;">BEREID VANDAAG:</div>
        ${spells.filter(s=>s.prepared).map(s=>`<div class="list-item">
          <div class="list-bullet">✨</div>
          <div class="list-content"><div class="list-name">${s.spell_name} <span class="tag tag-prepared">Lv.${s.spell_level}</span></div>
          ${s.notes?`<div class="list-note">${s.notes.substring(0,80)}</div>`:''}
          </div>
          ${canEdit?`<button class="del-btn" onclick="delSpell(${s.id})">✕</button>`:''}
        </div>`).join('')}
      </div>`:''}
      ${spells.filter(s=>!s.prepared).length?`<div><div style="font-family:'Cinzel',serif;font-size:10px;color:var(--ink3);letter-spacing:.5px;margin-bottom:6px;">SPELLBOOK / GEWETEN:</div>
        ${spells.filter(s=>!s.prepared).map(s=>`<div class="list-item">
          <div class="list-bullet">📖</div>
          <div class="list-content"><div class="list-name">${s.spell_name} <span class="tag tag-known">Lv.${s.spell_level}</span></div></div>
          ${canEdit?`<button class="del-btn" onclick="delSpell(${s.id})">✕</button>`:''}
        </div>`).join('')}
      </div>`:''}
    `:`<div style="padding:12px 0;font-style:italic;color:var(--ink3);font-size:13px;">Nog geen spreuken toegevoegd.</div>`}
    ${canEdit?`<div class="add-btn" onclick="openAdd('spells')">+ spreuk toevoegen</div>`:''}
  </div>`:''} 

  <!-- SKILLS + ITEMS -->
  <div class="g2" style="margin-bottom:16px;">
    <div class="card" style="margin:0;">
      <div class="card-header">Vaardigheden</div>
      <div id="skills-list">
        ${skills.length?skills.map(s=>`<div class="list-item">
          <div class="list-bullet">◆</div>
          <div class="list-content">
            <div class="list-name">${s.skill_name} ${s.skill_type==='Weapon'?`<span class="tag tag-weapon">Wapen</span>`:`<span class="tag tag-nonweapon">Niet-wapen</span>`}</div>
            ${s.stat_modifier?`<div class="list-meta">${s.stat_modifier}</div>`:''}
            ${s.notes?`<div class="list-note">${s.notes}</div>`:''}
          </div>
          ${canEdit?`<button class="del-btn" onclick="delSkill(${s.id})">✕</button>`:''}
        </div>`).join(''):`<div style="padding:12px 0;font-style:italic;color:var(--ink3);font-size:13px;">Nog geen vaardigheden.</div>`}
      </div>
      ${canEdit?`<div class="add-btn" onclick="openAdd('skills')">+ vaardigheid</div>`:''}
    </div>
    <div class="card" style="margin:0;">
      <div class="card-header">Items & Uitrusting</div>
      <div id="items-list">
        ${items.length?items.map(i=>`<div class="list-item">
          <div class="list-bullet">◆</div>
          <div class="list-content">
            <div class="list-name">${i.item_name}${i.quantity>1?` <span style="color:var(--ink3);font-size:12px;">(${i.quantity}×)</span>`:''}</div>
            ${i.category?`<div class="list-meta">${i.category}</div>`:''}
            ${i.notes?`<div class="list-note">${i.notes}</div>`:''}
          </div>
          ${canEdit?`<button class="del-btn" onclick="delItem(${i.id})">✕</button>`:''}
        </div>`).join(''):`<div style="padding:12px 0;font-style:italic;color:var(--ink3);font-size:13px;">Nog geen items.</div>`}
      </div>
      ${canEdit?`<div class="add-btn" onclick="openAdd('items')">+ item</div>`:''}
    </div>
  </div>

  <!-- COINS -->
  <div class="card" style="margin-bottom:16px;">
    <div class="card-header">Geldkoers</div>
    <div class="coin-row">
      <div class="coin-box"><div class="coin-type">Platinum</div><div class="coin-val">${ef('pp',c.pp,18)} PP</div></div>
      <div class="coin-box"><div class="coin-type">Gold</div><div class="coin-val">${ef('gp',c.gp,18)} GP</div></div>
      <div class="coin-box"><div class="coin-type">Silver</div><div class="coin-val">${ef('sp',c.sp,18)} SP</div></div>
      <div class="coin-box"><div class="coin-type">Copper</div><div class="coin-val">${ef('cp',c.cp,18)} CP</div></div>
    </div>
  </div>

  <!-- NOTES -->
  <div class="card" style="margin-bottom:16px;">
    <div class="card-header">Notities (speler)</div>
    <textarea id="char-notes" style="width:100%;min-height:100px;background:#fff;border:1.5px solid var(--card-border);border-radius:4px;font-family:'Crimson Text',serif;font-size:14px;color:var(--ink);padding:10px;resize:vertical;" ${canEdit?'':'readonly'} onblur="saveNotes()">${c.notes||''}</textarea>
  </div>

  ${isDM?`<!-- DM PANELS -->
  <div class="dm-panel" style="margin-bottom:16px;">
    <div class="dm-panel-title">🔒 DM Privé Notities <small style="font-size:10px;opacity:.7;">(Onzichtbaar voor spelers)</small></div>
    <textarea class="dm-textarea" id="dm-notes" onblur="saveDMNotes()">${c.dm_notes||''}</textarea>
  </div>
  <div class="dm-panel">
    <div class="dm-panel-title">🔒 DM Sessie-aantekeningen <small style="font-size:10px;opacity:.7;">(Voor XP-toekenning en verhaalbeheer — onzichtbaar voor spelers)</small></div>
    <textarea class="dm-textarea" id="dm-session-notes" onblur="saveDMSessionNotes()" style="min-height:120px;">${c.dm_session_notes||''}</textarea>
  </div>`:''} 
  `;
}

// FIELD SAVING
async function saveField(el){
  const key=el.dataset.key,id=el.dataset.id,val=el.innerText.trim();
  const nums=['level','hp_current','hp_max','thac0','xp','xp_next','str','dex','int','wis','con','cha','comeliness','sv_pd','sv_rsw','sv_pp','sv_bw','sv_spell','sv_poison','pp','gp','sp','cp'];
  const upd={};upd[key]=nums.includes(key)?(parseInt(val)||0):val;upd.updated_at=new Date().toISOString();
  const oldVal=CC?CC[key]:null;
  const{error}=await sb.from('characters').update(upd).eq('id',id);
  if(error){toast('Fout: '+error.message,false);return;}
  if(CC)CC[key]=upd[key];
  const labels={hp_current:'HP huidig',hp_max:'HP max',xp:'XP',level:'Level',thac0:'THAC0',ac:'AC',str:'STR',dex:'DEX',int:'INT',wis:'WIS',con:'CON',cha:'CHA',alignment:'Gezindheid',name:'Naam'};
  if(labels[key]&&String(oldVal)!==String(upd[key]))await logChange(id,`${labels[key]} gewijzigd`,'stat',oldVal,upd[key]);
  toast('✓ Opgeslagen');
}
async function saveNotes(){if(!CC)return;const v=document.getElementById('char-notes')?.value;if(v===undefined)return;await sb.from('characters').update({notes:v}).eq('id',CC.id);await logChange(CC.id,'Notities bijgewerkt','note');toast('✓ Notities opgeslagen');}
async function saveDMNotes(){if(!CC)return;const v=document.getElementById('dm-notes')?.value;if(v===undefined)return;await sb.from('characters').update({dm_notes:v}).eq('id',CC.id);await logChange(CC.id,'DM notities bijgewerkt','dm_note');toast('✓ DM notities opgeslagen');}
async function saveDMSessionNotes(){if(!CC)return;const v=document.getElementById('dm-session-notes')?.value;if(v===undefined)return;await sb.from('characters').update({dm_session_notes:v}).eq('id',CC.id);toast('✓ Sessie-aantekeningen opgeslagen');}

// AVATAR
async function uploadAvatar(input){
  if(!CC||!input.files[0])return;
  const file=input.files[0];
  if(file.size>2*1024*1024){toast('Max 2MB voor afbeelding',false);return;}
  const reader=new FileReader();
  reader.onload=async(e)=>{
    const url=e.target.result;
    await sb.from('characters').update({avatar_url:url}).eq('id',CC.id);
    CC.avatar_url=url;
    document.getElementById('avatar-display').innerHTML=`<img src="${url}" alt="${CC.name}" style="width:100%;height:100%;object-fit:cover;">`;
    toast('✓ Profielfoto opgeslagen');
  };
  reader.readAsDataURL(file);
}

// DELETE / INACTIVE
function askDeleteChar(id,name){
  document.getElementById('delchar-name').textContent=name;
  pendingDelCharId=id;
  openM('delchar-modal');
}
async function confirmDeleteChar(){
  if(!pendingDelCharId)return;
  const id=pendingDelCharId;
  await Promise.all([
    sb.from('character_weapons').delete().eq('character_id',id),
    sb.from('character_items').delete().eq('character_id',id),
    sb.from('character_skills').delete().eq('character_id',id),
    sb.from('character_spells').delete().eq('character_id',id),
    sb.from('character_log').delete().eq('character_id',id),
    sb.from('character_opens').delete().eq('character_id',id)
  ]);
  await sb.from('characters').delete().eq('id',id);
  pendingDelCharId=null;
  closeM('delchar-modal');
  toast('Karakter verwijderd');
  showPage('characters');loadChars();
}
async function toggleActive(id,current){
  const ns=!current;
  await sb.from('characters').update({is_active:ns}).eq('id',id);
  await logChange(id,ns?'Karakter geactiveerd':'Karakter op inactief gezet','status');
  toast(ns?'✓ Karakter geactiveerd':'✓ Karakter inactief gezet');
  openChar(id);
}

// WEAPONS/ITEMS/SKILLS/SPELLS - ADD MODAL
async function openAdd(table){
  if(!CC){toast('Geen karakter geladen',false);return;}
  addTable=table;
  const titles={weapons:'Wapen Toevoegen',items:'Item Toevoegen',skills:'Vaardigheid Toevoegen',spells:'Spreuk Toevoegen'};
  document.getElementById('add-modal-title').textContent=titles[table]||'Toevoegen';
  document.getElementById('add-search').value='';
  document.getElementById('add-results').innerHTML='<div style="padding:12px;text-align:center;color:var(--ink3);font-style:italic;">Laden...</div>';
  document.getElementById('add-filter-bar').style.display=table==='weapons'?'flex':'none';
  renderAddForm(table);
  openM('add-modal');
  await loadAddData(table,'');
  if(table==='weapons')await loadWeaponTypeFilter();
}

async function loadWeaponTypeFilter(){
  const{data}=await sb.from('weapon_types').select('name').order('name');
  const sel=document.getElementById('add-type-filter');
  if(sel)sel.innerHTML='<option value="">Alle types</option>'+(data||[]).map(t=>`<option>${t.name}</option>`).join('');
}

async function filterAddResults(){
  const q=document.getElementById('add-search').value;
  await searchAddItems(q);
}

async function loadAddData(table,query){
  let q=sb.from(table).select('*').order('name');
  if(query)q=q.ilike('name','%'+query+'%');
  else q=q.limit(40);
  if(table==='weapons'){
    const tf=document.getElementById('add-type-filter')?.value;
    if(tf)q=q.eq('weapon_type',tf);
  }
  const{data}=await q;
  addData=data||[];
  renderAddResults(addData);
}

async function searchAddItems(query){
  await loadAddData(addTable,query);
}

function renderAddResults(data){
  const el=document.getElementById('add-results');
  if(!data.length){el.innerHTML='<div style="padding:12px;text-align:center;color:var(--ink3);font-style:italic;">Geen resultaten</div>';return;}
  el.innerHTML=data.map((item,i)=>`<div class="select-item" onclick="prefillAdd(${i})">
    <div class="si-name">${item.name}${item.weapon_type?` <span class="tag tag-weapon">${item.weapon_type}</span>`:''}</div>
    ${item.damage?`<div class="si-meta">⚔ Dmg: ${item.damage} · SF: ${item.speed_factor||'—'} · ${item.type||''}</div>`:''}
    ${item.level!==undefined&&item.level!==null&&item.class?`<div class="si-meta">✨ Level ${item.level} ${item.class}</div>`:''}
    ${item.base_stat?`<div class="si-meta">🎯 ${item.base_stat} · ${item.type||''}</div>`:''}
    ${item.description?`<div class="si-desc">${item.description.substring(0,90)}${item.description.length>90?'...':''}</div>`:''}
  </div>`).join('');
}

function prefillAdd(idx){
  const item=addData[idx];
  const t=addTable;
  if(t==='weapons'){
    document.getElementById('af-wname').value=item.name||'';
    document.getElementById('af-watk').value='1/1';
    document.getElementById('af-wdmg').value=item.damage||'';
    document.getElementById('af-wsf').value=item.speed_factor||7;
    document.getElementById('af-wnotes').value=item.description||'';
  }else if(t==='items'){
    document.getElementById('af-iname').value=item.name||'';
    document.getElementById('af-icat').value=item.category||'item';
    document.getElementById('af-inotes').value=item.description||'';
  }else if(t==='skills'){
    document.getElementById('af-sname').value=item.name||'';
    document.getElementById('af-stype').value=item.type||'Non-Weapon';
    document.getElementById('af-smod').value=item.base_stat||'';
    document.getElementById('af-snotes').value=item.description||'';
  }else if(t==='spells'){
    document.getElementById('af-spname').value=item.name||'';
    document.getElementById('af-splevel').value=item.level||1;
    document.getElementById('af-spclass').value=item.class||'Magic-User';
    document.getElementById('af-spnotes').value=item.description||'';
  }
}

function renderAddForm(table){
  const forms={
    weapons:`<div style="border-top:1.5px solid var(--divider);margin-top:10px;padding-top:12px;">
      <p style="font-size:12px;color:var(--ink3);font-style:italic;margin-bottom:10px;">Klik een wapen aan om in te vullen, of vul zelf in:</p>
      <div class="fg-row col2">
        <div class="fg"><label>Naam wapen <span class="req">*</span></label><input type="text" id="af-wname"></div>
        <div class="fg"><label>Aanvallen/ronde</label><input type="text" id="af-watk" value="1/1" placeholder="bv. 2/1"></div>
        <div class="fg"><label>Schade (Dmg) <small>D8=bijl, D6=kort zwaard</small></label><input type="text" id="af-wdmg" placeholder="bv. 1d8+2"></div>
        <div class="fg"><label>Speed Factor <small>Lager=sneller (bijl=7, dolk=2)</small></label><input type="number" id="af-wsf" value="7" min="1" max="15"></div>
        <div class="fg"><label>Magische bonus <small>Optioneel</small></label><input type="text" id="af-wbonus" placeholder="bv. +1/+2"></div>
        <div class="fg"><label>Notities</label><input type="text" id="af-wnotes" placeholder="extra info"></div>
      </div>
      <button class="btn btn-primary btn-sm" onclick="submitAdd('weapons')">+ Toevoegen aan karakter</button>
    </div>`,
    items:`<div style="border-top:1.5px solid var(--divider);margin-top:10px;padding-top:12px;">
      <p style="font-size:12px;color:var(--ink3);font-style:italic;margin-bottom:10px;">Klik een item aan of vul zelf in:</p>
      <div class="fg-row col2">
        <div class="fg"><label>Naam item <span class="req">*</span></label><input type="text" id="af-iname"></div>
        <div class="fg"><label>Categorie</label>
          <select id="af-icat"><option value="item">Algemeen</option><option value="Magic Item">Magisch item</option><option value="Armor">Pantser</option><option value="Potion">Drankje</option><option value="Ring">Ring</option><option value="Wand">Staf/Wand</option><option value="Wondrous">Wonderlijk voorwerp</option><option value="Adventuring">Avonturiersuitrusting</option><option value="Food">Voedsel</option></select>
        </div>
        <div class="fg"><label>Hoeveelheid</label><input type="number" id="af-iqty" value="1" min="1"></div>
        <div class="fg"><label>Notities</label><input type="text" id="af-inotes" placeholder="gebruik, effect..."></div>
      </div>
      <button class="btn btn-primary btn-sm" onclick="submitAdd('items')">+ Toevoegen aan karakter</button>
    </div>`,
    skills:`<div style="border-top:1.5px solid var(--divider);margin-top:10px;padding-top:12px;">
      <p style="font-size:12px;color:var(--ink3);font-style:italic;margin-bottom:10px;">Klik een vaardigheid aan of vul zelf in:</p>
      <div class="fg-row col2">
        <div class="fg"><label>Naam <span class="req">*</span></label><input type="text" id="af-sname"></div>
        <div class="fg"><label>Type</label><select id="af-stype"><option value="Weapon">Wapenproficiëntie</option><option value="Non-Weapon" selected>Niet-wapen</option></select></div>
        <div class="fg"><label>Stat modifier <small>bv. WIS+3</small></label><input type="text" id="af-smod" placeholder="bv. WIS+3"></div>
        <div class="fg"><label>Notities</label><input type="text" id="af-snotes"></div>
      </div>
      <button class="btn btn-primary btn-sm" onclick="submitAdd('skills')">+ Toevoegen aan karakter</button>
    </div>`,
    spells:`<div style="border-top:1.5px solid var(--divider);margin-top:10px;padding-top:12px;">
      <p style="font-size:12px;color:var(--ink3);font-style:italic;margin-bottom:10px;">Klik een spreuk aan of vul zelf in:</p>
      <div class="fg-row col2">
        <div class="fg"><label>Naam spreuk <span class="req">*</span></label><input type="text" id="af-spname"></div>
        <div class="fg"><label>Niveau</label><select id="af-splevel"><option>1</option><option>2</option><option>3</option><option>4</option><option>5</option><option>6</option><option>7</option><option>8</option><option>9</option></select></div>
        <div class="fg"><label>Klasse</label><select id="af-spclass"><option>Magic-User</option><option>Cleric</option><option>Druid</option><option>Illusionist</option><option>Ranger</option><option>Paladin</option></select></div>
        <div class="fg"><label>Status</label><select id="af-spprep"><option value="1">Bereid vandaag</option><option value="0">Spellbook/geweten</option></select></div>
        <div class="fg" style="grid-column:1/-1;"><label>Notities / beschrijving</label><textarea id="af-spnotes" rows="2" style="width:100%;padding:8px;border:1.5px solid var(--card-border);border-radius:4px;font-family:'Crimson Text',serif;font-size:13px;resize:none;"></textarea></div>
      </div>
      <button class="btn btn-primary btn-sm" onclick="submitAdd('spells')">+ Toevoegen aan karakter</button>
    </div>`
  };
  document.getElementById('add-form').innerHTML=forms[table]||'';
}

async function submitAdd(table){
  if(!CC){toast('Geen karakter geladen',false);return;}
  if(table==='weapons'){
    const name=document.getElementById('af-wname').value.trim();
    if(!name){toast('Naam is verplicht',false);return;}
    const bonus=document.getElementById('af-wbonus').value.trim();
    const full=bonus?`${name} ${bonus}`:name;
    await sb.from('character_weapons').insert({character_id:CC.id,weapon_name:full,attacks_per_round:document.getElementById('af-watk').value||'1/1',damage:document.getElementById('af-wdmg').value,speed_factor:parseInt(document.getElementById('af-wsf').value)||7,notes:document.getElementById('af-wnotes').value});
    await logChange(CC.id,'Wapen toegevoegd: '+full,'weapon');
  }else if(table==='items'){
    const name=document.getElementById('af-iname').value.trim();
    if(!name){toast('Naam is verplicht',false);return;}
    await sb.from('character_items').insert({character_id:CC.id,item_name:name,category:document.getElementById('af-icat').value,quantity:parseInt(document.getElementById('af-iqty').value)||1,notes:document.getElementById('af-inotes').value});
    await logChange(CC.id,'Item toegevoegd: '+name,'item');
  }else if(table==='skills'){
    const name=document.getElementById('af-sname').value.trim();
    if(!name){toast('Naam is verplicht',false);return;}
    await sb.from('character_skills').insert({character_id:CC.id,skill_name:name,skill_type:document.getElementById('af-stype').value,stat_modifier:document.getElementById('af-smod').value,notes:document.getElementById('af-snotes').value});
    await logChange(CC.id,'Vaardigheid toegevoegd: '+name,'skill');
  }else if(table==='spells'){
    const name=document.getElementById('af-spname').value.trim();
    if(!name){toast('Naam is verplicht',false);return;}
    await sb.from('character_spells').insert({character_id:CC.id,spell_name:name,spell_level:parseInt(document.getElementById('af-splevel').value)||1,spell_class:document.getElementById('af-spclass').value,prepared:document.getElementById('af-spprep').value==='1',notes:document.getElementById('af-spnotes').value});
    await logChange(CC.id,'Spreuk toegevoegd: '+name,'spell');
  }
  closeM('add-modal');openChar(CC.id);
}

async function delWeapon(id){await sb.from('character_weapons').delete().eq('id',id);await logChange(CC.id,'Wapen verwijderd','weapon');openChar(CC.id);}
async function delItem(id){await sb.from('character_items').delete().eq('id',id);await logChange(CC.id,'Item verwijderd','item');openChar(CC.id);}
async function delSkill(id){await sb.from('character_skills').delete().eq('id',id);await logChange(CC.id,'Vaardigheid verwijderd','skill');openChar(CC.id);}
async function delSpell(id){await sb.from('character_spells').delete().eq('id',id);await logChange(CC.id,'Spreuk verwijderd','spell');openChar(CC.id);}

// ENCYCLOPEDIA
let encCurrentTable='weapons';
async function loadEnc(table,event){
  encCurrentTable=table;
  document.querySelectorAll('.db-tab').forEach(t=>t.classList.remove('active'));
  if(event?.target)event.target.classList.add('active');
  document.getElementById('enc-search').value='';
  document.getElementById('enc-content').innerHTML='<div style="padding:30px;text-align:center;color:var(--ink3);">Laden...</div>';
  const{data}=await sb.from(table).select('*').order('name');
  encAllData=data||[];
  // Load type filter for weapons
  const fb=document.getElementById('enc-filter-bar');
  const ts=document.getElementById('enc-type-filter');
  if(table==='weapons'){
    fb.style.display='flex';
    const{data:types}=await sb.from('weapon_types').select('name').order('name');
    ts.innerHTML='<option value="">Alle types</option>'+(types||[]).map(t=>`<option>${t.name}</option>`).join('');
  }else{fb.style.display='none';}
  renderEnc(encAllData);
  if(CU?.is_dm){document.getElementById('enc-add-card').style.display='block';renderEncAddForm(table);}
}

function filterEnc(){
  const q=document.getElementById('enc-search').value.toLowerCase();
  const tf=document.getElementById('enc-type-filter')?.value||'';
  let data=encAllData;
  if(q)data=data.filter(r=>JSON.stringify(r).toLowerCase().includes(q));
  if(tf)data=data.filter(r=>r.weapon_type===tf);
  renderEnc(data);
}

// Cache per ID for fast info-popup lookup with image
let encRowCache={};

function renderEnc(data){
  if(!data.length){document.getElementById('enc-content').innerHTML='<div style="padding:30px;text-align:center;color:var(--ink3);font-style:italic;">Geen resultaten gevonden.</div>';return;}
  const cols={weapons:['name','weapon_type','damage','speed_factor','type','description'],spells:['name','level','class','range','duration','description'],items:['name','category','cost','description'],races:['name','description'],classes:['name','hit_die','primary_stat','description'],skills:['name','type','base_stat','description'],monsters:['name','ac','hp_dice','thac0','damage','alignment','description']};
  const c=cols[encCurrentTable]||['name','description'];
  const isDM=CU?.is_dm;
  encRowCache={};data.forEach(r=>{encRowCache[r.id]=r;});
  document.getElementById('enc-content').innerHTML=`<div style="overflow-x:auto;"><table class="db-table">
    <thead><tr><th style="width:50px;">Foto</th>${c.map(col=>`<th>${col}</th>`).join('')}${isDM?'<th>Actie</th>':''}</tr></thead>
    <tbody>${data.map(row=>`<tr>
      <td>${row.image_url?`<img src="${row.image_url}" alt="${row.name||''}" style="width:40px;height:40px;object-fit:cover;border-radius:4px;border:1px solid var(--card-border);cursor:pointer;" onclick="showInfoFromCache('${encCurrentTable}',${row.id})">`:'<div style="width:40px;height:40px;border-radius:4px;background:rgba(196,160,96,.15);display:flex;align-items:center;justify-content:center;color:var(--ink3);font-size:18px;">🖼</div>'}</td>
      ${c.map((col,i)=>i===0?`<td><strong>${row[col]||''}</strong> <span class="info-pill" onclick="showInfoFromCache('${encCurrentTable}',${row.id})">info</span></td>`:`<td>${row[col]!=null?row[col]:''}</td>`).join('')}
      ${isDM?`<td><button class="btn btn-xs btn-ghost" onclick="openDBEdit('${encCurrentTable}',${row.id})">✏</button></td>`:''}
    </tr>`).join('')}
    </tbody></table></div>`;
}

function showInfoFromCache(table,id){
  const r=encRowCache[id];if(!r)return;
  document.getElementById('info-title').textContent=r.name||'';
  const meta=Object.keys(r).filter(k=>!['id','name','description','image_url','source'].includes(k)&&r[k]!=null&&r[k]!=='').map(k=>`<strong>${k}:</strong> ${r[k]}`).join(' · ');
  document.getElementById('info-body').innerHTML=`
    ${r.image_url?`<div style="text-align:center;margin-bottom:12px;"><img src="${r.image_url}" alt="${r.name||''}" style="max-width:100%;max-height:300px;border-radius:6px;border:1px solid var(--card-border);"></div>`:''}
    ${meta?`<div style="font-size:12px;color:var(--ink3);margin-bottom:10px;padding:6px 8px;background:rgba(196,160,96,.08);border-radius:3px;">${meta}</div>`:''}
    <p style="white-space:pre-wrap;line-height:1.6;">${(r.description||'').replace(/</g,'&lt;')}</p>
    ${r.source&&r.source!=='Greyhawk'?`<div style="font-size:11px;color:var(--ink3);font-style:italic;margin-top:10px;text-align:right;">bron: ${r.source}</div>`:''}`;
  openM('info-modal');
}

function showInfo(name,desc){
  // legacy fallback
  document.getElementById('info-title').textContent=name;
  document.getElementById('info-body').innerHTML=`<p>${desc}</p>`;
  openM('info-modal');
}

// DB EDIT (DM)
function imageUrlFieldHtml(prefix,currentUrl){
  const u=(currentUrl||'').replace(/"/g,'&quot;');
  return `<div class="fg" style="grid-column:1/-1;">
    <label>🖼 Afbeelding <small>(URL of upload)</small></label>
    <div style="display:flex;gap:8px;align-items:flex-start;flex-wrap:wrap;">
      <div style="flex:1;min-width:200px;">
        <input type="text" id="${prefix}-image_url" value="${u}" placeholder="https://... of upload hieronder" style="width:100%;">
        <div style="display:flex;gap:6px;margin-top:4px;align-items:center;">
          <input type="file" id="${prefix}-image_file" accept="image/*" onchange="readImageToField(this,'${prefix}-image_url','${prefix}-image_preview')" style="font-size:11px;flex:1;">
          <button type="button" class="btn btn-xs btn-ghost" onclick="document.getElementById('${prefix}-image_url').value='';document.getElementById('${prefix}-image_preview').innerHTML='';">✕ Wissen</button>
        </div>
      </div>
      <div id="${prefix}-image_preview" style="width:80px;height:80px;border:1px dashed var(--card-border);border-radius:4px;background:#fff;display:flex;align-items:center;justify-content:center;overflow:hidden;">
        ${currentUrl?`<img src="${u}" style="max-width:100%;max-height:100%;object-fit:cover;">`:'<span style="font-size:24px;color:var(--ink3);">🖼</span>'}
      </div>
    </div>
  </div>`;
}

function readImageToField(input,urlFieldId,previewId){
  const f=input.files?.[0];if(!f)return;
  if(f.size>2*1024*1024){toast('Afbeelding te groot (max 2MB)',false);input.value='';return;}
  const r=new FileReader();
  r.onload=e=>{
    document.getElementById(urlFieldId).value=e.target.result;
    document.getElementById(previewId).innerHTML=`<img src="${e.target.result}" style="max-width:100%;max-height:100%;object-fit:cover;">`;
  };
  r.readAsDataURL(f);
}

async function openDBEdit(table,id){
  dbEditTable=table;dbEditId=id;
  const{data}=await sb.from(table).select('*').eq('id',id).single();
  if(!data)return;
  const fields={weapons:['name','weapon_type','damage','speed_factor','weight','type','description'],spells:['name','level','class','range','duration','area','description'],items:['name','category','weight','cost','description'],monsters:['name','ac','hp_dice','thac0','damage','move','alignment','description'],skills:['name','type','base_stat','description'],races:['name','description'],classes:['name','description','hit_die','primary_stat']};
  const f=fields[table]||['name','description'];
  document.getElementById('dbedit-title').textContent=`${data.name} bewerken`;
  document.getElementById('dbedit-err').textContent='';
  document.getElementById('dbedit-form').innerHTML=
    `<div class="fg-row col2">${f.map(field=>`<div class="fg"><label>${field}</label><input type="text" id="dbe-${field}" value="${(data[field]||'').toString().replace(/"/g,'&quot;')}"></div>`).join('')}</div>`+
    imageUrlFieldHtml('dbe',data.image_url);
  openM('dbedit-modal');
}

async function submitDBEdit(){
  const fields={weapons:['name','weapon_type','damage','speed_factor','weight','type','description'],spells:['name','level','class','range','duration','area','description'],items:['name','category','weight','cost','description'],monsters:['name','ac','hp_dice','thac0','damage','move','alignment','description'],skills:['name','type','base_stat','description'],races:['name','description'],classes:['name','description','hit_die','primary_stat']};
  const f=fields[dbEditTable]||['name','description'];
  const upd={};f.forEach(field=>{const el=document.getElementById('dbe-'+field);if(el)upd[field]=el.value;});
  const imgEl=document.getElementById('dbe-image_url');
  if(imgEl)upd.image_url=imgEl.value||null;
  const{error}=await sb.from(dbEditTable).update(upd).eq('id',dbEditId);
  if(error){document.getElementById('dbedit-err').textContent='Fout: '+error.message;return;}
  closeM('dbedit-modal');toast('✓ Opgeslagen');loadEnc(dbEditTable);
}

async function deleteDBItem(){
  if(!confirm(`Dit item permanent verwijderen uit de database?`))return;
  await sb.from(dbEditTable).delete().eq('id',dbEditId);
  closeM('dbedit-modal');toast('✓ Verwijderd uit database');loadEnc(dbEditTable);
}

function renderEncAddForm(table){
  const fields={weapons:['name','weapon_type','damage','speed_factor','type','description'],spells:['name','level','class','range','duration','area','description'],items:['name','category','cost','description'],monsters:['name','ac','hp_dice','thac0','damage','alignment','description'],skills:['name','type','base_stat','description'],races:['name','description'],classes:['name','description','hit_die','primary_stat']};
  const f=fields[table];
  if(!f){document.getElementById('enc-add-card').style.display='none';return;}
  document.getElementById('enc-add-form').innerHTML=
    `<div class="fg-row col3">${f.map(field=>`<div class="fg"><label>${field}${field==='name'?` <span class="req">*</span>`:''}</label><input type="text" id="ea-${field}" placeholder="${field}"></div>`).join('')}</div>`+
    imageUrlFieldHtml('ea',null)+
    `<button class="btn btn-primary btn-sm" onclick="submitEncAdd('${table}')">Toevoegen aan Database</button>`;
}

async function submitEncAdd(table){
  const fields={weapons:['name','weapon_type','damage','speed_factor','type','description'],spells:['name','level','class','range','duration','area','description'],items:['name','category','cost','description'],monsters:['name','ac','hp_dice','thac0','damage','alignment','description'],skills:['name','type','base_stat','description'],races:['name','description'],classes:['name','description','hit_die','primary_stat']};
  const obj={source:'Homebrew'};
  (fields[table]||[]).forEach(f=>{const el=document.getElementById('ea-'+f);if(el)obj[f]=el.value;});
  const imgEl=document.getElementById('ea-image_url');
  if(imgEl&&imgEl.value)obj.image_url=imgEl.value;
  if(!obj.name?.trim()){toast('Naam is verplicht',false);return;}
  const{error}=await sb.from(table).insert(obj);
  if(error){toast('Fout: '+error.message,false);return;}
  toast('✓ '+obj.name+' toegevoegd aan database');
  // reset form image preview
  if(imgEl)imgEl.value='';
  const prev=document.getElementById('ea-image_preview');if(prev)prev.innerHTML='<span style="font-size:24px;color:var(--ink3);">🖼</span>';
  loadEnc(table);
}

// DM DASHBOARD
async function loadDMDash(){
  const{data}=await sb.from('characters').select('*').order('is_active',{ascending:false}).order('name');
  const grid=document.getElementById('dm-grid');
  if(!data?.length){grid.innerHTML='<div style="padding:40px;text-align:center;color:var(--ink3);">Geen karakters gevonden.</div>';return;}
  grid.innerHTML=data.map(c=>{
    const pct=c.hp_max?Math.round((c.hp_current/c.hp_max)*100):100;
    const hpClass=pct>50?'hp-good':pct>25?'hp-med':'hp-low';
    const initials=(c.name||'?').substring(0,2).toUpperCase();
    return`<div class="char-card ${c.is_active===false?'char-inactive':''}" onclick="openChar('${c.id}')">
      <div class="char-card-banner">
        ${c.avatar_url?`<img src="${c.avatar_url}" alt="${c.name}">`:`<div class="char-initials">${initials}</div>`}
      </div>
      <div class="char-card-body">
        <div class="char-card-name">${c.name}${c.is_active===false?' <span class="badge badge-inactive">Inactief</span>':''}</div>
        <div class="char-card-meta">${c.race||''} ${c.class||''} — Lv.${c.level||1} · ${c.player_name||c.player_id?.substring(0,8)||'?'}</div>
        <div class="char-card-stats">HP: ${c.hp_current||0}/${c.hp_max||0} · AC: ${c.ac||'—'}</div>
        ${c.dm_notes?`<div style="font-size:11px;color:var(--dm-text);font-style:italic;margin-top:4px;">🔒 ${c.dm_notes.substring(0,50)}${c.dm_notes.length>50?'...':''}</div>`:''}
        <div class="hp-bar" style="margin-top:6px;"><div class="hp-fill ${hpClass}" style="width:${pct}%"></div></div>
      </div>
    </div>`;
  }).join('');
}

// PDF
function exportPDF(){
  const c=CC;if(!c)return;
  const w=window.open('','_blank');
  w.document.write(`<!DOCTYPE html><html><head><meta charset="UTF-8"><title>${c.name}</title>
  <style>body{font-family:Georgia,serif;max-width:800px;margin:20px auto;padding:20px;font-size:13px;color:#2a1a0a;}h1{font-size:24px;text-align:center;border-bottom:3px double #8a6030;padding-bottom:10px;margin-bottom:16px;}h2{font-size:13px;text-transform:uppercase;letter-spacing:1px;border-bottom:1px solid #c4a060;padding-bottom:3px;margin-bottom:8px;color:#7a1c1c;}
  .g2{display:grid;grid-template-columns:1fr 1fr;gap:14px;margin-bottom:14px;}.box{border:1px solid #c4a060;border-radius:3px;padding:10px;}.row{display:flex;justify-content:space-between;padding:3px 0;border-bottom:1px dotted #c4a060;font-size:12px;}
  .g3{display:grid;grid-template-columns:1fr 1fr 1fr;gap:8px;}.stat{text-align:center;padding:6px;border:1px solid #c4a060;border-radius:3px;}.sn{font-size:9px;text-transform:uppercase;color:#6b4520;}.sv{font-size:20px;font-weight:bold;}
  li{font-size:12px;margin-bottom:3px;}@media print{.noprint{display:none}}</style></head><body>
  <button class="noprint" onclick="window.print()" style="margin-bottom:12px;padding:8px 20px;background:#7a1c1c;color:white;border:none;border-radius:3px;cursor:pointer;font-size:14px;">🖨️ Afdrukken / PDF opslaan</button>
  <h1>${c.name}</h1>
  <div class="g2">
    <div class="box"><h2>Identiteit</h2>
      <div class="row"><span>Naam</span><strong>${c.name||'—'}</strong></div>
      <div class="row"><span>Ras</span><span>${c.race||'—'}</span></div>
      <div class="row"><span>Klasse</span><span>${c.class||'—'}</span></div>
      <div class="row"><span>Level</span><span>${c.level||1}</span></div>
      <div class="row"><span>Gezindheid</span><span>${c.alignment||'—'}</span></div>
      <div class="row"><span>Geslacht</span><span>${c.sex||'—'}</span></div>
      <div class="row"><span>Speler</span><span>${c.player_name||'—'}</span></div>
      <div class="row"><span>XP</span><span>${c.xp||0} / ${c.xp_next||'?'}</span></div>
    </div>
    <div class="box"><h2>Vitalen</h2>
      <div class="row"><span>HP huidig</span><strong>${c.hp_current||0} / ${c.hp_max||0}</strong></div>
      <div class="row"><span>Armor Class</span><strong>${c.ac||10}</strong></div>
      <div class="row"><span>THAC0</span><strong>${c.thac0||20}</strong></div>
      <div class="row"><span>Platinum</span><span>${c.pp||0} PP</span></div>
      <div class="row"><span>Gold</span><span>${c.gp||0} GP</span></div>
      <div class="row"><span>Silver</span><span>${c.sp||0} SP</span></div>
      <div class="row"><span>Copper</span><span>${c.cp||0} CP</span></div>
    </div>
  </div>
  <div class="box" style="margin-bottom:14px;"><h2>Ability Scores</h2>
    <div class="g3">
      <div class="stat"><div class="sn">Strength</div><div class="sv">${c.str||'—'}</div><div style="font-size:10px;color:#1c4a7a;">${c.str_mod||''}</div></div>
      <div class="stat"><div class="sn">Dexterity</div><div class="sv">${c.dex||'—'}</div><div style="font-size:10px;color:#1c4a7a;">${c.dex_mod||''}</div></div>
      <div class="stat"><div class="sn">Intelligence</div><div class="sv">${c.int||'—'}</div></div>
      <div class="stat"><div class="sn">Wisdom</div><div class="sv">${c.wis||'—'}</div></div>
      <div class="stat"><div class="sn">Constitution</div><div class="sv">${c.con||'—'}</div><div style="font-size:10px;color:#1c4a7a;">${c.con_mod||''}</div></div>
      <div class="stat"><div class="sn">Charisma</div><div class="sv">${c.cha||'—'}</div></div>
    </div>
  </div>
  <div class="g2">
    <div class="box"><h2>Saving Throws</h2>
      <div class="row"><span>Paralyzation/Death</span><span>${c.sv_pd||'—'}</span></div>
      <div class="row"><span>Rod/Staff/Wand</span><span>${c.sv_rsw||'—'}</span></div>
      <div class="row"><span>Petrification</span><span>${c.sv_pp||'—'}</span></div>
      <div class="row"><span>Breath Weapon</span><span>${c.sv_bw||'—'}</span></div>
      <div class="row"><span>Spell</span><span>${c.sv_spell||'—'}</span></div>
      <div class="row"><span>Poison</span><span>${c.sv_poison||'—'}</span></div>
    </div>
    <div class="box"><h2>Notities</h2><p style="font-size:12px;white-space:pre-wrap;">${c.notes||'—'}</p></div>
  </div>
  </body></html>`);
  w.document.close();
}

// HELP
function showAppHelp(){
  const isDM=CU?.is_dm;
  document.getElementById('help-body').innerHTML=isDM?`
  <h3 style="font-family:'Cinzel',serif;color:#4a3a7a;margin:0 0 12px;">DM Functies</h3>
  <div style="background:rgba(42,26,74,.06);border:1px solid rgba(106,74,154,.3);border-radius:4px;padding:12px;margin-bottom:12px;font-size:13px;">
    <strong>DM Dashboard</strong> — zie alle karakters van alle spelers<br>
    <strong>🔒 Privé Notities</strong> — onderaan elk karakter, onzichtbaar voor spelers<br>
    <strong>🔒 Sessie-aantekeningen</strong> — voor XP-toekenning en verhaalbeheer<br>
    <strong>✏ Encyclopedie bewerken</strong> — klik het ✏ icoon naast elk item<br>
    <strong>+ Toevoegen aan database</strong> — onderaan Encyclopedie pagina<br>
    <strong>🔑 Reset</strong> — tijdelijk wachtwoord instellen voor een speler<br>
    <strong>⏸ Inactief</strong> — karakter tijdelijk verbergen zonder verwijderen
  </div>
  <h3 style="font-family:'Cinzel',serif;color:#4a3a7a;margin:12px 0 8px;">Logboek</h3>
  <p style="font-size:13px;">Klik "📋 Logboek" op een karakter. Spelers zien automatisch DM-wijzigingen bij volgende login.</p>
  <h3 style="font-family:'Cinzel',serif;color:#4a3a7a;margin:12px 0 8px;">DM Code</h3>
  <p style="font-size:13px;font-family:monospace;background:rgba(42,26,74,.08);padding:8px;border-radius:4px;">GREYHAWK_DM_2025</p>
  `:`
  <h3 style="font-family:'Cinzel',serif;color:var(--rust);margin:0 0 10px;">Snel aan de slag</h3>
  <div style="font-size:13px;line-height:1.8;">
    <strong>Karakter aanmaken:</strong> Klik "+ Nieuw Karakter". Kies eerst je ras — de beschikbare klassen passen zich automatisch aan. Klik <strong>?</strong> naast elk veld voor uitleg.<br><br>
    <strong>Velden bewerken:</strong> Klik op een waarde met de stippellijn eronder → typ → druk Enter of klik ergens anders. Auto-opslaan.<br><br>
    <strong>Wapens/items/spreuken/vaardigheden:</strong> Klik "+ toevoegen" → zoek in de Greyhawk database → klik een item aan om het formulier in te vullen → klik Toevoegen.<br><br>
    <strong>Wapens filteren op type:</strong> In het toevoeg-venster staat een type-filter (Sword, Axe, Bow...)<br><br>
    <strong>Encyclopedie:</strong> 170+ monsters, 250+ spreuken, 80+ wapens, 150+ items. Klik "info" voor details.<br><br>
    <strong>Profielfoto:</strong> Klik het 📷 icoon op je karakterblad om een foto te uploaden (max 2MB).<br><br>
    <strong>PDF:</strong> Klik "📄 PDF" bovenaan het karakterblad → Afdrukken / PDF opslaan.<br><br>
    <strong>Logboek:</strong> Bij elke login zie je automatisch wat de DM heeft gewijzigd. Klik "📋 Logboek" voor volledig overzicht.<br><br>
    <strong>Inactief karakter:</strong> Karakters op inactief gezet door de DM verschijnen iets meer uitgevaagd en kunnen opnieuw geactiveerd worden.
  </div>`;
  openM('help-modal');
}

// =====================================================================
// SCAN KARAKTERBLAD (via Netlify serverless function)
// =====================================================================
let scanResultData=null;

function openScanModal(){
  document.getElementById('scan-file').value='';
  document.getElementById('scan-img').src='';
  document.getElementById('scan-preview').style.display='none';
  document.getElementById('scan-status').textContent='';
  document.getElementById('scan-err').textContent='';
  document.getElementById('scan-go').disabled=true;
  // Verberg waarschuwing als we op netlify draaien
  const onNetlify=location.hostname.endsWith('.netlify.app')||location.hostname.endsWith('.netlify.live');
  document.getElementById('scan-warn').style.display=onNetlify?'none':'block';
  openM('scan-modal');
}

function previewScan(input){
  const f=input.files?.[0];
  if(!f){document.getElementById('scan-go').disabled=true;return;}
  if(f.size>5*1024*1024){document.getElementById('scan-err').textContent='Bestand te groot (max 5MB).';return;}
  document.getElementById('scan-err').textContent='';
  const r=new FileReader();
  r.onload=e=>{
    document.getElementById('scan-img').src=e.target.result;
    document.getElementById('scan-preview').style.display='block';
    document.getElementById('scan-go').disabled=false;
  };
  r.readAsDataURL(f);
}

async function doScan(){
  const f=document.getElementById('scan-file').files?.[0];
  if(!f)return;
  document.getElementById('scan-go').disabled=true;
  document.getElementById('scan-status').textContent='Foto wordt geanalyseerd door Claude... (kan 10-30 seconden duren)';
  document.getElementById('scan-err').textContent='';
  try{
    const dataUrl=await new Promise((res,rej)=>{const r=new FileReader();r.onload=e=>res(e.target.result);r.onerror=rej;r.readAsDataURL(f);});
    const base64=dataUrl.split(',')[1];
    const resp=await fetch('/.netlify/functions/scan-character',{
      method:'POST',
      headers:{'content-type':'application/json'},
      body:JSON.stringify({imageBase64:base64,mediaType:f.type})
    });
    if(!resp.ok){
      let msg='Fout '+resp.status;
      try{const j=await resp.json();msg=j.error||msg;if(j.details)msg+=' — '+j.details;}catch(e){}
      if(resp.status===404)msg='Scan-functie niet gevonden. Vereist Netlify deployment (zie README).';
      throw new Error(msg);
    }
    const data=await resp.json();
    if(!data.character)throw new Error('Onverwacht antwoord van scan-functie.');
    scanResultData=data.character;
    closeM('scan-modal');
    showScanResult(scanResultData);
  }catch(e){
    document.getElementById('scan-err').textContent='✕ '+e.message;
    document.getElementById('scan-status').textContent='';
    document.getElementById('scan-go').disabled=false;
  }
}

function showScanResult(c){
  const races=Object.keys(RACE_CLASSES);
  const aligns=['Lawful Good','Lawful Neutral','Lawful Evil','Neutral Good','True Neutral','Neutral Evil','Chaotic Good','Chaotic Neutral','Chaotic Evil'];
  const cls=RACE_CLASSES[c.race]||RACE_CLASSES.Human;
  document.getElementById('scan-result-form').innerHTML=`
    <div class="fg-row col2">
      <div class="fg"><label>Naam <span class="req">*</span></label><input type="text" id="sr-name" value="${(c.name||'').replace(/"/g,'&quot;')}"></div>
      <div class="fg"><label>Speler</label><input type="text" id="sr-player" value="${(c.player_name||'').replace(/"/g,'&quot;')}"></div>
      <div class="fg"><label>Ras</label><select id="sr-race" onchange="updateSrClasses()">${races.map(r=>`<option ${r===c.race?'selected':''}>${r}</option>`).join('')}</select></div>
      <div class="fg"><label>Klasse</label><select id="sr-class">${cls.map(k=>`<option ${k===c.class?'selected':''}>${k}</option>`).join('')}</select></div>
      <div class="fg"><label>Gezindheid</label><select id="sr-align">${aligns.map(a=>`<option ${a===c.alignment?'selected':''}>${a}</option>`).join('')}</select></div>
      <div class="fg"><label>Geslacht</label><select id="sr-sex"><option ${c.sex==='Male'?'selected':''}>Male</option><option ${c.sex==='Female'?'selected':''}>Female</option></select></div>
      <div class="fg"><label>Level</label><input type="number" id="sr-level" value="${c.level||1}" min="1"></div>
      <div class="fg"><label>HP huidig / max</label><div style="display:flex;gap:6px;"><input type="number" id="sr-hp" value="${c.hp_current||0}" style="width:50%;"><input type="number" id="sr-hpmax" value="${c.hp_max||0}" style="width:50%;"></div></div>
      <div class="fg"><label>AC</label><input type="text" id="sr-ac" value="${c.ac||10}"></div>
      <div class="fg"><label>THAC0</label><input type="number" id="sr-thac0" value="${c.thac0||20}"></div>
    </div>
    <div style="font-family:'Cinzel',serif;font-size:11px;color:var(--ink3);letter-spacing:1px;margin:8px 0 4px;">ABILITY SCORES</div>
    <div class="fg-row col3">
      <div class="fg"><label>STR</label><input type="number" id="sr-str" value="${c.str||''}"></div>
      <div class="fg"><label>DEX</label><input type="number" id="sr-dex" value="${c.dex||''}"></div>
      <div class="fg"><label>INT</label><input type="number" id="sr-int" value="${c.int||''}"></div>
      <div class="fg"><label>WIS</label><input type="number" id="sr-wis" value="${c.wis||''}"></div>
      <div class="fg"><label>CON</label><input type="number" id="sr-con" value="${c.con||''}"></div>
      <div class="fg"><label>CHA</label><input type="number" id="sr-cha" value="${c.cha||''}"></div>
    </div>
    <div style="font-size:12px;color:var(--ink3);font-style:italic;margin-top:8px;">
      Wapens (${(c.weapons||[]).length}), Items (${(c.items||[]).length}), Vaardigheden (${(c.skills||[]).length}), Spreuken (${(c.spells||[]).length}) worden automatisch toegevoegd.
    </div>`;
  document.getElementById('scan-result-err').textContent='';
  openM('scan-result-modal');
}

function updateSrClasses(){
  const r=document.getElementById('sr-race').value;
  const cls=RACE_CLASSES[r]||RACE_CLASSES.Human;
  document.getElementById('sr-class').innerHTML=cls.map(k=>`<option>${k}</option>`).join('');
}

async function confirmScanResult(){
  const name=document.getElementById('sr-name').value.trim();
  if(!name){document.getElementById('scan-result-err').textContent='Naam is verplicht.';return;}
  const c=scanResultData||{};
  const obj={
    player_id:CU.id,name,
    player_name:document.getElementById('sr-player').value,
    race:document.getElementById('sr-race').value,
    class:document.getElementById('sr-class').value,
    alignment:document.getElementById('sr-align').value,
    sex:document.getElementById('sr-sex').value,
    level:parseInt(document.getElementById('sr-level').value)||1,
    hp_current:parseInt(document.getElementById('sr-hp').value)||0,
    hp_max:parseInt(document.getElementById('sr-hpmax').value)||0,
    ac:document.getElementById('sr-ac').value||'10',
    thac0:parseInt(document.getElementById('sr-thac0').value)||20,
    str:parseInt(document.getElementById('sr-str').value)||null,
    dex:parseInt(document.getElementById('sr-dex').value)||null,
    int:parseInt(document.getElementById('sr-int').value)||null,
    wis:parseInt(document.getElementById('sr-wis').value)||null,
    con:parseInt(document.getElementById('sr-con').value)||null,
    cha:parseInt(document.getElementById('sr-cha').value)||null,
    str_mod:c.str_mod||null, dex_mod:c.dex_mod||null, int_mod:c.int_mod||null,
    wis_mod:c.wis_mod||null, con_mod:c.con_mod||null, cha_mod:c.cha_mod||null,
    comeliness:c.comeliness||null,
    sv_pd:c.sv_pd||null, sv_rsw:c.sv_rsw||null, sv_pp:c.sv_pp||null,
    sv_bw:c.sv_bw||null, sv_spell:c.sv_spell||null, sv_poison:c.sv_poison||null,
    xp:c.xp||0, xp_next:c.xp_next||null,
    pp:c.pp||0, gp:c.gp||0, sp:c.sp||0, cp:c.cp||0,
    notes:c.notes||null,
    is_active:true
  };
  const{data,error}=await sb.from('characters').insert(obj).select().single();
  if(error){document.getElementById('scan-result-err').textContent='Fout: '+error.message;return;}
  // Insert subtables
  const cid=data.id;
  const tasks=[];
  (c.weapons||[]).forEach(w=>{if(w.weapon_name)tasks.push(sb.from('character_weapons').insert({character_id:cid,weapon_name:w.weapon_name,attacks_per_round:w.attacks_per_round||'1/1',damage:w.damage||null,speed_factor:parseInt(w.speed_factor)||7,notes:w.notes||null}));});
  (c.items||[]).forEach(i=>{if(i.item_name)tasks.push(sb.from('character_items').insert({character_id:cid,item_name:i.item_name,category:i.category||'item',quantity:parseInt(i.quantity)||1,notes:i.notes||null}));});
  (c.skills||[]).forEach(s=>{if(s.skill_name)tasks.push(sb.from('character_skills').insert({character_id:cid,skill_name:s.skill_name,skill_type:s.skill_type||'Non-Weapon',stat_modifier:s.stat_modifier||null,notes:s.notes||null}));});
  (c.spells||[]).forEach(s=>{if(s.spell_name)tasks.push(sb.from('character_spells').insert({character_id:cid,spell_name:s.spell_name,spell_level:parseInt(s.spell_level)||1,spell_class:s.spell_class||null,prepared:!!s.prepared,notes:s.notes||null}));});
  await Promise.all(tasks);
  await logChange(cid,'Karakter aangemaakt via scan','system');
  closeM('scan-result-modal');toast('✓ Karakter '+name+' aangemaakt!');
  loadChars();openChar(cid);
}

// =====================================================================
// CSV IMPORT (encyclopedie - DM only)
// =====================================================================
const CSV_FIELDS={
  weapons:['name','weapon_type','damage','speed_factor','weight','type','description','image_url'],
  spells:['name','level','class','range','duration','area','description','image_url'],
  items:['name','category','weight','cost','description','image_url'],
  monsters:['name','ac','hp_dice','thac0','damage','move','alignment','description','image_url'],
  skills:['name','type','base_stat','description','image_url'],
  races:['name','description','image_url'],
  classes:['name','description','hit_die','primary_stat','image_url']
};
const CSV_NUMERIC={spells:['level'],weapons:['speed_factor'],items:['weight'],monsters:['ac','thac0','move']};

function openCsvImport(){
  if(!CU?.is_dm){toast('Alleen voor DM',false);return;}
  const t=encCurrentTable||'weapons';
  document.getElementById('csv-table-name').textContent=t;
  document.getElementById('csv-table-name2').textContent=t;
  document.getElementById('csv-cols-hint').textContent=(CSV_FIELDS[t]||['name','description']).join(', ');
  document.getElementById('csv-file').value='';
  document.getElementById('csv-text').value='';
  document.getElementById('csv-err').textContent='';
  document.getElementById('csv-status').textContent='';
  openM('csv-modal');
}

function parseCSV(text){
  const rows=[];let cur=[],val='',inQ=false;
  for(let i=0;i<text.length;i++){
    const c=text[i],n=text[i+1];
    if(inQ){
      if(c==='"'&&n==='"'){val+='"';i++;}
      else if(c==='"'){inQ=false;}
      else val+=c;
    }else{
      if(c==='"')inQ=true;
      else if(c===','){cur.push(val);val='';}
      else if(c==='\n'){cur.push(val);rows.push(cur);cur=[];val='';}
      else if(c==='\r'){/* skip */}
      else val+=c;
    }
  }
  if(val.length||cur.length){cur.push(val);rows.push(cur);}
  return rows.filter(r=>r.length&&r.some(v=>v!==''));
}

async function doCsvImport(){
  const t=encCurrentTable||'weapons';
  let text=document.getElementById('csv-text').value;
  const f=document.getElementById('csv-file').files?.[0];
  if(f&&!text){text=await f.text();}
  if(!text){document.getElementById('csv-err').textContent='Geen CSV inhoud.';return;}
  const rows=parseCSV(text);
  if(rows.length<2){document.getElementById('csv-err').textContent='CSV moet minimaal een header en 1 rij bevatten.';return;}
  const header=rows[0].map(h=>h.trim().toLowerCase());
  if(!header.includes('name')){document.getElementById('csv-err').textContent='Kolom "name" is verplicht.';return;}
  const allowed=new Set(CSV_FIELDS[t]||['name','description']);
  const numFields=new Set(CSV_NUMERIC[t]||[]);
  const records=[];
  for(let i=1;i<rows.length;i++){
    const r=rows[i];const obj={source:'CSV import'};
    header.forEach((h,idx)=>{
      if(!allowed.has(h))return;
      let v=r[idx]??'';v=String(v).trim();if(v==='')return;
      if(numFields.has(h)){const n=parseInt(v);if(!isNaN(n))obj[h]=n;}
      else obj[h]=v;
    });
    if(obj.name)records.push(obj);
  }
  if(!records.length){document.getElementById('csv-err').textContent='Geen geldige rijen gevonden.';return;}
  document.getElementById('csv-status').textContent='Importeren van '+records.length+' rijen...';
  document.getElementById('csv-err').textContent='';
  // Insert per chunks van 100
  let ok=0,fail=0;
  for(let i=0;i<records.length;i+=100){
    const chunk=records.slice(i,i+100);
    const{error}=await sb.from(t).insert(chunk);
    if(error){fail+=chunk.length;document.getElementById('csv-err').textContent='Fout: '+error.message;}
    else ok+=chunk.length;
  }
  document.getElementById('csv-status').textContent=`✓ ${ok} geïmporteerd${fail?`, ${fail} mislukt`:''}.`;
  toast(`✓ ${ok} rijen toegevoegd aan ${t}`);
  if(ok>0)loadEnc(t);
  setTimeout(()=>closeM('csv-modal'),1500);
}

// =====================================================================
// SESSIES (campagne-sessies met logboek per karakter)
// =====================================================================
let editingSessionId=null, currentSession=null, currentLogEntry=null;

async function loadSessions(){
  const el=document.getElementById('sessions-list');
  el.innerHTML='<div style="padding:30px;text-align:center;color:var(--gold);font-style:italic;">Laden...</div>';
  let q=sb.from('sessions').select('*').order('session_date',{ascending:false}).order('created_at',{ascending:false});
  const{data:sessions,error}=await q;
  if(error){el.innerHTML=`<div style="padding:20px;color:var(--rust2);">Fout: ${error.message}</div>`;return;}
  // voor niet-DM: filter op sessies waar hun karakter in zit
  let visible=sessions||[];
  if(!CU.is_dm&&visible.length){
    const{data:myChars}=await sb.from('characters').select('id').eq('player_id',CU.id);
    const myIds=(myChars||[]).map(c=>c.id);
    if(myIds.length){
      const{data:parts}=await sb.from('session_participants').select('session_id,character_id').in('character_id',myIds);
      const sessionSet=new Set((parts||[]).map(p=>p.session_id));
      visible=visible.filter(s=>sessionSet.has(s.id));
    }else{visible=[];}
  }
  if(!visible.length){
    el.innerHTML=CU.is_dm
      ?'<div style="padding:40px;text-align:center;color:var(--ink3);font-style:italic;">Nog geen sessies. Klik "+ Nieuwe sessie" om te beginnen.</div>'
      :'<div style="padding:40px;text-align:center;color:var(--ink3);font-style:italic;">Je karakter zit nog in geen enkele sessie. Vraag aan de DM.</div>';
    return;
  }
  // Voor elke sessie: laad deelnemers-count
  const sessionIds=visible.map(s=>s.id);
  const{data:allParts}=await sb.from('session_participants').select('session_id,character_id,xp_awarded').in('session_id',sessionIds);
  const partsBySession={};(allParts||[]).forEach(p=>{(partsBySession[p.session_id]=partsBySession[p.session_id]||[]).push(p);});
  el.innerHTML=visible.map(s=>{
    const parts=partsBySession[s.id]||[];
    const statusColor={planned:'var(--blue2)',active:'var(--green2)',completed:'var(--ink3)'}[s.status]||'var(--ink3)';
    const statusLabel={planned:'Gepland',active:'Actief',completed:'Afgesloten'}[s.status]||s.status;
    const dateStr=s.session_date?new Date(s.session_date).toLocaleDateString('nl-BE',{day:'numeric',month:'long',year:'numeric'}):'Geen datum';
    return`<div class="card" style="cursor:pointer;" onclick="openSession('${s.id}')">
      <div style="display:flex;justify-content:space-between;align-items:flex-start;gap:10px;">
        <div style="flex:1;">
          <div style="font-family:'Cinzel',serif;font-size:16px;color:var(--rust);font-weight:600;">${s.name}</div>
          <div style="font-size:13px;color:var(--ink3);margin-top:4px;">📅 ${dateStr}${s.location?' · 📍 '+s.location:''}</div>
          ${s.summary?`<div style="font-size:13px;color:var(--ink);margin-top:6px;font-style:italic;">${s.summary.substring(0,200)}${s.summary.length>200?'...':''}</div>`:''}
        </div>
        <div style="text-align:right;">
          <span style="display:inline-block;padding:3px 10px;border-radius:3px;background:${statusColor};color:#fff;font-family:'Cinzel',serif;font-size:10px;letter-spacing:1px;">${statusLabel}</span>
          <div style="font-size:11px;color:var(--ink3);margin-top:6px;">${parts.length} karakter${parts.length===1?'':'s'}</div>
          ${s.xp_awarded_total?`<div style="font-size:11px;color:var(--gold);margin-top:2px;">⭐ ${s.xp_awarded_total} XP</div>`:''}
        </div>
      </div>
    </div>`;
  }).join('');
}

async function openNewSession(){
  editingSessionId=null;
  document.getElementById('ns-title').textContent='+ Nieuwe Sessie';
  document.getElementById('ns-name').value='';
  document.getElementById('ns-date').value=new Date().toISOString().substring(0,10);
  document.getElementById('ns-loc').value='';
  document.getElementById('ns-summary').value='';
  document.getElementById('ns-dmnotes').value='';
  document.getElementById('ns-status').value='planned';
  document.getElementById('ns-err').textContent='';
  await loadParticipantsPicker([]);
  openM('ns-modal');
}

async function loadParticipantsPicker(checkedIds){
  const{data:chars}=await sb.from('characters').select('id,name,race,class,player_name,is_active').order('is_active',{ascending:false}).order('name');
  const set=new Set(checkedIds);
  document.getElementById('ns-participants').innerHTML=(chars||[]).map(c=>`
    <label style="display:flex;gap:8px;align-items:center;padding:4px 2px;cursor:pointer;${c.is_active===false?'opacity:.5;':''}">
      <input type="checkbox" value="${c.id}" ${set.has(c.id)?'checked':''}>
      <span><strong>${c.name}</strong> <span style="color:var(--ink3);">${c.race||''} ${c.class||''}${c.player_name?' ('+c.player_name+')':''}${c.is_active===false?' — inactief':''}</span></span>
    </label>`).join('')||'<div style="color:var(--ink3);font-style:italic;">Geen karakters gevonden.</div>';
}

async function submitSession(){
  const name=document.getElementById('ns-name').value.trim();
  if(!name){document.getElementById('ns-err').textContent='Naam is verplicht.';return;}
  const checked=[...document.querySelectorAll('#ns-participants input[type=checkbox]:checked')].map(el=>el.value);
  if(!checked.length){document.getElementById('ns-err').textContent='Selecteer minstens één karakter.';return;}
  const obj={
    name,
    session_date:document.getElementById('ns-date').value||null,
    location:document.getElementById('ns-loc').value||null,
    summary:document.getElementById('ns-summary').value||null,
    dm_notes:document.getElementById('ns-dmnotes').value||null,
    status:document.getElementById('ns-status').value,
    created_by:CU.id,
    updated_at:new Date().toISOString()
  };
  let sessionId=editingSessionId;
  if(editingSessionId){
    const{error}=await sb.from('sessions').update(obj).eq('id',editingSessionId);
    if(error){document.getElementById('ns-err').textContent='Fout: '+error.message;return;}
  }else{
    const{data,error}=await sb.from('sessions').insert(obj).select().single();
    if(error){document.getElementById('ns-err').textContent='Fout: '+error.message;return;}
    sessionId=data.id;
  }
  // sync participants: delete + insert
  await sb.from('session_participants').delete().eq('session_id',sessionId);
  if(checked.length){
    const rows=checked.map(cid=>({session_id:sessionId,character_id:cid}));
    await sb.from('session_participants').insert(rows);
    // ensure session_logs exist for each participant
    const{data:existing}=await sb.from('session_logs').select('character_id').eq('session_id',sessionId);
    const has=new Set((existing||[]).map(e=>e.character_id));
    const newLogs=checked.filter(cid=>!has.has(cid)).map(cid=>({session_id:sessionId,character_id:cid}));
    if(newLogs.length)await sb.from('session_logs').insert(newLogs);
  }
  closeM('ns-modal');toast(editingSessionId?'✓ Sessie bijgewerkt':'✓ Sessie aangemaakt');
  loadSessions();
}

async function openSession(id){
  const{data:s,error}=await sb.from('sessions').select('*').eq('id',id).single();
  if(error||!s){toast('Sessie niet gevonden',false);return;}
  currentSession=s;
  const{data:participants}=await sb.from('session_participants').select('*,characters(id,name,race,class,player_id,player_name,xp,avatar_url,is_active)').eq('session_id',id);
  const{data:logs}=await sb.from('session_logs').select('*').eq('session_id',id);
  const logByChar={};(logs||[]).forEach(l=>logByChar[l.character_id]=l);
  const isDM=CU.is_dm;
  const statusColor={planned:'var(--blue2)',active:'var(--green2)',completed:'var(--ink3)'}[s.status]||'var(--ink3)';
  const statusLabel={planned:'Gepland',active:'Actief',completed:'Afgesloten'}[s.status]||s.status;
  const dateStr=s.session_date?new Date(s.session_date).toLocaleDateString('nl-BE',{day:'numeric',month:'long',year:'numeric'}):'Geen datum';
  document.getElementById('sd-title').textContent=s.name;
  let html=`
    <div style="margin-bottom:16px;padding:12px;background:rgba(196,160,96,.08);border:1px solid var(--card-border);border-radius:4px;">
      <div style="display:flex;justify-content:space-between;align-items:center;flex-wrap:wrap;gap:8px;margin-bottom:6px;">
        <span style="font-size:13px;color:var(--ink3);">📅 ${dateStr}${s.location?' · 📍 '+s.location:''}</span>
        <span style="display:inline-block;padding:3px 10px;border-radius:3px;background:${statusColor};color:#fff;font-family:'Cinzel',serif;font-size:10px;letter-spacing:1px;">${statusLabel}</span>
      </div>
      ${s.summary?`<div style="font-size:13px;color:var(--ink);margin-top:6px;">${s.summary.replace(/\n/g,'<br>')}</div>`:''}
    </div>`;
  if(isDM){
    html+=`<div class="dm-panel" style="margin-bottom:16px;">
      <div class="dm-panel-title">🔒 DM-notities <small style="font-size:10px;opacity:.7;">(Onzichtbaar voor spelers)</small></div>
      <textarea class="dm-textarea" onblur="saveSessionDMNotes('${s.id}',this.value)" style="min-height:60px;">${s.dm_notes||''}</textarea>
    </div>`;
  }
  html+=`<div style="font-family:'Cinzel',serif;font-size:12px;color:var(--ink3);letter-spacing:1px;margin:10px 0 6px;">DEELNEMERS & HUN LOGBOEK</div>`;
  html+=(participants||[]).map(p=>{
    const c=p.characters;if(!c)return '';
    const log=logByChar[c.id]||{};
    const canEdit=isDM||c.player_id===CU.id;
    const hasContent=log.player_notes||log.encounters||log.npcs_met||log.loot_found;
    const initials=(c.name||'?').substring(0,2).toUpperCase();
    return`<div class="card" style="margin-bottom:10px;">
      <div style="display:flex;gap:10px;align-items:center;margin-bottom:8px;">
        ${c.avatar_url?`<img src="${c.avatar_url}" style="width:40px;height:40px;border-radius:4px;object-fit:cover;">`:`<div style="width:40px;height:40px;border-radius:4px;background:var(--rust);color:#fdf5e0;font-family:'Cinzel',serif;display:flex;align-items:center;justify-content:center;font-weight:600;">${initials}</div>`}
        <div style="flex:1;">
          <div style="font-family:'Cinzel',serif;font-weight:600;color:var(--rust);">${c.name}</div>
          <div style="font-size:12px;color:var(--ink3);">${c.race||''} ${c.class||''} · XP: ${c.xp||0}${p.xp_awarded?` (+${p.xp_awarded} deze sessie)`:''}</div>
        </div>
        ${canEdit?`<button class="btn btn-primary btn-sm" onclick="openSessionLog('${s.id}','${c.id}','${c.name.replace(/'/g,"&#39;")}')">${hasContent?'✏ Bewerk log':'+ Log aanvullen'}</button>`:''}
        ${isDM?`<button class="btn btn-ghost btn-sm" onclick="openAwardXp('${s.id}','${c.id}','${c.name.replace(/'/g,"&#39;")}',${p.xp_awarded||0})">⭐ XP</button>`:''}
      </div>
      ${hasContent?`<div style="font-size:12px;color:var(--ink);background:rgba(196,160,96,.06);padding:8px;border-radius:3px;">
        ${log.encounters?`<div><strong>⚔ Ontmoetingen:</strong> ${log.encounters.substring(0,150)}${log.encounters.length>150?'...':''}</div>`:''}
        ${log.npcs_met?`<div><strong>💬 NPCs:</strong> ${log.npcs_met.substring(0,150)}${log.npcs_met.length>150?'...':''}</div>`:''}
        ${log.loot_found?`<div><strong>💰 Loot:</strong> ${log.loot_found.substring(0,150)}${log.loot_found.length>150?'...':''}</div>`:''}
        ${log.player_notes?`<div><strong>📝 Notities:</strong> ${log.player_notes.substring(0,200)}${log.player_notes.length>200?'...':''}</div>`:''}
      </div>`:'<div style="font-size:12px;color:var(--ink3);font-style:italic;">Nog geen log-inhoud.</div>'}
    </div>`;
  }).join('');
  html+=`<div style="text-align:right;margin-top:14px;display:flex;gap:8px;justify-content:flex-end;flex-wrap:wrap;">
    <button class="btn btn-ghost btn-sm" onclick="openExportModal('session')">📤 Export</button>
    ${isDM?`<button class="btn btn-ghost btn-sm" onclick="editSession('${s.id}')">✏ Bewerken</button>
    <button class="btn btn-danger btn-sm" onclick="deleteSession('${s.id}')">🗑 Verwijderen</button>`:''}
  </div>`;
  document.getElementById('sd-body').innerHTML=html;
  openM('sd-modal');
}

async function saveSessionDMNotes(id,val){
  await sb.from('sessions').update({dm_notes:val,updated_at:new Date().toISOString()}).eq('id',id);
  toast('✓ DM-notities opgeslagen');
}

async function editSession(id){
  if(!CU.is_dm)return;
  closeM('sd-modal');
  const{data:s}=await sb.from('sessions').select('*').eq('id',id).single();
  if(!s)return;
  editingSessionId=id;
  document.getElementById('ns-title').textContent='Sessie Bewerken';
  document.getElementById('ns-name').value=s.name||'';
  document.getElementById('ns-date').value=s.session_date||'';
  document.getElementById('ns-loc').value=s.location||'';
  document.getElementById('ns-summary').value=s.summary||'';
  document.getElementById('ns-dmnotes').value=s.dm_notes||'';
  document.getElementById('ns-status').value=s.status||'planned';
  document.getElementById('ns-err').textContent='';
  const{data:parts}=await sb.from('session_participants').select('character_id').eq('session_id',id);
  await loadParticipantsPicker((parts||[]).map(p=>p.character_id));
  openM('ns-modal');
}

async function deleteSession(id){
  if(!CU.is_dm)return;
  if(!confirm('Deze sessie en ALLE bijhorende logs permanent verwijderen?'))return;
  await sb.from('session_logs').delete().eq('session_id',id);
  await sb.from('session_participants').delete().eq('session_id',id);
  await sb.from('sessions').delete().eq('id',id);
  closeM('sd-modal');toast('✓ Sessie verwijderd');loadSessions();
}

async function openSessionLog(sessionId,characterId,characterName){
  let{data:log}=await sb.from('session_logs').select('*').eq('session_id',sessionId).eq('character_id',characterId).maybeSingle();
  if(!log){
    const ins=await sb.from('session_logs').insert({session_id:sessionId,character_id:characterId}).select().single();
    log=ins.data;
  }
  currentLogEntry={sessionId,characterId,logId:log.id};
  const isDM=CU.is_dm;
  document.getElementById('slog-title').textContent=`Logboek — ${characterName}`;
  document.getElementById('slog-body').innerHTML=`
    <p style="font-size:13px;color:var(--ink3);margin-bottom:10px;font-style:italic;">Vul aan wat nuttig is voor de volgende sessie: tegen wie je vocht, wie je sprak, wat je vond, belangrijke momenten.</p>
    <div class="fg"><label>⚔ Ontmoetingen & gevechten</label><textarea id="slog-enc" rows="3" style="width:100%;padding:8px;border:1.5px solid var(--card-border);border-radius:4px;">${log.encounters||''}</textarea></div>
    <div class="fg"><label>💬 NPCs & gesprekken</label><textarea id="slog-npc" rows="3" style="width:100%;padding:8px;border:1.5px solid var(--card-border);border-radius:4px;">${log.npcs_met||''}</textarea></div>
    <div class="fg"><label>💰 Loot & vondsten</label><textarea id="slog-loot" rows="2" style="width:100%;padding:8px;border:1.5px solid var(--card-border);border-radius:4px;">${log.loot_found||''}</textarea></div>
    <div class="fg"><label>📝 Algemene notities</label><textarea id="slog-notes" rows="4" style="width:100%;padding:8px;border:1.5px solid var(--card-border);border-radius:4px;">${log.player_notes||''}</textarea></div>
    ${isDM?`<div class="fg"><label>🔒 DM-notities <small>(onzichtbaar voor speler)</small></label><textarea id="slog-dm" rows="3" style="width:100%;padding:8px;border:1.5px solid var(--dm-border);border-radius:4px;background:#f0e8f8;">${log.dm_notes||''}</textarea></div>`:''}
    <div class="err" id="slog-err"></div>
    <div style="text-align:right;margin-top:12px;">
      <button class="btn btn-ghost btn-sm" onclick="closeM('slog-modal')">Annuleren</button>
      <button class="btn btn-primary btn-sm" onclick="saveSessionLog()">✓ Opslaan</button>
    </div>`;
  openM('slog-modal');
}

async function saveSessionLog(){
  if(!currentLogEntry)return;
  const upd={
    encounters:document.getElementById('slog-enc').value,
    npcs_met:document.getElementById('slog-npc').value,
    loot_found:document.getElementById('slog-loot').value,
    player_notes:document.getElementById('slog-notes').value,
    updated_at:new Date().toISOString()
  };
  const dmEl=document.getElementById('slog-dm');
  if(dmEl)upd.dm_notes=dmEl.value;
  const{error}=await sb.from('session_logs').update(upd).eq('id',currentLogEntry.logId);
  if(error){document.getElementById('slog-err').textContent='Fout: '+error.message;return;}
  toast('✓ Logboek opgeslagen');closeM('slog-modal');
  openSession(currentLogEntry.sessionId);
}

async function openAwardXp(sessionId,characterId,characterName,currentXpAwarded){
  if(!CU.is_dm)return;
  document.getElementById('xp-body').innerHTML=`
    <p style="font-size:13px;color:var(--ink3);margin-bottom:10px;">Toekenning wordt direct aan het karakter''s totale XP toegevoegd én in het sessielogboek bijgehouden.</p>
    <div class="fg"><label>Karakter</label><input type="text" disabled value="${characterName.replace(/"/g,'&quot;')}"></div>
    <div class="fg"><label>XP deze sessie</label><input type="number" id="xp-amount" value="${currentXpAwarded||0}" min="0"></div>
    <div class="fg"><label>Reden / beschrijving <small>(komt in karakter-logboek)</small></label><input type="text" id="xp-reason" placeholder="bv. Sessie 3: hydra verslagen"></div>
    <div class="err" id="xp-err"></div>
    <div style="text-align:right;margin-top:10px;">
      <button class="btn btn-ghost btn-sm" onclick="closeM('xp-modal')">Annuleren</button>
      <button class="btn btn-primary btn-sm" onclick="confirmAwardXp('${sessionId}','${characterId}',${currentXpAwarded||0})">✓ Toekennen</button>
    </div>`;
  openM('xp-modal');
}

async function confirmAwardXp(sessionId,characterId,oldAwarded){
  const newAwarded=parseInt(document.getElementById('xp-amount').value)||0;
  const reason=document.getElementById('xp-reason').value.trim();
  const delta=newAwarded-oldAwarded;
  // update participant record
  await sb.from('session_participants').update({xp_awarded:newAwarded}).eq('session_id',sessionId).eq('character_id',characterId);
  // update character total xp (delta)
  if(delta!==0){
    const{data:c}=await sb.from('characters').select('xp').eq('id',characterId).single();
    const newTotal=(c?.xp||0)+delta;
    await sb.from('characters').update({xp:newTotal}).eq('id',characterId);
    await logChange(characterId,`Sessie-XP: ${delta>0?'+':''}${delta}${reason?' ('+reason+')':''}`,'xp',c?.xp||0,newTotal);
  }
  // recalc session total
  const{data:allParts}=await sb.from('session_participants').select('xp_awarded').eq('session_id',sessionId);
  const total=(allParts||[]).reduce((a,p)=>a+(p.xp_awarded||0),0);
  await sb.from('sessions').update({xp_awarded_total:total,updated_at:new Date().toISOString()}).eq('id',sessionId);
  closeM('xp-modal');toast('✓ XP bijgewerkt');
  openSession(sessionId);
}

// Show DM's "+ Nieuwe sessie" button when DM logs in — patch doLogin flow via CSS class already on button.
document.addEventListener('DOMContentLoaded',()=>{
  // After login, dm-only elements get display:block via existing code. Nothing extra needed.
});

// =====================================================================
// FEATURE OVERVIEW
// =====================================================================
function showFeatureOverview(){
  const isDM=CU?.is_dm;
  const playerFeat=`
    <h3 style="font-family:'Cinzel',serif;color:var(--rust);margin:0 0 10px;">Voor spelers</h3>
    <table style="width:100%;font-size:13px;border-collapse:collapse;">
      <thead><tr><th style="text-align:left;padding:6px;border-bottom:1px solid var(--divider);font-family:'Cinzel',serif;font-size:11px;color:var(--ink3);">Feature</th><th style="text-align:left;padding:6px;border-bottom:1px solid var(--divider);font-family:'Cinzel',serif;font-size:11px;color:var(--ink3);">Wat het doet</th></tr></thead>
      <tbody>
        <tr><td style="padding:6px;"><strong>+ Nieuw Karakter</strong></td><td style="padding:6px;">Ras + klasse + gezindheid aanmaken met AD&D regels</td></tr>
        <tr><td style="padding:6px;"><strong>📷 Scan karakterblad</strong></td><td style="padding:6px;">Foto van handgeschreven blad → automatisch ingelezen (vereist Netlify)</td></tr>
        <tr><td style="padding:6px;"><strong>Click-to-edit</strong></td><td style="padding:6px;">Elke waarde met stippellijn: klik, typ, auto-opslaan</td></tr>
        <tr><td style="padding:6px;"><strong>📷 Profielfoto</strong></td><td style="padding:6px;">Upload afbeelding van je karakter (max 2MB)</td></tr>
        <tr><td style="padding:6px;"><strong>Wapens / Items / Skills / Spells</strong></td><td style="padding:6px;">Toevoegen met zoekmodal tegen Greyhawk-encyclopedie</td></tr>
        <tr><td style="padding:6px;"><strong>📋 Logboek</strong></td><td style="padding:6px;">Bij login automatisch notificatie wat DM wijzigde</td></tr>
        <tr><td style="padding:6px;"><strong>📅 Sessies</strong></td><td style="padding:6px;">Per sessie eigen log (ontmoetingen, NPCs, loot, notities)</td></tr>
        <tr><td style="padding:6px;"><strong>📚 Encyclopedie</strong></td><td style="padding:6px;">750+ items met uitgebreide beschrijvingen</td></tr>
        <tr><td style="padding:6px;"><strong>📄 PDF karakterblad</strong></td><td style="padding:6px;">Volledig printbaar of opslaan als PDF</td></tr>
        <tr><td style="padding:6px;"><strong>📤 Export</strong></td><td style="padding:6px;">Karakter / sessies / encyclopedie als CSV, JSON, MD of PDF</td></tr>
        <tr><td style="padding:6px;"><strong>🔑 Wachtwoord</strong></td><td style="padding:6px;">Zelf wijzigen, of door DM resetten</td></tr>
      </tbody>
    </table>`;
  const dmFeat=`
    <h3 style="font-family:'Cinzel',serif;color:var(--dm-text);margin:16px 0 10px;">Extra voor de DM</h3>
    <table style="width:100%;font-size:13px;border-collapse:collapse;background:rgba(42,26,74,.04);">
      <thead><tr><th style="text-align:left;padding:6px;border-bottom:1px solid var(--divider);font-family:'Cinzel',serif;font-size:11px;color:var(--ink3);">Feature</th><th style="text-align:left;padding:6px;border-bottom:1px solid var(--divider);font-family:'Cinzel',serif;font-size:11px;color:var(--ink3);">Wat het doet</th></tr></thead>
      <tbody>
        <tr><td style="padding:6px;"><strong>DM Dashboard</strong></td><td style="padding:6px;">Alle karakters van alle spelers in één overzicht</td></tr>
        <tr><td style="padding:6px;"><strong>🔒 Privé Notities</strong></td><td style="padding:6px;">Per karakter — onzichtbaar voor speler</td></tr>
        <tr><td style="padding:6px;"><strong>🔒 Sessie-aantekeningen</strong></td><td style="padding:6px;">Voor XP-planning — onzichtbaar voor speler</td></tr>
        <tr><td style="padding:6px;"><strong>Alle karakters bewerken</strong></td><td style="padding:6px;">Volledige toegang incl. verwijderen, inactief zetten</td></tr>
        <tr><td style="padding:6px;"><strong>+ Nieuwe sessie</strong></td><td style="padding:6px;">Deelnemers kiezen, datum, locatie, summary, DM-only notities</td></tr>
        <tr><td style="padding:6px;"><strong>⭐ XP toekennen</strong></td><td style="padding:6px;">Per speler per sessie — updatet karakter.xp + logt transparant</td></tr>
        <tr><td style="padding:6px;"><strong>🔒 Per-sessie DM-notities</strong></td><td style="padding:6px;">Per speler per sessie een privé veld</td></tr>
        <tr><td style="padding:6px;"><strong>✏ Encyclopedie bewerken</strong></td><td style="padding:6px;">Elke entry bewerken/verwijderen; + toevoegen onderaan</td></tr>
        <tr><td style="padding:6px;"><strong>📥 Bulk import</strong></td><td style="padding:6px;">CSV, JSON of Markdown — honderden entries tegelijk</td></tr>
        <tr><td style="padding:6px;"><strong>🔑 Wachtwoord reset</strong></td><td style="padding:6px;">Tijdelijk wachtwoord voor speler die zijn wachtwoord vergat</td></tr>
        <tr><td style="padding:6px;"><strong>🔒 Veiligheidsvraag</strong></td><td style="padding:6px;">DM-only bij registratie</td></tr>
      </tbody>
    </table>`;
  const techFeat=`
    <h3 style="font-family:'Cinzel',serif;color:var(--ink3);margin:16px 0 10px;">Technisch</h3>
    <div style="font-size:13px;background:rgba(196,160,96,.08);padding:10px;border-radius:4px;">
      Gratis Supabase PostgreSQL · GitHub Pages / Netlify hosting · Geen build step · Eén gedeelde database voor hele groep · Open source MIT · <a href="https://shiftedmake.com" target="_blank" style="color:var(--blue2);">shiftedmake.com</a>
    </div>`;
  document.getElementById('feat-body').innerHTML=playerFeat+(isDM?dmFeat:'')+techFeat;
  openM('feat-modal');
}

// =====================================================================
// UNIVERSELE EXPORT (CSV / JSON / MD / PDF) — encyclopedie, karakter, sessie
// =====================================================================
function csvEscape(v){if(v==null)return '';const s=String(v);return /[",\n]/.test(s)?'"'+s.replace(/"/g,'""')+'"':s;}
function rowsToCsv(rows){if(!rows.length)return '';const keys=Object.keys(rows[0]);return keys.join(',')+'\n'+rows.map(r=>keys.map(k=>csvEscape(r[k])).join(',')).join('\n');}
function rowsToJson(rows){return JSON.stringify(rows,null,2);}
function rowsToMd(rows,title){
  if(!rows.length)return '_Geen data._';
  const keys=Object.keys(rows[0]);
  let out=title?`# ${title}\n\n`:'';
  out+='| '+keys.join(' | ')+' |\n';
  out+='|'+keys.map(()=>'---').join('|')+'|\n';
  rows.forEach(r=>{out+='| '+keys.map(k=>String(r[k]==null?'':r[k]).replace(/\|/g,'\\|').replace(/\n/g,' ')).join(' | ')+' |\n';});
  return out;
}
function downloadBlob(name,mime,content){
  const blob=new Blob([content],{type:mime});const url=URL.createObjectURL(blob);
  const a=document.createElement('a');a.href=url;a.download=name;document.body.appendChild(a);a.click();a.remove();
  setTimeout(()=>URL.revokeObjectURL(url),1000);
}

async function openExportModal(scope){
  let html='';
  if(scope==='encyclopedia'){
    const t=encCurrentTable||'weapons';
    html=`<p style="font-size:13px;color:var(--ink3);margin-bottom:10px;">Exporteer de volledige <strong>${t}</strong> tabel van de encyclopedie.</p>
      <div class="fg"><label>Formaat</label><select id="exp-fmt">
        <option value="csv">CSV (Excel/spreadsheets)</option>
        <option value="json">JSON (AI / scripts)</option>
        <option value="md">Markdown (documentatie)</option>
        <option value="pdf">PDF (afdrukbare referentiegids)</option>
      </select></div>
      <div style="text-align:right;margin-top:12px;">
        <button class="btn btn-ghost btn-sm" onclick="closeM('exp-modal')">Annuleren</button>
        <button class="btn btn-primary btn-sm" onclick="doExport('enc','${t}')">📤 Downloaden</button>
      </div>`;
  }else if(scope==='character'){
    html=`<p style="font-size:13px;color:var(--ink3);margin-bottom:10px;">Exporteer <strong>${CC?.name||'dit karakter'}</strong> inclusief wapens, items, skills, spells en logboek.</p>
      <div class="fg"><label>Formaat</label><select id="exp-fmt">
        <option value="json">JSON (volledig, backup-waardig)</option>
        <option value="md">Markdown (leesbaar dossier)</option>
        <option value="pdf">PDF (karakterblad)</option>
      </select></div>
      <div style="text-align:right;margin-top:12px;">
        <button class="btn btn-ghost btn-sm" onclick="closeM('exp-modal')">Annuleren</button>
        <button class="btn btn-primary btn-sm" onclick="doExport('character','${CC?.id}')">📤 Downloaden</button>
      </div>`;
  }else if(scope==='session'){
    html=`<p style="font-size:13px;color:var(--ink3);margin-bottom:10px;">Exporteer deze sessie met alle deelnemers en hun logs.</p>
      <div class="fg"><label>Formaat</label><select id="exp-fmt">
        <option value="json">JSON</option>
        <option value="md">Markdown (sessieverslag)</option>
        <option value="pdf">PDF (afdrukbaar)</option>
      </select></div>
      <div style="text-align:right;margin-top:12px;">
        <button class="btn btn-ghost btn-sm" onclick="closeM('exp-modal')">Annuleren</button>
        <button class="btn btn-primary btn-sm" onclick="doExport('session','${currentSession?.id}')">📤 Downloaden</button>
      </div>`;
  }
  document.getElementById('exp-body').innerHTML=html;
  openM('exp-modal');
}

async function doExport(scope,id){
  const fmt=document.getElementById('exp-fmt').value;
  if(scope==='enc'){
    const{data}=await sb.from(id).select('*').order('name');
    const rows=data||[];
    const base='greyhawk_'+id+'_'+new Date().toISOString().substring(0,10);
    if(fmt==='csv')downloadBlob(base+'.csv','text/csv',rowsToCsv(rows));
    else if(fmt==='json')downloadBlob(base+'.json','application/json',rowsToJson(rows));
    else if(fmt==='md')downloadBlob(base+'.md','text/markdown',rowsToMd(rows,'Greyhawk — '+id));
    else if(fmt==='pdf')exportEncPdf(id,rows);
  }else if(scope==='character'){
    const{data:c}=await sb.from('characters').select('*').eq('id',id).single();
    const[{data:w},{data:it},{data:sk},{data:sp},{data:lg}]=await Promise.all([
      sb.from('character_weapons').select('*').eq('character_id',id),
      sb.from('character_items').select('*').eq('character_id',id),
      sb.from('character_skills').select('*').eq('character_id',id),
      sb.from('character_spells').select('*').eq('character_id',id),
      sb.from('character_log').select('*').eq('character_id',id).order('created_at',{ascending:false}).limit(200),
    ]);
    const pkg={character:c,weapons:w||[],items:it||[],skills:sk||[],spells:sp||[],log:lg||[]};
    const base=(c.name||'karakter').replace(/[^a-z0-9]/gi,'_')+'_'+new Date().toISOString().substring(0,10);
    if(fmt==='json')downloadBlob(base+'.json','application/json',JSON.stringify(pkg,null,2));
    else if(fmt==='md')downloadBlob(base+'.md','text/markdown',characterToMd(pkg));
    else if(fmt==='pdf'){closeM('exp-modal');exportPDF();return;}
  }else if(scope==='session'){
    const{data:s}=await sb.from('sessions').select('*').eq('id',id).single();
    const{data:parts}=await sb.from('session_participants').select('*,characters(name,race,class,player_name)').eq('session_id',id);
    const{data:logs}=await sb.from('session_logs').select('*,characters(name)').eq('session_id',id);
    const pkg={session:s,participants:parts||[],logs:logs||[]};
    const base='sessie_'+(s.name||'').replace(/[^a-z0-9]/gi,'_')+'_'+new Date().toISOString().substring(0,10);
    if(fmt==='json')downloadBlob(base+'.json','application/json',JSON.stringify(pkg,null,2));
    else if(fmt==='md')downloadBlob(base+'.md','text/markdown',sessionToMd(pkg));
    else if(fmt==='pdf')exportSessionPdf(pkg);
  }
  closeM('exp-modal');toast('✓ Gedownload');
}

function characterToMd(p){
  const c=p.character;
  let m=`# ${c.name}\n\n`;
  m+=`**${c.race||''} ${c.class||''}** · Level ${c.level||1} · ${c.alignment||''}\n\n`;
  m+=`## Vitalen\n- HP: ${c.hp_current||0}/${c.hp_max||0}\n- AC: ${c.ac||'—'}\n- THAC0: ${c.thac0||'—'}\n- XP: ${c.xp||0}${c.xp_next?' / '+c.xp_next:''}\n\n`;
  m+=`## Ability Scores\n| STR | DEX | INT | WIS | CON | CHA |\n|---|---|---|---|---|---|\n| ${c.str||'—'} | ${c.dex||'—'} | ${c.int||'—'} | ${c.wis||'—'} | ${c.con||'—'} | ${c.cha||'—'} |\n\n`;
  m+=`## Saves\n| Paralyz/Death | Rod/Staff/Wand | Pet./Polym. | Breath | Spell | Poison |\n|---|---|---|---|---|---|\n| ${c.sv_pd||'—'} | ${c.sv_rsw||'—'} | ${c.sv_pp||'—'} | ${c.sv_bw||'—'} | ${c.sv_spell||'—'} | ${c.sv_poison||'—'} |\n\n`;
  m+=`## Geld\nPP ${c.pp||0} · GP ${c.gp||0} · SP ${c.sp||0} · CP ${c.cp||0}\n\n`;
  if(p.weapons.length){m+=`## Wapens\n`;p.weapons.forEach(w=>{m+=`- **${w.weapon_name}** — ${w.damage||'—'} (SF ${w.speed_factor||'—'}, ${w.attacks_per_round||'1/1'})${w.notes?' — '+w.notes:''}\n`;});m+='\n';}
  if(p.items.length){m+=`## Items\n`;p.items.forEach(i=>{m+=`- ${i.item_name}${i.quantity>1?` (${i.quantity}×)`:''}${i.category?' — '+i.category:''}${i.notes?' — '+i.notes:''}\n`;});m+='\n';}
  if(p.skills.length){m+=`## Vaardigheden\n`;p.skills.forEach(s=>{m+=`- ${s.skill_name} (${s.skill_type||''})${s.stat_modifier?' — '+s.stat_modifier:''}\n`;});m+='\n';}
  if(p.spells.length){m+=`## Spreuken\n`;p.spells.forEach(s=>{m+=`- ${s.spell_name} — Lv.${s.spell_level||'?'} ${s.spell_class||''}${s.prepared?' **(bereid)**':''}\n`;});m+='\n';}
  if(c.notes){m+=`## Notities\n${c.notes}\n\n`;}
  if(p.log&&p.log.length){m+=`## Logboek (laatste ${p.log.length})\n`;p.log.slice(0,30).forEach(l=>{m+=`- ${new Date(l.created_at).toLocaleString('nl-BE')} · ${l.username}${l.is_dm?' [DM]':''}: ${l.beschrijving}\n`;});}
  return m;
}

function sessionToMd(p){
  const s=p.session;
  let m=`# ${s.name}\n\n`;
  m+=`**Datum:** ${s.session_date||'—'} · **Locatie:** ${s.location||'—'} · **Status:** ${s.status}\n\n`;
  if(s.summary){m+=`## Samenvatting\n${s.summary}\n\n`;}
  m+=`## Deelnemers (${p.participants.length})\n`;
  p.participants.forEach(pt=>{const c=pt.characters||{};m+=`- **${c.name||'?'}** (${c.race||''} ${c.class||''}) ${pt.xp_awarded?`— ⭐ ${pt.xp_awarded} XP`:''}\n`;});
  m+='\n';
  m+=`## Logs per karakter\n\n`;
  p.logs.forEach(l=>{
    const c=l.characters||{};
    m+=`### ${c.name||'?'}\n`;
    if(l.encounters)m+=`**⚔ Ontmoetingen:** ${l.encounters}\n\n`;
    if(l.npcs_met)m+=`**💬 NPCs:** ${l.npcs_met}\n\n`;
    if(l.loot_found)m+=`**💰 Loot:** ${l.loot_found}\n\n`;
    if(l.player_notes)m+=`**📝 Notities:** ${l.player_notes}\n\n`;
  });
  return m;
}

function exportEncPdf(table,rows){
  const w=window.open('','_blank');
  const cols=Object.keys(rows[0]||{}).filter(k=>k!=='id'&&k!=='source');
  w.document.write(`<!DOCTYPE html><html><head><meta charset="UTF-8"><title>Greyhawk — ${table}</title>
  <style>body{font-family:Georgia,serif;max-width:900px;margin:20px auto;padding:20px;font-size:11px;color:#2a1a0a;}
  h1{font-size:22px;text-align:center;border-bottom:3px double #8a6030;padding-bottom:8px;margin-bottom:12px;}
  .entry{margin-bottom:10px;padding:8px;border:1px solid #c4a060;border-radius:3px;page-break-inside:avoid;}
  .entry h2{font-size:14px;color:#7a1c1c;margin-bottom:4px;}
  .meta{font-size:10px;color:#7a5030;margin-bottom:4px;}
  .desc{font-size:11px;line-height:1.4;}
  @media print{.noprint{display:none}}</style></head><body>
  <button class="noprint" onclick="window.print()" style="padding:8px 18px;background:#7a1c1c;color:white;border:none;border-radius:3px;cursor:pointer;margin-bottom:12px;">🖨️ Afdrukken / PDF</button>
  <h1>Greyhawk Referentie — ${table}</h1>`);
  rows.forEach(r=>{
    const desc=r.description||'';
    const metaPairs=cols.filter(c=>c!=='name'&&c!=='description').map(c=>r[c]?`<strong>${c}:</strong> ${r[c]}`:'').filter(Boolean).join(' · ');
    w.document.write(`<div class="entry"><h2>${r.name||'?'}</h2>${metaPairs?`<div class="meta">${metaPairs}</div>`:''}${desc?`<div class="desc">${desc}</div>`:''}</div>`);
  });
  w.document.write(`</body></html>`);w.document.close();
}

function exportSessionPdf(p){
  const s=p.session;
  const w=window.open('','_blank');
  w.document.write(`<!DOCTYPE html><html><head><meta charset="UTF-8"><title>Sessie: ${s.name}</title>
  <style>body{font-family:Georgia,serif;max-width:820px;margin:20px auto;padding:20px;color:#2a1a0a;font-size:13px;}
  h1{font-size:24px;border-bottom:3px double #8a6030;padding-bottom:8px;}h2{font-size:16px;color:#7a1c1c;margin-top:18px;}h3{font-size:13px;color:#1a3a6a;margin-top:12px;}
  .meta{color:#7a5030;font-style:italic;margin-bottom:12px;}
  .log-entry{border:1px solid #c4a060;border-radius:3px;padding:10px;margin-bottom:10px;page-break-inside:avoid;}
  @media print{.noprint{display:none}}</style></head><body>
  <button class="noprint" onclick="window.print()" style="padding:8px 18px;background:#7a1c1c;color:white;border:none;border-radius:3px;cursor:pointer;margin-bottom:12px;">🖨️ Afdrukken / PDF</button>
  <h1>${s.name}</h1>
  <div class="meta">📅 ${s.session_date||'—'} · 📍 ${s.location||'—'} · Status: ${s.status}</div>`);
  if(s.summary)w.document.write(`<h2>Samenvatting</h2><p>${s.summary.replace(/\n/g,'<br>')}</p>`);
  w.document.write(`<h2>Deelnemers</h2><ul>`);
  p.participants.forEach(pt=>{const c=pt.characters||{};w.document.write(`<li><strong>${c.name||'?'}</strong> (${c.race||''} ${c.class||''})${pt.xp_awarded?' — ⭐ '+pt.xp_awarded+' XP':''}</li>`);});
  w.document.write(`</ul><h2>Logs per karakter</h2>`);
  p.logs.forEach(l=>{
    const c=l.characters||{};
    w.document.write(`<div class="log-entry"><h3>${c.name||'?'}</h3>`);
    if(l.encounters)w.document.write(`<p><strong>⚔ Ontmoetingen:</strong> ${l.encounters.replace(/\n/g,'<br>')}</p>`);
    if(l.npcs_met)w.document.write(`<p><strong>💬 NPCs:</strong> ${l.npcs_met.replace(/\n/g,'<br>')}</p>`);
    if(l.loot_found)w.document.write(`<p><strong>💰 Loot:</strong> ${l.loot_found.replace(/\n/g,'<br>')}</p>`);
    if(l.player_notes)w.document.write(`<p><strong>📝 Notities:</strong> ${l.player_notes.replace(/\n/g,'<br>')}</p>`);
    w.document.write(`</div>`);
  });
  w.document.write(`</body></html>`);w.document.close();
}

// =====================================================================
// UNIVERSELE IMPORT (CSV / JSON / MD)
// =====================================================================
function openImportModal(table){
  if(!CU?.is_dm){toast('Alleen voor DM',false);return;}
  document.getElementById('imp-table-name').textContent=table;
  document.getElementById('imp-file').value='';
  document.getElementById('imp-text').value='';
  document.getElementById('imp-err').textContent='';
  document.getElementById('imp-status').textContent='';
  document.getElementById('imp-format').value='csv';
  window._impTable=table;
  updateImportHint();
  openM('imp-modal');
}

function updateImportHint(){
  const t=window._impTable||'weapons';
  const fmt=document.getElementById('imp-format').value;
  const fields=(CSV_FIELDS[t]||['name','description']).join(', ');
  let hint='';
  if(fmt==='csv'){hint=`<strong>CSV</strong> — eerste rij = kolomnamen. Verwachte velden voor <strong>${t}</strong>: <code style="font-size:11px;">${fields}</code>. Tekst met komma's: tussen "…".`;}
  else if(fmt==='json'){hint=`<strong>JSON</strong> — array van objecten. Voorbeeld: <code style="font-size:11px;">[{"name":"...","description":"..."}]</code>. Velden voor <strong>${t}</strong>: <code style="font-size:11px;">${fields}</code>.`;}
  else if(fmt==='md'){hint=`<strong>Markdown-tabel</strong> — eerste regel headers, tweede regel \`|---|\` scheiders, daarna data. Velden voor <strong>${t}</strong>: <code style="font-size:11px;">${fields}</code>.`;}
  document.getElementById('imp-hint').innerHTML=hint;
}

function parseJsonInput(text){
  const data=JSON.parse(text);
  if(!Array.isArray(data))throw new Error('Verwacht JSON array van objecten.');
  return data;
}

function parseMdTable(text){
  const lines=text.split(/\r?\n/).filter(l=>l.trim().startsWith('|'));
  if(lines.length<3)throw new Error('Markdown tabel heeft header + separator + data nodig.');
  const parseRow=l=>l.trim().replace(/^\|/,'').replace(/\|$/,'').split('|').map(c=>c.trim().replace(/\\\|/g,'|'));
  const headers=parseRow(lines[0]).map(h=>h.toLowerCase());
  const rows=[];
  for(let i=2;i<lines.length;i++){
    const cells=parseRow(lines[i]);
    const obj={};headers.forEach((h,idx)=>{if(cells[idx]!==undefined&&cells[idx]!=='')obj[h]=cells[idx];});
    if(obj.name)rows.push(obj);
  }
  return rows;
}

async function doImport(){
  const t=window._impTable||'weapons';
  const fmt=document.getElementById('imp-format').value;
  let text=document.getElementById('imp-text').value;
  const f=document.getElementById('imp-file').files?.[0];
  if(f&&!text){text=await f.text();}
  if(!text){document.getElementById('imp-err').textContent='Geen inhoud.';return;}
  let records=[];
  try{
    if(fmt==='csv'){
      const rows=parseCSV(text);
      if(rows.length<2)throw new Error('CSV moet header + minstens 1 rij hebben.');
      const header=rows[0].map(h=>h.trim().toLowerCase());
      const allowed=new Set(CSV_FIELDS[t]||['name','description']);
      const numFields=new Set(CSV_NUMERIC[t]||[]);
      for(let i=1;i<rows.length;i++){
        const obj={source:'Import'};
        header.forEach((h,idx)=>{
          if(!allowed.has(h))return;
          let v=rows[i][idx]??'';v=String(v).trim();if(v==='')return;
          if(numFields.has(h)){const n=parseInt(v);if(!isNaN(n))obj[h]=n;}else obj[h]=v;
        });
        if(obj.name)records.push(obj);
      }
    }else if(fmt==='json'){records=parseJsonInput(text);}
    else if(fmt==='md'){records=parseMdTable(text);}
  }catch(e){document.getElementById('imp-err').textContent='Parse-fout: '+e.message;return;}
  // filter naar toegelaten velden
  const allowed=new Set([...(CSV_FIELDS[t]||['name','description']),'source']);
  const numFields=new Set(CSV_NUMERIC[t]||[]);
  records=records.map(r=>{
    const o={};Object.keys(r).forEach(k=>{
      const lk=k.toLowerCase();
      if(!allowed.has(lk))return;
      let v=r[k];
      if(numFields.has(lk)){v=parseInt(v);if(isNaN(v))return;}
      o[lk]=v;
    });
    if(!o.source)o.source='Import';
    return o;
  }).filter(r=>r.name);
  if(!records.length){document.getElementById('imp-err').textContent='Geen geldige rijen met "name" veld.';return;}
  document.getElementById('imp-status').textContent='Importeren van '+records.length+' rijen...';
  let ok=0;
  for(let i=0;i<records.length;i+=100){
    const chunk=records.slice(i,i+100);
    const{error}=await sb.from(t).insert(chunk);
    if(error){document.getElementById('imp-err').textContent='Fout: '+error.message;break;}
    ok+=chunk.length;
  }
  try{await sb.from('csv_imports').insert({table_name:t,imported_by:CU.id,row_count:ok});}catch(e){}
  document.getElementById('imp-status').textContent=`✓ ${ok} rijen geïmporteerd.`;
  toast(`✓ ${ok} rijen toegevoegd aan ${t}`);
  if(ok>0)loadEnc(t);
  setTimeout(()=>closeM('imp-modal'),1200);
}

// KEYBOARD
document.addEventListener('keydown',e=>{
  if(e.key==='Enter'&&document.getElementById('login-screen').style.display!=='none')doLogin();
  if(e.key==='Escape'){document.querySelectorAll('.modal-overlay.open,.tt-overlay.open').forEach(m=>m.classList.remove('open'));}
});

// INIT
updateClasses();
