# Notices

## Font

The game's text is drawn in **m6x11** by **Daniel Linssen (managore)**, <https://managore.itch.io/m6x11>, which the author's page says is "free to use with attribution". `odin/web/font.png` is that font rendered, unmodified, into a tile sheet by `odin/tools/make_font_sheet.py` (the script needs `m6x11.ttf`, which is not kept in this repository; download it from the author's page).

The author's page does not address commercial use, modification or redistribution. The project reads "free to use with attribution" broadly: it does not exclude commercial use, so the font is used here, including in any paid release, with the credit above. (The glyphs are rendered unmodified.)

The rest of this repository is under the MIT license (see [`LICENSE`](LICENSE)).

## Odin

The game is compiled with the [Odin](https://odin-lang.org) compiler. `bus.wasm` contains code from Odin's base and core libraries, and `odin.js` is Odin's browser runtime, copied unchanged into the build. Odin's licence (Copyright 2016-2025 Ginger Bill) permits use in commercial products and redistribution, and asks that its notice is not removed; the full text is in `odin/web/NOTICE.txt`, which ships with the build. An acknowledgement is appreciated but not required.

## History

Before October 2026 the game used a font image captured from the VCC emulator (Copyright 2015 Joseph Forgione, GPL-3.0-or-later), shipped with a GPL-3.0 notice. It was replaced by m6x11 on the `font-m6x11` branch and is only in git history now (last present on `main` at commit `07906f7`).
