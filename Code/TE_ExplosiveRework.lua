--Defs_Explosive
local function checkID(id)
    if not InventoryItemDefs[id] then
        return false
    end
    if not _G[id] then
        return false
    end
    return true
end

local function TE_Explosive(id, dmg, ap, area, minR)
    if checkID(id) == false then
        return
    end

    local defs = InventoryItemDefs[id]
    local load = _G[id]

    defs.BaseDamage             = dmg
    load.BaseDamage             = dmg

    if ap then
        defs.AttackAP           = ap * 1000
        load.AttackAP           = ap * 1000
    end
	
    if area then
        defs.AreaOfEffect       = area
        load.AreaOfEffect       = area
    end
	
    if minR then
        defs.BaseRange          = minR
        defs.ThrowMaxRange      = minR + 10
        load.BaseRange          = minR
        load.ThrowMaxRange      = minR + 10
    end
end

local function TE_Trap(id, dmg, area)
    if checkID(id) == false then
        return
    end

    local defs = InventoryItemDefs[id]
    local load = _G[id]

    defs.BaseDamage             = dmg
    load.BaseDamage             = dmg

    if area then
        defs.AreaOfEffect       = area
        load.AreaOfEffect       = area
    end
end

local function TE_Heavy(id, MinP, MaxP, apS, apR)
    if checkID(id) == false then
        return
    end

    local defs = InventoryItemDefs[id]
    local load = _G[id]

    if MinP then
        defs.MinMishapChance = MinP
        load.MinMishapChance = MinP
    end
	
    if MaxP then
        defs.MaxMishapChance = MaxP
        load.MaxMishapChance = MaxP
    end
	
    if apS then
        defs.ShootAP            = apS * 1000
        load.ShootAP            = apS * 1000
    end
	
    if apR then
        defs.ReloadAP           = apR * 1000
        load.ReloadAP           = apR * 1000
    end
end

local function TE_ExplosiveInstant()
    --            id                          dmg,  ap,  area,  minR
    TE_Explosive("ShapedCharge",              50,   9,   nil,   2)
    TE_Explosive("FragGrenade",               45,   9,   2,     4)
    TE_Explosive("HE_Grenade",                60,   9,   3,     2)
    TE_Explosive("Super_HE_Grenade",          90,   9,   3,     4)
    TE_Explosive("ConcussiveGrenade",         nil,  5,   3,     4)
    TE_Explosive("Molotov",                   nil,  7,   3,     2)
    TE_Explosive("FlareStick",                nil,  7,   nil,   2)
    TE_Explosive("GlowStick",                 nil,  5,   nil,   4)
    TE_Explosive("SmokeGrenade",              nil,  5,   nil,   2)
    TE_Explosive("TearGasGrenade",            nil,  7,   nil,   2)
    TE_Explosive("ToxicGasGrenade",           nil,  9,   nil,   2)
    TE_Explosive("PipeBomb",                  nil,  9,   nil,   4)
    TE_Explosive("ProximityC4",               nil,  9,   nil,   2)
    TE_Explosive("ProximityPETN",             nil,  9,   nil,   2)
    TE_Explosive("ProximityTNT",              nil,  9,   nil,   2)
    TE_Explosive("RemoteC4",                  nil,  9,   nil,   2)
    TE_Explosive("RemotePETN",                nil,  9,   nil,   2)
    TE_Explosive("RemoteTNT",                 nil,  9,   nil,   2)
    TE_Explosive("TimedC4",                   nil,  9,   nil,   2)
    TE_Explosive("TimedPETN",                 nil,  9,   nil,   2)
    TE_Explosive("TimedTNT",                  nil,  9,   nil,   2)
end

local function TE_ExplosiveTrap()
    --       id                               dmg,   area
    TE_Trap("BlackPowder",                    60,    2)
    TE_Trap("C4",                             75,    3)
    TE_Trap("PETN",                           85,    4)
    TE_Trap("TNT",                            95,    4)
end

local function TE_ExplosiveShell()
    --            id                          dmg,  ap,   area,  minR
    TE_Explosive("MortarShell_HE",            70,   nil,  4,     nil)
    --        id                              MinP, MaxP, apS,   apR
    TE_Heavy("MortarInventoryItem",           nil,  nil,  6,     4)
end

local function TE_Explosive40mm()
    --            id                          dmg,  ap,   area,  minR
    TE_Explosive("_22mm_NATO_Frag",           45,   nil,  2,     nil)
    TE_Explosive("_22mm_WP_Frag",             45,   nil,  2,     nil)
    TE_Explosive("_40mmFragGrenade",          45,   nil,  2,     nil)
    TE_Explosive("_40mmFlashbangGrenade",     nil,  nil,  2,     nil)
    --        id                              MinP, MaxP, apS,   apR
    TE_Heavy("MGL",                           nil,  nil,  9,     7)
    --        id                              MinP, MaxP, apS,   apR
    TE_Heavy("MoW_GL_RGM40",                  nil,  nil,  9,     7)
    --        id                              MinP, MaxP, apS,   apR
    TE_Heavy("MoW_UGL_GP30",                  nil,  nil,  9,     7)
    --        id                              MinP, MaxP, apS,   apR
    TE_Heavy("MoW_UGL_M203",                  nil,  nil,  9,     7)
    --        id                              MinP, MaxP, apS,   apR
    TE_Heavy("MoW_UGL_AGC",                   nil,  nil,  9,     7)
    --        id                              MinP, MaxP, apS,   apR
    TE_Heavy("MoW_GL_HK69",                   nil,  nil,  9,     7)
    --        id                              MinP, MaxP, apS,   apR
    TE_Heavy("UnderslungGrenadeLauncher",     nil,  nil,  9,     7)
end

local function TE_ExplosiveWarhead()
    --            id                          dmg,  ap,   area,  minR
    TE_Explosive("Warhead_Frag",              70,   nil,  4,     nil)
    --        id                              MinP, MaxP, apS,   apR
    TE_Heavy("RPG7",                          nil,  nil,  9,     7)
end


--Load Changes
function OnMsg.ModsReloaded()
	if CurrentModOptions["Gunfight_Rework"] then
		TE_ExplosiveInstant()
		TE_ExplosiveTrap()
		TE_ExplosiveShell()
		TE_Explosive40mm()
		TE_ExplosiveWarhead()
	end
end
function OnMsg.DataLoaded()
	if CurrentModOptions["Gunfight_Rework"] then
		TE_ExplosiveInstant()
		TE_ExplosiveTrap()
		TE_ExplosiveShell()
		TE_Explosive40mm()
		TE_ExplosiveWarhead()
	end
end
function OnMsg.OptionsApply()
	if CurrentModOptions["Gunfight_Rework"] then
		TE_ExplosiveInstant()
		TE_ExplosiveTrap()
		TE_ExplosiveShell()
		TE_Explosive40mm()
		TE_ExplosiveWarhead()
	end
end