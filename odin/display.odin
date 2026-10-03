package bus

COLUMNS :: 32
ROWS    :: 16

// Tile indices are 1-based into CoCoFontSmall.png (32 tiles per row, 8x12 px each).
// Character set 1 is the normal text (tiles 65..128), set 2 the highlighted text (tiles 1..64).
Character_Set :: enum {
	Normal    = 1,
	Highlight = 2,
}

BLANK_CELL :: 97

Display :: struct {
	cells:  [ROWS][COLUMNS]u8, // row 0 is the top of the screen
	column: int,
	row:    int,
}

display: Display

char_to_tile :: proc(c: u8, set: Character_Set) -> u8 {
	c := c
	if c >= 'a' && c <= 'z' {
		c -= 'a' - 'A'
	}
	if c < 32 || c > 95 {
		c = ' '
	}
	tile := u8(c < 64 ? c + 1 : c - 63)
	return set == .Normal ? tile + 64 : tile
}

display_set_cell :: proc(column, row: int, cell: u8) {
	if column >= 0 && column < COLUMNS && row >= 0 && row < ROWS {
		display.cells[row][column] = cell
	}
}

display_clear :: proc(cell: u8 = BLANK_CELL) {
	for &line in display.cells {
		for &c in line {
			c = cell
		}
	}
	display.column = 0
	display.row = 0
}

display_write_cell :: proc(cell: u8) {
	display_set_cell(display.column, display.row, cell)
	display.column += 1
	if display.column >= COLUMNS {
		display.column = 0
		// TODO: scroll screen (the Defold version just overwrites the last line too)
		display.row = min(display.row + 1, ROWS - 1)
	}
}

display_write :: proc(text: string, set: Character_Set = .Normal) {
	for i in 0 ..< len(text) {
		display_write_cell(char_to_tile(text[i], set))
	}
}

display_new_line :: proc(set: Character_Set = .Normal) {
	for display.column != 0 {
		display_write(" ", set)
	}
}

display_write_line :: proc(text: string, set: Character_Set = .Normal) {
	display_write(text, set)
	display_new_line(set)
}

// Draws a numbered menu entry such as "1)WAIT FOR BUS" with the key highlighted.
display_menu_item :: proc(key: string, label: string) {
	display_write(key, .Highlight)
	display_write_line(label)
}
