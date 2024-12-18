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
	display_buffer.write_line("ATTACK!", 1)
	if data.get_flowers()>0 then
		display_buffer.write("2)", 2)
		display_buffer.write_line("USE FLOWER!", 1)
	end
	return states.FIGHT
end

function M.handle_command(command)
	if command == commands.ONE then
		return data.attack()
	elseif command == commands.TWO and data.get_flowers()>0 then
		return data.use_flower()
	end
	return states.FIGHT
end

return M