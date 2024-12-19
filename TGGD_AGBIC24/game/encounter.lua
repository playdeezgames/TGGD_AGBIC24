local M = {}

M.NOTHING = "NOTHING"
M.ZOMBIE = "ZOMBIE"
M.BEGGAR = "BEGGAR"
M.PROSELYTIZER = "PROSELYTIZER"
M.HIPPIE = "HIPPIE"
M.VENDOR = "VENDOR"
M.BEGGAR = "BEGGAR"

local encounter_table = {}
encounter_table[M.NOTHING]={
    weight=20,
    handle=function(data)
        --do nothing!
    end
}
encounter_table[M.ZOMBIE]={
    weight=1,
    handle=function(data)
        data.set_zombie_health(25)
        data.set_zombie_attack(10)
        data.set_zombie_defend(10)
        data.add_message("A ZOMBIE APPROACHES YOU, AND NOWYOU MUST FIGHT!")
    end
}
encounter_table[M.HIPPIE]={
    weight=1,
    handle=function(data)
        data.set_hippie(true)
        data.add_message("YOU ARE APPROACHED BY A TREE-HUGGIN' HIPPIE!")
        data.add_message("HE'LL GIVE YOU A SMELLY HUG IF YOU GIVE HIM LITTER!")
    end
}
encounter_table[M.VENDOR]={
    weight=1,
    handle=function(data)
        data.set_vendor(true)
        data.add_message("A VENDOR APPROACHES SELLING HALF-EATEN SAMMICHES FOR "..data.get_sammich_price().." CENTS EACH!")
    end
}
encounter_table[M.BEGGAR]={
    weight=1,
    handle=function(data)
        data.set_beggar(true)
        data.add_message("A BEGGAR APPROACHES YOU, ASKING YOU TO SPARE SOME CHANGE.")
    end
}

local function determine_encounter()
    local total = 0
    for _, descriptor in pairs(encounter_table) do
        total = total + descriptor.weight
    end
    local generated = math.random(0, total-1)
    for candidate, descriptor in pairs(encounter_table) do
        if generated < descriptor.weight then
            return candidate
        end
        generated = generated - descriptor.weight
    end
    assert(false,"determine_encounter generated nothing, which \"shouldn't\" happen")
end

function M.check_for_encounter(data)
    encounter_table[determine_encounter()].handle(data)
end

return M