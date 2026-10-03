package bus

Forageable :: enum {
	Nothing,
	Litter,
	Sammich,
	Bandage,
	Change,
}

forage_weights := [Forageable]int {
	.Nothing = 25,
	.Litter  = 10,
	.Sammich = 5,
	.Bandage = 3,
	.Change  = 5,
}

forage_for_something :: proc() {
	switch pick_weighted(forage_weights) {
	case .Nothing:
		add_message("YOU FIND NOTHING!")
	case .Litter:
		add_message("YOU FIND LITTER!")
		data.litter += 1
		add_message("YOU HAVE %d LITTER", data.litter)
	case .Sammich:
		add_message("YOU FIND A HALF-EATEN SAMMICH!")
		data.sammiches += 1
		add_message("YOU HAVE %d SAMMICH(ES)", data.sammiches)
	case .Bandage:
		add_message("YOU FIND A USED BANDAGE!")
		data.bandages += 1
		add_message("YOU HAVE %d BANDAGE(S)", data.bandages)
	case .Change:
		amount := random_range(1, 25)
		add_message("YOU FIND %d CENT(S) IN LOOSE CHANGE!", amount)
		data.money += amount
		add_message("YOU HAVE %d CENT(S)", data.money)
	}
}
