local states = require("game.states")

local M = {}

local data = {}

function M.new_game()
	data = {}
	M.set_wait_time(0)
	M.initialize_satiety()
	M.initialize_health()
	M.clear_messages()
	M.add_message("YOU ARRIVE AT THE BUS STOP IN   PLENTY OF TIME TO CATCH YER BUS")
end

function M.initialize_health()
	M.set_maximum_health(100)
	M.set_health(M.get_maximum_health())
end

function M.set_maximum_health(value)
	data.maximum_health = value
end

function M.get_maximum_health()
	return data.maximum_health
end

function M.set_health(value)
	data.health = vmath.clamp(value, 0, M.get_maximum_health())
end

function M.get_health()
	return data.health
end

function M.initialize_satiety()
	M.set_maximum_satiety(100)
	M.set_satiety(M.get_maximum_satiety())
end

function M.set_maximum_satiety(value)
	data.maximum_satiety=value
end

function M.get_maximum_satiety()
	return data.maximum_satiety
end

function M.set_satiety(value)
	data.satiety = vmath.clamp(value,0, M.get_maximum_satiety())
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
	M.perform_hunger()
	if M.is_dead() then
		return states.DEAD
	else
		return states.IN_PLAY
	end
end

function M.is_dead()
	return M.get_health() == 0
end

function M.perform_hunger()
	if M.get_satiety()>0 then
		M.add_message("-1 SATIETY")
		M.set_satiety(M.get_satiety()-1)
		M.add_message("SATIETY: "..M.get_satiety().."/"..M.get_maximum_satiety())
	elseif M.get_health()>0 then
		M.add_message("YER STARVING!")
		M.add_message("-1 HEALTH")
		M.set_health(M.get_health()-1)
		M.add_message("HEALTH:"..M.get_health().."/"..M.get_maximum_health())
	end
end

function M.get_satiety()
	return data.satiety
end

return M
