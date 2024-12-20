local display_buffer = require("display_buffer.display_buffer")
local states = require("game.states")
local commands = require("game.commands")
local data = require("game.data")

local M = {}

function M.update(dt)
	display_buffer.clear(97)
	display_buffer.write_line("YER DEAD!", 2)
	display_buffer.write_line("FINAL SCORE: "..data.get_final_score(), 2)
	for _, message in ipairs(data.get_messages()) do
		display_buffer.write_line(message, 1)
	end
	display_buffer.write_line(" ", 1)
	display_buffer.write("0)", 2)
	display_buffer.write_line("DONE", 1)
	return states.DEAD
end

function M.handle_command(command)
	if command == commands.ZERO then
		return states.TITLE
	end
	return states.DEAD
end

return M