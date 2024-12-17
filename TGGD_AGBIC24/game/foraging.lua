local M = {}

M.NOTHING = "NOTHING"
M.LITTER = "LITTER"
M.SAMMICH = "SAMMICH"
M.BANDAGE = "BANDAGE"
M.CHANGE = "CHANGE"

local forage_table = {}
forage_table[M.NOTHING] = {
    weight=25,
    handle=function(data)
        data.add_message("YOU FIND NOTHING!")
    end
}
forage_table[M.LITTER] = {
    weight=10,
    handle=function(data)
        data.add_message("YOU FIND LITTER!")
        data.set_litter(data.get_litter() + 1)
        data.add_message("YOU HAVE "..data.get_litter().." LITTER")
    end
}
forage_table[M.SAMMICH] = {
    weight=5,
    handle=function(data)
        data.add_message("YOU FIND A HALF-EATEN SAMMICH!")
        data.set_sammiches(data.get_sammiches() + 1)
        data.add_message("YOU HAVE "..data.get_sammiches().." SAMMICH(ES)")
    end
}
forage_table[M.BANDAGE] = {
    weight=3,
    handle=function(data)
        data.add_message("YOU FIND A USED BANDAGE!")
        data.set_bandages(data.get_bandages() + 1)
        data.add_message("YOU HAVE "..data.get_bandages().." BANDAGE(S)")
    end
}
forage_table[M.CHANGE] = {
    weight=5,
    handle=function(data)
        local amount = math.random(1,25)
        data.add_message("YOU FIND "..amount.." CENT(S) IN LOOSE CHANGE!")
        data.set_money(data.get_money() + amount)
        data.add_message("YOU HAVE "..data.get_money().." CENT(S)")
    end
}

local function determine_foragable()
    local total = 0
    for _, descriptor in pairs(forage_table) do
        total = total + descriptor.weight
    end
    local generated = math.random(0, total-1)
    for candidate, descriptor in pairs(forage_table) do
        if generated < descriptor.weight then
            return candidate
        end
        generated = generated - descriptor.weight
    end
    assert(false,"determine_foragable generated nothing, which \"shouldn't\" happen")
end

function M.forage(data)
    forage_table[determine_foragable()].handle(data)
end

return M