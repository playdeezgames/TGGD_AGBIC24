local display_buffer = require("display_buffer.display_buffer")
local states = require("game.states")
local commands = require("game.commands")
local data = require("game.data")

local M = {}

function M.update(dt)
	display_buffer.clear(97)
	display_buffer.write_line("INVENTORY:", 2)
    local has_inventory = false
    if data.get_money() > 0 then
        display_buffer.write_line(data.get_money().." CENT(S) IN LOOSE CHANGE", 1)
        has_inventory = true
    end
    if data.get_litter() > 0 then
        display_buffer.write_line(data.get_litter().." PIECE(S) OF LITTER", 1)
        has_inventory = true
    end
    if data.get_sammiches() > 0 then
        display_buffer.write_line(data.get_sammiches().." HALF-EATEN SAMMICH(ES)", 1)
        has_inventory = true
    end
    if data.get_bandages() > 0 then
        display_buffer.write_line(data.get_bandages().." USED BANDAGE(S)", 1)
        has_inventory = true
    end
    if data.get_flowers() > 0 then
        display_buffer.write_line(data.get_flowers().." FLOWER(S)", 1)
        has_inventory = true
    end
    if data.get_beer_bottles() > 0 then
        display_buffer.write_line(data.get_beer_bottles().." EMPTY BEER BOTTLES", 1)
        has_inventory = true
    end
    if not has_inventory then
        display_buffer.write_line("NOTHING!", 1)
    end
	display_buffer.write_line(" ", 1)
    if data.get_sammiches() > 0 then
        display_buffer.write("1)", 2)
        display_buffer.write_line("EAT SAMMICH", 1)
    end
    if data.get_bandages() > 0 then
        display_buffer.write("2)", 2)
        display_buffer.write_line("(RE)USE BANDAGE", 1)
    end
    if data.get_flowers() > 0 then
        display_buffer.write("3)", 2)
        display_buffer.write_line("SMELL FLOWER", 1)
    end
	display_buffer.write("0)", 2)
	display_buffer.write_line("DONE", 1)
	return states.INVENTORY
end

function M.handle_command(command)
	if command == commands.ZERO then
		return states.IN_PLAY
    elseif command == commands.ONE and data.get_sammiches() > 0 then
        return data.eat_sammich()
    elseif command == commands.TWO and data.get_bandages() > 0 then
        return data.use_bandage()
    elseif command == commands.THREE and data.get_flowers() > 0 then
        return data.smell_flower()
    end
	return states.INVENTORY
end

return M