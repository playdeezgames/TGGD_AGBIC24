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
    if data.get_litter()>0 then
        display_buffer.write("1)", 2)
        display_buffer.write_line("HERE YA GO!", 1)
    end
	display_buffer.write("0)", 2)
	display_buffer.write_line("GET LOST", 1)
	return states.HIPPIE
end

function M.handle_command(command)
	if command == commands.ZERO then
		return data.deny_hippie()
    elseif command == commands.ONE and data.get_litter()>0 then
        return data.accept_hippie()
    end
	return states.HIPPIE
end

return M