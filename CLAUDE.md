# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

"How Am I Still Waiting For The Bus" is a text-mode survival game in Odin, compiled to `js_wasm32` and played in the browser (itch.io). It was originally written in Lua on Defold (December 2024) and rewritten line for line in Odin in October 2026; the Defold project was removed afterwards. The last commit that contains it is `6c5262a`, which is the reference if the original behaviour is ever in question (quirks like hard character-wrapping at 32 columns and hand-padded message strings come from there). The port has since moved past it: the proselytizer, holy water, zombie guts, poison and touch taps exist only in the Odin version.

The repo root holds `shippit.sh`, README, `NOTICE.md`, `TODO.md`, `ITCH_DESCRIPTION.md`, `cover.png`, and the `odin/` directory with all the code.

## Commands

- Build: `odin/build.sh` writes `odin/out/` (`bus.wasm`, `odin.js` from the Odin install, and everything in `odin/web/`). Serve `odin/out` with any static server and open it.
- Test (native, not js): `cd odin && odin test . -define:ODIN_TEST_THREADS=1`. Single-threaded because tests share the global `data`; each test calls `begin_test`/`end_test` because the runner gives every test its own allocator. The run leaves a stray `odin` binary, which is git-ignored. It is a randomized playthrough that must reach every state, plus glyph-mapping and feature checks.
- Ship (`./shippit.sh`, from the repo root): runs `odin/build.sh`, then `butler push odin/out thegrumpygamedev/how-am-i-still-waiting-for-the-bus:web`. Publishes to itch.io, so only when asked.

## Architecture

One Odin package (`bus`) in `odin/`. Everything is platform independent except `main_js.odin` (`#+build js`), which holds the `step` export, keyboard events (`KeyboardEvent.code` to `Command`), the `touch_row` export, RNG seeding, and the `present` foreign call. `game_test.odin` is `#+build !js`.

- `display.odin`: a 32x16 grid of tile indices, a write cursor (row 0 is the top), and per-row tap commands recorded by `display_menu_item`. Text wraps by character, never by word. Writing past the bottom row scrolls the screen up (deferred until the next write, so exactly 16 rows does not scroll), so the menu at the bottom is never overwritten.
- `data.odin`: the single global `data`, the message log (`add_message`/`clear_messages`), and every action. Actions return the next `State`. `get_next_state` is the router and its order matters: dead, zombie, hippie, vendor, beggar, proselytizer, then in play.
- `states.odin`: a `draw_*`/`handle_*` pair per `State`; `game_update` and `game_handle_command` dispatch on `current_state`.
- `encounter.odin` and `foraging.odin`: enum-indexed weight arrays rolled by `pick_weighted` in `rng.odin`.
- `web/index.html`: implements `present` by blitting 8x12 tiles from `CoCoFontSmall.png` onto a 256x192 canvas (tile index is 1-based, 32 per row; character set 1 is tiles 65..128, set 2 is 1..64), and turns taps on the canvas into `touch_row` calls.
- Input is entirely numbered menus ("1) WAIT FOR BUS"). Keys 0 to 9 and the numpad are bound; only 0 to 4 are used.

## Licensing

The repo is MIT, except the font image `CoCoFontSmall.png`, which was captured from the VCC emulator and is GPL-3.0 (Copyright 2015 Joseph Forgione). See `NOTICE.md`. `odin/web/NOTICE.txt` and `odin/web/GPL-3.0.txt` are copied into the build next to the font, so they ship with the game; keep them there. Keep the credit in `README.md` and `ITCH_DESCRIPTION.md`.
