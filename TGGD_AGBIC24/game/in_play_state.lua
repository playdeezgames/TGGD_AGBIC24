local display_buffer = require("display_buffer.display_buffer")
local states = require("game.states")
local commands = require("game.commands")
local data = require("game.data")

local M = {}

function M.update(dt)
	display_buffer.clear(97)
	for _, message in ipairs(data.get_messages()) do
		display_buffer.write_line(message, 1)
	end
	display_buffer.write_line(" ", 1)
	display_buffer.write("1)", 2)
	display_buffer.write_line("WAIT FOR BUS", 1)
	display_buffer.write("2)", 2)
	display_buffer.write_line("FORAGE", 1)
	display_buffer.write("3)", 2)
	display_buffer.write_line("INVENTORY", 1)
	display_buffer.write("4)", 2)
	display_buffer.write_line("STATUS", 1)
	display_buffer.write("0)", 2)
	display_buffer.write_line("QUIT", 1)
	return states.IN_PLAY
end

function M.handle_command(command)
	if command == commands.ZERO then
		return states.CONFIRM_QUIT
	elseif command == commands.ONE then
		return data.wait_for_bus()
	elseif command == commands.TWO then
		return data.forage()
	elseif command == commands.THREE then
		return states.INVENTORY
	elseif command == commands.FOUR then
		return states.STATUS
	end
	return states.IN_PLAY
end

return M