# TODO

## Game

- [ ] Zombie guts distract zombies from attacking (the last README idea; guts are collected but do nothing yet)
- [ ] Allow eating zombie guts from inventory. Eating sets a poison stat to 25. Each time the satiety check runs (`perform_hunger`), poison drops by 1, health drops by 1, and a "YER POISONED" message is shown.
  - Decided: poisoning does not stack. Eating guts puts poison back at 25, even if already poisoned.
  - Decided: the status screen shows poison when it is non-zero.
  - Decided: if poison is what kills you, the game over screen says you turned into a zombie.
  - [ ] Open: what counts as dying of poison? Assumed: health hits 0 on the poison tick of the satiety check. If a zombie attack or starvation kills you while poisoned, keep the usual death message?
- [x] Play through the proselytizer screen and the holy water fight option in a browser (done on a rigged build; found and fixed an overflow that hid the donate option, and four wrapping slips)
- [x] Confirm that the RNG seeding changes outcomes between loads (tested: the default RNG already varied per load, so the seed is harmless but was not needed)
- [x] Update `README.md`, which still listed the proselytizer, holy water and zombie guts as ideas (the ideas list is gone; the remaining one is above)

## Repo

- [x] Decide whether to keep the Defold project (removed; last commit that has it is `6c5262a`)

## itch.io page (done by hand)

- [x] Paste the new `ITCH_DESCRIPTION.md` text into the page (it now includes the font credit)
- [x] Remove the old `TGGD_AGBIC24.zip` download from the Defold build

## Vault

- [x] Find the author and licence of the CoCo font sheet (VCC, Joseph Forgione, GPL-3.0; credited in the notes)
- [ ] Update the bus game note when zombie guts get a use (it currently lists that as the next feature)
