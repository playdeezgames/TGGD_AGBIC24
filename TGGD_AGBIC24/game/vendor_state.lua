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
    display_buffer.write_line("YOU HAVE "..data.get_money().." CENTS", 1)
    display_buffer.write_line("YOU HAVE "..data.get_sammiches().." HALF-EATEN SAMMICHES", 1)
	display_buffer.write_line(" ", 1)
    if data.can_buy_sammich() then
        display_buffer.write("1)", 2)
        display_buffer.write_line("I'LL TAKE ONE!", 1)
    end
	display_buffer.write("0)", 2)
	display_buffer.write_line("SORRY, I'M BROKE!", 1)
	return states.VENDOR
end

function M.handle_command(command)
	if command == commands.ZERO then
		return data.deny_vendor()
    elseif command == commands.ONE and data.can_buy_sammich() then
        return data.accept_vendor()
    end
	return states.VENDOR
end

return M