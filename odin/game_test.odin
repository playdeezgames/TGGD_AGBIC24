#+build !js
package bus

import "core:testing"

@(test)
random_playthroughs_never_crash :: proc(t: ^testing.T) {
	commands := [?]Command{.Zero, .One, .Two, .Three, .Four}
	seen: [State]bool
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
