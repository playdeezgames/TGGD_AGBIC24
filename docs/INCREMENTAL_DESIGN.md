# Incremental design: Bus Anticipator of SPLORR!!

Status: **first draft, October 8, 2026, with the first two rounds of answers in. Design only; nothing here is built.** It turns the decisions in `docs/STEAM_DEMO_PLAN.md` ("The direction") into a loop that can be built and tuned. **Every number is a first guess to be tuned with the simulator** (`odin/tools/sim`, phase 2 of the plan), not a decision. Text for the road is **not** written here; see section 9a of the plan and section 8 below.

## 1. The loop in one paragraph

A **run** is one stay at the bus stop. It ends when the player's health hits 0, or (when morale is low enough) when the player steps into the road and the bus hits them. Either way the run is scored in **advancement points** that depend only on **how long the run lasted**. Points are spent in the **advancement shop** on **starting perks, unlocks, automation rules and the journal**. Then a new run starts, a little stronger and with a little more of the world open. A demo is **four to six** such runs in 45 to 60 minutes.

The currency has to make a long run worth more than a short one, and it must **never make the road the better way to end a run** (plan section 9a).

## 2. A run

- **Clock.** 1 turn = 5 game minutes; a day is 288 turns. A run begins at 6:15 a.m. on day 1. The day number scales the danger (plan, phase 2).
- **Needs.** Satiety and health as now, plus **morale** (section 3). Poison stays as it is.
- **Ends.** Health 0 by any cause (zombie, starvation, poison), or the road. **Every ending pays the same** (section 4). The game over screen says how it ended and what it paid.
- **No forced ending.** At morale 0 nothing happens by itself; the road is only ever a choice.

## 3. Morale

A new stat that gates the road (the user's design). It is also a way to make the waiting itself costly, because waiting is what the game is about.

- **Name. Decided: MORALE, higher is better**, shown as `MORALE: 62/100`, like health and satiety.
- **Range and start.** 0 to 100. A run starts at **70**.
- **What lowers it** (first guesses):

| Event | Change |
| --- | --- |
| Each turn spent waiting or foraging | -1 every 4th turn (about -72 a day) |
| Night (from 8 p.m. to 6 a.m.), extra | -1 every 6th turn |
| Foraging finds nothing | -1 |
| Taking damage from a zombie | -3 per hit |
| A zombie turns up | -2 |
| Starving | -2 per turn |
| Poisoned | -1 per turn |
| Turning someone away (beggar, hippie, vendor, proselytizer) | -2 |

- **What raises it** (first guesses):

| Event | Change |
| --- | --- |
| Eating a sammich | +4 |
| Finding loose change | +2 |
| Killing a zombie | +5 |
| Helping someone (giving the hippie litter, the beggar change, paying the proselytizer) | **+3 (decided)**, so virtue and morale tie together |
| A new dawn | +10, so getting through a night matters |
| Using a bandage | +1 |
| **A flower** | **0. The flower stays pointless.** |

- **The gate.** The road option appears at the bus stop only at **morale 15 or below**. From **30 or below** there may be hints in the message text, with the wording to be written and approved (plan section 9a).
- **Other effects of low morale: flavour only (decided).** The messages and the status line get gloomier, but no stat changes. Morale is a gate and a mood, not a punishment; nothing gets weaker because it is low. (This keeps the road from being a "get out of a bad state" button with a reward attached.)
- **What the numbers should do.** Waiting alone drains about 72 morale a day and a dawn gives back 10, so a **quiet player drifts to the gate in about a day and a half**, which is where the road starts to be a real option. Comfort (sammiches, helping people, killing zombies) pushes it back. Perks and automation can slow the drain, so a stronger run lasts longer. The simulator checks that the road becomes available in roughly the middle of a typical run, and that no strategy can hold morale high forever.

## 4. Advancement points

- **Formula (decided: diminishing returns).** `points = round(5 * sqrt(turns / 100))`, where `turns` is the number of turns the run lasted. **Every ending pays the same.**
- **Why that shape.** A first run today lasts about 100 turns and pays 5, which is enough for the first perk. Longer runs pay more but with diminishing returns, so the longest possible run is not the only strategy.

| Run length | Turns | Points |
| --- | --- | --- |
| A bad first run (today's average) | 96 | 5 |
| A third of a day | 100 | 5 |
| One day | 288 | 8 |
| Three days (the demo target) | 864 | 15 |
| Ten days | 2,880 | 27 |
| 75 days (the careful bot today) | 21,500 | 73 |

- **Total in the demo.** Four to six runs at 5, 7, 9, 11, 13 and 15 pay about **60 points**, so the demo shop should hold about **100** points of things and the player affords roughly the first half.

## 5. The shop

All four things the user chose (D2). Costs are first guesses. The demo shows only the first tier; the full game adds the rest.

### Starting perks (8 in the demo)

None removes the danger. Each changes the start of a run.

| Perk | Effect | Cost |
| --- | --- | --- |
| A Flower | Start with a flower. It is as pointless as ever. | 2 |
| Pocket Change | Start with 15 cents. | 3 |
| Spare Sammich | Start with a half-eaten sammich. | 5 |
| Roll of Bandages | Start with 2 bandages. | 7 |
| Thicker Skin | +10 maximum health. | 10 |
| Empty Bottle | Start with an empty beer bottle (attack doubled until it breaks). | 12 |
| Regular Customer | The vendor charges 20 cents, not 25. | 15 |
| Blessed | Start with one holy water. | 18 |

### Unlocks (content that is not there at first)

| Unlock | What arrives | Cost |
| --- | --- | --- |
| The gas station | A second place: a shop with a rotating stock and its own forage table. | 12 |
| The park | A third place: hippies, flowers and daytime quiet. | 18 |
| The underpass | A dangerous place with rich loot and a zombie nest. | 24 |
| Recurring cast, step 1 to 3 | A named visitor who remembers yer; one chain each for the hippie, the beggar and the vendor. | 10 each |
| Runner | A fast zombie that attacks twice and is distractible by guts. | 15 |
| Bloater | A zombie that explodes when killed in melee, so it wants holy water or distance. | 22 |
| Recipes, tier 1 | Combine two items into a third (for example sammich and guts). | 14 |

### Automation (rules the player buys and sets from a menu; decided October 8, 2026)

Automation plays the free turns so a long run takes fewer button presses. **Decided limits:** it **never fights and never presses the road**, and **every rule stops the moment anything happens** (an encounter, a fight, or morale reaching the gate). **Automated turns count exactly like turns played by hand, for run length and for points.**

| Rule | What it does | Cost | Status |
| --- | --- | --- | --- |
| Auto-eat | Eat a sammich when satiety falls below a set level (20, 40 or 60). | 20 | Chosen |
| Auto-bandage | Use a bandage when health falls below a set level. | 25 | Chosen |
| Forage until someone shows up | Repeat the forage turn until an encounter, the end of the day, or morale falls below the road gate. | 30 | Chosen |
| Wait until dawn | Repeat the wait turn until morning or an encounter. | 35 | Chosen |
| Decline politely | Turn away vendors, beggars, hippies and proselytizers without stopping. (It costs morale as usual.) | 40 | **Not confirmed.** The question that chose the rules could offer only four, so this one was not offered. It is out until the user says otherwise. |

- **Automation never presses the road, and stops when morale reaches the gate** (decided), so the player sees it and chooses.
- **The simulator measures what automation does to run length and to points per hour,** so it makes a run longer without making the early game trivial.

### The journal (bestiary)

A log of everyone and everything met, with a flavour line each. About **30 entries** in the demo (items, cast, zombie types, places, events). It is free, and it gives **no points**, so it cannot be ground for a reward. It shows the player how much of the game they have seen.

## 6. Screens (32 columns by 16 rows, numbered menus)

Mock-ups, not final text. Player-facing text follows the voice rules ("yer", never "your" or "you're", uppercase, deadpan).

```
BUS ANTICIPATOR OF SPLORR!!        <- title (header)
BEST RUN: 0 MINUTES                <- joke until the first run
POINTS: 7

1)NEW RUN
2)ADVANCEMENT
3)JOURNAL
4)INSTRUCTIONS
```

```
THAT WAS A RUN.                    <- run end (header)
YER LASTED 2 DAYS, 3 HOURS.
<ONE LINE ABOUT HOW IT ENDED>     <- text per ending, not written yet (section 8)
+11 POINTS
YOU HAVE 18 POINTS

1)ADVANCEMENT
2)NEW RUN
```

```
ADVANCEMENT: 18 POINTS             <- shop (header)
1)PERKS
2)UNLOCKS
3)RULES
0)BACK
```

```
RULES:                             <- automation
1)AUTO-EAT         BELOW 40  ON
2)AUTO-BANDAGE     (25 POINTS)
3)FORAGE UNTIL...  (30 POINTS)
0)BACK
```

The **status screen** gets a MORALE line, and the **game over screen** replaces the stub score with points.

## 7. Save and profile

One versioned JSON document per profile (browser storage on the web, a file in the per-user directory on the native client):

- points held, points ever earned, best run (turns), runs played;
- perks, unlocks and rules owned, and each rule's settings;
- the journal (a flag per entry).

**A run in progress is not saved (decided).** Runs are 10 to 20 minutes, so closing the game mid-run loses the run; the profile saves when a run ends and whenever something is bought. That removes a Continue option and a whole class of mid-run save bugs.

A profile from an older version loads and is migrated (the vault's Murder Hobo and Kordanor's Cabal notes describe the pattern); a corrupt one is set aside, never overwritten.

## 8. The road: text and rules (not written yet)

Plan section 9a governs. This section lists what has to be decided before any text exists:

- the content note wording (title screen and store page);
- the message at morale 30 or below, the road menu line, the bus text, and the game over line for it, each flat and short, none decorating or praising;
- the achievement's name and description (full game only), worded flatly;
- whether to add a crisis-line line to the credits or options screen (the user's call, in the TODO).

**The text is written only after the user approves the rules in plan section 9a**, and each line is shown to the user before it goes in.

## 9. Open questions

**Answered October 8, 2026:** the stat is **MORALE, higher is better**; **helping people lifts morale by 3**; the **points curve is diminishing returns**; **saving is between runs only**; **four automation rules are chosen** (auto-eat, auto-bandage, forage until someone shows up, wait until dawn), automation **never fights and never presses the road** and stops at anything that happens or at the morale gate, and **automated turns count the same as manual ones**; **low morale is flavour only.**

Still open:

1. **"Decline politely"** (the fifth automation rule) was not offered in the question, so it is out until the user says otherwise.
2. **The numbers.** Every number in sections 3 to 5 is a first guess; the simulator will say which are wrong.
3. **The text for the road** (section 8), which is written only after the user approves plan section 9a.

## 10. What the simulator has to answer

Once `odin/tools/sim` exists (plan, phase 2), these are measured, not guessed:

- The careful bot ends its run, on average, between **day 3 and day 5**, and the naive bot on **day 1**.
- **Morale reaches the road gate** in the middle of a typical run for most strategies, and **no strategy holds it high forever.**
- **Runs end by zombie, starvation, poison and the road in a spread** that is not nearly all one cause.
- **Points per run** follow the table in section 4, and **a first perk is affordable after one run and a first unlock after two.**
- **Automation** raises run length and points per hour without making the first run trivial.
- Across a **45 to 60 minute demo** (600 to 1,200 turns), a player reaches about four to six runs.

## Related

`docs/STEAM_DEMO_PLAN.md` (the decisions, section 9a on the road, the phases) · `TODO.md` · the vault page `Games/Bus Anticipator of SPLORR!!`.
