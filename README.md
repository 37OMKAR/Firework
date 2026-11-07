# Diwali Fireworks 🪔

A free, single-file Diwali fireworks simulator. Open `index.html` in any modern browser — no build step.

**Festive look:** Diwali night sky with a lit temple & palace skyline, a glowing row of flickering diyas, swaying lanterns, a rangoli start screen, "शुभ दीपावली" / "HAPPY DIWALI" marquee, saffron-gold-magenta "Diwali mix" colours. Large high-contrast UI (solid panels, big buttons) that works on phones.

**Shells (25):** Peony, Chrysanthemum, Willow, Palm, Ring, Double ring, Heart, Star, Spiral, Saturn, Smiley, Butterfly, Flower, Crossette, Crackle, Strobe, Horsetail, **Diya flame**, **Anar (fountain)**, **Chakri (spinner)**, **Laddi (string of crackers)**, **Bomb**, Roman candle, Sky text, Random.

**Sound (all synthesized with Web Audio):** mortar thump + rising whistle, layered boom with reverb and stereo panning, realistic flash-to-bang delay, crackle/fizz, cracker bangs, chakri whirr, temple bells, **dhol drums** on the finale, crowd ooh/cheer/applause, **Diwali raga & tabla music** (or ambient pads), 3 sound styles, per-layer toggles and volume sliders.

**Marquee text:** neon ticker on a banner (Neon / Outline / LED / Retro 3D), Diwali gold flow / rainbow / follows-fireworks / solid colours, pulses on every burst. **Text fireworks** write messages (including Devanagari) in the sky.

**Edge glow:** screen edges flare in each burst's colour on the side nearest the explosion, plus a neon frame; reactive / rainbow / static modes.

**Keys:** Space random shell · 1–9 shell type · 0 random · G finale · T sky text · A auto · M mute · F fullscreen · H hide UI.

## Rendering & performance
- **Glow sprites:** sparks are drawn from pre-rendered glow sprites (white-hot core → colour → soft falloff) instead of per-frame gradients/arcs, with streak stamping for fast sparks.
- **Cooling embers:** sparks start white-hot, settle to their colour, then warm hues cool toward orange-red.
- **Bloom, smoke & flash:** low-res bloom pass, drifting smoke that is lit by later bursts, rocket comet tails, pistil cores in round shells.
- **Cheap DOM:** the marquee is baked once to a canvas and scrolled with a GPU-only transform; edge glow only touches the DOM when a value changes (no blend modes, no per-frame box-shadow).
- **Adaptive quality:** *Settings → Show → Quality* (Auto / High / Medium / Low). Auto watches frame time and scales particle cap, density, resolution, bloom and smoke up/down. Press **P** (or the setting) for a live FPS meter.

## v3 – sky-first UI, more shells, shows & sound
- **Sky-first UI:** only the sky plus a few small buttons by default. **☰ Controls** opens shells, colours, wish box and shows; **⚙ Settings** opens the options. Marquee and lanterns are now off by default (turn on in Settings → Text / Scene).
- **Bigger, finer bursts:** ~35% more sparks, wider shells, finer longer streaks.
- **36 shells:** adds Kamuro, Silver willow, Brocade, Dahlia, Two colour, Colour change, Triple pistil, Triple blast, Serpent, Comet and Crackle chrysanthemum.
- **Shows:** 🎆 Grand show (~70 s, four acts), 📅 Today's show (same show for everyone on a given date), ⏱ Countdown 10→0 into a finale with your text, ✍ Write in sky, 🔗 Share greeting (link opens with your message written in the sky).
- **Sound:** layered synthesized booms (crack + body + sub thump + rumbling tail), rolling echoes, optional double boom, night ambience (wind & crickets), button clicks, countdown ticks, sky-text shimmer, crossette pops. Optional recorded booms: see `sounds/README.md`.

## v4 – mobile-first layout
- Controls is a compact tabbed bottom sheet (Shells · Colours · Shows · Wish); Settings is a bottom sheet on phones. Only one is open at a time and the sky stays visible above.
- The skyline is a thin strip by default (Settings → Scene → Skyline height, or set Horizon to "Open sky"); diyas are smaller on phones.
- Recorded booms: list files in `sounds/manifest.json` (see `sounds/README.md`).

## v5 – crisp rendering
- Sparks are thin tapered streaks with a small bright head (no more fat blobs); text fireworks use crisp dots.
- The sky stays dark: flash, bloom, smoke and edge glow were toned down, the horizon gradient is darker, and the neon frame border is off by default.
- Pixel-density cap raised to 2x on capable devices (the adaptive-quality governor still steps down if the device struggles).
- Small ticker "HAPPY DIWALI from Om" under the buttons — edit it in Settings → Text.

## v6 – minimal chrome
Only a **Full screen** button (top right) and a **Controls** button (bottom centre) are on the sky. Controls opens the sheet (Shells · Colours · Shows · Wish); Sound, Save photo, Settings and Hide UI are in its Shows tab. The scrolling ticker is off by default (Settings → Text → Show marquee).

## v7 – sound
Booms are layered (sharp crack + click, body, sub-bass, long rumbling tail, rolling echoes, crackle tail). Measured by offline rendering: louder boom, ~14 dB stronger late tail than before. A master limiter + soft clipper keeps stacked finales from clipping (worst-case stack peak 1.40 → 0.92, zero clipped samples).

## v8 – quiet by default
Auto show, festive music and night ambience are now off by default; the sky only fires when you tap. Turn them on in Controls → Shows (Auto show) and Settings → Sound.

## v9 – hands & hand-lit crackers
- **Laddi (hand-lit):** a guy's hand lights the fuse of a hanging string of crackers; they burst one by one from the bottom up.
- **Sutli bomb:** hand lights the wick, the spark runs down, then one huge bang with shockwave and debris.
- **Flower pot (anar):** hand lights the wick; the pot erupts in a fountain that changes colour.
- **Sparkler (phuljhadi):** a girl's hand (gold bangles) holds a golden sparkler; hold and drag on the sky to draw with it.
- **Crash protection:** caps on rockets (42), on-screen props (5), queued shots and audio voices; per-button rate limits; Finale/shows can't be stacked; the adaptive-quality governor sheds load. Stress-tested with hundreds of rapid taps and button mashing.

## v10 – shells fire when picked
Picking a shell in Controls → Shells now fires it immediately where you can see it. Low-placed items (laddi, sutli bomb, flower pot, sparkler, chakri, candle, sky text) close the sheet first so they are not hidden behind it; picking a colour fires a preview in that colour.

## v12 – unobtrusive cracker info
Firing a cracker no longer pops up a text card over the sky. A small half-transparent **ⓘ** appears in the top-left corner; tap it to read the cracker's local names, look and effect, tap again (or the sky) to close.

## v13 – every cracker feels different, languages, clear icon
- **Sound variety:** each bomb has its own voice (kuruvi tick, bijli crack, laxmi pop, chocolate thud, atom boom with 3 echoes, maroons deep doom with 4 echoes + long rumble, hydro splash, bullet whip, chinese double-crack, 555 triple). Fountains hiss or roar by size, spinners whirr at a pitch that matches their size, ladi bangs change pitch with cracker size. Heavy bombs get rolling stereo echoes.
- **Haptics:** a different vibration pattern per cracker (Android; Settings → Sound → Haptic feedback + strength slider). iPhones do not allow web vibration.
- **Look:** hydro = water splash, maroons/atom = dust + big shockwave and shake, chocolate = brown debris, chinese = red/gold sparks.
- **Languages:** English · हिन्दी · मराठी — pick on the welcome screen or in Settings → Show. Everything is translated (menus, settings, shells, all 64 cracker names and info cards, messages); the language is remembered and defaults to your browser language.
- **Clear icon:** small eraser button at the top-left clears the whole sky.
