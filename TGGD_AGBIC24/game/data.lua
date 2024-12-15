local states = require("game.states")

local M = {}

local data = {}

function M.new_game()
	data = {}
	M.set_wait_time(0)
	M.clear_messages()
	M.add_message("YOU ARRIVE AT THE BUS STOP IN   PLENTY OF TIME TO CATCH YER BUS")
end

function M.set_wait_time(value)
	data.wait_time = value
end

function M.get_wait_time()
	return data.wait_time
end

function M.clear_messages()
	data.messages={}
end

function M.add_message(message)
	table.insert(data.messages, message)
end

function M.get_messages()
	return data.messages
end

function M.wait_for_bus()
	M.clear_messages()
	M.add_message("YOU WAIT FOR THE BUS")
	M.set_wait_time(M.get_wait_time()+1)
	if M.get_wait_time() == 1 then
		M.add_message("YOU HAVE BEEN WAITING FOR "..M.get_wait_time().." MINUTE")
	else
		M.add_message("YOU HAVE BEEN WAITING FOR "..M.get_wait_time().." MINUTES")
	end
	return states.IN_PLAY
end

return M
