#+build !js
package bus

import "core:testing"

// The test runner gives every test its own allocator, so each test must start from (and leave behind)
// a state that holds no allocations from another test.
begin_test :: proc() {
	data = {}
	current_state = .Title
}

end_test :: proc() {
	clear_messages()
	delete(data.messages)
	data = {}
}

@(test)
random_playthroughs_never_crash :: proc(t: ^testing.T) {
	commands := [?]Command{.Zero, .One, .Two, .Three, .Four}
	seen: [State]bool
	begin_test()
	defer end_test()
	for _ in 0 ..< 200 {
		current_state = .Title
		game_handle_command(.One)
		for _ in 0 ..< 2000 {
			game_update()
			seen[current_state] = true
			game_handle_command(random_pick(commands[:]))
		}
	}
	for s in State {
		testing.expectf(t, seen[s], "state %v was never reached", s)
	}
}

@(test)
glyph_mapping_matches_defold_tables :: proc(t: ^testing.T) {
	testing.expect_value(t, char_to_tile(' ', .Normal), 97)
	testing.expect_value(t, char_to_tile('@', .Normal), 65)
	testing.expect_value(t, char_to_tile('?', .Normal), 128)
	testing.expect_value(t, char_to_tile('Z', .Highlight), 27)
	testing.expect_value(t, char_to_tile('0', .Highlight), 49)
}

@(test)
holy_water_explodes_the_zombie_and_leaves_guts :: proc(t: ^testing.T) {
	begin_test()
	defer end_test()
	new_game()
	data.zombie_health = 25
	data.holy_water = 2
	next := use_holy_water()
	testing.expect_value(t, next, State.In_Play)
	testing.expect_value(t, data.holy_water, 1)
	testing.expect_value(t, data.zombie_guts, 1)
	testing.expect_value(t, data.zombie_kills, 1)
}

@(test)
donating_costs_money_and_gives_holy_water :: proc(t: ^testing.T) {
	begin_test()
	defer end_test()
	new_game()
	data.proselytizer = true
	data.money = 12
	testing.expect(t, can_afford_holy_water())
	next := accept_proselytizer()
	testing.expect_value(t, next, State.In_Play)
	testing.expect_value(t, data.money, 2)
	testing.expect_value(t, data.holy_water, 1)
	testing.expect(t, !can_afford_holy_water())
}
