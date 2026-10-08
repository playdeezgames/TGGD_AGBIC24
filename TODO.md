# TODO

## Tomorrow (2026-10-06)

- [x] **Ship the zombie guts distraction** (shipped 2026-10-06; itch shows it as Version 8)
- [x] Write a new dev log entry in `devlog/20261006/` (`devlog.md`, plain text for copy and paste, screenshots in the same folder) about throwing guts at zombies
- [x] Post the `devlog/20261006` entry on itch and attach its screenshots (posted, retitled "We're... done?"; body matches the file)
- [x] Paste the updated `ITCH_DESCRIPTION.md` into the page (it now lists the proselytizer, holy water, guts and poison)

## Steam demo (planned, nothing started)

Plan: `docs/STEAM_DEMO_PLAN.md`. Next Fest is not a goal right now (the dates in the plan are a pacing aid only). Nothing gets built until the decisions are answered.

- [ ] Answer the decisions D1 to D10 in section 4 of the plan (the bus, the score, the font, the art, the title clash, Windows builds, audio)

## Rename and cut the jam ties (October 8, 2026)

The jam line is gone from the title screen and the itch copy. The game is now **Bus Anticipator of SPLORR!!** (chosen by the user from three suggestions); the old title was the name of the art the game was based on.

- [x] Pick the new title
- [x] Apply it in the game repo: title screen, `odin/web/index.html`, `odin/web/NOTICE.txt`, `README.md`, `CLAUDE.md`, the plan
- [ ] Ship it (`./shippit.sh`; the live build still has the old title and the font notice)
- [ ] On itch (yours): rename the project and the description headline; change the project URL slug if you want it renamed too (then update the butler target in `shippit.sh`, which still points at `how-am-i-still-waiting-for-the-bus`); remove the jam line from the description; and the December 2024 devlog "Rock and a Hard Place", which says the game was written for the jam
- [ ] Rename the GitHub repo and the local folder: `TGGD_AGBIC24` is the jam's abbreviation (GitHub redirects the old URL; links in `NOTICE.md`, `ITCH_DESCRIPTION.md` and `odin/web/NOTICE.txt` need the new name)
- [x] Regenerate `cover.png` (done: the new title screen, new font, 640 by 480; regenerate again if the title screen changes)
- [ ] Update the vault notes (the game note, Home, Steam evaluation, CoCo font, the jam page) for the new title

## Font branch (`font-m6x11`, in progress)

Replaces the GPL font with m6x11 by Daniel Linssen in 10 by 14 cells (screen 320 by 224). Built and playable on the branch; not merged, not shipped.

- [ ] Merge to `main` when happy, then run `./shippit.sh` (the live itch build still has the GPL font and notice)
- [ ] After merging, paste the new credit line from `ITCH_DESCRIPTION.md` into the itch page
- [x] m6x11 terms: the user decided to read "free to use with attribution" broadly (it does not exclude commercial use), so no need to ask the author; keep the credit everywhere
- [ ] Update the vault notes (CoCo font, the bus game note, the Steam evaluation) once the branch is merged
- [ ] Regenerate `cover.png` (still a screenshot with the old font) if it is used anywhere

## Game

- [x] Zombie guts distract zombies from attacking (throw them in a fight, key 4: no counter-attack that turn, then the zombie is busy for 3 more turns; built and watched in a browser)
- [x] Allow eating zombie guts from inventory (built and watched in a browser: eat sets poison to 25, tick each satiety check, status line, zombie game over). Eating sets a poison stat to 25. Each time the satiety check runs (`perform_hunger`), poison drops by 1, health drops by 1, and a "YER POISONED" message is shown.
  - Decided: poisoning does not stack. Eating guts puts poison back at 25, even if already poisoned.
  - Decided: the status screen shows poison when it is non-zero.
  - Decided: any time the player dies while poisoned (poison above 0), whatever the cause, the game over screen says they came back as a zombie.
- [x] Play through the proselytizer screen and the holy water fight option in a browser (done on a rigged build; found and fixed an overflow that hid the donate option, and four wrapping slips)
- [x] Confirm that the RNG seeding changes outcomes between loads (tested: the default RNG already varied per load, so the seed is harmless but was not needed)
- [x] Update `README.md`, which still listed the proselytizer, holy water and zombie guts as ideas (the ideas list is gone; the remaining one is above)

## Repo

- [x] Decide whether to keep the Defold project (removed; last commit that has it is `6c5262a`)

## itch.io page (done by hand)

- [x] Draft a dev log entry for the new update and the rewrite (`devlog/20261005/devlog.md`, with screenshots)
- [x] Post the `devlog/20261005` entry on the itch page and attach the screenshots (poison and the snarky message are live; that entry's "What's next" line is about the guts distraction, which ships tomorrow)
- [x] Paste the new `ITCH_DESCRIPTION.md` text into the page (it now includes the font credit)
- [x] Remove the old `TGGD_AGBIC24.zip` download from the Defold build

## Vault

- [x] Find the author and licence of the CoCo font sheet (VCC, Joseph Forgione, GPL-3.0; credited in the notes)
- [x] Update the bus game note when zombie guts get a use (done)
