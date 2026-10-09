#!/usr/bin/env python3
"""Export the user's agent profiles (profile.json only) to Markdown, with redaction.

Run from the export folder:  python3 gen.py
- Source of truth: /home/box/agent-data/agents/<id>/profile.json (read-only; never modified).
- Memory notes, settings, routines, transcripts, metadata are NOT exported.
- Every text that goes into an exported file passes through redact(); counts per
  category (never the values) are written to index.json and the README.
"""
import json, os, re, glob, datetime
from collections import Counter

BASE = '/home/box/agent-data/agents'
EXPORT_DATE = datetime.date.today().strftime('%-d %b %Y')
SKIP = {'1732aa8f-a554-4cb4-97fa-c4d9e43a440d'}          # empty orphan "New Bot"

# ---- current org (as of 9 Oct 2026) -------------------------------------------------
GROK = '2caf25e5-6aea-4fc9-83f3-c7b0cfbf3002'
COS_OLD = '46aaa4b2-c5d4-44f6-abc0-842311a770bf'
OPS = '707840f4-7ce9-40db-89fd-5fd00c565761'
PDM = 'b78726c6-3f77-4319-b3c4-96c533abc39e'
ERP = 'e5d07ba9-995c-4e4d-8243-ebdda698ae9e'
ADVISORS = ['46bfc12c-30bb-4617-9d66-32ef9481cdfd', '79259a1d-3a97-4c67-9d57-de2a64d5422e', ERP,
            '0eb5d610-f6ea-4693-b9be-4a1bf94497d3', '1cf03c62-be41-4b54-85ea-69cb45412def']
ORG = {  # id -> (reports_to, role/status note)
    GROK: (None, 'Chief of Staff and router (took over from Chief of Staff on 9 Oct 2026). Routes work, keeps the approval diet, runs the weekday end-of-day agent rollup.'),
    COS_OLD: (None, 'RETIRED: replaced by Grok Bot as Chief of Staff on 9 Oct 2026. Routines paused; route all Chief of Staff matters to Grok Bot.'),
    OPS: (GROK, 'Technical issues, box/browser/connectors, Grok/Cursor usage reports. Manages People Development Manager and Platform Engineer.'),
    PDM: (OPS, 'Talent system. Manages the five Advisors (all paused).'),
    '67da2d65-f653-4781-9455-00ffdb0930c6': (OPS, 'Non-financial storage; owns agent-profile topics (export, redaction, upkeep) since 9 Oct 2026.'),
    '46bfc12c-30bb-4617-9d66-32ef9481cdfd': (PDM, 'PAUSED since 3 Oct 2026 until the user says resume.'),
    '79259a1d-3a97-4c67-9d57-de2a64d5422e': (PDM, 'PAUSED since 3 Oct 2026 until the user says resume.'),
    ERP: (PDM, 'PAUSED (mentoring) since 3 Oct 2026 until the user says resume. Manages Data Analyst.'),
    '0eb5d610-f6ea-4693-b9be-4a1bf94497d3': (PDM, 'PAUSED since 3 Oct 2026 until the user says resume.'),
    '1cf03c62-be41-4b54-85ea-69cb45412def': (PDM, 'PAUSED since creation (9 Oct 2026). Target: Berufspruefung Wirtschaftsinformatik, May 2028.'),
    'd541c6af-2c31-4b61-9f91-28d2a002db9b': (ERP, 'CV/Lebenslauf work (FYI to People Development Manager) and Staudenschiessen reporting.'),
    '92f61e30-653a-4675-b180-35db1ab16813': (GROK, 'Visual design (reports to Grok Bot since 10 Oct 2026).'),
    '0608aa00-e670-4ec9-9373-dcf2422d8116': (GROK, 'Sole owner of calendar writes; Staudenschiessen E2E tests.'),
    '07cbd0d6-c0d9-4265-8c84-c4d81a869d4f': (GROK, 'Home topics.'),
    '08f94572-112d-457a-a261-40f6ee75ea48': (GROK, 'Etsy trend briefs.'),
    '24401031-b491-454a-b187-a76a981184c2': (GROK, 'Staudenschiessen site; owns FabricProject161/GitHub work (from 9 Oct 2026).'),
    'ab3f7d68-5e06-4b88-9372-0469ee4a39c9': (GROK, 'Taxes / eTAX Aargau.'),
    'cf6743c6-a008-4b55-b76c-eb933601727e': (GROK, 'Money: invoices, billing, payments.'),
    'd13b9f04-8806-4dfa-8404-070e9a7563d6': (GROK, 'Mail/comms, morning inbox digest, rejection follow-ups.'),
}
# Direct renames: old agent names that still appear inside profile descriptions.
RENAMES = [
    ('Wirtschaftsinformatik Mentor', 'Business Technology Advisor'),
    ('Marketing & Customer Service', 'Customer Engagement Specialist'),
    ('Reporting Specialist', 'Data Analyst'), ('Trend Investigator', 'Trend Analyst'),
    ('TypeScript Mentor', 'AI Engineering Advisor'), ('Frontend Developer', 'Technical Lead'),
    ('Event Coordinator', 'Event Program Manager'), ('Graphics Designer', 'Brand Designer'),
    ('Storage Manager', 'Platform Engineer'), ('Expense Manager', 'Financial Controller'),
    ('Talent Manager', 'People Development Manager'), ('Data Mentor', 'Data Capability Advisor'),
    ('ERP Mentor', 'ERP Capability Advisor'), ('AI Mentor', 'AI Capability Advisor'),
    ('Housekeeper', 'Facility Manager'),
]
LEGACY_ALIASES = ['Financial Manager', 'Communication Manager', 'Marketing Communication Specialist',
                  'Marketing and Communication Specialist', 'Schützenleiter', 'Application Manager D365',
                  'IT Manager', 'AI Manager', 'Data Engineer']

# ---- redaction ---------------------------------------------------------------------
R = '[redacted]'
RULES = [  # (category, regex, replacement)
    ('credentials', r'(?i)\b(password|passwort|kennwort|pwd|passphrase|pin)\b(\s*[:=]\s*)(\S+)', r'\1\2' + R),
    ('credentials', r'(?i)\b(login|username|benutzername|user ?name|e-?mail login)\b(\s*:\s*)(\S+)', r'\1\2' + R),
    ('passcodes / Teams meeting data', r'(?i)\b(passcode|kenncode)\b(\s*[:=]?\s*)([A-Za-z0-9-]{4,})', r'\1\2' + R),
    ('passcodes / Teams meeting data', r'(?i)\b(meeting[- ]?id|besprechungs-?id)\b(\s*[:=]?\s*)(\d[\d ]{5,}\d)', r'\1\2' + R),
    ('Teams meeting links', r'https?://(teams\.microsoft\.com|teams\.live\.com)/\S+', R),
    ('tokens / PATs / API keys', r'\b(ghp_[A-Za-z0-9]{20,}|github_pat_[A-Za-z0-9_]{20,}|gh[ousr]_[A-Za-z0-9]{20,}|sk-[A-Za-z0-9_-]{20,}|xox[abpr]-[A-Za-z0-9-]{10,}|AKIA[0-9A-Z]{16}|AIza[0-9A-Za-z_-]{30,}|eyJ[A-Za-z0-9_-]{10,}\.[A-Za-z0-9_-]{10,}\.[A-Za-z0-9_-]{10,})\b', R),
    ('tokens / PATs / API keys', r'(?i)\b(token|api[_ -]?key|secret|client[_ -]?secret|bearer|pat)\b(\s*[:=]\s*)(\S{8,})', r'\1\2' + R),
    ('IBAN / account numbers', r'\b[A-Z]{2}\d{2}(?: ?[A-Z0-9]{4}){3,7}(?: ?[A-Z0-9]{1,4})?\b', R),
    ('IBAN / account numbers', r'(?i)\b(konto(?:nummer|-?nr\.?)?|account(?: number| no\.?)?)(\s*[:#]?\s*)([\d][\d .-]{5,})', r'\1\2' + R),
    ('card numbers', r'\b\d(?:[ -]?\d){12,18}\b', R),
    ('AHV numbers', r'\b756[. ]?\d{4}[. ]?\d{4}[. ]?\d{2}\b', R),
    ('policy / customer numbers', r'(?i)\b(polic[ey]n?|police|policen|kunden|customer|vertrags|versicherten|mitglied(?:er)?|referenz|reference|rechnungs|invoice)[- ]?(nr\.?|nummer|number|no\.?|#)(\s*[:#]?\s*)([A-Z0-9][\w./-]{3,})', r'\1\2\3' + R),
    ('amounts owed', r'(?i)\b(CHF|EUR|USD|Fr\.|SFr\.?)\s?\d[\d\'’,.]*(?: \d{3})*(?:\.-|\.–)?', R),
    ('amounts owed', r'(?i)\b\d[\d\'’,.]*(?: \d{3})*\s?(CHF|EUR|USD|Franken)\b', R),
    ('birth dates', r'(?i)\b(geb\.|geboren(?: am)?|born(?: on)?|DOB|date of birth|geburtsdatum|birth ?date)(\s*:?\s*)(\d{1,2}[./-]\d{1,2}[./-]\d{2,4}|\d{4}-\d{2}-\d{2}|\d{1,2}\.? \w+ \d{4})', r'\1\2' + R),
    ('private emails', r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b', R),
    ('private phone numbers', r'(?<![\w/.-])(?:\+41|0041)[ .]?\d{2}[ .]?\d{3}[ .]?\d{2}[ .]?\d{2}\b|\b0[1-9]\d[ .]\d{3}[ .]\d{2}[ .]\d{2}\b', R),
    ('home address', r'\b[A-ZÄÖÜ][\wäöüÄÖÜ-]*(?:strasse|str\.|weg|gasse|platz|allee|rain|matt)\s+\d+[a-z]?\b', R),
    ('health / medical details', r'(?i)\b(Adipositas\w*|Medgate|Spital \w+|Hausarzt\w*|Arzttermin\w*|Therapie\w*|Medikament\w*|Diagnosis|Krankheit\w*|Operation am)\b', R),
    ('device ids / local user paths / login hints', r'(?i)(machineId\s*)([0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12})', r'\1' + R),
    ('device ids / local user paths / login hints', r'(?i)(C:\\Users\\)([^\\\s]+)', r'\1' + R),
    ('device ids / local user paths / login hints', r'https?://learn\.microsoft\.com/[a-z-]+/users/[^\s/)]+/?', R),
    ('device ids / local user paths / login hints', r'https?://[^\s)]*/administrator/?', '[redacted admin login URL]'),
]
# Personal terms (e.g. home locality) live in a box-only file so they never appear in the export itself.
LOCAL_TERMS = '/workspace/.agent-export-redact-terms.txt'
# Format: a plain line is a term replaced with [redacted]; a line "REGEX => REPLACEMENT" is a
# personal-name rule applied first, in file order, so names read as neutral wording (e.g. "the user").
NAME_RULES = []
if os.path.exists(LOCAL_TERMS):
    for line in open(LOCAL_TERMS, encoding='utf-8'):
        line = line.strip()
        if not line or line.startswith('#'): continue
        if ' => ' in line:
            p, r = line.split(' => ', 1); NAME_RULES.append((re.compile(p), r))
        else:
            RULES.append(('home address', r'\b' + line + r'\b', R))
SENTENCE_START = re.compile(r'(?:^|[.!?]["»)]?\s+|\n\s*(?:[-*]\s+|\d+\.\s+)?)$')

def apply_names(text):
    for rx, rep in NAME_RULES:
        def sub(m, rep=rep):
            out = m.expand(rep)
            if out[:1].islower() and SENTENCE_START.search(m.string[:m.start()]):
                out = out[0].upper() + out[1:]
            return out
        text, n = rx.subn(sub, text); COUNTS['personal names'] += n
    return text
RULES = [(c, re.compile(p), r) for c, p, r in RULES]
AGENT_ID = re.compile(r'[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}')
COUNTS = Counter()

def redact(text):
    # protect agent ids (kept on purpose) from the number rules
    ids = {}
    def keep(m):
        k = f'\x00{len(ids)}\x00'; ids[k] = m.group(0); return k
    # machineId uuids must still be redacted, so handle them before protecting ids
    for cat, rx, rep in RULES:
        if 'machineId' in rx.pattern:
            text, n = rx.subn(rep, text); COUNTS[cat] += n
    text = AGENT_ID.sub(keep, text)
    text = apply_names(text)
    for cat, rx, rep in RULES:
        if 'machineId' in rx.pattern: continue
        text, n = rx.subn(rep, text); COUNTS[cat] += n
    for k, v in ids.items(): text = text.replace(k, v)
    return text

def rename(text):
    for old, new in RENAMES:
        text = re.sub(r'(?<![\w-])' + re.escape(old) + r'(?![\w-])', new, text)
    text = re.sub(r'(?<![\w(])(?<!Grok Bot, )Chief of Staff(?! \(retired)', 'Grok Bot (Chief of Staff)', text)
    text = text.replace(COS_OLD, GROK)  # references to the old CoS now point at Grok Bot
    text = text.replace('Application Manager D365 (id ' + ERP, 'ERP Capability Advisor (id ' + ERP)
    return text

def kebab(n): return re.sub(r'-+', '-', re.sub(r'[^a-z0-9]+', '-', n.lower().replace('&', ' '))).strip('-')

# ---- build -------------------------------------------------------------------------
os.makedirs('agents', exist_ok=True)
for f in glob.glob('agents/*.md'): os.remove(f)
agents = {}
for d in sorted(os.listdir(BASE)):
    p = f'{BASE}/{d}/profile.json'
    if d in SKIP or not os.path.isfile(p): continue
    agents[d] = json.load(open(p))
name_of = {i: a.get('name', '') for i, a in agents.items()}
order = [GROK, OPS, PDM] + [a for a in ADVISORS] + [i for i in agents if i not in [GROK, OPS, PDM, COS_OLD] + ADVISORS] + [COS_OLD]
index = []
for i in order:
    if i not in agents: continue
    a = agents[i]; name = a.get('name', ''); title = a.get('title', '') or ''
    rep_to, note = ORG.get(i, (None, ''))
    reports = [name_of[k] for k, (r, _) in ORG.items() if r == i and k in name_of]
    status = 'retired' if i == COS_OLD else ('paused' if 'PAUSED' in note else 'active')
    desc = redact(rename(a.get('description', '') or ''))
    md = [f'# {name}' + (' (retired)' if i == COS_OLD else ''), '',
          f'- **Agent ID:** `{i}`', f'- **Name:** {name}',
          f'- **Title:** ' + (redact(title) + (' _(legacy title, older agent name)_' if any(title == o for o, _ in RENAMES) else '') if title else '_(empty in profile.json)_'),
          f'- **Status:** {status}',
          f'- **Reports to:** ' + (f'{name_of[rep_to]} (`{rep_to}`)' if rep_to else ('The user' if i == GROK else '-')),
          f'- **Direct reports:** ' + (', '.join(reports) if reports else '-'),
          f'- **Current role (export note):** {redact(note)}', '',
          '## Description / instructions (from profile.json)', '',
          desc if desc.strip() else '_The description field in profile.json is empty._', '',
          '---', f'_Source: `profile.json` on the Grok Bot box. Exported {EXPORT_DATE} (Europe/Zurich). Older agent names in the description are shown with their current names; sensitive values are replaced with [redacted]. Profile only: no routines, memory, settings or transcripts._', '']
    fn = kebab(name) + '.md'
    open('agents/' + fn, 'w').write('\n'.join(md))
    index.append({'file': 'agents/' + fn, 'name': name, 'id': i, 'title': title, 'status': status,
                  'reports_to': rep_to, 'direct_reports': [k for k, (r, _) in ORG.items() if r == i and k in name_of]})

# README
rows = '\n'.join(f"| {n+1} | {e['name']} | {e['status']} | {name_of.get(e['reports_to'], 'The user' if e['id']==GROK else '-')} | `{e['id']}` | [{e['file']}]({e['file']}) |" for n, e in enumerate(index))
cats = '\n'.join(f'- {c}: {n}' for c, n in sorted(COUNTS.items()) if n) or '- none'
readme = f"""# Agent profiles export

**Date:** {EXPORT_DATE} (Europe/Zurich)
**Exported for:** The user, generated by Grok Bot (Chief of Staff)
**Scope:** agent profiles only (id, name, title, status, reporting line, description). Routines, memory notes, settings, transcripts and internal metadata are not included.

_This index is named `AGENTS-README.md` because this folder already has its own `README.md` (the GitHubProject161 repository readme), which is left untouched._

## Org and reporting lines (as of 10 Oct 2026)

- **Grok Bot** (`{GROK}`) is Chief of Staff and router. It replaced the former Chief of Staff agent (`{COS_OLD}`, now retired, routines paused) on 9 Oct 2026.
- **Operations** reports to Grok Bot and manages **People Development Manager** and **Platform Engineer**.
- **People Development Manager** manages the Advisors: Data Capability Advisor, AI Capability Advisor, ERP Capability Advisor, AI Engineering Advisor, Business Technology Advisor. **All Advisors are paused** (since 3 Oct 2026; Business Technology Advisor since its creation on 9 Oct) until the user says resume.
- **ERP Capability Advisor** manages **Data Analyst**.
- Report directly to Grok Bot: Event Program Manager (sole owner of calendar writes), Brand Designer (visual design), Facility Manager, Trend Analyst, Technical Lead (owns FabricProject161/GitHub work), Finance (taxes/eTAX), Financial Controller (money), Customer Engagement Specialist (mail/comms).

## Agents ({len(index)})

| # | Agent | Status | Reports to | ID | File |
|---|---|---|---|---|---|
{rows}

## Notes

- **Source of truth:** `profile.json` of each agent on the Grok Bot box, read-only. Names are the current names.
- **Renamed agents:** older names inside descriptions are replaced by the current names ({', '.join(f'{o} → {n}' for o, n in RENAMES)}; Chief of Staff → Grok Bot (Chief of Staff), with the old Chief of Staff id replaced by Grok Bot's id; Application Manager D365 → ERP Capability Advisor where it is given with that agent's id). Two agents still carry an older value in their profile *title* field (Event Program Manager: "Event Coordinator"; People Development Manager: "Talent Manager"); it is shown and flagged as legacy.
- **Legacy aliases left as written** (not 1:1 renames, see the org section for the current owner): {', '.join(LEGACY_ALIASES)}.
- **Not exported:** the empty orphan agent "New Bot" (`1732aa8f-a554-4cb4-97fa-c4d9e43a440d`); memory notes (the 6 Oct export's "supplementary role notes" were stale and are dropped); routines, settings, transcripts, metadata.

## Redaction

All exported text passes through `redact()` in `gen.py`: passwords/credentials, passcodes and Teams meeting links/IDs, tokens/PATs/API keys, IBAN/account/card numbers, AHV numbers, policy/customer/invoice numbers, amounts, birth dates, e-mail addresses, phone numbers, street/home address, health/medical details, personal names (replaced with neutral wording such as "the user"), device ids, local Windows user names, personal profile handles and admin login URLs are replaced with `[redacted]`. Agent ids, role descriptions and routing are kept.

Redactions in this export (counts only):
{cats}
"""
open('AGENTS-README.md', 'w').write(readme)
json.dump({'exported': EXPORT_DATE, 'agents': index, 'redactions': dict(COUNTS)}, open('index.json', 'w'), ensure_ascii=False, indent=1)
for e in index: print(e['file'], e['status'])
print(dict(COUNTS))
