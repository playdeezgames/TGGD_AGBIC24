package bus

Encounter :: enum {
	Nothing,
	Zombie,
	Hippie,
	Vendor,
	Beggar,
}

encounter_weights := [Encounter]int {
	.Nothing = 20,
	.Zombie  = 1,
	.Hippie  = 1,
	.Vendor  = 1,
	.Beggar  = 1,
}

check_for_encounter :: proc() {
	switch pick_weighted(encounter_weights) {
	case .Nothing:
	case .Zombie:
		data.zombie_health = 25
		data.zombie_attack = 10
		data.zombie_defend = 10
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
	}
}
