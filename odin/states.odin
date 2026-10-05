package bus

import "core:fmt"

current_state := State.Title

game_update :: proc() {
	display_clear()
	switch current_state {
	case .Title:        draw_title()
	case .Instructions: draw_instructions()
	case .In_Play:      draw_in_play()
	case .Confirm_Quit: draw_confirm_quit()
	case .Dead:         draw_dead()
	case .Inventory:    draw_inventory()
	case .Fight:        draw_fight()
	case .Status:       draw_status()
	case .Hippie:       draw_hippie()
	case .Vendor:       draw_vendor()
	case .Beggar:       draw_beggar()
	case .Proselytizer: draw_proselytizer()
	}
}

game_handle_command :: proc(command: Command) {
	switch current_state {
	case .Title:        current_state = handle_title(command)
	case .Instructions: current_state = handle_instructions(command)
	case .In_Play:      current_state = handle_in_play(command)
	case .Confirm_Quit: current_state = handle_confirm_quit(command)
	case .Dead:         current_state = handle_dead(command)
	case .Inventory:    current_state = handle_inventory(command)
	case .Fight:        current_state = handle_fight(command)
	case .Status:       current_state = handle_status(command)
	case .Hippie:       current_state = handle_hippie(command)
	case .Vendor:       current_state = handle_vendor(command)
	case .Beggar:       current_state = handle_beggar(command)
	case .Proselytizer: current_state = handle_proselytizer(command)
	}
}

write_messages :: proc() {
	for message in data.messages {
		display_write_line(message)
	}
}

write_stat :: proc(format: string, args: ..any) {
	display_write_line(fmt.tprintf(format, ..args))
}

// Title

draw_title :: proc() {
	display_write_line("HOW AM I STILL WAITING FOR THE  BUS?", .Highlight)
	display_write_line("A PRODUCTION OF THEGRUMPYGAMEDEV")
	display_write_line("FOR A GAME BY ITS COVER 2024")
	display_write_line("DECEMBER 2024")
	display_write_line(" ")
	display_menu_item("1)", "NEW GAME")
	display_menu_item("2)", "INSTRUCTIONS")
}

handle_title :: proc(command: Command) -> State {
	#partial switch command {
	case .One:
		new_game()
		return .In_Play
	case .Two:
		return .Instructions
	}
	return .Title
}

// Instructions

draw_instructions :: proc() {
	display_write_line("INSTRUCTIONS:", .Highlight)
	display_write_line("YER AT A BUS STOP, WAITING FOR ABUS.")
	display_write_line("IT MIGHT BE A WHILE. YOU SHOULD PROLLY FIND SOME WAY TO OCCUPY  YERSELF WHILE YER WAITING.")
	display_write_line(" ")
	display_menu_item("0)", "DONE")
}

handle_instructions :: proc(command: Command) -> State {
	if command == .Zero {
		return .Title
	}
	return .Instructions
}

// In play

draw_in_play :: proc() {
	write_messages()
	display_write_line(" ")
	display_menu_item("1)", "WAIT FOR BUS")
	display_menu_item("2)", "FORAGE")
	display_menu_item("3)", "INVENTORY")
	display_menu_item("4)", "STATUS")
	display_menu_item("0)", "QUIT")
}

handle_in_play :: proc(command: Command) -> State {
	#partial switch command {
	case .Zero:  return .Confirm_Quit
	case .One:   return wait_for_bus()
	case .Two:   return forage()
	case .Three: return .Inventory
	case .Four:  return .Status
	}
	return .In_Play
}

// Confirm quit

draw_confirm_quit :: proc() {
	display_write_line("ARE YOU SURE YOU WANT TO QUIT?", .Highlight)
	display_write_line(" ")
	display_menu_item("1)", "YES")
	display_menu_item("0)", "NO")
}

handle_confirm_quit :: proc(command: Command) -> State {
	#partial switch command {
	case .One:  return .Title
	case .Zero: return .In_Play
	}
	return .Confirm_Quit
}

// Dead

draw_dead :: proc() {
	display_write_line(data.turned_zombie ? "YOU TURNED INTO A ZOMBIE!" : "YER DEAD!", .Highlight)
	display_write_line(fmt.tprintf("FINAL SCORE: %d", get_final_score()), .Highlight)
	write_messages()
	display_write_line(" ")
	display_menu_item("0)", "DONE")
}

handle_dead :: proc(command: Command) -> State {
	if command == .Zero {
		return .Title
	}
	return .Dead
}

// Inventory

draw_inventory :: proc() {
	display_write_line("INVENTORY:", .Highlight)
	has_inventory := false
	if data.money > 0 {
		write_stat("%d CENT(S) IN LOOSE CHANGE", data.money)
		has_inventory = true
	}
	if data.litter > 0 {
		write_stat("%d PIECE(S) OF LITTER", data.litter)
		has_inventory = true
	}
	if data.sammiches > 0 {
		write_stat("%d HALF-EATEN SAMMICH(ES)", data.sammiches)
		has_inventory = true
	}
	if data.bandages > 0 {
		write_stat("%d USED BANDAGE(S)", data.bandages)
		has_inventory = true
	}
	if data.flowers > 0 {
		write_stat("%d FLOWER(S)", data.flowers)
		has_inventory = true
	}
	if data.beer_bottles > 0 {
		write_stat("%d EMPTY BEER BOTTLES", data.beer_bottles)
		has_inventory = true
	}
	if data.broken_beer_bottles > 0 {
		write_stat("%d BROKEN BEER BOTTLES", data.broken_beer_bottles)
		has_inventory = true
	}
	if data.holy_water > 0 {
		write_stat("%d VIAL(S) OF HOLY WATER", data.holy_water)
		has_inventory = true
	}
	if data.zombie_guts > 0 {
		write_stat("%d PILE(S) OF ZOMBIE GUTS", data.zombie_guts)
		has_inventory = true
	}
	if !has_inventory {
		display_write_line("NOTHING!")
	}
	display_write_line(" ")
	if data.sammiches > 0 {
		display_menu_item("1)", "EAT SAMMICH")
	}
	if data.bandages > 0 {
		display_menu_item("2)", "(RE)USE BANDAGE")
	}
	if data.flowers > 0 {
		display_menu_item("3)", "SMELL FLOWER")
	}
	if data.beer_bottles > 0 {
		display_menu_item("4)", "BREAK BEER BOTTLE")
	}
	if data.zombie_guts > 0 {
		display_menu_item("5)", "EAT ZOMBIE GUTS")
	}
	display_menu_item("0)", "DONE")
}

handle_inventory :: proc(command: Command) -> State {
	#partial switch command {
	case .Zero:
		return .In_Play
	case .One:
		if data.sammiches > 0 { return eat_sammich() }
	case .Two:
		if data.bandages > 0 { return use_bandage() }
	case .Three:
		if data.flowers > 0 { return smell_flower() }
	case .Four:
		if data.beer_bottles > 0 { return break_beer_bottle() }
	case .Five:
		if data.zombie_guts > 0 { return eat_zombie_guts() }
	}
	return .Inventory
}

// Fight

draw_fight :: proc() {
	write_messages()
	display_write_line(" ")
	display_menu_item("1)", "ATTACK!")
	if data.flowers > 0 {
		display_menu_item("2)", "USE FLOWER!")
	}
	if data.holy_water > 0 {
		display_menu_item("3)", "USE HOLY WATER!")
	}
	if data.zombie_guts > 0 {
		display_menu_item("4)", "THROW ZOMBIE GUTS!")
	}
}

handle_fight :: proc(command: Command) -> State {
	#partial switch command {
	case .One:
		return attack()
	case .Two:
		if data.flowers > 0 { return use_flower() }
	case .Three:
		if data.holy_water > 0 { return use_holy_water() }
	case .Four:
		if data.zombie_guts > 0 { return throw_zombie_guts() }
	}
	return .Fight
}

// Status

draw_status :: proc() {
	display_write_line("STATUS:", .Highlight)
	write_stat("HEALTH:%d/%d", data.health, data.maximum_health)
	write_stat("SATIETY: %d/%d", data.satiety, data.maximum_satiety)
	write_stat("VIRTUE: %d", data.virtue)
	if data.poison > 0 {
		write_stat("POISON: %d", data.poison)
	}
	write_stat("WEAPON: %s", get_weapon())
	write_stat("ATTACK STRENGTH: %d", get_attack())
	write_stat("DEFEND STRENGTH: %d", data.defend)
	if data.zombie_kills > 0 {
		write_stat("ZOMBIES KILLED: %d", data.zombie_kills)
	}
	display_write_line(" ")
	display_menu_item("0)", "DONE")
}

handle_status :: proc(command: Command) -> State {
	if command == .Zero {
		return get_next_state()
	}
	return .Status
}

// Hippie

draw_hippie :: proc() {
	write_messages()
	display_write_line(" ")
	if data.litter > 0 {
		display_menu_item("1)", "HERE YA GO!")
	}
	display_menu_item("0)", "GET LOST")
}

handle_hippie :: proc(command: Command) -> State {
	#partial switch command {
	case .Zero:
		return deny_hippie()
	case .One:
		if data.litter > 0 { return accept_hippie() }
	}
	return .Hippie
}

// Vendor

draw_vendor :: proc() {
	write_messages()
	write_stat("YOU HAVE %d CENTS", data.money)
	write_stat("YOU HAVE %d HALF-EATEN SAMMICHES", data.sammiches)
	display_write_line(" ")
	if can_buy_sammich() {
		display_menu_item("1)", "I'LL TAKE ONE!")
	}
	display_menu_item("0)", "SORRY, I'M BROKE!")
}

handle_vendor :: proc(command: Command) -> State {
	#partial switch command {
	case .Zero:
		return deny_vendor()
	case .One:
		if can_buy_sammich() { return accept_vendor() }
	}
	return .Vendor
}

// Beggar

draw_beggar :: proc() {
	write_messages()
	display_write_line(" ")
	if data.money > 0 {
		display_menu_item("1)", "HERE YA GO!")
	}
	display_menu_item("0)", "GET A JOB!")
}

handle_beggar :: proc(command: Command) -> State {
	#partial switch command {
	case .Zero:
		return deny_beggar()
	case .One:
		if data.money > 0 { return accept_beggar() }
	}
	return .Beggar
}

// Proselytizer

draw_proselytizer :: proc() {
	write_messages()
	write_stat("YOU HAVE %d CENTS", data.money)
	display_write_line(" ")
	if can_afford_holy_water() {
		display_menu_item("1)", "I'LL DONATE!")
	}
	display_menu_item("0)", "I'M ALREADY SAVED")
}

handle_proselytizer :: proc(command: Command) -> State {
	#partial switch command {
	case .Zero:
		return deny_proselytizer()
	case .One:
		if can_afford_holy_water() { return accept_proselytizer() }
	}
	return .Proselytizer
}
