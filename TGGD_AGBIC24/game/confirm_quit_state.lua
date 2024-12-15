local display_buffer = require("display_buffer.display_buffer")
local states = require("game.states")
local commands = require("game.commands")
local data = require("game.data")

local M = {}

function M.update(dt)
	display_buffer.clear(97)
	display_buffer.write_line("ARE YOU SURE YOU WANT TO QUIT?", 2)
	display_buffer.write_line(" ", 1)
	display_buffer.write("1)", 2)
	display_buffer.write_line("YES", 1)
	display_buffer.write("0)", 2)
	display_buffer.write_line("NO", 1)
	return states.CONFIRM_QUIT
end

function M.handle_command(command)
	if command == commands.ONE then
		return states.TITLE
	elseif command == commands.ZERO then
		return states.IN_PLAY
	end
	return states.CONFIRM_QUIT
end

return M