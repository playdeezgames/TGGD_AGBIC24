# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

"Bus Anticipator of SPLORR!!" (until October 2026, "How Am I Still Waiting For The Bus?") is a text-mode survival game in Odin, compiled to `js_wasm32` and played in the browser (itch.io). It was originally written in Lua on Defold (December 2024) and rewritten line for line in Odin in October 2026; the Defold project was removed afterwards. The last commit that contains it is `6c5262a`, which is the reference if the original behaviour is ever in question (quirks like hard character-wrapping at 32 columns and hand-padded message strings come from there). The port has since moved past it: the proselytizer, holy water, zombie guts, poison and touch taps exist only in the Odin version.

The repo root holds `shippit.sh`, README, `NOTICE.md`, `TODO.md`, `ITCH_DESCRIPTION.md`, `cover.png`, the `odin/` directory with all the code, and `devlog/`: one subfolder per entry named by date (`devlog/20261005/`), each holding `devlog.md` and the screenshots it uses. The first entry's screenshots were rendered from the game's own display grid with the real font sheet, driven by scripted key presses.

## Commands

- Build: `odin/build.sh` writes `odin/out/` (`bus.wasm`, `odin.js` from the Odin install, and everything in `odin/web/`). Serve `odin/out` with any static server and open it.
- Test (native, not js): `cd odin && odin test . -define:ODIN_TEST_THREADS=1`. Single-threaded because tests share the global `data`; each test calls `begin_test`/`end_test` because the runner gives every test its own allocator. The run leaves a stray `odin` binary, which is git-ignored. It is a seeded random playthrough (a fixed seed, with quitting made rare so deaths happen) that must reach every state, plus glyph-mapping and feature checks.
- Ship (`./shippit.sh`, from the repo root): runs `odin/build.sh`, then `butler push odin/out thegrumpygamedev/how-am-i-still-waiting-for-the-bus:web`. Publishes to itch.io, so only when asked. **Ship hold (October 8, 2026): do not ship until the repo is renamed, the new itch page exists, and more Steam-candidacy work is done (see the top of `TODO.md`), even if asked to "commit and push" or to finish a task.** The itch project slug is still the old `how-am-i-still-waiting-for-the-bus` until the user renames the page; change it here when they do.

## Architecture

One Odin package (`bus`) in `odin/`. Everything is platform independent except `main_js.odin` (`#+build js`), which holds the `step` export, keyboard events (`KeyboardEvent.code` to `Command`), the `touch_row` export, RNG seeding, and the `present` foreign call. `game_test.odin` is `#+build !js`.

- `display.odin`: a 32x16 grid of tile indices, a write cursor (row 0 is the top), and per-row tap commands recorded by `display_menu_item`. Text wraps by character, never by word. Writing past the bottom row scrolls the screen up (deferred until the next write, so exactly 16 rows does not scroll), so the menu at the bottom is never overwritten.
- `data.odin`: the single global `data`, the message log (`add_message`/`clear_messages`), and every action. Actions return the next `State`. `get_next_state` is the router and its order matters: dead, zombie, hippie, vendor, beggar, proselytizer, then in play.
- `states.odin`: a `draw_*`/`handle_*` pair per `State`; `game_update` and `game_handle_command` dispatch on `current_state`.
- `encounter.odin` and `foraging.odin`: enum-indexed weight arrays rolled by `pick_weighted` in `rng.odin`.
- `web/index.html`: implements `present` by blitting 10x14 tiles from `font.png` onto a 320x224 canvas (32 columns by 16 rows) (tile index is 1-based, 32 per row; character set 1 is tiles 65..128, set 2 is 1..64), and turns taps on the canvas into `touch_row` calls.
- Input is entirely numbered menus ("1) WAIT FOR BUS"). Keys 0 to 9 and the numpad are bound; only 0 to 4 are used.

## Licensing

The repo is MIT. The text font is m6x11 by Daniel Linssen (managore), "free to use with attribution", rendered unmodified into `odin/web/font.png` by `odin/tools/make_font_sheet.py` (the TTF is not kept in the repo). The author's page does not address commercial use or modification; the user's decision is to read "free to use with attribution" broadly, since it does not exclude commercial use. Always keep the credit. See `NOTICE.md`. `odin/web/NOTICE.txt` is copied into the build next to the font, so it ships with the game; keep it there. Keep the credit in `README.md` and `ITCH_DESCRIPTION.md`. (Until October 2026 the font was a GPL-3.0 image from the VCC emulator; it is in git history up to `07906f7`.)
