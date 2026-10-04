#+build js
package bus

import "base:runtime"
import "core:math/rand"
import "core:time"
import "core:sys/wasm/js"

foreign import host "env"

@(default_calling_convention = "contextless")
foreign host {
	// Implemented in web/index.html: draws COLUMNS x ROWS tile indices (row-major, top row first).
	present :: proc(cells: ^[ROWS][COLUMNS]u8) ---
}

main :: proc() {
	// The default RNG returns the same sequence every run in the wasm build.
	rand.reset(u64(time.now()._nsec))
	js.add_window_event_listener(.Key_Down, nil, on_key_down)
}

on_key_down :: proc(e: js.Event) {
	command: Command
	switch e.key.code {
	case "Digit0", "Numpad0": command = .Zero
	case "Digit1", "Numpad1": command = .One
	case "Digit2", "Numpad2": command = .Two
	case "Digit3", "Numpad3": command = .Three
	case "Digit4", "Numpad4": command = .Four
	case "Digit5", "Numpad5": command = .Five
	case "Digit6", "Numpad6": command = .Six
	case "Digit7", "Numpad7": command = .Seven
	case "Digit8", "Numpad8": command = .Eight
	case "Digit9", "Numpad9": command = .Nine
	case "Enter", "NumpadEnter": command = .Enter
	case "Backspace": command = .Backspace
	case "Delete", "NumpadDecimal": command = .Delete
	case: return
	}
	if !e.key.repeat {
		game_handle_command(command)
	}
}

@(export)
step :: proc(dt: f64) -> (keep_going: bool) {
	context = runtime.default_context()
	free_all(context.temp_allocator)
	game_update()
	present(&display.cells)
	return true
}

// Called from web/index.html with the screen row (0 = top) the player tapped.
@(export)
touch_row :: proc "c" (row: i32) {
	context = runtime.default_context()
	if row >= 0 && row < ROWS {
		if command, ok := display.taps[row].?; ok {
			game_handle_command(command)
		}
	}
}
