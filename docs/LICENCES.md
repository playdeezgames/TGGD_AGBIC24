# Licence ledger: Bus Anticipator of SPLORR!!

Status: **started October 8, 2026 (phase 1 of `docs/STEAM_DEMO_PLAN.md`).** One page that lists every font, sound, picture, word source and tool the game uses, with its licence and what has to be shown. **Every later phase adds its rows here before its work is called done.** If something is not on this page, it is not cleared.

This is a record of what is known, not legal advice. Where a licence is unclear, the row says so and says what the user decided.

## 1. What ships to players

Everything in `odin/out/` (what `./shippit.sh` uploads) and on the Steam build later.

| Item | What it is | Whose | Licence and what it requires | Where the notice is |
| --- | --- | --- | --- | --- |
| `bus.wasm` | The game, compiled from `odin/*.odin` | The user and Claude Code (AI-written code, disclosed) | The game: MIT (`LICENSE`). It also contains code from **Odin's base and core libraries**: Odin's licence (zlib-style, Copyright 2016-2025 Ginger Bill), which allows commercial use and requires only that its notice is not removed | `odin/out/NOTICE.txt` (full text); `NOTICE.md` |
| `odin.js` | Odin's browser runtime, copied unchanged from the Odin install at build time | Ginger Bill | Odin's licence, as above | `odin/out/NOTICE.txt` |
| `index.html` | The page that draws the game and takes taps | The user and Claude Code | MIT | `LICENSE` |
| `font.png` | The text font: **m6x11**, rendered unmodified into a tile sheet by `odin/tools/make_font_sheet.py` | **Daniel Linssen (managore)**, <https://managore.itch.io/m6x11> | "Free to use with attribution." The author's page does not mention commercial use, modification or redistribution. **The user's decision (October 8, 2026): read it broadly, since it does not exclude commercial use.** Credit is required | `odin/out/NOTICE.txt`, `NOTICE.md`, `README.md`, `ITCH_DESCRIPTION.md`; to add: the credits screen and the Steam store page |
| `NOTICE.txt` | The credits and licence text shipped with the build | The user and Claude Code | MIT | itself |
| All the words in the game (messages, menus, instructions) | Every string in `odin/*.odin` | The user and **Claude Code (AI-drafted, disclosed)**. No quoted or copied third-party text is known | Original. The voice rules ("yer", uppercase, deadpan) are the user's | Credits and the Steam AI disclosure (plan D10) |
| The title and the "of SPLORR!!" brand | "Bus Anticipator of SPLORR!!" | The user | Original. Searched on Steam and the web on October 8, 2026 with no match (itch.io's own search could not be read; trademarks were not searched; see section 4) | n/a |
| Sound and music | **None yet** | n/a | When added (plan D6): code-synthesized from note tables, so original; each track and effect gets a row here | n/a |
| Pictures and art | **None in the game.** The screen is text drawn with the font | n/a | n/a | n/a |

## 2. What is in the repository but does not ship to players

| Item | What it is | Licence and notes |
| --- | --- | --- |
| `cover.png` | A rendering of the title screen in the new font, for the itch.io page | Ours. Contains only the game's own text and m6x11 glyphs, so the font credit applies |
| `devlog/*/` screenshots | Rendered from the game's own display grid | Ours. **The `20261005` and `20261006` screenshots show the old font** (a GPL-3.0 image from the VCC emulator, Copyright 2015 Joseph Forgione). They are pictures of text, not the font file, and are not part of the game; they are listed because the old font's notice was in `devlog/20261005/devlog.md` |
| `docs/`, `TODO.md`, `README.md`, `NOTICE.md` | The plan, the design and the notes | MIT |
| `odin/tools/make_font_sheet.py` | Builds `font.png` from `m6x11.ttf` | MIT. Needs **Pillow** (the Python imaging library, HPND licence) at development time only; not shipped. `m6x11.ttf` itself is **not kept in the repository**; download it from the author's page |
| `odin/game_test.odin` | The tests | MIT |

## 3. What was used to make it (not shipped)

| Tool | Use | Licence and notes |
| --- | --- | --- |
| Odin compiler (`dev-2026-07-nightly`) | Builds the game | Odin's licence. Output includes its library code (section 1) |
| Claude Code (Claude Sonnet 5.5) | Wrote the code, the tests, the devlogs and the docs, with the user directing, approving and playing every build | Disclosed everywhere the user's stance requires. Steam's AI disclosure on the store page: **plan D10, disclose everything** |
| `butler` (itch.io) | Uploads builds to itch.io | Not shipped |
| Python 3 and Pillow | The font sheet script; rendering devlog screenshots and `cover.png` | Not shipped |

## 4. Old material that is gone, for the record

- **The CoCo font image** (`CoCoFontSmall.png`), captured from the VCC emulator, GPL-3.0-or-later, Copyright 2015 Joseph Forgione. **Removed from the build and from `main` on October 8, 2026** (commit `26dbf1c`; last present at `07906f7`). Its GPL notice and licence text were removed with it. The vault keeps a retired copy for reference.
- **The Lua and Defold version.** Removed (last present at commit `6c5262a`). Anything in it that came from elsewhere is not in the current game.

## 5. Open items

1. **The title.** Steam's own search shows no game by this name, and the web searches found none. **itch.io's search page could not be read by the tool used, so check it by hand**, and check trademarks before store assets are made.
2. **The font.** The user reads "free to use with attribution" broadly. The author has not been asked (decided not to). The credit must stay in the game, on the store page and on the itch.io page.
3. **Store art.** Not made. When it is (plan D5), each tool's commercial-use terms are recorded here first, and Steam's AI disclosure is answered to match. **Deferred until near a release candidate.**
4. **Sound.** None yet. Each added sound or track is recorded here with its source (code-synthesized, so original).
5. **Third-party names in the game.** None known. The vault's note about a sponsor, a streamer or another game's characters does not apply to this game. Check any new character or joke against this before it goes in.
6. **Unwritten credits screen.** The in-game credits (plan, phase 5) must list everything in section 1 that needs a credit.

## Related

`NOTICE.md` · `odin/web/NOTICE.txt` · `docs/STEAM_DEMO_PLAN.md` (phase 1 and decision D10) · `docs/INCREMENTAL_DESIGN.md`.
