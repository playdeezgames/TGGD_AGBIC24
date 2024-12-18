local states = require("game.states")
local foraging = require("game.foraging")
local encounter = require("game.encounter")

local M = {}

local data = {}

function M.new_game()
	data = {}
	M.set_wait_time(0)
	M.initialize_satiety()
	M.initialize_health()
	M.set_litter(0)
	M.set_sammiches(0)
	M.set_bandages(0)
	M.set_zombie_attack(0)
	M.set_zombie_defend(0)
	M.set_zombie_health(0)
	M.set_attack(10)
	M.set_defend(10)
	M.set_virtue(0)
	M.set_money(0)
	M.set_flowers(0)
	M.set_hippie(false)
	M.clear_messages()
	M.add_message("YOU ARRIVE AT THE BUS STOP IN   PLENTY OF TIME TO CATCH YER BUS")
end

function M.set_flowers(value)
	data.flowers = math.max(0, value)
end

function M.get_flowers()
	return data.flowers
end

function M.set_hippie(value)
	data.hippie = value
end

function M.get_hippie()
	return data.hippie
end

function M.set_virtue(value)
	data.virtue = math.max(0,value)
end

function M.get_virtue()
	return data.virtue
end

function M.set_money(value)
	data.money = math.max(0, value)
end

function M.get_money()
	return data.money
end	

function M.set_attack(value)
	data.attack=math.max(0,value)
end

function M.set_defend(value)
	data.defend=math.max(0,value)
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
	M.perform_wait()
	M.perform_hunger()
	return M.get_next_state()
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

function M.perform_wait()
	M.set_wait_time(M.get_wait_time()+5)
	if M.get_wait_time() == 1 then
		M.add_message("YOU HAVE BEEN WAITING FOR "..M.get_wait_time().." MINUTE")
	else
		M.add_message("YOU HAVE BEEN WAITING FOR "..M.get_wait_time().." MINUTES")
	end
	encounter.check_for_encounter(M)
end

function M.set_zombie_attack(value)
	data.zombie_attack = math.max(0, value)
end

function M.set_zombie_defend(value)
	data.zombie_defend = math.max(0, value)
end

function M.set_zombie_health(value)
	data.zombie_health = math.max(0, value)
end

function M.forage()
	M.clear_messages()
	M.add_message("YOU FORAGE WHILE YOU WAIT")
	foraging.forage(M)
	M.perform_wait()
	M.perform_hunger()
	return M.get_next_state()
end

function M.get_next_state()
	if M.is_dead() then
		return states.DEAD
	elseif not M.is_zombie_dead() then
		return states.FIGHT
	elseif M.get_hippie() then
		return states.HIPPIE
	else
		return states.IN_PLAY
	end
end

function M.is_zombie_dead()
	return M.get_zombie_health() == 0
end

function M.set_litter(value)
	data.litter = math.max(0, value)
end

function M.get_litter()
	return data.litter
end

function M.set_sammiches(value)
	data.sammiches = math.max(0, value)
end

function M.get_sammiches()
	return data.sammiches
end

function M.eat_sammich()
	M.clear_messages()
	if M.get_sammiches()>0 then
		M.add_message("YOU EAT A SAMMICH")
		M.set_sammiches(M.get_sammiches()-1)
		M.set_satiety(M.get_satiety()+10)
		M.add_message("SATIETY: "..M.get_satiety().."/"..M.get_maximum_satiety())
		return states.IN_PLAY
	else
		assert(false, "the player doesnt have any sammiches, so how did we get here?")
	end
end

function M.set_bandages(value)
	data.bandages=math.max(0, value)
end

function M.get_bandages()
	return data.bandages
end

function M.use_bandage()
	M.clear_messages()
	if M.get_bandages()>0 then
		M.add_message("YOU (RE)USE A BANDAGE")
		M.set_bandages(M.get_bandages()-1)
		M.set_health(M.get_health()+10)
		M.add_message("HEALTH: "..M.get_health().."/"..M.get_maximum_health())
		return states.IN_PLAY
	else
		assert(false, "the player doesnt have any bandages, so how did we get here?")
	end
end

function M.get_zombie_health()
	return data.zombie_health
end

function M.attack()
	M.clear_messages()
	M.add_message("YOU ATTACK THE ZOMBIE!")
	local attack_roll = math.max(0,math.random(1,M.get_attack())-math.random(1,M.get_zombie_defend()))
	if attack_roll > 0 then
		M.add_message("YOU HIT FOR "..attack_roll.." DAMAGE!")
		M.set_zombie_health(M.get_zombie_health()-attack_roll)
		if M.is_zombie_dead() then
			M.add_message("YOU KILLED THE ZOMBIE!")
		else
			M.add_message("THE ZOMBIE HAS "..M.get_zombie_health().." HEALTH LEFT!")
			M.counter_attack()
		end
	else
		M.add_message("YOU MISS!")
		M.counter_attack()
	end
	return M.get_next_state()
end

function M.counter_attack()
	M.add_message("THE ZOMBIE ATTACKS YOU!")
	local counter_attack_roll = math.max(0,math.random(1,M.get_zombie_attack())-math.random(1,M.get_defend()))
	if counter_attack_roll > 0 then
		M.add_message("THE ZOMBIE HITS FOR "..counter_attack_roll.." DAMAGE!")
		local virtue = math.min(counter_attack_roll, M.get_virtue())
		if virtue > 0 then
			M.add_message("YER VIRTUE ABSORBS "..virtue.." DAMAGE!")
			counter_attack_roll = counter_attack_roll - virtue
			M.set_virtue(M.get_virtue()-virtue)
			M.add_message("YOU HAVE "..M.get_virtue().." VIRTUE REMAINING.")
		end
		M.set_health(M.get_health()-counter_attack_roll)
		if M.is_dead() then
			M.add_message("YER DEAD.")
		else
			M.add_message("YER HEALTH: "..M.get_health().."/"..M.get_maximum_health())
		end
	else
		M.add_message("THE ZOMBIE MISSES!")
	end
end

function M.get_attack()
	return data.attack
end

function M.get_defend()
	return data.defend
end

function M.get_zombie_attack()
	return data.zombie_attack
end

function M.get_zombie_defend()
	return data.zombie_defend
end

function M.deny_hippie()
	M.clear_messages()
	M.add_message("YOU TELL THE DIRTY HIPPIE TO POUND SAND.")
	M.set_hippie(false)
	return states.IN_PLAY
end

function M.accept_hippie()
	M.clear_messages()
	M.add_message("YOU GIVE THE HIPPIER ALL YER LITTER, AND SUDDENLY FEEL A LOT BETTER ABOUT YER CARBON FOOTPRINT.")
	M.add_message("THE HIPPIE GIVES YOU A FLOWER.")
	M.add_message("+1 FLOWER")
	M.add_message("-"..M.get_litter().." LITTER")
	M.add_message("+"..M.get_litter().." VIRTUE")
	M.set_virtue(M.get_virtue() + M.get_litter())
	M.set_flowers(M.get_flowers() + 1)
	M.set_litter(0)
	M.set_hippie(false)
	return M.get_next_state()
end

function M.smell_flower()
	M.clear_messages()
	M.add_message("IT SMELLS FLOWERY.")
	return M.get_next_state()
end

function M.use_flower()
	M.clear_messages()
	M.add_message("THAT DOESN'T HELP. DUNNO WHAT YER THINKING.")
	M.set_flowers(M.get_flowers() - 1)
	M.add_message("-1 FLOWER")
	M.counter_attack()
	return M.get_next_state()
end

return M
