# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

"How Am I Still Waiting For The Bus" — a text-mode survival game written in Lua on the [Defold](https://defold.com) engine (jam entry, "AGBIC24"). The Defold project lives in the nested `TGGD_AGBIC24/` directory (contains `game.project`); the repo root holds only `shippit.sh`, README (design notes/ideas), and `cover.png`. There is no test suite or linter.

## Odin port (`odin/`, in progress — the active codebase)

The goal is a full rewrite of the Defold/Lua game into Odin targeting `js_wasm32`; `TGGD_AGBIC24/` is the reference implementation for the original behaviour (including quirks like hard character-wrapping at 32 columns and hand-padded message strings). The port has since moved past it: new features (proselytizer, holy water, zombie guts, from the README ideas) exist only in the Odin version.

- Build: `odin/build.sh` → `odin/out/` (`bus.wasm` + `odin.js` from the Odin install + `web/index.html` + font PNG). Serve `odin/out` with any static server and open it.
- Test (native, not js): `cd odin && odin test . -define:ODIN_TEST_THREADS=1` (single-threaded: tests share the global `data`; each test calls `begin_test`/`end_test` because the runner gives every test its own allocator; the run leaves a stray `odin` binary that is git-ignored) — a randomized playthrough that must reach every state, plus glyph-mapping checks.
- One package (`bus`). Everything is platform-independent except `main_js.odin` (`#+build js`), which holds the `step` export, keyboard events (`KeyboardEvent.code` → `Command`), and the `present` foreign call. `game_test.odin` is `#+build !js`.
- Mapping from Lua: `display.odin` = display_buffer (row 0 is the top; Defold's tilemap is y-up so the Lua cursor started at row 16), `data.odin` = game/data.lua, `states.odin` = all `*_state.lua` (a `draw_*`/`handle_*` pair per `State`), `encounter.odin`/`foraging.odin` = weighted tables (enum-indexed arrays), `rng.odin` = random helpers.
- Rendering: Odin fills a 32x16 tile-index grid; `web/index.html` implements `present` by blitting 8x12 tiles from `CoCoFontSmall.png` onto a 256x192 canvas (tile index is 1-based, 32 per row; character set 1 = tiles 65..128, set 2 = 1..64).

## Licensing

The repo is MIT, except the font image `CoCoFontSmall.png` (both copies), which was captured from the VCC emulator and is GPL-3.0 (Copyright 2015 Joseph Forgione). See `NOTICE.md`. `odin/web/NOTICE.txt` and `odin/web/GPL-3.0.txt` are copied into the build next to the font, so they ship with the game; keep them there. Keep the credit in `README.md` and `ITCH_DESCRIPTION.md`.

## Commands (Defold original)

- Develop/run: open the nested `TGGD_AGBIC24/` folder in the Defold editor (Project > Build).
- Web release + itch.io upload (`shippit.sh`, run from repo root): builds with `bob.jar` (git-ignored, must be supplied locally) for `js-web` into `pub-web/`, then `butler push` to `thegrumpygamedev/how-am-i-still-waiting-for-the-bus:web`.

## Architecture

**Rendering:** The game is a 32x16 character grid drawn into a Defold tilemap. `display_buffer/display_buffer.lua` holds the in-memory grid (`COLUMNS`/`ROWS`, `clear`, `write`, `write_line`, `get_cell`) and maps characters to tile indices through its `characters` table (the font is `screen/CoCoFontSmall.png`; only uppercase/punctuation glyphs exist, so all on-screen text is UPPERCASE). `screen/screen_script.script` is the single Defold entry script: every frame it calls `game.update(dt)` and copies the buffer into the tilemap, and it forwards key presses to `game.handle_command`.

**Input:** Bindings in `input/game.input_binding` map keys to action names that must match the string constants in `game/commands.lua` (`ZERO`..`NINE`, `ENTER`, `BACKSPACE`, `DELETE`). New commands must be added both to the binding file and to `commands.ALL`. The UI is entirely numbered menus ("1) WAIT FOR BUS").

**State machine:** `game/game.lua` holds `current_state` and a table mapping each name in `game/states.lua` to a state module. Every state module exposes `update(dt)` (draws to the display buffer, returns the state name) and `handle_command(command)` (returns the next state name). Adding a state means: a constant in `states.lua`, a module, and registration in `game.lua`.

**Game data and logic:** `game/data.lua` is the single store of mutable game state (module-local `data` table with getter/setter pairs, e.g. `set_money`, which clamp at 0), the message log shown above menus (`add_message`/`clear_messages`), and the turn logic (`wait_for_bus`, `forage`, `perform_hunger`, `get_next_state`). Action functions in `data.lua` return the next state, which state modules return straight from `handle_command`. `new_game()` resets everything — new fields need initializing there.

**Random events:** `game/encounter.lua` is a weighted table of encounters (nothing, zombie, hippie, vendor, beggar, ...), each with a `handle(data)` that sets flags/stats and queues messages; `get_next_state` in `data.lua` then routes to FIGHT/HIPPIE/VENDOR/BEGGAR states. `game/foraging.lua` is the analogous weighted table for foraging results. Messages are hard-wrapped by hand to the 32-column width (note the odd spacing in message strings).
