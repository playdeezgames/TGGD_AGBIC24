local states = require("game.states")

local M = {}

local current_state = states.TITLE
local game_states={}
game_states[states.TITLE] = require("game.title_state")
game_states[states.INSTRUCTIONS] = require("game.instructions_state")
game_states[states.IN_PLAY] = require("game.in_play_state")
game_states[states.CONFIRM_QUIT] = require("game.confirm_quit_state")
game_states[states.DEAD] = require("game.dead_state")
game_states[states.INVENTORY] = require("game.inventory_state")
game_states[states.FIGHT] = require("game.fight_state")
game_states[states.STATUS] = require("game.status_state")
game_states[states.HIPPIE] = require("game.hippie_state")
game_states[states.VENDOR] = require("game.vendor_state")
game_states[states.BEGGAR] = require("game.beggar_state")


function M.update(dt)
	current_state = game_states[current_state].update(dt)
end

function M.handle_command(command)
	current_state = game_states[current_state].handle_command(command)
	print(current_state)
end

return M