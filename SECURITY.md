# Security audit – Diwali Fireworks

Scope: the single-page app (`index.html`), its optional `sounds/` folder, the local `serve.sh`, and hosting headers.
It is a static, client-only app: no backend, no accounts, no cookies, no analytics, no npm dependencies.
Method: code review of every browser API sink and input source, a search of all git history for secrets, and
active attack tests (hostile `localStorage`, hostile greeting links, a malicious sound manifest, CSP behaviour).

## Findings and fixes

| # | Severity | Finding | Fix | Verified |
|---|----------|---------|-----|----------|
| 1 | Medium | Dev server (`python3 -m http.server` from the repo root) served the whole project, including `.git/` (HTTP 200 on `.git/config`) — repo history readable by anyone who can reach the port | `serve.sh` copies only `index.html` + `sounds/` to a temp dir and serves that (binds 127.0.0.1 by default) | `.git/*`, `README.md`, scripts → 404 |
| 2 | Medium | Greeting links accepted palette key `__proto__` (`PALS['__proto__']` is truthy) → TypeError when the greeting fired | Own-property check (`hasOwn`) for every palette key (`__proto__`, `constructor`, `toString`, `hasOwnProperty` tested) | falls back to default, app keeps working |
| 3 | Medium | Saved settings were loaded from `localStorage` unvalidated (`Object.assign`): a tampered value such as `mqSize: 1e12` could freeze the page; unknown keys / `__proto__` accepted | Only keys present in `DEFAULTS` are copied; `sanitizeSettings()` enforces type, numeric range, enum membership, colour format (`#rrggbb`), string length and strips control characters | clamped / reset; prototype not polluted |
| 4 | Low | Sound manifest file names were not restricted (could request odd paths on the same origin) | Allow-list: plain file name, `.mp3/.ogg/.wav/.m4a`, ≤81 chars, no `..`, max 12 files, <8 MB each | only the one valid name is requested |
| 5 | Low | No Content-Security-Policy | CSP `<meta>` (no `object`, no `base`, no forms, `connect-src 'self'`, only Google Fonts as an external host); full header set in `vercel.json` / `_headers` incl. `frame-ancestors 'none'`, `nosniff`, `Referrer-Policy: no-referrer`, `Permissions-Policy`, HSTS | no CSP violations while using every feature |

## Checked and found clean
- No `eval`, `new Function`, `document.write`, string `setTimeout`, `postMessage`, `window.open` or dynamic navigation.
- Every `innerHTML` receives only static strings (palette names/colours, fixed decoration markup). User text (wish, sky text, ticker, countdown) is rendered with `textContent` or drawn on a canvas.
- Greeting links: strict hex format, length-capped, JSON in `try/catch`, message stripped of control characters and `<>`, capped at 28 characters.
- No secrets in the working tree or in any commit (searched all revisions for keys/tokens/passwords/private-key headers).
- No third-party scripts. Only Google Fonts CSS/fonts are loaded externally.
- Resource-exhaustion limits: max 42 rockets, 5 props, 350 queued shots, 46 audio voices, particle cap by quality level, per-button cooldowns, adaptive quality governor (stress-tested with 500 random crackers + 500 shells).

## Residual risks / recommendations
1. **`script-src 'unsafe-inline'`** is required because the app is one HTML file. Mitigated by the absence of any HTML-injection sink. To remove it, move the script to `app.js` and serve with `script-src 'self'`.
2. **Google Fonts** sends visitors' IP/User-Agent to Google. Self-hosting the three fonts (Outfit, Hind, Yatra One — all OFL-licensed) removes the external dependency and the privacy leak.
3. **`window.Firework`** debug global exposes internals to the browser console (the user's own session only). Remove for production if desired.
4. **Greeting links** are unauthenticated: anyone can craft one with any 28-character text. Content is a short text drawn in the sky, not HTML, but a host may want a profanity filter.
5. Frame-busting / clickjacking protection and HSTS only work as **HTTP headers** (use `vercel.json` or `_headers`); a `<meta>` tag cannot set them.
6. Hosted preview pages in claude.ai artifacts are governed by that viewer's own sandbox and CSP; the CSP `<meta>` is intentionally omitted from the artifact build.

## Pre-deployment re-audit (v14: 15 languages, neon-frame default, credit line)
- `lang` and every other setting is validated by `SCHEMA` / `sanitizeSettings()`; tampered values (numbers, null, unknown codes, `__proto__`) fall back to English. Translated strings are only ever written with `textContent` / `append` (the one `innerHTML` that remains receives a static palette colour).
- Storage migration v6 -> v7 copies only known keys through the same validation.
- Re-run on the final build: 86 button checks, 17 attack tests, hostile-language test, 500 crackers + 500 shells stress test (R=42, props=5, no errors), 15-language switch/persistence test, CSP run with zero violations (apart from the Google Fonts hosts, which are allowed).
- No secrets in the tree or any commit; only tracked files are the app, docs, headers, `serve.sh`, `sounds/`. No `eval`/`document.write`/`postMessage`/`window.open`/navigation sinks.
- Dev server exposes only `index.html` and `sounds/` (`.git`, README, scripts return 404).
- Still open (unchanged): `unsafe-inline` script (single file), Google Fonts third-party request, `window.Firework` debug global, unauthenticated greeting links. Deploy with the header files so HSTS / frame-ancestors apply.
