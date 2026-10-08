#+build !js
package bus

import "core:math/rand"
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
	// Quitting is rare in the mix on purpose: with a flat 1 in 6 chance of opening the quit prompt, a
	// seed in about 8 never got a single game to end in death within 200 games. A fixed seed makes it repeatable.
	commands := [?]Command{.Zero, .One, .One, .One, .Two, .Two, .Two, .Three, .Four, .Five}
	seen: [State]bool
	rand.reset(2026_10_08)
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

@(test)
eating_zombie_guts_sets_poison_to_25_without_stacking :: proc(t: ^testing.T) {
	begin_test()
	defer end_test()
	new_game()
	data.zombie_guts = 2
	testing.expect_value(t, eat_zombie_guts(), State.In_Play)
	testing.expect_value(t, data.poison, 25)
	testing.expect_value(t, data.zombie_guts, 1)
	data.poison = 10
	eat_zombie_guts()
	testing.expect_value(t, data.poison, 25)
	testing.expect_value(t, data.zombie_guts, 0)
}

@(test)
poison_costs_health_and_wears_off_each_satiety_check :: proc(t: ^testing.T) {
	begin_test()
	defer end_test()
	new_game()
	data.poison = 2
	clear_messages()
	perform_hunger()
	testing.expect_value(t, data.poison, 1)
	testing.expect_value(t, data.health, 99)
	testing.expect_value(t, data.satiety, 99)
	testing.expect_value(t, data.messages[len(data.messages) - 1], "YER POISONED! -1 HEALTH")
	perform_hunger()
	perform_hunger()
	testing.expect_value(t, data.poison, 0)
	testing.expect_value(t, data.health, 98)
	testing.expect(t, !data.turned_zombie)
}

@(test)
dying_while_poisoned_turns_you_into_a_zombie :: proc(t: ^testing.T) {
	begin_test()
	defer end_test()

	// the poison tick itself is fatal, with the last of the poison
	new_game()
	data.health = 1
	data.poison = 1
	perform_hunger()
	testing.expect_value(t, get_next_state(), State.Dead)
	testing.expect(t, data.turned_zombie)

	// starvation is fatal while poisoned
	new_game()
	data.satiety = 0
	data.health = 1
	data.poison = 5
	perform_hunger()
	testing.expect_value(t, get_next_state(), State.Dead)
	testing.expect(t, data.turned_zombie)

	// a zombie attack is fatal while poisoned
	new_game()
	data.health = 1
	data.poison = 5
	data.zombie_health = 25
	data.zombie_attack = 1000
	data.defend = 1
	for !is_dead() {
		counter_attack()
	}
	testing.expect(t, data.turned_zombie)

	// dying without poison is an ordinary death
	new_game()
	data.satiety = 0
	data.health = 1
	perform_hunger()
	testing.expect_value(t, get_next_state(), State.Dead)
	testing.expect(t, !data.turned_zombie)
}

@(test)
overflowing_text_scrolls_instead_of_overwriting_the_menu :: proc(t: ^testing.T) {
	begin_test()
	defer end_test()

	// exactly ROWS lines: nothing scrolls
	display_clear()
	for i in 0 ..< ROWS {
		display_write_line(i == 0 ? "A" : "B")
	}
	testing.expect_value(t, display.cells[0][0], char_to_tile('A', .Normal))

	// one more line pushes the first one off the top
	display_clear()
	for i in 0 ..< ROWS {
		display_write_line(i == 0 ? "A" : "B")
	}
	display_menu_item("1)", "LAST")
	testing.expect_value(t, display.cells[0][0], char_to_tile('B', .Normal))
	testing.expect_value(t, display.cells[ROWS - 1][0], char_to_tile('1', .Highlight))
	testing.expect(t, display.taps[ROWS - 1] == Command.One)
	testing.expect(t, display.taps[0] == nil)

	// a menu that overflows keeps every option, each on its own row
	display_clear()
	for _ in 0 ..< ROWS - 1 {
		display_write_line("TEXT")
	}
	display_menu_item("1)", "ONE")
	display_menu_item("0)", "ZERO")
	testing.expect(t, display.taps[ROWS - 2] == Command.One)
	testing.expect(t, display.taps[ROWS - 1] == Command.Zero)
}

@(test)
thrown_guts_distract_the_zombie_for_three_turns :: proc(t: ^testing.T) {
	begin_test()
	defer end_test()
	new_game()
	spawn_zombie()
	data.zombie_attack = 1000
	data.defend = 1
	data.zombie_guts = 2

	testing.expect_value(t, throw_zombie_guts(), State.Fight)
	testing.expect_value(t, data.zombie_guts, 1)
	testing.expect_value(t, data.zombie_distracted, 3)
	testing.expect_value(t, data.health, 100)

	// throwing again while distracted restarts the count, it does not add to it
	throw_zombie_guts()
	testing.expect_value(t, data.zombie_distracted, 3)

	// three counter-attacks are skipped, and the fourth one lands
	for _ in 0 ..< 3 {
		counter_attack()
		testing.expect_value(t, data.health, 100)
	}
	testing.expect_value(t, data.zombie_distracted, 0)
	for _ in 0 ..< 100 {
		if data.health < 100 { break }
		counter_attack()
	}
	testing.expect(t, data.health < 100)
}

@(test)
a_new_zombie_is_not_distracted :: proc(t: ^testing.T) {
	begin_test()
	defer end_test()
	new_game()
	data.zombie_distracted = 2
	spawn_zombie()
	testing.expect_value(t, data.zombie_distracted, 0)
	testing.expect_value(t, data.zombie_health, 25)
}
