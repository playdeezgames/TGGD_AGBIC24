package bus

import "core:math/rand"

// Inclusive on both ends, like Lua's math.random(lo, hi).
random_range :: proc(lo, hi: int) -> int {
	return lo + rand.int_max(hi - lo + 1)
}

// Picks an index into an enum-indexed weight table, e.g. `[Encounter]int`.
pick_weighted :: proc(weights: [$E]int) -> E {
	total := 0
	for w in weights {
		total += w
	}
	generated := random_range(0, total - 1)
	for w, e in weights {
		if generated < w {
			return e
		}
		generated -= w
	}
	unreachable()
}

random_pick :: proc(items: []$T) -> T {
	return items[rand.int_max(len(items))]
}
