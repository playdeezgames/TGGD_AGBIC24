package bus

import "core:fmt"

State :: enum {
	Title,
	Instructions,
	In_Play,
	Confirm_Quit,
	Dead,
	Inventory,
	Fight,
	Status,
	Hippie,
	Vendor,
	Beggar,
}

Game_Data :: struct {
	wait_time:            int,
	satiety:              int,
	maximum_satiety:      int,
	health:               int,
	maximum_health:       int,
	litter:               int,
	sammiches:            int,
	bandages:             int,
	zombie_attack:        int,
	zombie_defend:        int,
	zombie_health:        int,
	zombie_kills:         int,
	attack:               int,
	defend:               int,
	virtue:               int,
	money:                int,
	flowers:              int,
	hippie:               bool,
	vendor:               bool,
	beggar:               bool,
	beer_bottles:         int,
	broken_beer_bottles:  int,
	sammich_price:        int,
	messages:             [dynamic]string,
}

data: Game_Data

new_game :: proc() {
	clear_messages()
	messages := data.messages
	data = {}
	data.messages = messages

	data.maximum_satiety = 100
	data.satiety = data.maximum_satiety
	data.maximum_health = 100
	data.health = data.maximum_health
	data.attack = 10
	data.defend = 10
	data.sammich_price = 25
	add_message("YOU ARRIVE AT THE BUS STOP IN   PLENTY OF TIME TO CATCH YER BUS")
}

// Messages

clear_messages :: proc() {
	for m in data.messages {
		delete(m)
	}
	clear(&data.messages)
}

add_message :: proc(format: string, args: ..any) {
	append(&data.messages, fmt.aprintf(format, ..args))
}

// Turn logic

wait_for_bus :: proc() -> State {
	clear_messages()
	add_message("YOU WAIT FOR THE BUS")
	perform_wait()
	perform_hunger()
	return get_next_state()
}

forage :: proc() -> State {
	clear_messages()
	add_message("YOU FORAGE WHILE YOU WAIT")
	forage_for_something()
	perform_wait()
	perform_hunger()
	return get_next_state()
}

perform_wait :: proc() {
	data.wait_time += 5
	if data.wait_time == 1 {
		add_message("YOU HAVE BEEN WAITING FOR %d MINUTE", data.wait_time)
	} else {
		add_message("YOU HAVE BEEN WAITING FOR %d MINUTES", data.wait_time)
	}
	check_for_encounter()
}

perform_hunger :: proc() {
	if data.satiety > 0 {
		add_message("-1 SATIETY")
		data.satiety -= 1
		add_message("SATIETY: %d/%d", data.satiety, data.maximum_satiety)
	} else if data.health > 0 {
		add_message("YER STARVING!")
		add_message("-1 HEALTH")
		data.health -= 1
		add_message("HEALTH:%d/%d", data.health, data.maximum_health)
	}
}

is_dead :: proc() -> bool {
	return data.health == 0
}

is_zombie_dead :: proc() -> bool {
	return data.zombie_health == 0
}

get_next_state :: proc() -> State {
	switch {
	case is_dead():         return .Dead
	case !is_zombie_dead(): return .Fight
	case data.hippie:       return .Hippie
	case data.vendor:       return .Vendor
	case data.beggar:       return .Beggar
	}
	return .In_Play
}

// Inventory

eat_sammich :: proc() -> State {
	clear_messages()
	assert(data.sammiches > 0, "the player doesnt have any sammiches, so how did we get here?")
	add_message("YOU EAT A SAMMICH")
	data.sammiches -= 1
	data.satiety = min(data.satiety + 10, data.maximum_satiety)
	add_message("SATIETY: %d/%d", data.satiety, data.maximum_satiety)
	return .In_Play
}

use_bandage :: proc() -> State {
	clear_messages()
	assert(data.bandages > 0, "the player doesnt have any bandages, so how did we get here?")
	add_message("YOU (RE)USE A BANDAGE")
	data.bandages -= 1
	data.health = min(data.health + 10, data.maximum_health)
	add_message("HEALTH: %d/%d", data.health, data.maximum_health)
	return .In_Play
}

smell_flower :: proc() -> State {
	clear_messages()
	add_message("IT SMELLS FLOWERY.")
	return get_next_state()
}

break_beer_bottle :: proc() -> State {
	data.beer_bottles -= 1
	data.broken_beer_bottles += 1
	clear_messages()
	add_message("YOU BREAK A BEER BOTTLE, MAKING IT A MUCH MORE FORMIDABLE WEAPON.")
	add_message("-1 EMPTY BEER BOTTLE")
	add_message("+1 BROKEN BEER BOTTLE")
	return get_next_state()
}

// Combat

get_attack :: proc() -> int {
	result := data.attack
	if data.broken_beer_bottles > 0 {
		result *= 3
	} else if data.beer_bottles > 0 {
		result *= 2
	}
	return result
}

get_weapon :: proc() -> string {
	if data.broken_beer_bottles > 0 {
		return "A BROKEN BEER BOTTLE"
	} else if data.beer_bottles > 0 {
		return "AN EMPTY BEER BOTTLE"
	}
	return "YER FISTS"
}

get_final_score :: proc() -> int {
	return 0
}

check_breakage :: proc() {
	if data.broken_beer_bottles > 0 {
		if random_range(1, 5) == 1 {
			add_message("THE BROKEN BEER BOTTLE SMASHES TO PIECES!")
			data.broken_beer_bottles -= 1
		}
	} else if data.beer_bottles > 0 {
		if random_range(1, 5) == 1 {
			add_message("THE EMPTY BEER BOTTLE BREAKS!")
			data.beer_bottles -= 1
			data.broken_beer_bottles += 1
		}
	}
}

attack :: proc() -> State {
	clear_messages()
	add_message("YOU ATTACK THE ZOMBIE WITH %s!", get_weapon())
	attack_roll := max(0, random_range(1, get_attack()) - random_range(1, data.zombie_defend))
	if attack_roll > 0 {
		add_message("YOU HIT FOR %d DAMAGE!", attack_roll)
		data.zombie_health = max(0, data.zombie_health - attack_roll)
		if is_zombie_dead() {
			data.zombie_kills += 1
			add_message("YOU KILLED THE ZOMBIE!")
		} else {
			add_message("THE ZOMBIE HAS %d HEALTH LEFT!", data.zombie_health)
			counter_attack()
		}
		check_breakage()
	} else {
		add_message("YOU MISS!")
		counter_attack()
	}
	return get_next_state()
}

counter_attack :: proc() {
	add_message("THE ZOMBIE ATTACKS YOU!")
	roll := max(0, random_range(1, data.zombie_attack) - random_range(1, data.defend))
	if roll > 0 {
		add_message("THE ZOMBIE HITS FOR %d DAMAGE!", roll)
		virtue := min(roll, data.virtue)
		if virtue > 0 {
			add_message("YER VIRTUE ABSORBS %d DAMAGE!", virtue)
			roll -= virtue
			data.virtue -= virtue
			add_message("YOU HAVE %d VIRTUE REMAINING.", data.virtue)
		}
		data.health = clamp(data.health - roll, 0, data.maximum_health)
		if is_dead() {
			add_message("YER DEAD.")
		} else {
			add_message("YER HEALTH: %d/%d", data.health, data.maximum_health)
		}
	} else {
		add_message("THE ZOMBIE MISSES!")
	}
}

use_flower :: proc() -> State {
	clear_messages()
	add_message("THAT DOESN'T HELP. DUNNO WHAT YER THINKING.")
	data.flowers -= 1
	add_message("-1 FLOWER")
	counter_attack()
	return get_next_state()
}

// Encounters

can_buy_sammich :: proc() -> bool {
	return data.money >= data.sammich_price
}

accept_vendor :: proc() -> State {
	clear_messages()
	add_message("-%d CENTS", data.sammich_price)
	add_message("+1 HALF-EATEN SAMMICH")
	data.money -= data.sammich_price
	data.sammiches += 1
	add_message("THANK YOU FOR YER BUSINESS!")
	return get_next_state()
}

deny_vendor :: proc() -> State {
	clear_messages()
	add_message("WELL, MAYBE NEXT TIME!")
	add_message("THE VENDOR LEAVES.")
	data.vendor = false
	return get_next_state()
}

deny_hippie :: proc() -> State {
	clear_messages()
	add_message("YOU TELL THE DIRTY HIPPIE TO POUND SAND.")
	data.hippie = false
	return .In_Play
}

accept_hippie :: proc() -> State {
	clear_messages()
	add_message("YOU GIVE THE HIPPIE ALL YER LITTER, AND SUDDENLY FEEL A LOT BETTER ABOUT YER CARBON FOOTPRINT.")
	add_message("THE HIPPIE GIVES YOU A FLOWER.")
	add_message("+1 FLOWER")
	add_message("-%d LITTER", data.litter)
	add_message("+%d VIRTUE", data.litter)
	data.virtue += data.litter
	data.flowers += 1
	data.litter = 0
	data.hippie = false
	return get_next_state()
}

accept_beggar :: proc() -> State {
	clear_messages()
	add_message("YOU GIVE THE BEGGAR ALL YER LOOSE CHANGE.")
	add_message("-%d CENT(S)", data.money)
	add_message("+%d VIRTUE", data.money)
	data.virtue += data.money
	add_message("YOU HAVE %d VIRTUE", data.virtue)
	if random_range(1, 100) <= data.money {
		add_message("THE BEGGAR GIVES YOU AN EMPTY BEER BOTTLE")
		data.beer_bottles += 1
		add_message("YOU HAVE %d BEER BOTTLE(S)", data.beer_bottles)
	}
	data.money = 0
	data.beggar = false
	return get_next_state()
}

deny_beggar :: proc() -> State {
	clear_messages()
	add_message("THE BEGGAR LEAVES, GIVING YOU A DIRTY LOOK.")
	data.beggar = false
	return get_next_state()
}
