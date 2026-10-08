# TODO

## Ship hold (set October 8, 2026, by the user)

**Do not ship (`./shippit.sh`) again until all three are true.** Nothing here is shipped by default; the user says when.

- [ ] The GitHub repo has its new name (and the local folder)
- [ ] The new itch page exists
- [ ] More work has gone into the game's candidacy for Steam (`docs/STEAM_DEMO_PLAN.md`; how much counts as "more" is the user's call)

Until then the live itch build stays as it is: the old title, the old font with its GPL notice, and the old title screen with the jam line. That is a decision, not an oversight.

## Tomorrow (2026-10-06)

- [x] **Ship the zombie guts distraction** (shipped 2026-10-06; itch shows it as Version 8)
- [x] Write a new dev log entry in `devlog/20261006/` (`devlog.md`, plain text for copy and paste, screenshots in the same folder) about throwing guts at zombies
- [x] Post the `devlog/20261006` entry on itch and attach its screenshots (posted, retitled "We're... done?"; body matches the file)
- [x] Paste the updated `ITCH_DESCRIPTION.md` into the page (it now lists the proselytizer, holy water, guts and poison)

## Steam demo (planned, nothing started)

Plan: `docs/STEAM_DEMO_PLAN.md`. Next Fest is not a goal right now (the dates in the plan are a pacing aid only). Nothing gets built until the decisions are answered.

- [x] Decisions answered October 8, 2026: D1 (small, $4 to $5), D2 (the bus hits you; it is the prestige reset of an incremental), D3 (the score is advancement points that depend on run length), D5 (AI-made store art), D6 (code-synthesized audio), D8 (Windows built on the user's machine), D10 (disclose everything); D4 and D7 were settled earlier
- [x] D9 (no SDK in the demo), D11 (sanity stat: out for now), Q1 (the road appears when morale is low) and Q2 (all deaths pay the same, the road is not rewarded and triggers an achievement in the full game) answered October 8, 2026
- [ ] Still open: Q3 (the shape of the points curve), Q4 (the form of automation), the name of the new stat (despair or morale), what raises and lowers it, and where "low" starts
- [ ] Write the content rules for the road (plan section 9a): the content note wording, the in-game text, whether to add a crisis-line line, and revisit before release
- [ ] **Deferred until close to a release candidate (the user's call, October 8, 2026): find and price AI tools for the store art** (capsules and key art): commercial-use terms, cost, and how Steam's AI disclosure treats the output (the user chose AI-made art; AI can do the research, the user approves and pays)
- [ ] Write the incremental design doc (`docs/INCREMENTAL_DESIGN.md`): the road, the points curve, about 8 perks, the unlock list, automation rules, the bestiary

## Rename and cut the jam ties (October 8, 2026)

The jam line is gone from the title screen and the itch copy. The game is now **Bus Anticipator of SPLORR!!** (chosen by the user from three suggestions); the old title was the name of the art the game was based on.

- [x] Pick the new title
- [x] Apply it in the game repo: title screen, `odin/web/index.html`, `odin/web/NOTICE.txt`, `README.md`, `CLAUDE.md`, the plan
- [ ] Ship it (held, see the top of this file; ship to the new itch page's target, not the old page)
- [ ] **Make a new itch page and retire the old one** (the itch steps are yours; I can prepare the files)
  - [ ] Create the new project: title "Bus Anticipator of SPLORR!!", a new URL slug, `cover.png`, the description from `ITCH_DESCRIPTION.md` (it has no jam line), tags, and an HTML5 upload ticked "played in the browser"
  - [ ] Point `shippit.sh` at the new butler target (`thegrumpygamedev/<new-slug>:web`) and ship once to upload the build
  - [ ] Decide which devlog entries to re-post on the new page (`devlog/20261005` and `devlog/20261006` were written for the old title, so check the wording)
  - [ ] Retire the old page "How Am I Still Waiting For The Bus?": decide how (unpublish it, or leave it up with a note pointing to the new one). It carries your December 2024 devlog "Rock and a Hard Place", which says the game was written for the jam, plus its comments and likes
  - [ ] Update the vault: the itch URL and slug in the bus game note, and the Shipping note
- [ ] **Rename the GitHub repo and the local folder** (`TGGD_AGBIC24` is the jam's abbreviation)
  - [ ] Rename the repo on GitHub (Settings; GitHub redirects the old URL)
  - [ ] `git remote set-url origin <new url>`, then rename the local folder
  - [ ] Replace `TGGD_AGBIC24` in the links in `NOTICE.md`, `ITCH_DESCRIPTION.md` and `odin/web/NOTICE.txt` (search the repo for it)
  - [ ] Claude Code keeps its memory for this project under the old folder name (`~/.claude/projects/-home-yermom-git-TGGD-AGBIC24/memory`, which holds the "yer, never your" rule): copy it to the new folder's project directory after renaming, or it will not be found
  - [ ] Update the vault: the `repo:` path in the bus game note and any other mention of the folder
- [x] Regenerate `cover.png` (done: the new title screen, new font, 640 by 480; regenerate again if the title screen changes)
- [x] Update the vault notes for the new title (done: game note renamed, links fixed, jam page removed, CoCo font marked retired, Steam evaluation re-ranked)

## Font branch (`font-m6x11`, in progress)

Replaces the GPL font with m6x11 by Daniel Linssen in 10 by 14 cells (screen 320 by 224). Built and playable on the branch; not merged, not shipped.

- [x] Merge to `main` (done, `26dbf1c`)
- [ ] Ship it (held, see the top of this file)
- [ ] After merging, paste the new credit line from `ITCH_DESCRIPTION.md` into the itch page
- [x] m6x11 terms: the user decided to read "free to use with attribution" broadly (it does not exclude commercial use), so no need to ask the author; keep the credit everywhere
- [x] Update the vault notes (CoCo font, the bus game note, the Steam evaluation) once the branch is merged (done)
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
