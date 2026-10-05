# TODO

## Tomorrow (2026-10-06)

- [ ] **Ship the zombie guts distraction** (committed and pushed, not live yet): run `./shippit.sh` from the repo root
- [ ] Write a new dev log entry in `devlog/20261006/` (`devlog.md`, plain text for copy and paste, screenshots in the same folder) about throwing guts at zombies

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
- [ ] Post the `devlog/20261005` entry on the itch page and attach the screenshots (poison and the snarky message are live; that entry's "What's next" line is about the guts distraction, which ships tomorrow)
- [x] Paste the new `ITCH_DESCRIPTION.md` text into the page (it now includes the font credit)
- [x] Remove the old `TGGD_AGBIC24.zip` download from the Defold build

## Vault

- [x] Find the author and licence of the CoCo font sheet (VCC, Joseph Forgione, GPL-3.0; credited in the notes)
- [ ] Update the bus game note when zombie guts get a use (it currently lists that as the next feature)
