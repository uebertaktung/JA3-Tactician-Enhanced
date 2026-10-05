--Defs_Caliber
local function checkID(id)
    if not InventoryItemDefs[id] then
        return false
    end
    if not _G[id] then
        return false
    end
    return true
end

local function TE_Ammo(id, modify, effect, hint)
    if checkID(id) == false then
        return
    end

    local defs = InventoryItemDefs[id]
    local load = _G[id]

    defs.Modifications      = modify
    defs.AppliedEffects     = effect

    load.Modifications      = modify
    load.AppliedEffects     = effect

    if hint then
        defs.AdditionalHint = hint
        load.AdditionalHint = hint
    end
end

local function TE_Ammo_Normal()
    local modify_AP = {
        PlaceObj('CaliberModification', {
            mod_add = 2,
            target_prop = "PenetrationClass",
        }),
        PlaceObj('CaliberModification', {
            mod_add = -50,
            target_prop = "CritChance",
        }),
    }
    local modify_HP = {
        PlaceObj('CaliberModification', {
            mod_add = -2,
            target_prop = "PenetrationClass",
        }),
        PlaceObj('CaliberModification', {
            mod_add = 50,
            target_prop = "CritChance",
        }),
    }
    local modify_Shock = {
        PlaceObj('CaliberModification', {
            mod_add = -5,
            target_prop = "PenetrationClass",
        }),
    }
    local modify_Match = {
        PlaceObj('CaliberModification', {
            mod_add = 15,
            target_prop = "CritChance",
        }),
        PlaceObj('CaliberModification', {
            mod_add = 2,
            target_prop = "AimAccuracy",
        }),
    }
    local modify_Subsonic = {
        PlaceObj('CaliberModification', {
            mod_add = 15,
            target_prop = "CritChance",
        }),
        PlaceObj('CaliberModification', {
            mod_add = 2,
            target_prop = "AimAccuracy",
        }),
        PlaceObj('CaliberModification', {
            mod_add = -1,
            target_prop = "PenetrationClass",
        }),
        PlaceObj('CaliberModification', {
            mod_mul = 800,
            target_prop = "Noise",
        }),
    }
    
    local effect_HP = {
        "Bleeding",
    }
    local effect_Tracer = {
        "IlluminationSpotted",
        "Exposed",
    }
    local effect_Shock = {
        "Inaccurate",
        "Slowed",
    }
    
    local hint_AP           = T(30072476860801, "<bullet_point> Increased Armor Penetration\n<bullet_point> Decreased Crit Chance")
    local hint_HP           = T(30072476860802, "<bullet_point> Increased Crit Chance\n<bullet_point> Less Armor Penetration\n<bullet_point> Inflicts <em>Bleeding</em>")
    local hint_Match        = T(30072476860803, "<bullet_point> Increased Crit Chance, Aiming Bonus")
    local hint_Tracer       = T(30072476860804, "<bullet_point> Inflicts <em>Illuminated</em> and <em>Exposed</em>")
    local hint_Shock        = T(30072476860805, "<bullet_point> Inflicts <em>Inaccurate</em> and <em>Slowed</em>\n<bullet_point> No Armor penetration")
    local hint_Subsonic     = T(30072476860806, "<bullet_point> Increased Crit Chance and Aiming Bonus\n<bullet_point> Less Armor Penetration\n<bullet_point> Less Noise")
    
    --AP
    TE_Ammo("_9mm_AP",                     modify_AP,          nil,            hint_AP)
    TE_Ammo("_9x18_AP",                    modify_AP,          nil,            hint_AP)
    TE_Ammo("_9x39_AP",                    modify_AP,          nil,            hint_AP)
    TE_Ammo("_22LR_AP",                    modify_AP,          nil,            hint_AP)
    TE_Ammo("_280British_AP",              modify_AP,          nil,            hint_AP)
    TE_Ammo("_300Blackout_AP",             modify_AP,          nil,            hint_AP)
    TE_Ammo("_300WinMag_AP",               modify_AP,          nil,            hint_AP)
    TE_Ammo("_303_AP",                     modify_AP,          nil,            hint_AP)
    TE_Ammo("_308Win_AP",                  modify_AP,          nil,            hint_AP)
    TE_Ammo("_30_60_AP",                   modify_AP,          nil,            hint_AP)
    TE_Ammo("_32ACP_AP",                   modify_AP,          nil,            hint_AP)
    TE_Ammo("_32HRMAG_AP",                 modify_AP,          nil,            hint_AP)
    TE_Ammo("_338_Lapua_Magnum_AP",        modify_AP,          nil,            hint_AP)
    TE_Ammo("_357MAG_AP",                  modify_AP,          nil,            hint_AP)
    TE_Ammo("_38SP_AP",                    modify_AP,          nil,            hint_AP)
    TE_Ammo("_380ACP_AP",                  modify_AP,          nil,            hint_AP)
    TE_Ammo("_40SW_AP",                    modify_AP,          nil,            hint_AP)
    TE_Ammo("_408_ChayTac_AP",             modify_AP,          nil,            hint_AP)
    TE_Ammo("_44AMP_AP",                   modify_AP,          nil,            hint_AP)
    TE_Ammo("_44CAL_AP",                   modify_AP,          nil,            hint_AP)
    TE_Ammo("_44MAG_AP",                   modify_AP,          nil,            hint_AP)
    TE_Ammo("_45ACP_AP",                   modify_AP,          nil,            hint_AP)
    TE_Ammo("_50AE_AP",                    modify_AP,          nil,            hint_AP)
    TE_Ammo("_4_6x30_AP",                  modify_AP,          nil,            hint_AP)
    TE_Ammo("_4_7x33_AP",                  modify_AP,          nil,            hint_AP)
    TE_Ammo("_5_45x39_AP",                 modify_AP,          nil,            hint_AP)
    TE_Ammo("_556_AP",                     modify_AP,          nil,            hint_AP)
    TE_Ammo("_5_7x28_AP",                  modify_AP,          nil,            hint_AP)
    TE_Ammo("_58CHN_AP",                   modify_AP,          nil,            hint_AP)
    TE_Ammo("_6_5Creedmoor_AP",            modify_AP,          nil,            hint_AP)
    TE_Ammo("_6_5Grendel_AP",              modify_AP,          nil,            hint_AP)
    TE_Ammo("_7_5x54_AP",                  modify_AP,          nil,            hint_AP)
    TE_Ammo("_762WP_AP",                   modify_AP,          nil,            hint_AP)
    TE_Ammo("_762NATO_AP",                 modify_AP,          nil,            hint_AP)
    TE_Ammo("_7_62x25_AP",                 modify_AP,          nil,            hint_AP)
    TE_Ammo("_7_62x54_AP",                 modify_AP,          nil,            hint_AP)
    TE_Ammo("_7_65x21_AP",                 modify_AP,          nil,            hint_AP)
    TE_Ammo("_7_92x33_AP",                 modify_AP,          nil,            hint_AP)
    TE_Ammo("_7_92x57_AP",                 modify_AP,          nil,            hint_AP)
    TE_Ammo("_86CHN_AP",                   modify_AP,          nil,            hint_AP)
    --HP
    TE_Ammo("_9mm_HP",                     modify_HP,          effect_HP,      hint_HP)
    TE_Ammo("_9x18_HP",                    modify_HP,          effect_HP,      hint_HP)
    TE_Ammo("_9x39_HP",                    modify_HP,          effect_HP,      hint_HP)
    TE_Ammo("_22LR_HP",                    modify_HP,          effect_HP,      hint_HP)
    TE_Ammo("_280British_HP",              modify_HP,          effect_HP,      hint_HP)
    TE_Ammo("_300Blackout_HP",             modify_HP,          effect_HP,      hint_HP)
    TE_Ammo("_300WinMag_HP",               modify_HP,          effect_HP,      hint_HP)
    TE_Ammo("_303_HP",                     modify_HP,          effect_HP,      hint_HP)
    TE_Ammo("_308Win_HP",                  modify_HP,          effect_HP,      hint_HP)
    TE_Ammo("_30_60_HP",                   modify_HP,          effect_HP,      hint_HP)
    TE_Ammo("_32ACP_HP",                   modify_HP,          effect_HP,      hint_HP)
    TE_Ammo("_32HRMAG_HP",                 modify_HP,          effect_HP,      hint_HP)
    TE_Ammo("_338_Lapua_Magnum_HP",        modify_HP,          effect_HP,      hint_HP)
    TE_Ammo("_357MAG_HP",                  modify_HP,          effect_HP,      hint_HP)
    TE_Ammo("_38SP_HP",                    modify_HP,          effect_HP,      hint_HP)
    TE_Ammo("_380ACP_HP",                  modify_HP,          effect_HP,      hint_HP)
    TE_Ammo("_40SW_HP",                    modify_HP,          effect_HP,      hint_HP)
    TE_Ammo("_408_ChayTac_HP",             modify_HP,          effect_HP,      hint_HP)
    TE_Ammo("_44AMP_HP",                   modify_HP,          effect_HP,      hint_HP)
    TE_Ammo("_44CAL_HP",                   modify_HP,          effect_HP,      hint_HP)
    TE_Ammo("_44MAG_HP",                   modify_HP,          effect_HP,      hint_HP)
    TE_Ammo("_45ACP_HP",                   modify_HP,          effect_HP,      hint_HP)
    TE_Ammo("_50AE_HP",                    modify_HP,          effect_HP,      hint_HP)
    TE_Ammo("_4_6x30_HP",                  modify_HP,          effect_HP,      hint_HP)
    TE_Ammo("_4_7x33_HP",                  modify_HP,          effect_HP,      hint_HP)
    TE_Ammo("_5_45x39_HP",                 modify_HP,          effect_HP,      hint_HP)
    TE_Ammo("_556_HP",                     modify_HP,          effect_HP,      hint_HP)
    TE_Ammo("_5_7x28_HP",                  modify_HP,          effect_HP,      hint_HP)
    TE_Ammo("_58CHN_HP",                   modify_HP,          effect_HP,      hint_HP)
    TE_Ammo("_6_5Creedmoor_HP",            modify_HP,          effect_HP,      hint_HP)
    TE_Ammo("_6_5Grendel_HP",              modify_HP,          effect_HP,      hint_HP)
    TE_Ammo("_7_5x54_HP",                  modify_HP,          effect_HP,      hint_HP)
    TE_Ammo("_762WP_HP",                   modify_HP,          effect_HP,      hint_HP)
    TE_Ammo("_762NATO_HP",                 modify_HP,          effect_HP,      hint_HP)
    TE_Ammo("_7_62x25_HP",                 modify_HP,          effect_HP,      hint_HP)
    TE_Ammo("_7_62x54_HP",                 modify_HP,          effect_HP,      hint_HP)
    TE_Ammo("_7_65x21_HP",                 modify_HP,          effect_HP,      hint_HP)
    TE_Ammo("_7_92x33_HP",                 modify_HP,          effect_HP,      hint_HP)
    TE_Ammo("_7_92x57_HP",                 modify_HP,          effect_HP,      hint_HP)
    TE_Ammo("_86CHN_HP",                   modify_HP,          effect_HP,      hint_HP)
    --Match
    TE_Ammo("_9mm_Match",                  modify_Match,       nil,            hint_Match)
    TE_Ammo("_9x18_Match",                 modify_Match,       nil,            hint_Match)
    TE_Ammo("_9x39_Match",                 modify_Match,       nil,            hint_Match)
    TE_Ammo("_22LR_Match",                 modify_Match,       nil,            hint_Match)
    TE_Ammo("_280British_Match",           modify_Match,       nil,            hint_Match)
    TE_Ammo("_300Blackout_Match",          modify_Match,       nil,            hint_Match)
    TE_Ammo("_300WinMag_Match",            modify_Match,       nil,            hint_Match)
    TE_Ammo("_303_Match",                  modify_Match,       nil,            hint_Match)
    TE_Ammo("_308Win_Match",               modify_Match,       nil,            hint_Match)
    TE_Ammo("_30_60_Match",                modify_Match,       nil,            hint_Match)
    TE_Ammo("_32ACP_Match",                modify_Match,       nil,            hint_Match)
    TE_Ammo("_32HRMAG_Match",              modify_Match,       nil,            hint_Match)
    TE_Ammo("_338_Lapua_Magnum_Match",     modify_Match,       nil,            hint_Match)
    TE_Ammo("_357MAG_Match",               modify_Match,       nil,            hint_Match)
    TE_Ammo("_38SP_Match",                 modify_Match,       nil,            hint_Match)
    TE_Ammo("_380ACP_Match",               modify_Match,       nil,            hint_Match)
    TE_Ammo("_40SW_Match",                 modify_Match,       nil,            hint_Match)
    TE_Ammo("_408_ChayTac_Match",          modify_Match,       nil,            hint_Match)
    TE_Ammo("_44AMP_Match",                modify_Match,       nil,            hint_Match)
    TE_Ammo("_44CAL_Match",                modify_Match,       nil,            hint_Match)
    TE_Ammo("_44MAG_Match",                modify_Match,       nil,            hint_Match)
    TE_Ammo("_45ACP_Match",                modify_Match,       nil,            hint_Match)
    TE_Ammo("_50AE_Match",                 modify_Match,       nil,            hint_Match)
    TE_Ammo("_4_6x30_Match",               modify_Match,       nil,            hint_Match)
    TE_Ammo("_4_7x33_Match",               modify_Match,       nil,            hint_Match)
    TE_Ammo("_5_45x39_Match",              modify_Match,       nil,            hint_Match)
    TE_Ammo("_556_Match",                  modify_Match,       nil,            hint_Match)
    TE_Ammo("_5_7x28_Match",               modify_Match,       nil,            hint_Match)
    TE_Ammo("_58CHN_Match",                modify_Match,       nil,            hint_Match)
    TE_Ammo("_6_5Creedmoor_Match",         modify_Match,       nil,            hint_Match)
    TE_Ammo("_6_5Grendel_Match",           modify_Match,       nil,            hint_Match)
    TE_Ammo("_7_5x54_Match",               modify_Match,       nil,            hint_Match)
    TE_Ammo("_762WP_Match",                modify_Match,       nil,            hint_Match)
    TE_Ammo("_762NATO_Match",              modify_Match,       nil,            hint_Match)
    TE_Ammo("_7_62x25_Match",              modify_Match,       nil,            hint_Match)
    TE_Ammo("_7_62x54_Match",              modify_Match,       nil,            hint_Match)
    TE_Ammo("_7_65x21_Match",              modify_Match,       nil,            hint_Match)
    TE_Ammo("_7_92x33_Match",              modify_Match,       nil,            hint_Match)
    TE_Ammo("_7_92x57_Match",              modify_Match,       nil,            hint_Match)
    TE_Ammo("_86CHN_Match",                modify_Match,       nil,            hint_Match)
    --Tracer
    TE_Ammo("_9mm_Tracer",                 nil,                effect_Tracer,  hint_Tracer)
    TE_Ammo("_9x18_Tracer",                nil,                effect_Tracer,  hint_Tracer)
    TE_Ammo("_9x39_Tracer",                nil,                effect_Tracer,  hint_Tracer)
    TE_Ammo("_22LR_Tracer",                nil,                effect_Tracer,  hint_Tracer)
    TE_Ammo("_280British_Tracer",          nil,                effect_Tracer,  hint_Tracer)
    TE_Ammo("_300Blackout_Tracer",         nil,                effect_Tracer,  hint_Tracer)
    TE_Ammo("_300WinMag_Tracer",           nil,                effect_Tracer,  hint_Tracer)
    TE_Ammo("_303_Tracer",                 nil,                effect_Tracer,  hint_Tracer)
    TE_Ammo("_308Win_Tracer",              nil,                effect_Tracer,  hint_Tracer)
    TE_Ammo("_30_60_Tracer",               nil,                effect_Tracer,  hint_Tracer)
    TE_Ammo("_32ACP_Tracer",               nil,                effect_Tracer,  hint_Tracer)
    TE_Ammo("_32HRMAG_Tracer",             nil,                effect_Tracer,  hint_Tracer)
    TE_Ammo("_338_Lapua_Magnum_Tracer",    nil,                effect_Tracer,  hint_Tracer)
    TE_Ammo("_357MAG_Tracer",              nil,                effect_Tracer,  hint_Tracer)
    TE_Ammo("_38SP_Tracer",                nil,                effect_Tracer,  hint_Tracer)
    TE_Ammo("_380ACP_Tracer",              nil,                effect_Tracer,  hint_Tracer)
    TE_Ammo("_40SW_Tracer",                nil,                effect_Tracer,  hint_Tracer)
    TE_Ammo("_408_ChayTac_Tracer",         nil,                effect_Tracer,  hint_Tracer)
    TE_Ammo("_44AMP_Tracer",               nil,                effect_Tracer,  hint_Tracer)
    TE_Ammo("_44CAL_Tracer",               nil,                effect_Tracer,  hint_Tracer)
    TE_Ammo("_44MAG_Tracer",               nil,                effect_Tracer,  hint_Tracer)
    TE_Ammo("_45ACP_Tracer",               nil,                effect_Tracer,  hint_Tracer)
    TE_Ammo("_50AE_Tracer",                nil,                effect_Tracer,  hint_Tracer)
    TE_Ammo("_4_6x30_Tracer",              nil,                effect_Tracer,  hint_Tracer)
    TE_Ammo("_4_7x33_Tracer",              nil,                effect_Tracer,  hint_Tracer)
    TE_Ammo("_5_45x39_Tracer",             nil,                effect_Tracer,  hint_Tracer)
    TE_Ammo("_556_Tracer",                 nil,                effect_Tracer,  hint_Tracer)
    TE_Ammo("_5_7x28_Tracer",              nil,                effect_Tracer,  hint_Tracer)
    TE_Ammo("_58CHN_Tracer",               nil,                effect_Tracer,  hint_Tracer)
    TE_Ammo("_6_5Creedmoor_Tracer",        nil,                effect_Tracer,  hint_Tracer)
    TE_Ammo("_6_5Grendel_Tracer",          nil,                effect_Tracer,  hint_Tracer)
    TE_Ammo("_7_5x54_Tracer",              nil,                effect_Tracer,  hint_Tracer)
    TE_Ammo("_762WP_Tracer",               nil,                effect_Tracer,  hint_Tracer)
    TE_Ammo("_762NATO_Tracer",             nil,                effect_Tracer,  hint_Tracer)
    TE_Ammo("_7_62x25_Tracer",             nil,                effect_Tracer,  hint_Tracer)
    TE_Ammo("_7_62x54_Tracer",             nil,                effect_Tracer,  hint_Tracer)
    TE_Ammo("_7_65x21_Tracer",             nil,                effect_Tracer,  hint_Tracer)
    TE_Ammo("_7_92x33_Tracer",             nil,                effect_Tracer,  hint_Tracer)
    TE_Ammo("_7_92x57_Tracer",             nil,                effect_Tracer,  hint_Tracer)
    TE_Ammo("_86CHN_Tracer",               nil,                effect_Tracer,  hint_Tracer)
    --Shock
    TE_Ammo("_9mm_Shock",                  modify_Shock,       effect_Shock,   hint_Shock)
    TE_Ammo("_32HRMAG_Shock",              modify_Shock,       effect_Shock,   hint_Shock)
    TE_Ammo("_44AMP_Shock",                modify_Shock,       effect_Shock,   hint_Shock)
    TE_Ammo("_44CAL_Shock",                modify_Shock,       effect_Shock,   hint_Shock)
    TE_Ammo("_44MAG_Shock",                modify_Shock,       effect_Shock,   hint_Shock)
    TE_Ammo("_50AE_Shock",                 modify_Shock,       effect_Shock,   hint_Shock)
    --Subsonic
    TE_Ammo("_9mm_Subsonic",               modify_Subsonic,    nil,            hint_Subsonic)
    TE_Ammo("_300Blackout_Subsonic",       modify_Subsonic,    nil,            hint_Subsonic)
    TE_Ammo("_44AMP_Subsonic",             modify_Subsonic,    nil,            hint_Subsonic)
    TE_Ammo("_44CAL_Subsonic",             modify_Subsonic,    nil,            hint_Subsonic)
    TE_Ammo("_44MAG_Subsonic",             modify_Subsonic,    nil,            hint_Subsonic)
    TE_Ammo("_45ACP_Subsonic",             modify_Subsonic,    nil,            hint_Subsonic)
end

local function TE_Ammo_Gauge()
    local modify_Buckshot = {
        PlaceObj('CaliberModification', {
            mod_add = 50,
            target_prop = "CritChance",
        }),
    }
    local modify_Breacher = {
        PlaceObj('CaliberModification', {
            mod_add = 2,
            target_prop = "PenetrationClass",
        }),
        PlaceObj('CaliberModification', {
            mod_add = -50,
            target_prop = "CritChance",
        }),
		PlaceObj('CaliberModification', {
			mod_add = 1,
			target_prop = "IgnoreCoverReduction",
		}),
    }
    local modify_Saltshot = {
        PlaceObj('CaliberModification', {
            mod_add = -15,
            target_prop = "CritChance",
        }),
        PlaceObj('CaliberModification', {
			mod_mul = 2000,
			target_prop = "BuckshotConeAngle",
		}),
    }
    local modify_Flechette = {
        PlaceObj('CaliberModification', {
            mod_add = 2,
            target_prop = "PenetrationClass",
        }),
        PlaceObj('CaliberModification', {
            mod_add = -15,
            target_prop = "CritChance",
        }),
        PlaceObj('CaliberModification', {
			mod_mul = 500,
			target_prop = "BuckshotConeAngle",
		}),
    }

    local effect_Breacher = {
        "Exposed",
    }
    local effect_Saltshot = {
        "Inaccurate",
        "Slowed",
    }
    local effect_Flechette = {
        "Bleeding",
    }

    local hint_Buckshot     = T(30072476860807, "<bullet_point> Increased Crit Chance")
    local hint_Breacher     = T(30072476860808, "<bullet_point> Increased Armor Penetration\n<bullet_point> Decreased Crit Chance\n<bullet_point> Ignore Cover\n<bullet_point> Inflicts <em>Exposed</em>")
    local hint_Saltshot     = T(30072476860809, "<bullet_point> Increased Attack Cone\n<bullet_point> Decreased Crit Chance\n<bullet_point> Inflicts <em>Inaccurate</em> and <em>Slowed</em>")
    local hint_Flechette    = T(30072476860810, "<bullet_point> Increased Armor Penetration\n<bullet_point> Decreased Crit Chance\n<bullet_point> Less Attack Cone\n<bullet_point> Inflicts <em>Bleeding</em>")
    
    --12Gauge
    TE_Ammo("_12gauge_Buckshot",   modify_Buckshot,    nil,                hint_Buckshot)
    TE_Ammo("_12gauge_Breacher",   modify_Breacher,    effect_Breacher,    hint_Breacher)
    TE_Ammo("_12gauge_Saltshot",   modify_Saltshot,    effect_Saltshot,    hint_Saltshot)
    TE_Ammo("_12gauge_Flechette",  modify_Flechette,   effect_Flechette,   hint_Flechette)
end

local function TE_Ammo_BMG()
    local modify_HE = {
        PlaceObj('CaliberModification', {
            mod_add = -2,
            target_prop = "PenetrationClass",
        }),
        PlaceObj('CaliberModification', {
            mod_add = 50,
            target_prop = "CritChance",
        }),
        PlaceObj('CaliberModification', {
			mod_add = 1,
			target_prop = "IgnoreCoverReduction",
		}),
    }
    local modify_SLAP = {
        PlaceObj('CaliberModification', {
            mod_add = 2,
            target_prop = "PenetrationClass",
        }),
        PlaceObj('CaliberModification', {
            mod_add = -50,
            target_prop = "CritChance",
        }),
    }

    local effect_HE = {
        "Exposed",
    }
    local effect_SLAP = {
        "Bleeding",
    }
    local effect_Burn = {
        "Burning",
    }

    local hint_HE       = T(30072476860811, "<bullet_point> Increased Crit Chance\n<bullet_point> Less Armor Penetration\n<bullet_point> Ignore Cover\n<bullet_point> Inflicts <em>Exposed</em>")
    local hint_SLAP     = T(30072476860812, "<bullet_point> Increased Armor Penetration\n<bullet_point> Decreased Crit Chance\n<bullet_point> Inflicts <em>Bleeding</em>")
    local hint_Burn     = T(30072476860813, "<bullet_point> Inflicts <em>Burning</em>")
    
	--.20
    TE_Ammo("_20x82_HE",           modify_HE,      effect_HE,      hint_HE)
    TE_Ammo("_20x82_SLAP",         modify_SLAP,    effect_SLAP,    hint_SLAP)
    TE_Ammo("_20x81_Incendiary",   nil,            effect_Burn,    hint_Burn)
	--.50
    TE_Ammo("_50BMG_HE",           modify_HE,      effect_HE,      hint_HE)
    TE_Ammo("_50BMG_SLAP",         modify_SLAP,    effect_SLAP,    hint_SLAP)
    TE_Ammo("_50BMG_Incendiary",   nil,            effect_Burn,    hint_Burn)
end

-- Load Changes
function OnMsg.ModsReloaded()
	if CurrentModOptions["Gunfight_Rework"] then
    	TE_Ammo_Normal()
    	TE_Ammo_Gauge()
    	TE_Ammo_BMG()
	end
end
function OnMsg.DataLoaded()
	if CurrentModOptions["Gunfight_Rework"] then
    	TE_Ammo_Normal()
    	TE_Ammo_Gauge()
    	TE_Ammo_BMG()
	end
end
function OnMsg.OptionsApply()
	if CurrentModOptions["Gunfight_Rework"] then
    	TE_Ammo_Normal()
    	TE_Ammo_Gauge()
    	TE_Ammo_BMG()
	end
end