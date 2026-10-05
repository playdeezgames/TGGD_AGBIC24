package bus

Encounter :: enum {
	Nothing,
	Zombie,
	Hippie,
	Vendor,
	Beggar,
	Proselytizer,
}

encounter_weights := [Encounter]int {
	.Nothing = 20,
	.Zombie  = 1,
	.Hippie  = 1,
	.Vendor  = 1,
	.Beggar  = 1,
	.Proselytizer = 1,
}

check_for_encounter :: proc() {
	switch pick_weighted(encounter_weights) {
	case .Nothing:
	case .Zombie:
		spawn_zombie()
		add_message("A ZOMBIE APPROACHES YOU, AND NOWYOU MUST FIGHT!")
	case .Hippie:
		data.hippie = true
		add_message("YOU ARE APPROACHED BY A TREE-HUGGIN' HIPPIE!")
		add_message("HE'LL GIVE YOU A SMELLY HUG IF YOU GIVE HIM LITTER!")
	case .Vendor:
		data.vendor = true
		add_message("A VENDOR APPROACHES SELLING HALF-EATEN SAMMICHES FOR %d CENTS EACH!", data.sammich_price)
	case .Beggar:
		data.beggar = true
		add_message("A BEGGAR APPROACHES YOU, ASKING YOU TO SPARE SOME CHANGE.")
	case .Proselytizer:
		data.proselytizer = true
		add_message("A PROSELYTIZER WANTS TO SAVE    YER SOUL.")
		add_message("HOLY WATER: %d CENT DONATION.", data.holy_water_price)
	}
}
