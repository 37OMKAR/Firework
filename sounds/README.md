# Recorded boom sounds (optional)

1. Download explosion / firework-boom recordings you are allowed to use (for example from
   Pixabay — check the licence of each sound).
2. Put the files in this folder.
3. List the file names in `manifest.json`:

       { "booms": ["firework-1.mp3", "firework-2.mp3", "big-boom.mp3"] }

4. Serve the site over http(s) (e.g. `python3 -m http.server`) — browsers block `fetch` on `file://`.

Booms then use your recordings (random pick, slight pitch variation, distance filtering) in place of the
synthesized boom. Turn this off any time in **Settings → Sound → Use recorded booms**.
