local display_buffer = require("display_buffer.display_buffer")
local states = require("game.states")
local commands = require("game.commands")
local data = require("game.data")

local M = {}

function M.update(dt)
	display_buffer.clear(97)
	display_buffer.write_line("HOW AM I STILL WAITING FOR THE  BUS?", 2)
	display_buffer.write_line("A PRODUCTION OF THEGRUMPYGAMEDEV", 1)
	display_buffer.write_line("A GAME BY ITS COVER 2024", 1)
	display_buffer.write_line("DECEMBER 2024", 1)
	display_buffer.write_line(" ", 1)
	display_buffer.write("1)", 2)
	display_buffer.write_line("NEW GAME", 1)
	display_buffer.write("2)", 2)
	display_buffer.write_line("INSTRUCTIONS", 1)
	return states.TITLE
end

function M.handle_command(command)
	if command == commands.ONE then
		data.new_game()
		return states.IN_PLAY
	elseif command == commands.TWO then
		return states.INSTRUCTIONS
	end
	return states.TITLE
end

return M