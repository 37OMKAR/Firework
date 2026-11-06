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
