# Steam demo plan: How Am I Still Waiting For The Bus?

Status: **plan only. Nothing in this document has been built or started.** Drafted October 8, 2026. Each phase below ends at an approval gate, the same way the Murder Hobo port was run (`docs/PORT_PLAN.md` in that repo): decide first, then build a phase, then the user plays it, then the next phase.

**Update, October 8, 2026 (the user): Next Fest is not a goal right now.** The user is evaluating games and improving the ones they personally like, not racing a deadline. Read the dates in sections 3 and 7 as a pacing aid only. Do not pay the Steam fee or set up a store page on the strength of this plan; the phases and the depth work stand on their own.

Source of the idea: the vault page `Strategy/Steam pivot evaluation.md` ranks this game 6th of 8 as a commercial base ("small; font licence problem") and lists ideas that would make it stronger. This plan turns those ideas into a schedule. It does **not** overrule the vault's rule that the deliberate jokes (no bus, the pointless flower, the stub score) are the user's to change; those are listed as decisions below, not assumed.

## 1. Where the game stands today (measured)

The game is about 900 lines of logic (`data.odin` 447, `states.odin` 373, plus tables). One location, five encounter types, five forage results, one weapon ladder, no save, no sound, no persistence between runs, no real score.

I measured how long runs last by playing the real game code with simple bots (600 to 1,000 games per bot, seeded, native build, October 8, 2026). One turn is 5 game minutes, so one game day is **288 turns**.

| Bot | What it does | Result |
| --- | --- | --- |
| Forager / Waiter | Forages (or waits) every turn and never eats, heals or uses items | Dies after **96 turns on average** (median 102, p90 140, max 200). About 8 game hours, **a third of one day**. Zombies kill most of them (3 fights per game) before starvation does. |
| Careful | Eats a sammich at 85 satiety or below, uses a bandage at 70 health or below, throws holy water or guts at zombies, and accepts every trade | **Never dies.** 571 of 600 games were still alive after 30,000 inputs (about 21,500 turns, **75 game days**), with 800+ kills each. |

Why the careful bot survives: foraging finds a sammich on 5 of 48 rolls and a sammich gives 10 satiety, so **foraging yields about 1.04 satiety per turn against a cost of 1 per turn**. Bandages return about 0.6 health per forage turn. Once a player learns the loop, nothing pushes back, and the encounter odds never change.

So today's depth problem has two halves: a bad run is short (about 8 real minutes if a decision takes 5 seconds), and a good run never ends and never changes. A paid game, or a demo meant to sell one, needs the opposite: a good run that is long, varied, and finite.

## 2. What "ready to be a Steam demo" means here

A working definition for this game (edit it):

- **A demo run is about 45 to 60 minutes the first time.** At 3 to 5 seconds a decision, that is roughly **3 game days (about 860 turns)**, so a typical run has to last about nine times as long as today's average death.
- **Each day is different.** Day 1 teaches, day 2 turns the screws, day 3 has a set piece. The three days are not the same loop three times.
- **There is a reason to play again.** At the end of a run something persists (an unlock, a bestiary entry, a record), and a second run starts differently.
- **It saves.** Close the window, come back, continue.
- **It looks and sounds like a product:** native Windows and Linux builds, a 16:9 window that fills the screen, sound and music, a title screen, options, a credits screen, controller support.
- **It has a clean paper trail:** no GPL font, no uncleared art, every sound and word source recorded, AI use disclosed.
- **It does not give away the joke.** The pillars in section 9 hold.

Target sizes to confirm (decision D1): **demo 45 to 60 minutes; full game 3 to 5 hours at $4 to $5.** The vault's own range is "an evening for $3 to $5" or "a long weekend for $10+". This plan is sized for the first. The second is a much bigger plan.

## 3. Steam facts and the calendar

**Checked on October 8, 2026 against Valve's own Steamworks pages (partner.steamgames.com):**

- App fee **$100 per product**, non-refundable, **recouped** once the product has $1,000 adjusted gross revenue.
- Valve's review of the store page and configuration takes **1 to 5 days**. There is a **30-day wait from paying the fee** before release, and a public **"coming soon" page must be up at least 2 weeks** before release.
- A demo is a **separate app ID** with its own depots and builds. A separate demo store page, if you use one, needs a written description, **at least 5 screenshots, a trailer**, capsule and library assets that say "demo", and an accurate content survey. **Achievements should be disabled** in a demo; use Steam Cloud for saves. The wishlist-notification email for a demo can be triggered **once, within 14 days** of its release.
- Store art sizes: header capsule 920 by 430, small 462 by 174, main 1232 by 706, vertical 748 by 896, screenshots **at least 1920 by 1080 (16:9)**, library capsule 600 by 900, library hero 3840 by 1240, library logo 1280 wide or 720 tall, app icon 184 by 184, shortcut icon 256 by 256.
- **Steam Next Fest** runs three times a year (listed: **October 2026, February 2027, June 2027**). To enter, the base game's store page must be **public**, with **at least one trailer**, the game must have a **publicly playable demo when the event starts**, and the demo must be **submitted for review 3 weeks before** the event starts (5 weeks for the press preview). **A game can only ever join one Next Fest.** Exact February and June dates were not on the page I read; read them from Steamworks.

**Not verified (secondary sources only; confirm before relying on them):**

- **AI disclosure.** News coverage of Valve's current rules says developers declare *pre-generated* AI content that ships to players (art, voice, and LLM-written text count) and *live-generated* AI content, and no longer need to report AI "efficiency tools" used behind the scenes. By that reading, AI-written *code* is exempt but AI-written *game text and music* are not. The user's own public stance is to disclose everything, so plan to.
- **Steam Auto-Cloud** (cloud saves that need no Steamworks code, set up by pointing Steam at the save folder) exists, as far as I know. Confirm in the Steamworks docs.
- **An Odin binding for the Steamworks SDK** (needed only for achievements and similar). Not needed for the demo.

**Consequences for the calendar**

- **October 2026 Next Fest is out of reach** (the demo is due 3 weeks before it starts, and nothing here exists).
- **Target: the February 2027 Next Fest**, with the demo due about **16 weeks from now** (about 3 weeks before the event). The fallback is June 2027.
- **A game gets one Next Fest.** Do not spend it on a thin demo. If the demo is not strong by late January, wait for June.

## 4. Decisions needed before building (the user's)

None of these have been answered. "Recommended" is my suggestion, not a decision.

| # | Question | Options | Recommended |
| --- | --- | --- | --- |
| D1 | **Target size and price.** | Demo 45 to 60 min / full game 3 to 5 h at $4 to $5, or a bigger game. | The first. Also note this competes for time with the vault's front runner, Kordanor's Cabal; is this the project for the next four months? |
| D2 | **The bus.** The central joke is that it never comes. A paid game needs structure around that joke. (The vault says to ask before touching it.) | **A.** The bus never comes; structure comes from days, score and unlocks. **B.** A plus **near-misses**: a wrong bus that passes, a posted timetable that lies, a sign that says "SOON", on fixed days. **C.** B plus a real ending in the full game, which can be earned by a long run (the bus arrives and does not stop, or you board and it is the zombie bus). | **B** for the demo. Decide C later. |
| D3 | **A real score.** The final score is a stub that always returns 0, and the vault calls that the joke. | Keep 0 / **longest wait** (minutes, days) as the score and the record / a points formula. | Longest wait. "0" can stay as the title-screen joke ("BEST WAIT: 0 MINUTES" before the first run). |
| D4 | **Font.** **Decided October 8, 2026: m6x11 (Daniel Linssen) in 10 by 14 cells, built on the `font-m6x11` branch; the user reads the author's "free to use with attribution" broadly, since it does not exclude commercial use.** The CoCo font image was GPL-3.0 (copied from the VCC emulator), which is a hard stop for a paid closed release. | **(a)** Redraw it as an original 8 by 12 font, with a generated tile sheet. **(b)** Use m5x7 (CC0, already used in Murder Hobo) in the same grid. **(c)** Keep the GPL font and release the whole game as GPL (open source on Steam). | (a) or (b). The "ROM font 8x8" sheet is also unsuitable: it has no licence, and it is a 1999 screenshot of the DOS system font. |
| D5 | **Art.** The vault says the original cover art was never cleared. The repo's `cover.png` is just a screenshot of the title screen, so I could not tell what in the game comes from the Famicase cover. | What, if anything, in the title, words or look comes from that cover? Who makes the capsule art: the user, a commission, or an in-engine render? | Tell me what derives from the cover; I will plan the clearing or the rename. Capsule art made from in-engine renders, with a hand-drawn key image if the user wants. |
| D6 | **Audio.** None today. | **Code-synthesized chiptune and effects** (original, no licence) / commission / AI-generated (needs disclosure and unclear terms). | Code-synthesized, written by me from tables and approved by the user. |
| D7 | **The title.** The jam's own submissions page lists *another* game called "How am I Still Waiting for the Bus?" by SweetHeart Squad, a browser survival game. | Keep the title / add a subtitle or "of SPLORR!!" / rename for Steam. | Check that game; use "of SPLORR!!" or a subtitle if it is live or related. This needs a decision before store assets are made. |
| D8 | **Platforms and builds.** The Murder Hobo note says Odin cannot cross-build Windows from the user's Linux machine. | Windows plus Linux (plus Steam Deck, which runs Linux) / add Mac. Windows built on a Windows machine, in GitHub Actions, or by a Windows toolchain. | Windows plus Linux. Does the user have a Windows machine? |
| D9 | **Steamworks in the demo.** | No SDK at all (launch from Steam, Auto-Cloud for saves, no achievements) / full SDK. | No SDK for the demo. Achievements arrive with the full game. |
| D10 | **AI disclosure wording** for the store page content survey. | Disclose code, text and any music generated with AI / only what Steam requires. | Disclose everything, as the user's public stance says. |
| D11 | **Sanity or boredom stat** (a new "patience" need that drains while waiting and brings false alarms). | In / out. | Optional: a stretch item in phase 3. |

## 5. The plan

Sizes: **S** is one working session, **M** is two to four, **L** is five or more. A "session" is one sitting with Claude Code; **the user's review time is the real bottleneck**, so each phase ends in something the user can play.

### Phase 0: decisions (this week)

Answer D1 to D10. Output: this document updated with the answers, and `TODO.md` pointing at it. **Gate:** no building until the user says go.

### Phase 1: clear the gates (S to M)

Things that make a paid release impossible if left alone, and are cheap now.

1. **Replace the GPL font** (D4): new sheet in the same tile layout, glyph mapping test kept, `NOTICE.md`, `README.md` credits, `ITCH_DESCRIPTION.md` and the devlog credit lines updated, `odin/web/GPL-3.0.txt` removed from the build. The itch version can ship the new font too, so there is one codebase.
2. **Remove the jam claim.** The title screen says "FOR A GAME BY ITS COVER 2024". The game was never entered; decide what the title screen says instead (D5).
3. **Title and IP check** (D7).
4. **Licence ledger.** One page (`docs/LICENCES.md`) listing every font, sound, word-source and tool with its licence. Starts nearly empty; every later phase adds to it.

**Exit:** a build with only original or CC0 material, and a ledger that proves it.

### Phase 2: make a run a game (L, the heart of the plan)

This is where "depth" comes from. It changes the economy and gives runs a shape.

1. **Engineering foundations first (M).** `data.odin` stores each item as its own field and each action as its own procedure; that does not scale to dozens of items, places and characters. Move to: an item table (`[Item]int` inventory, per-item data for names, uses and effects), a world clock, a generic **conversation** state driven by data, and a save/profile layer (browser storage on the web, native files in the SDL preference path, one JSON format with a version number; the vault says Murder Hobo and Kordanor's Cabal already have saves of this kind). Keep the 32 by 16 grid, the yer voice and the numbered menus. Tests stay green at every step.
2. **A balance simulator in the repo (S).** Turn the throwaway bot above into `odin/tools/sim`, with several strategies (naive, careful, greedy, reckless). Every economy change gets measured in minutes, not by playing. Targets live in the plan, not in anyone's head: see section 6.
3. **Days (M).** The wait clock becomes a 24-hour clock starting at 6:15 a.m. (turn 0). Each dawn ends a day with a summary screen ("YOU HAVE WAITED 1 DAY. THE BUS HAS NOT COME."), and the day number scales danger. Time of day changes the encounter table: **night brings more zombies and fewer vendors; rush hour brings people; the early morning is quiet.** Weather (rain, heat) as a modifier on satiety and foraging, three states at most.
4. **Make the economy push back (M).** Levers to try, each tested against the sim: sammich spoilage (a half-eaten sammich goes off after N turns), hunger that rises with exertion (fights cost satiety), a lower sammich forage rate, a **danger ramp** (zombie health, attack and encounter weight rise each day), carry limits, and prices that rise. First targets in section 6.
5. **A real score and a persistent record (S, D3).** Longest wait, days survived, kills, best day. Stored in the profile; shown on the title screen and the game over screen. **Exit:** the careful bot dies, on average between days 3 and 5, and a naive bot lasts about a day.

**Gate:** the user plays three runs and says whether it feels like pressure rather than a chore.

### Phase 3: make the world bigger (L)

All of this is **data**, not code, once phase 2 step 1 is done. That is what makes it quick.

1. **More places (M).** The bus stop plus **two or three nearby places**, reached by a "walk" command that costs turns and satiety and carries the risk of missing a bus sighting (D2 B). Suggested for the demo: the **gas station** (a shop with a rotating stock, a microwave, an attendant), the **underpass** (dangerous and rich in loot, home of a zombie nest), and a **park** (hippies, flowers). Each place gets its own forage table and encounter table, with time-of-day variants.
2. **A cast who remember you (M).** Today the hippie, beggar, vendor and proselytizer are rolled fresh and forgotten. Give each a name, a state (what they know about you), and **a three-step chain** told in the generic conversation state: for example, the hippie asks for litter again and again, then offers a map, then asks you for something you cannot give. Chains pay off in items, shortcuts, bestiary entries and the odd joke. Suggested demo cast: **five** recurring characters. Names and lines are written by me from the user's tone notes and approved by the user.
3. **Things to find, make and carry (M).** A recipe table of **8 to 12 combinations** (for example, sammich plus guts, bottle plus holy water), **three weapon tiers** that are found rather than only broken, and **armour** for the head and body. Each new item should change a decision, not only a number. The flower stays pointless (vault rule); say so in its description.
4. **More kinds of zombie (M).** Three or four types with different counters: the shambler (today's), a fast one that attacks twice and is distractible by guts, a bloater that explodes when killed in melee and so wants holy water or distance, and a big one at night. Existing items get niches rather than all being "attack harder".
5. **Stretch (D11):** a sanity or boredom stat and false alarms ("THE BUS IS HERE! IT WAS A DELIVERY TRUCK.").

**Exit (content-complete for the demo):** three days with their set pieces, two or three places, five cast chains, 12 items or recipes, four zombie types.
**Gate:** the user plays the whole demo once and lists what to cut.

### Phase 4: a reason to come back (M)

1. **Meta-progression.** At the end of a run, convert the run into a persistent currency (virtue is the obvious thing to deepen; the vault suggests starting perks bought with accumulated virtue). Spend it on **8 or so starting perks** (a bottle, extra health, a flower, a discount, a cleaner sammich). Each costs more than the last and none removes the danger.
2. **Bestiary and journal.** Everyone and everything met is logged, with a line of flavour each. This is also a cheap way to show the player how much of the game they have seen.
3. **Daily seed (S, optional).** The seed feature from Kordanor's Cabal (`?seed=` and `--seed`) gives a shareable run for free.

**Exit:** a second run feels different from the first, with the sim showing runs spread over day 2 to day 6.

### Phase 5: make it a product (M to L; can overlap phases 3 and 4)

1. **Native client (M).** Reuse Murder Hobo's SDL2 platform layer (window, integer scaling, per-user save directory, `--seed`, `--script`, `--dump`). The game core already has no platform dependencies. Add a **16:9 window**: the 256 by 192 grid scaled by an integer, centred, with a frame or side panels (clock, day, stats) in the spare space, which is also what makes **1920 by 1080 screenshots** possible without cropping.
2. **Controller and Steam Deck.** Numbered menus map cleanly to a d-pad and A/B buttons. A pad cursor highlights a row and confirms.
3. **Audio (M, D6).** A small synthesizer in the platform layer, with square and noise channels, SFX for each action and a handful of looping tracks written as note tables. Everything original; the ledger records that.
4. **Options and polish (S).** Volume, full screen, window size, a credits screen listing every source (including the "yer" voice credits and the AI disclosure), a saved-game prompt, a quit that saves.
5. **Windows build path (S to M, D8).** Prove a Windows binary exists before anything depends on it.

**Exit:** `./tools/build.sh native` produces a Windows and a Linux build that a stranger could install and play.

### Phase 6: the demo cut and quality (M)

1. **Demo build.** A flag (not a fork) that limits the game to the first three days, disables achievements, and ends with a screen that says what the full game adds.
2. **QA and balance.** The sim at scale, the existing soak test extended with the new states, a **save-fuzz test** (kill and reload at random points, as Kordanor's Cabal does), and the menu-never-lost check I used for the scroll fix. A playtest on stream.
3. **Fix list and content freeze** about three weeks before the demo is submitted.

### Phase 7: the Steam track (S to M, in parallel from phase 3)

Not code, and it has waiting periods, so it starts early.

1. **Steamworks account and the $100 fee**, paid once D1 to D10 are answered, and **by mid November at the latest**: the store page needs the app to exist and a 1 to 5 day review before it can go public. (The 30-day wait only gates the release itself, but paying early starts that clock too.)
2. **Store page** (description, tags, content survey, AI disclosure D10) submitted so it goes public as "coming soon" **at least 2 weeks, and ideally 6 weeks, before the fest**, because wishlists are what Next Fest runs on.
3. **Assets:** every size listed in section 3, **at least 5 screenshots**, and a **trailer** (required for Next Fest). The screenshot and trailer pipeline already exists in a rough form: the game's own display grid plus the real font, driven by scripted key presses, rendered to PNG. Extend it to render 1920 by 1080 frames and an ffmpeg video from a scripted run, which removes the need for screen recording.
4. **Demo app, depots, and an upload** with the Steam build tools, submitted for review 3 weeks before the fest.
5. **Register for Next Fest** once the base page is public.

## 6. Targets the simulator should hit

First guesses, to be tuned with the sim, not decided facts:

| Measure | Today | Target |
| --- | --- | --- |
| Naive bot (never eats or heals) | dies at turn 96 (a third of a day) | still dies on day 1 |
| Careful bot | never dies (75+ days) | median death **day 3 to 5**, p90 below day 8 |
| Sustainability | foraging gives 1.04 satiety per turn against a cost of 1 | below 0.8 once spoilage and exertion are in |
| Danger | constant | doubles by day 3 |
| First-run length (a person) | about 8 minutes dying, unlimited living | 45 to 60 minutes to reach day 3 |
| Fights per day | a fight on about 4% of turns, so **about 11 a day, all day and night, forever** | about 6 on day 1 (mostly at night) rising to about 16 on day 3, with quiet daylight hours |

## 7. Schedule

Anchored on the **February 2027 Next Fest**. Week 1 starts Monday, October 12, 2026. The weeks are working weeks and assume the user can review about one build a day.

| Weeks | Dates | Work | Checkpoint |
| --- | --- | --- | --- |
| 0 | Oct 8 to 11 | Phase 0: decisions | D1 to D10 answered |
| 1 | Oct 12 to 18 | Phase 1: clear the gates; start phase 2 foundations | A build with no GPL font and a licence ledger |
| 2 to 3 | Oct 19 to Nov 1 | Phase 2: foundations, sim, days, economy, score, saves | **A: a run is a three-day arc and the careful bot dies on days 3 to 5** |
| 3 | by Nov 2 | Pay the Steam fee (after the decisions) | App exists; the 30-day release clock starts |
| 3 to 7 | Nov 2 to 29 | Phase 3: places, cast, items, zombies | **B: demo content-complete** |
| 6 to 9 | Nov 16 to Dec 13 | Phase 4 (progression) and phase 5 (native, audio, controller) | **C: native Windows and Linux builds playable** |
| 8 to 11 | Dec 7 to 27 | Phase 7: store assets, trailer, page submitted | Page public as "coming soon" by about Dec 20 |
| 11 to 14 | Dec 28 to Jan 17 | Phase 6: QA, balance, playtest on stream; **content freeze Jan 3** | **D: release candidate** |
| 15 | Jan 18 to 24 | Upload the demo and submit it for review | Submitted at least 3 weeks before the fest |
| 16 | Jan 25 to 31 | Buffer, review fixes, Next Fest registration | Ready |

If checkpoint C or D slips by more than two weeks, **move to June 2027** instead of cutting the demo; the single Next Fest entry is worth more than the date.

## 8. What makes this quick

- **Content as data.** After the foundations phase, a place, a cast chain, an item or a zombie is a table entry plus text, not new procedures. That is the difference between weeks and months.
- **The simulator replaces playtests for balance**, and runs thousands of games a minute.
- **The tools already exist in this repo and the vault:** the bots, the soak test, the menu-never-lost check, the scripted screenshots, the SDL2 and save patterns from Murder Hobo and Kordanor's Cabal, and the seeds.
- **No Steamworks SDK for the demo** (D9), so nothing blocks on a binding that may not exist.
- **Writing is cheap here.** The voice is rule-based (yer, deadpan, uppercase, 32 columns), and the first draft of every line can come from Claude and be edited by the user. Disclosed on the store page (D10).
- **The itch.io web build keeps running** as the free front door and keeps getting the same code, so there is one game, not two.

## 9. Pillars (what not to break)

- The voice: **"yer", never "your" or "you're"**, uppercase, deadpan, no winking at the camera about difficulty.
- The interface: **numbered menus**, 32 by 16 text grid, tap to select. Nothing here adds free movement or character sprites.
- The joke: the bus does not come (D2 decides how far this bends). **The flower stays pointless.**
- Honest copy: the store page says what the game is, and that it was made with Claude Code.
- Nothing is published, pushed or paid for without the user saying so.

## 10. Risks

| Risk | Why it matters | What to do |
| --- | --- | --- |
| **The demo is too thin** | One Next Fest per game, and it is spent on the first entry. | Use the date gate in section 7 (June is the fallback). |
| **The joke dies under the structure** | A game with perks and chains may stop feeling like waiting for a bus. | Keep every system in the voice; the bus never gets closer in the demo; the user plays each phase before the next. |
| **Scope creep** | There are many good ideas here. | Content freeze January 3, and a cut list from the phase 3 gate. |
| **Windows builds** | Odin cannot cross-build Windows from this machine (per the vault). | Prove a Windows build in phase 1 or 5, before building features on top. |
| **Licence gaps** | One missed font or sound means a store takedown. | The ledger, started in phase 1 and checked before every release. |
| **Title clash** | Another game with the same name appears on the jam page. | D7. |
| **The AI stance** | The vault notes it costs some sales and reviews. | Disclose plainly (D10); the demo is the best answer to "is it any good". |
| **Competing with Kordanor's Cabal** | The vault ranks it as the front runner and pays off a long debt. | D1. |

## 11. Still to verify before spending money

1. The exact **February and June 2027 Next Fest dates** and deadlines.
2. **AI disclosure** on the live content survey form.
3. **Steam Auto-Cloud** setup for a native game with no SDK.
4. **Odin and Steamworks** bindings, for the full game's achievements.
5. A **Windows build** of the native client.
6. **m5x7** (or any replacement font) terms, read from the author's pages, if D4 picks it. The vault's note says a model read them and they should be confirmed.
7. The **title** (D7) and what in the game comes from the Famicase cover (D5).
8. **Whether the demo app needs its own $100 fee.** Valve's fee page says $100 "for each new app" and does not say whether a demo counts; the demo page says to click "Add Demo" on the base game and mentions no fee. I believe it is free, but that is not confirmed from Valve's text. Check at the "Add Demo" step, before any payment, or ask Steam support.

## Related

`TODO.md` (a pointer to this plan) · the vault pages `Strategy/Steam pivot evaluation`, `Games/How Am I Still Waiting For The Bus`, `Games/Murder Hobo of SPLORR!!` and `Tech/Kordanor's Cabal Odin port`.
