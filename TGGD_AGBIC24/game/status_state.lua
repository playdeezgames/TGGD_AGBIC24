local display_buffer = require("display_buffer.display_buffer")
local states = require("game.states")
local commands = require("game.commands")
local data = require("game.data")

local M = {}

function M.update(dt)
	display_buffer.clear(97)
	display_buffer.write_line("STATUS:", 2)
    display_buffer.write_line("HEALTH:"..data.get_health().."/"..data.get_maximum_health(), 1)
    display_buffer.write_line("SATIETY: "..data.get_satiety().."/"..data.get_maximum_satiety(), 1)
    display_buffer.write_line("VIRTUE: "..data.get_virtue(), 1)
	display_buffer.write_line(" ", 1)
	display_buffer.write("0)", 2)
	display_buffer.write_line("DONE", 1)
	return states.STATUS
end

function M.handle_command(command)
	if command == commands.ZERO then
		return data.get_next_state()
	end
	return states.STATUS
end

return M