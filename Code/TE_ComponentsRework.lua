--Defs_WeaponComponentEffect
function OnMsg.DataLoaded()
	PlaceObj('WeaponComponentEffect', {
		Description = T(30072476860001, "Increased AP cost when attacking"),
		ModificationType = "Add",
		Parameters = {
			PlaceObj('PresetParamNumber', {
				'Name', "ShootAPIncrease",
				'Value', 1,
				'Tag', "<ShootAPIncrease>",
			}),
		},
		RequiredParams = {
			"ShootAPIncrease",
		},
		Scale = "AP",
		StatToModify = "ShootAP",
		group = "CombatMod",
		id = "CombatMod_IncreaseShootAP",
	})
	
	PlaceObj('WeaponComponentEffect', {
		Description = T(30072476860002, "No extra aiming AP cost in heavy rain weather"),
		group = "CombatMod",
		id = "CombatMod_NoExtraAimCost",
	})

	PlaceObj('WeaponComponentEffect', {
		Description = T(30072476860003, "Reduced accuracy penalty of <em>Burst</em>, <em>Long Burst</em> and <em>Full Auto</em>"),
		group = "CombatMod",
		id = "CombatMod_ReduceAutoPenalty",
	})

	PlaceObj('WeaponComponentEffect', {
		Description = T(30072476860004, "NOT capable for <em>Burst</em>, <em>Long Burst</em> and <em>Full Auto</em> (Except deployed MG)"),
		group = "CombatMod",
		id = "CombatMod_IncreaseAutoPenalty",
	})

	PlaceObj('WeaponComponentEffect', {
		Description = T(30072476860005, "Accuracy penalty at 3- aim levels when NOT prone"),
		group = "CombatMod",
		id = "CombatMod_BipodPenalty",
	})

	PlaceObj('WeaponComponentEffect', {
		Description = T(30072476860006, "Accuracy bonus from Aiming is limited"),
		group = "CombatMod",
		id = "CombatMod_AimAccuracyLimit",
	})

	PlaceObj('WeaponComponentEffect', {
		Description = T(30072476860007, "Strength is more effective on firing <em>Burst</em>, <em>Long Burst</em>, <em>Full Auto</em>"),
		group = "CombatMod",
		id = "CombatMod_AutoStrength",
	})
	
	PlaceObj('WeaponComponentEffect', {
		Description = T(30072476860008, "Illumination: <em>Overwatch</em> can inflict <em>Illuminated</em> (Maximum 20 tiles)"),
		group = "CombatMod",
		id = "CombatMod_Illumination",
	})
end


--Defs_WeaponComponent
local function checkID(id)
    if not WeaponComponents[id] then
        return false
    end
    return true
end

local function TE_Component(id, cost, difficulty, addCost, effect, para)
    if checkID(id) == false then
        return
    end

    local defs = WeaponComponents[id]

    defs.Cost 						= cost
    defs.ModificationDifficulty 	= difficulty

    if addCost ~= "n/a" then
        defs.AdditionalCosts 		= addCost
    end
    if effect ~= "n/a" then
        defs.ModificationEffects 	= effect
    end
    if para ~= "n/a" then
		defs.Parameters 			= para
    end
end

local pipe = {
    PlaceObj('WeaponComponentCost', {
        'Amount', 1,
        'Type', "FineSteelPipe",
    }),
}
local lens = {
    PlaceObj('WeaponComponentCost', {
        'Amount', 1,
        'Type', "OpticalLens",
    }),
}
local chip = {
    PlaceObj('WeaponComponentCost', {
        'Amount', 1,
        'Type', "Microchip",
    }),
}

local range_mod = 4
local dura_mod = 10
local stealth_kill = 5

local function TE_Bipod(ratio)
    local eff_1 = {
        "AccuracyBonusProne",
		"CombatMod_BipodPenalty",
	}
    local para_1 = {
		PlaceObj('PresetParamNumber', {
			'Name', "AccuracyBonusProne",
			'Value', 25,
			'Tag', "<AccuracyBonusProne>",
		}),
	}
	
	--
    TE_Component("AK47_Bipod",                 (10*ratio),  0,  	nil,    eff_1,  para_1)
    TE_Component("Bipod_Under",                (10*ratio),  0,  	nil,    eff_1,  para_1)
    TE_Component("Bipod_Galil",                (10*ratio),  0,  	nil,    eff_1,  para_1)
    TE_Component("Bipod_MG42",                 (10*ratio),  0,  	nil,    eff_1,  para_1)
    TE_Component("Bipod",                      (10*ratio),  0,  	nil,    eff_1,  para_1)
	--
	g_PresetParamCache[WeaponComponents.AK47_Bipod]["AccuracyBonusProne"] 	         = 25
	g_PresetParamCache[WeaponComponents.Bipod_Under]["AccuracyBonusProne"] 	         = 25
	g_PresetParamCache[WeaponComponents.Bipod_Galil]["AccuracyBonusProne"] 	         = 25
	g_PresetParamCache[WeaponComponents.Bipod_MG42]["AccuracyBonusProne"] 	         = 25
	g_PresetParamCache[WeaponComponents.Bipod]["AccuracyBonusProne"] 	             = 25
end

local function TE_Grip(ratio)
    local eff_1 = {
        "CombatMod_AutoStrength",
	}

	--
    TE_Component("AK47_Handguard_basic",       0,  		    -25,    nil,    "n/a",  "n/a")
    TE_Component("AKSU_Hanguard_Basic",        0,  		    -25,    nil,    "n/a",  "n/a")
    TE_Component("RPK74_Hanguard_Basic",       0,  		    -25,    nil,    "n/a",  "n/a")
    TE_Component("FNFAL_Handguard",            0,  		    -25,    nil,    "n/a",  "n/a")
    TE_Component("Galil_Handguard_Default",    0,  		    -25,    nil,    "n/a",  "n/a")
    TE_Component("M16_Handguard",              0,  		    -25,    nil,    "n/a",  "n/a")
    TE_Component("Handguard_Commando",         0,  		    -25,    nil,    "n/a",  "n/a")
    TE_Component("MP5_Handguard",              0,  		    -25,    nil,    "n/a",  "n/a")
    TE_Component("TacGrip",                    10*ratio, 	0,      nil,    eff_1,  "n/a")
    TE_Component("AK47_TacGrip",               10*ratio, 	0,      nil,    eff_1,  "n/a")
    TE_Component("TacGrip_M14",                10*ratio, 	0,      nil,    eff_1,  "n/a")
    TE_Component("VerticalGrip",               10*ratio, 	0,      nil,    "n/a",  "n/a")
    TE_Component("AK47_VerticalGrip",          10*ratio, 	0,      nil,    "n/a",  "n/a")
    TE_Component("AKSU_VerticalGrip",          10*ratio, 	0,      nil,    "n/a",  "n/a")
    TE_Component("RPK74_VerticalGrip",         10*ratio, 	0,      nil,    "n/a",  "n/a")
    TE_Component("VerticalGrip_AUG",           10*ratio, 	0,      nil,    "n/a",  "n/a")
    TE_Component("VerticalGrip_M14",           10*ratio, 	0,      nil,    "n/a",  "n/a")
    TE_Component("VerticalGrip_M16",           10*ratio, 	0,      nil,    "n/a",  "n/a")
    TE_Component("VerticalGrip_Commando",      10*ratio, 	0,      nil,    "n/a",  "n/a")
end

local function TE_GL(ratio)
	--
    TE_Component("GrenadeLauncher",            10*ratio, 	0,  	pipe,	"n/a",  "n/a")
    TE_Component("AK47_Launcher",              10*ratio, 	0,  	pipe,	"n/a",  "n/a")
    TE_Component("GrenadeLauncher_AUG",        10*ratio, 	0,  	pipe,	"n/a",  "n/a")
    TE_Component("GrenadeLauncher_Galil",      10*ratio, 	0,  	pipe,	"n/a",  "n/a")
    TE_Component("GrenadeLauncher_M14",        10*ratio, 	0,  	pipe,	"n/a",  "n/a")
    TE_Component("GrenadeLauncher_M16A1",      10*ratio, 	0,  	pipe,	"n/a",  "n/a")
    TE_Component("GrenadeLauncher_Commando",   10*ratio, 	0,  	pipe,	"n/a",  "n/a")
end

local function TE_Muzzle(ratio)
    local eff_1 = {
		"IncreasedSingleShotAccuracy",
        "CombatMod_ReduceAutoPenalty",
	}

	local eff_2 = {
		"IncreasedSingleShotAccuracy",
        "CombatMod_ReduceAutoPenalty",
		"ExtraBurstShots",
	}

    local eff_3 = {
        "IncreaseBuckshotAngle"
	}
    local para_3 = {
		PlaceObj('PresetParamNumber', {
			'Name', "BuckshotAngleIncrease",
			'Value', 120,
			'Tag', "<BuckshotAngleIncrease>",
		}),
	}

    local eff_4 = {
		"IncreaseRange",
		"DecreaseBuckshotAngle",
	}
    local para_4 = {
		PlaceObj('PresetParamNumber', {
			'Name', "RangeIncrease",
			'Value', range_mod,
			'Tag', "<RangeIncrease>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "BuckshotAngleDecrease",
			'Value', 80,
			'Tag', "<BuckshotAngleDecrease>",
		}),
	}

	--
    TE_Component("Compensator_cosmetic",       0,  		    -25,    nil,    "n/a",  "n/a")
    TE_Component("Galil_Brake_Default",        0,  		    -25,    nil,    "n/a",  "n/a")
    TE_Component("DefaultMuzzle_HK21",         0,  		    -25,    nil,    "n/a",  "n/a")
    TE_Component("M14_Default_Muzzle",         0,  		    -25,    nil,    "n/a",  "n/a")
    TE_Component("MuzzleBooster",              10*ratio,	0,      nil,    "n/a",  "n/a")
    TE_Component("MuzzleBooster_Glock18",      10*ratio,	0,      nil,    "n/a",  "n/a")
    TE_Component("Compensator",                10*ratio,	0,      nil,    eff_1,  "n/a")
    TE_Component("Compensator_Glock",          10*ratio,	0,      nil,    eff_1,  "n/a")
    TE_Component("AUGCompensator_01",          10*ratio,	0,      nil,    eff_1,  "n/a")
    TE_Component("AUGCompensator_03",          10*ratio,	0,      nil,    eff_2,  "n/a")
    TE_Component("DuckbillChoke",              10*ratio,	0,      nil,    eff_3,  para_3)
    TE_Component("FullChoke",                  10*ratio,	0,      nil,    eff_4,  para_4)
	--
	g_PresetParamCache[WeaponComponents.DuckbillChoke]["BuckshotAngleIncrease"] = 120
	g_PresetParamCache[WeaponComponents.FullChoke]["RangeIncrease"] 			= range_mod
	g_PresetParamCache[WeaponComponents.FullChoke]["BuckshotAngleDecrease"] 	= 80
end

local function TE_Suppressor(ratio)
    local eff_1 = {
		"SilentShots",
		"ReduceReliability",
	}
    local para_1 = {
		PlaceObj('PresetParamNumber', {
			'Name', "ReliabilityDecrease",
			'Value', dura_mod,
			'Tag', "<ReliabilityDecrease>",
		}),
	}

    local eff_2 = {
		"SilentShots",
		"StealthKillBonusPerAim",
	}
    local para_2 = {
		PlaceObj('PresetParamPercent', {
			'Name', "stealth_kill_bonus",
			'Value', stealth_kill,
			'Tag', "<stealth_kill_bonus>%",
		}),
	}

	--
    TE_Component("ImprovisedSuppressor",           5*ratio, 	-10,    nil,    eff_1,  para_1)
    TE_Component("ImprovisedSuppressor_Anaconda",  5*ratio, 	-10,    nil,    eff_1,  para_1)
    TE_Component("Suppressor",                     10*ratio, 	0,      pipe,   eff_2,  para_2)
    TE_Component("Suppressor_Anaconda",            10*ratio, 	0,      pipe,   eff_2,  para_2)
	--
	g_PresetParamCache[WeaponComponents.ImprovisedSuppressor]["ReliabilityDecrease"] 	        = dura_mod
	g_PresetParamCache[WeaponComponents.ImprovisedSuppressor_Anaconda]["ReliabilityDecrease"] 	= dura_mod
	g_PresetParamCache[WeaponComponents.Suppressor]["stealth_kill_bonus"] 			            = stealth_kill
	g_PresetParamCache[WeaponComponents.Suppressor_Anaconda]["stealth_kill_bonus"] 		        = stealth_kill
end

local function TE_Barrel(ratio)
    local eff_1 = {
		"HalfRangeDmgIncrease",
		"ReduceShootAP",
		"ReduceRange",
	}
    local para_1 = {
		PlaceObj('PresetParamNumber', {
			'Name', "ShootAPDecrease",
			'Value', 1,
			'Tag', "<ShootAPDecrease>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "RangeDecrease",
			'Value', range_mod,
			'Tag', "<RangeDecrease>",
		}),
	}

    local eff_2 = {
		"IncreaseRange",
		"IncreaseAimAccuracy",
	}
    local para_2 = {
		PlaceObj('PresetParamNumber', {
			'Name', "RangeIncrease",
			'Value', range_mod,
			'Tag', "<RangeIncrease>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "AimAccuracyIncrease",
			'Value', 2,
			'Tag', "<AimAccuracyIncrease>",
		}),
	}

    local eff_3 = {
		"AccuracyBonusProne",
		"CombatMod_BipodPenalty",
		"IncreaseRange",
		"IncreaseAimAccuracy",
	}
    local para_3 = {
		PlaceObj('PresetParamNumber', {
			'Name', "AccuracyBonusProne",
			'Value', 25,
			'Tag', "<AccuracyBonusProne>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "RangeIncrease",
			'Value', range_mod,
			'Tag', "<RangeIncrease>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "AimAccuracyIncrease",
			'Value', 2,
			'Tag', "<AimAccuracyIncrease>",
		}),
	}

    local eff_4 = {
		"IncreaseAimAccuracy",
		"IncreaseReliability",
	}
    local para_4 = {
		PlaceObj('PresetParamNumber', {
			'Name', "AimAccuracyIncrease",
			'Value', 1,
			'Tag', "<AimAccuracyIncrease>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "ReliabilityIncrease",
			'Value', dura_mod,
			'Tag', "<ReliabilityIncrease>",
		}),
	}

    local eff_5 = {
		"HalfRangeDmgIncrease",
		"ReduceShootAP",
		"ReduceRange",
        "IncreaseReliability",
	}
    local para_5 = {
		PlaceObj('PresetParamNumber', {
			'Name', "ShootAPDecrease",
			'Value', 1,
			'Tag', "<ShootAPDecrease>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "RangeDecrease",
			'Value', range_mod,
			'Tag', "<RangeDecrease>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "ReliabilityIncrease",
			'Value', dura_mod,
			'Tag', "<ReliabilityIncrease>",
		}),
	}

    local eff_6 = {
        "IncreaseRange",
		"IncreaseAimAccuracy",
		"IncreaseReliability",
	}
    local para_6 = {
		PlaceObj('PresetParamNumber', {
			'Name', "RangeIncrease",
			'Value', range_mod,
			'Tag', "<RangeIncrease>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "AimAccuracyIncrease",
			'Value', 2,
			'Tag', "<AimAccuracyIncrease>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "ReliabilityIncrease",
			'Value', dura_mod,
			'Tag', "<ReliabilityIncrease>",
		}),
	}

    local eff_7 = {
		"AccuracyBonusProne",
		"CombatMod_BipodPenalty",
		"IncreaseRange",
		"IncreaseAimAccuracy",
		"IncreaseReliability",
	}
    local para_7 = {
		PlaceObj('PresetParamNumber', {
			'Name', "AccuracyBonusProne",
			'Value', 25,
			'Tag', "<AccuracyBonusProne>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "RangeIncrease",
			'Value', range_mod,
			'Tag', "<RangeIncrease>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "AimAccuracyIncrease",
			'Value', 2,
			'Tag', "<AimAccuracyIncrease>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "ReliabilityIncrease",
			'Value', dura_mod,
			'Tag', "<ReliabilityIncrease>",
		}),
	}

    local eff_8 = {
		"AccuracyBonusSameTarget",
		"IncreaseDamage",
		"IncreaseAimAccuracy"
	}
    local para_8 = {
		PlaceObj('PresetParamNumber', {
			'Name', "DamageIncrease",
			'Value', 7,
			'Tag', "<DamageIncrease>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "AimAccuracyIncrease",
			'Value', 1,
			'Tag', "<AimAccuracyIncrease>",
		}),
	}

    local eff_9 = {
		"HalfRangeDmgIncrease",
		"ReduceShootAP",
		"ReduceRange",
		"ReduceMagazineSize",
	}
    local para_9 = {
		PlaceObj('PresetParamNumber', {
			'Name', "ShootAPDecrease",
			'Value', 1,
			'Tag', "<ShootAPDecrease>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "RangeDecrease",
			'Value', range_mod,
			'Tag', "<RangeDecrease>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "MagazineSizeDecrease",
			'Value', 2,
			'Tag', "<MagazineSizeDecrease>",
		}),
	}

    local eff_A = {
		"IncreaseDamage",
		"ChangeCaliberToBMG",
		"ReduceReliability",
	}
    local para_A = {
		PlaceObj('PresetParamNumber', {
			'Name', "DamageIncrease",
			'Value', 14,
			'Tag', "<DamageIncrease>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "ReliabilityDecrease",
			'Value', dura_mod,
			'Tag', "<ReliabilityDecrease>",
		}),
	}

	--
    TE_Component("BarrelNormal",               10*ratio, 	0, 		pipe,   nil,    nil)
    TE_Component("BarrelShort",                15*ratio, 	10,		pipe,   eff_1,  para_1)
    TE_Component("BarrelShort_AUG",            15*ratio, 	10,		pipe,   eff_1,  para_1)
    TE_Component("BarrelLong",                 15*ratio, 	10,		pipe,   eff_2,  para_2)
    TE_Component("BarrelLong_AUG",             15*ratio, 	10,		pipe,   eff_3,  para_3)
    TE_Component("BarrelNormalImproved",       15*ratio, 	10,		pipe,   eff_4,  para_4)
    TE_Component("BarrelShortImproved",        25*ratio, 	20,		pipe,   eff_5,  para_5)
    TE_Component("BarrelShortImproved_AUG",    25*ratio, 	20,		pipe,   eff_5,  para_5)
    TE_Component("BarrelLongImproved",         25*ratio, 	20,		pipe,   eff_6,  para_6)
    TE_Component("BarrelLongImproved_AUG",     25*ratio, 	20,		pipe,   eff_7,  para_7)
    TE_Component("BarrelHeavy",                25*ratio, 	20,		pipe,   eff_8,  para_8)
    TE_Component("BarrelShort_Winchester",     15*ratio, 	10,		pipe,   eff_9,  para_9)
    TE_Component("Barrel50BMG_DesertEagle",    15*ratio, 	10,		pipe,   eff_A,  para_A)
	--
	g_PresetParamCache[WeaponComponents.BarrelShort]["ShootAPDecrease"] 				= 1
	g_PresetParamCache[WeaponComponents.BarrelShort]["RangeDecrease"] 					= range_mod
	g_PresetParamCache[WeaponComponents.BarrelShort_AUG]["ShootAPDecrease"] 			= 1
	g_PresetParamCache[WeaponComponents.BarrelShort_AUG]["RangeDecrease"] 				= range_mod
	g_PresetParamCache[WeaponComponents.BarrelLong]["RangeIncrease"] 					= range_mod
	g_PresetParamCache[WeaponComponents.BarrelLong]["AimAccuracyIncrease"] 				= 2
	g_PresetParamCache[WeaponComponents.BarrelLong_AUG]["AccuracyBonusProne"] 			= 25
	g_PresetParamCache[WeaponComponents.BarrelLong_AUG]["RangeIncrease"] 				= range_mod
	g_PresetParamCache[WeaponComponents.BarrelLong_AUG]["AimAccuracyIncrease"] 			= 2
	g_PresetParamCache[WeaponComponents.BarrelNormalImproved]["AimAccuracyIncrease"] 	= 1
	g_PresetParamCache[WeaponComponents.BarrelNormalImproved]["ReliabilityIncrease"] 	= dura_mod
	g_PresetParamCache[WeaponComponents.BarrelShortImproved]["ShootAPDecrease"] 		= 1
	g_PresetParamCache[WeaponComponents.BarrelShortImproved]["RangeDecrease"] 			= range_mod
	g_PresetParamCache[WeaponComponents.BarrelShortImproved]["ReliabilityIncrease"] 	= dura_mod
	g_PresetParamCache[WeaponComponents.BarrelShortImproved_AUG]["ShootAPDecrease"] 	= 1
	g_PresetParamCache[WeaponComponents.BarrelShortImproved_AUG]["RangeDecrease"] 		= range_mod
	g_PresetParamCache[WeaponComponents.BarrelShortImproved_AUG]["ReliabilityIncrease"] = dura_mod
	g_PresetParamCache[WeaponComponents.BarrelLongImproved]["RangeIncrease"] 			= range_mod
	g_PresetParamCache[WeaponComponents.BarrelLongImproved]["AimAccuracyIncrease"] 	    = 2
	g_PresetParamCache[WeaponComponents.BarrelLongImproved]["ReliabilityIncrease"] 		= dura_mod
	g_PresetParamCache[WeaponComponents.BarrelLongImproved_AUG]["AccuracyBonusProne"] 	= 25
	g_PresetParamCache[WeaponComponents.BarrelLongImproved_AUG]["RangeIncrease"] 		= range_mod
	g_PresetParamCache[WeaponComponents.BarrelLongImproved_AUG]["AimAccuracyIncrease"]  = 2
	g_PresetParamCache[WeaponComponents.BarrelLongImproved_AUG]["ReliabilityIncrease"] 	= dura_mod
	g_PresetParamCache[WeaponComponents.BarrelHeavy]["DamageIncrease"] 					= 7
	g_PresetParamCache[WeaponComponents.BarrelHeavy]["AimAccuracyIncrease"] 			= 1
	g_PresetParamCache[WeaponComponents.BarrelShort_Winchester]["ShootAPDecrease"] 		= 1
	g_PresetParamCache[WeaponComponents.BarrelShort_Winchester]["RangeDecrease"] 		= range_mod
	g_PresetParamCache[WeaponComponents.BarrelShort_Winchester]["MagazineSizeDecrease"] = 2
	g_PresetParamCache[WeaponComponents.Barrel50BMG_DesertEagle]["DamageIncrease"] 		= 14
	g_PresetParamCache[WeaponComponents.Barrel50BMG_DesertEagle]["ReliabilityDecrease"] = dura_mod
end

local function TE_Barrel_Shotgun(ratio)
    local eff_1 = {
		"IncreaseRange",
		"IncreaseAimAccuracy",
	}
    local para_1 = {
		PlaceObj('PresetParamNumber', {
			'Name', "RangeIncrease",
			'Value', range_mod,
			'Tag', "<RangeIncrease>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "AimAccuracyIncrease",
			'Value', 2,
			'Tag', "<AimAccuracyIncrease>",
		}),
	}

    local eff_2 = {
		"ReduceShootAP",
		"ReduceRange",
		"HalfRangeDmgIncrease",
		"IncreaseBuckshotAngle",
	}
    local para_2 = {
		PlaceObj('PresetParamNumber', {
			'Name', "ShootAPDecrease",
			'Value', 1,
			'Tag', "<ShootAPDecrease>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "RangeDecrease",
			'Value', range_mod,
			'Tag', "<RangeDecrease>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "BuckshotAngleIncrease",
			'Value', 120,
			'Tag', "<BuckshotAngleIncrease>",
		}),
	}

    local eff_3 = {
		"ReduceMagazineSize",
		"ReduceShootAP",
        "ReduceRange",
		"HalfRangeDmgIncrease",
        "IncreaseBuckshotAngle",
	}
    local para_3 = {
        PlaceObj('PresetParamNumber', {
			'Name', "MagazineSizeDecrease",
			'Value', 2,
			'Tag', "<MagazineSizeDecrease>",
		}),
        PlaceObj('PresetParamNumber', {
			'Name', "ShootAPDecrease",
			'Value', 1,
			'Tag', "<ShootAPDecrease>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "RangeDecrease",
			'Value', range_mod,
			'Tag', "<RangeDecrease>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "BuckshotAngleIncrease",
			'Value', 120,
			'Tag', "<BuckshotAngleIncrease>",
		}),
	}

    local eff_4 = {
		"IncreaseRange",
		"IncreaseAimAccuracy",
		"MagazineSizeMultiplier",
	}
    local para_4 = {
		PlaceObj('PresetParamNumber', {
			'Name', "RangeIncrease",
			'Value', range_mod,
			'Tag', "<RangeIncrease>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "AimAccuracyIncrease",
			'Value', 2,
			'Tag', "<AimAccuracyIncrease>",
		}),
		PlaceObj('PresetParamPercent', {
			'Name', "MagazineSizeMultiplier",
			'Value', 150,
			'Tag', "<MagazineSizeMultiplier>%",
		}),
	}

    local eff_5 = {
        "MagazineSizeMultiplier",
	}
    local para_5 = {
		PlaceObj('PresetParamPercent', {
			'Name', "MagazineSizeMultiplier",
			'Value', 150,
			'Tag', "<MagazineSizeMultiplier>%",
		}),
	}

    local eff_6 = {
		"IncreaseRange",
		"IncreaseAimAccuracy",
	}
    local para_6 = {
		PlaceObj('PresetParamNumber', {
			'Name', "RangeIncrease",
			'Value', range_mod,
			'Tag', "<RangeIncrease>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "AimAccuracyIncrease",
			'Value', 2,
			'Tag', "<AimAccuracyIncrease>",
		}),
	}

    local eff_7 = {
		"ReduceShootAP",
		"ReduceRange",
		"HalfRangeDmgIncrease",
		"IncreaseBuckshotAngle",
	}
    local para_7 = {
		PlaceObj('PresetParamNumber', {
			'Name', "ShootAPDecrease",
			'Value', 1,
			'Tag', "<ShootAPDecrease>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "RangeDecrease",
			'Value', range_mod,
			'Tag', "<RangeDecrease>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "BuckshotAngleIncrease",
			'Value', 120,
			'Tag', "<BuckshotAngleIncrease>",
		}),
	}

	--
    TE_Component("BarrelLongShotgun",          15*ratio, 	10,		pipe,   eff_1,  para_1)
    TE_Component("BarrelShortShotgun",         15*ratio, 	10,		pipe,   eff_2,  para_2)
    TE_Component("BarrelShortShotgun_Benelli", 15*ratio, 	10,		pipe,   eff_3,  para_3)
    TE_Component("Auto5_Basic_NMag",           10*ratio, 	0, 		pipe,   nil,    nil)
    TE_Component("Auto5_Long_LMag",            25*ratio, 	20,		pipe,   eff_4,  para_4)
    TE_Component("Auto5_Basic_LMag",           15*ratio, 	10,		pipe,   eff_5,  para_5)
    TE_Component("Auto5_Long_NMag",            15*ratio, 	10,		pipe,   eff_6,  para_6)
    TE_Component("Auto5_Short_NMag",           15*ratio, 	10,		pipe,   eff_7,  para_7)
	--
	g_PresetParamCache[WeaponComponents.BarrelLongShotgun]["RangeIncrease"] 					= range_mod
	g_PresetParamCache[WeaponComponents.BarrelLongShotgun]["AimAccuracyIncrease"] 				= 2
	g_PresetParamCache[WeaponComponents.BarrelShortShotgun]["ShootAPDecrease"] 					= 1
	g_PresetParamCache[WeaponComponents.BarrelShortShotgun]["RangeDecrease"] 					= range_mod
	g_PresetParamCache[WeaponComponents.BarrelShortShotgun]["BuckshotAngleIncrease"]			= 120
	g_PresetParamCache[WeaponComponents.BarrelShortShotgun_Benelli]["MagazineSizeDecrease"] 	= 2
	g_PresetParamCache[WeaponComponents.BarrelShortShotgun_Benelli]["ShootAPDecrease"] 			= 1
	g_PresetParamCache[WeaponComponents.BarrelShortShotgun_Benelli]["RangeDecrease"] 			= range_mod
	g_PresetParamCache[WeaponComponents.BarrelShortShotgun_Benelli]["BuckshotAngleIncrease"]	= 120
	g_PresetParamCache[WeaponComponents.Auto5_Long_LMag]["RangeIncrease"] 						= range_mod
	g_PresetParamCache[WeaponComponents.Auto5_Long_LMag]["AimAccuracyIncrease"] 				= 2
	g_PresetParamCache[WeaponComponents.Auto5_Long_LMag]["MagazineSizeMultiplier"] 				= 150
	g_PresetParamCache[WeaponComponents.Auto5_Long_NMag]["RangeIncrease"] 						= range_mod
	g_PresetParamCache[WeaponComponents.Auto5_Long_NMag]["AimAccuracyIncrease"] 				= 2
	g_PresetParamCache[WeaponComponents.Auto5_Basic_LMag]["MagazineSizeMultiplier"] 			= 150
	g_PresetParamCache[WeaponComponents.Auto5_Short_NMag]["ShootAPDecrease"] 					= 1
	g_PresetParamCache[WeaponComponents.Auto5_Short_NMag]["RangeDecrease"] 						= range_mod
	g_PresetParamCache[WeaponComponents.Auto5_Short_NMag]["BuckshotAngleIncrease"]				= 120
end

local function TE_Stock(ratio)
    local eff_1 = {
		"ReduceShootAP",
		"ReduceAimAccuracy",
		"FreeWeaponSwap",
		"CombatMod_AimAccuracyLimit",
	}
    local para_1 = {
		PlaceObj('PresetParamNumber', {
			'Name', "ShootAPDecrease",
			'Value', 2,
			'Tag', "<ShootAPDecrease>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "accuracy_penalty",
			'Value', -75,
			'Tag', "<accuracy_penalty>",
		}),
	}

    local eff_2 = {
		"IncreasedSingleShotAccuracy",
		"AccuracyBonusSameTarget",
		"CombatMod_IncreaseShootAP",
	}
    local para_2 = {
		PlaceObj('PresetParamNumber', {
			'Name', "ShootAPIncrease",
			'Value', 1,
			'Tag', "<ShootAPIncrease>",
		}),
	}

	local eff_3 = {
		"ReduceShootAP",
		"ReduceAimAccuracy",
	}
    local para_3 = {
		PlaceObj('PresetParamNumber', {
			'Name', "ShootAPDecrease",
			'Value', 1,
			'Tag', "<ShootAPDecrease>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "accuracy_penalty",
			'Value', -50,
			'Tag', "<accuracy_penalty>",
		}),
	}

    local eff_4 = {
        "NoFullAuto",
    }

    local eff_5 = {
		"IncreasedSingleShotAccuracy",
		"AccuracyBonusSameTarget",
        "NoFullAuto",
		"CombatMod_IncreaseShootAP",
	}

    local eff_6 = {
		"ReduceShootAP",
		"ReduceAimAccuracy",
        "NoFullAuto",
	}

    local eff_7 = {
        "EnableFullAuto",
    }

	--
    TE_Component("StockNo",                    0,  		    -25,  	nil,    eff_1,  para_1)
    TE_Component("StockFolded",                0,  		    -25,  	nil,    eff_1,  para_1)
    TE_Component("StockNormal",                10*ratio,  	0,    	nil,    nil,    nil)
    TE_Component("StockHeavy",                 15*ratio,  	10,   	nil,    eff_2,  para_2)
    TE_Component("StockLight",                 15*ratio,  	10,   	nil,    eff_3,  para_3)
    TE_Component("StockNormal_AR_BurstOnly",   10*ratio,  	0,    	nil,    eff_4,  nil)
    TE_Component("StockHeavy_AR_BurstOnly",    15*ratio,  	10,   	nil,    eff_5,  para_2)
    TE_Component("StockLight_AR_BurstOnly",    15*ratio,  	10,   	nil,    eff_6,  para_3)
    TE_Component("StockBump",                  15*ratio,  	10,   	nil,    eff_7,  nil)
	--
	g_PresetParamCache[WeaponComponents.StockNo]["ShootAPDecrease"] 					= 2
	g_PresetParamCache[WeaponComponents.StockNo]["accuracy_penalty"] 					= -75
	g_PresetParamCache[WeaponComponents.StockFolded]["ShootAPDecrease"] 				= 2
	g_PresetParamCache[WeaponComponents.StockFolded]["accuracy_penalty"] 				= -75
	g_PresetParamCache[WeaponComponents.StockHeavy]["ShootAPIncrease"] 					= 1
	g_PresetParamCache[WeaponComponents.StockLight]["ShootAPDecrease"] 					= 1
	g_PresetParamCache[WeaponComponents.StockLight]["accuracy_penalty"] 				= -50
	g_PresetParamCache[WeaponComponents.StockHeavy_AR_BurstOnly]["ShootAPIncrease"] 	= 1
	g_PresetParamCache[WeaponComponents.StockLight_AR_BurstOnly]["ShootAPDecrease"] 	= 1
	g_PresetParamCache[WeaponComponents.StockLight_AR_BurstOnly]["accuracy_penalty"] 	= -50
end

local function TE_Scope(ratio)
    local eff_1 = {
        "MinorAccuracyBonus",
	}

    local eff_2 = {
		"AccuracyBonusWhenAimed",
		"BonusAccuracyWhenFullyAimed",
	}

    local eff_3 = {
		"AccuracyBonusWhenAimed",
		"MinAim",
	}

    local eff_4 = {
		"FirstShotIncreasedAim",
		"IncreaseMaxAimActions",
		"CombatMod_IncreaseAutoPenalty",
		"CombatMod_IncreaseShootAP",
	}
    local para_4 = {
		PlaceObj('PresetParamNumber', {
			'Name', "MaxAimActionsIncrease",
			'Value', 1,
			'Tag', "<MaxAimActionsIncrease>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "ShootAPIncrease",
			'Value', 1,
			'Tag', "<ShootAPIncrease>",
		}),
	}

    local eff_5 = {
		"FirstShotIncreasedAim",
		"IncreaseMaxAimActions",
        "IgnoreCoverCtHWhenFullyAimed",
		"IgnoreLightOfSightWhenFullyAimed",
		"CombatMod_IncreaseAutoPenalty",
		"CombatMod_IncreaseShootAP",
	}
    local eff_10 = {
		"FirstShotIncreasedAim",
		"BonusAccuracyWhenFullyAimed",
		"IncreaseMaxAimActions",
        "IgnoreCoverCtHWhenFullyAimed",
		"IgnoreLightOfSightWhenFullyAimed",
		"CombatMod_IncreaseAutoPenalty",
		"CombatMod_IncreaseShootAP",
	}
    local para_5 = {
		PlaceObj('PresetParamNumber', {
			'Name', "MaxAimActionsIncrease",
			'Value', 2,
			'Tag', "<MaxAimActionsIncrease>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "ShootAPIncrease",
			'Value', 2,
			'Tag', "<ShootAPIncrease>",
		}),
	}

    local eff_6 = {
		"IgnoreCoverCtHWhenFullyAimed",
		"IgnoreGrazingHitsWhenFullyAimed",
		"IgnoreInTheDarkWhenFullyAimed",
		"IgnoreLightOfSightWhenFullyAimed",
		"CombatMod_NoExtraAimCost",
		"CombatMod_AimAccuracyLimit",
	}

    local eff_7 = {
		"OpportunityAttackBonusCth",
		"IncreaseOverwatchAngle",
		"MinorAccuracyBonus",
	}
    local eff_9 = {
		"OpportunityAttackBonusCth",
		"IncreaseOverwatchAngle",
		"ExtraOverwatchShots",
		"MinAim",
	}
    local para_7 = {
		PlaceObj('PresetParamNumber', {
			'Name', "OverwatchAngleIncrease",
			'Value', 150,
			'Tag', "<OverwatchAngleIncrease>",
		}),
	}

    local eff_8 = {
		"OpportunityAttackBonusCth",
		"ExtraOverwatchShots",
		"MinAim",
	}

	--
    TE_Component("BaseIronsight_Anaconda",     0,  		    -25, 	nil,    nil,    nil)
    TE_Component("GewehrDefaultSight",         0,  		    -25, 	nil,    nil,    nil)
    TE_Component("DefaultIronsight_AR15",      0,  		    -25, 	nil,    nil,    nil)
    TE_Component("DefaultIronsight_M82",       0,  		    -25, 	nil,    nil,    nil)
    TE_Component("ImprovedIronsight",          5*ratio, 	-10, 	nil,    eff_1,  nil)
    TE_Component("ImprovedIronsight_AR15",     5*ratio, 	-10, 	nil,    eff_1,  nil)
    TE_Component("ScopeCOG",                   10*ratio, 	0,   	lens,   eff_2,  nil)
    TE_Component("AUGScope_Default",           10*ratio, 	0,   	lens,   eff_2,  nil)
    TE_Component("ScopeCOGQuick",              10*ratio, 	0,   	lens,   eff_3,  nil)
    TE_Component("LROptics",                   15*ratio, 	10,  	lens,   eff_4,  para_4)
    TE_Component("LROptics_DragunovDefault",   15*ratio, 	10,  	lens,   eff_4,  para_4)
    TE_Component("PSG_DefaultScope",           15*ratio, 	10,  	lens,   eff_4,  para_4)
    TE_Component("LROpticsAdvanced",           15*ratio, 	10,  	lens,   eff_5,  para_5)
    TE_Component("ThermalScope",               25*ratio, 	20,  	chip,   eff_6,  nil)
    TE_Component("ReflexSight",                10*ratio, 	0,   	chip,   eff_7,  para_7)
    TE_Component("ReflexSightAdvanced",        10*ratio, 	0,   	chip,   eff_8,  nil)
    TE_Component("ReflexSightAdvanced_Glock",  10*ratio, 	0,   	chip,   eff_8,  nil)
	--
	g_PresetParamCache[WeaponComponents.LROptics]["MaxAimActionsIncrease"] 					= 1
	g_PresetParamCache[WeaponComponents.LROptics]["ShootAPIncrease"] 					    = 1
	g_PresetParamCache[WeaponComponents.LROptics_DragunovDefault]["MaxAimActionsIncrease"]	= 1
	g_PresetParamCache[WeaponComponents.LROptics_DragunovDefault]["ShootAPIncrease"]	    = 1
	g_PresetParamCache[WeaponComponents.PSG_DefaultScope]["MaxAimActionsIncrease"] 			= 1
	g_PresetParamCache[WeaponComponents.PSG_DefaultScope]["ShootAPIncrease"] 			    = 1
	g_PresetParamCache[WeaponComponents.LROpticsAdvanced]["MaxAimActionsIncrease"] 			= 2
	g_PresetParamCache[WeaponComponents.LROpticsAdvanced]["ShootAPIncrease"] 				= 2
	g_PresetParamCache[WeaponComponents.ReflexSight]["OverwatchAngleIncrease"] 				= 150
end

local function TE_Side(ratio)
    local eff_1 = {
        "IgnoreInTheDark",
        "CombatMod_Illumination",
	}

    local eff_2 = {
		"IgnoreInTheDarkWhenFullyAimed",
		"StealthKillBonusPerAim",
	}
    local para_2 = {
		PlaceObj('PresetParamPercent', {
			'Name', "stealth_kill_bonus",
			'Value', stealth_kill,
			'Tag', "<stealth_kill_bonus>%",
		}),
	}

    local eff_3 = {
		"CritBonusSameTarget",
		"CritBonusWhenFullyAimed",
	}

    local eff_4 = {
		"IgnoreGrazingHitsWhenFullyAimed",
		"MarkWhenFullyAimed",
	}

	--
    TE_Component("Flashlight",             5*ratio,  	-10, 	nil,	eff_1,  nil)
    TE_Component("FlashlightDot",          10*ratio,  	10, 	chip, 	eff_2,  para_2)
    TE_Component("LaserDot",               10*ratio,  	10, 	chip, 	eff_3,  nil)
    TE_Component("UVDot",                  10*ratio,  	10, 	chip, 	eff_4,  nil)
    TE_Component("Flashlight_aa12",        5*ratio,  	-10, 	nil,	eff_1,  nil)
    TE_Component("FlashlightDot_aa12",     10*ratio,  	10, 	chip, 	eff_2,  para_2)
    TE_Component("LaserDot_aa12",          10*ratio,  	10, 	chip, 	eff_3,  nil)
    TE_Component("UVDot_aa12",             10*ratio,  	10, 	chip, 	eff_4,  nil)
    TE_Component("Flashlight_PSG_M1",      5*ratio,  	-10, 	nil,	eff_1,  nil)
    TE_Component("FlashlightDot_PSG_M1",   10*ratio,  	10, 	chip, 	eff_2,  para_2)
    TE_Component("LaserDot_PSG_M1",        10*ratio,  	10, 	chip, 	eff_3,  nil)
    TE_Component("UVDot_PSG_M1",           10*ratio,  	10, 	chip, 	eff_4,  nil)
    TE_Component("Flashlight_Anaconda",    5*ratio,  	-10, 	nil,	eff_1,  nil)
    TE_Component("FlashlightDot_Anaconda", 10*ratio,  	10, 	chip, 	eff_2,  para_2)
    TE_Component("LaserDot_Anaconda",      10*ratio,  	10, 	chip, 	eff_3,  nil)
    TE_Component("UVDot_Anaconda",         10*ratio,  	10, 	chip, 	eff_4,  nil)
	--
	g_PresetParamCache[WeaponComponents.FlashlightDot]["stealth_kill_bonus"] 			= stealth_kill
	g_PresetParamCache[WeaponComponents.FlashlightDot_aa12]["stealth_kill_bonus"] 		= stealth_kill
	g_PresetParamCache[WeaponComponents.FlashlightDot_PSG_M1]["stealth_kill_bonus"] 	= stealth_kill
	g_PresetParamCache[WeaponComponents.FlashlightDot_Anaconda]["stealth_kill_bonus"] 	= stealth_kill
end


--WeaponComponent [Masters of War]
local function TE_Bipod_MoW(ratio)
    local eff_1 = {
        "AccuracyBonusProne",
		"CombatMod_BipodPenalty",
	}
    local para_1 = {
		PlaceObj('PresetParamNumber', {
			'Name', "AccuracyBonusProne",
			'Value', 25,
			'Tag', "<AccuracyBonusProne>",
		}),
	}
	
	--
    TE_Component("AK47_Bipod",                 (10*ratio),  0,  	nil,    eff_1,  para_1)
    TE_Component("Bipod_Under",                (10*ratio),  0,  	nil,    eff_1,  para_1)
    TE_Component("Bipod_Galil",                (10*ratio),  0,  	nil,    eff_1,  para_1)
    TE_Component("Bipod_MG42",                 (10*ratio),  0,  	nil,    eff_1,  para_1)
    TE_Component("Bipod",                      (10*ratio),  0,  	nil,    eff_1,  para_1)
    TE_Component("MoW_Bip_AWSM",               (10*ratio),  0,  	nil,    eff_1,  para_1)
    TE_Component("MoW_Bip_SG550",              (10*ratio),  0,  	nil,    eff_1,  para_1)
    TE_Component("MoW_Bip_SG550_1",            (10*ratio),  0,  	nil,    eff_1,  para_1)
    TE_Component("MoW_BipE_Chey",              (10*ratio),  0,  	nil,    eff_1,  para_1)
    TE_Component("MoW_BipE_Lynx",              (10*ratio),  0,  	nil,    eff_1,  para_1)
    TE_Component("MoW_Bip_MAG",                (10*ratio),  0,  	nil,    eff_1,  para_1)
    TE_Component("MoW_Bip_RPD",                (10*ratio),  0,  	nil,    eff_1,  para_1)
    TE_Component("MoW_Bip_NG7",                (10*ratio),  0,  	nil,    eff_1,  para_1)
    TE_Component("MoW_BipE_AANF1",             (10*ratio),  0,  	nil,    eff_1,  para_1)
    TE_Component("MoW_BipE_PKP",               (10*ratio),  0,  	nil,    eff_1,  para_1)
    TE_Component("MoW_Bip_Atlas",              (10*ratio),  0,  	nil,    eff_1,  para_1)
    TE_Component("MoW_BipE_RIS",               (10*ratio),  0,  	nil,    eff_1,  para_1)
    TE_Component("MoW_BipE_Civlife",           (10*ratio),  0,  	nil,    eff_1,  para_1)
	--
	g_PresetParamCache[WeaponComponents.AK47_Bipod]["AccuracyBonusProne"] 	         = 25
	g_PresetParamCache[WeaponComponents.Bipod_Under]["AccuracyBonusProne"] 	         = 25
	g_PresetParamCache[WeaponComponents.Bipod_Galil]["AccuracyBonusProne"] 	         = 25
	g_PresetParamCache[WeaponComponents.Bipod_MG42]["AccuracyBonusProne"] 	         = 25
	g_PresetParamCache[WeaponComponents.Bipod]["AccuracyBonusProne"] 	             = 25
	g_PresetParamCache[WeaponComponents.MoW_Bip_AWSM]["AccuracyBonusProne"] 	     = 25
	g_PresetParamCache[WeaponComponents.MoW_Bip_SG550]["AccuracyBonusProne"] 	     = 25
	g_PresetParamCache[WeaponComponents.MoW_Bip_SG550_1]["AccuracyBonusProne"] 	     = 25
	g_PresetParamCache[WeaponComponents.MoW_BipE_Chey]["AccuracyBonusProne"] 	     = 25
	g_PresetParamCache[WeaponComponents.MoW_BipE_Lynx]["AccuracyBonusProne"] 	     = 25
	g_PresetParamCache[WeaponComponents.MoW_Bip_MAG]["AccuracyBonusProne"] 	         = 25
	g_PresetParamCache[WeaponComponents.MoW_Bip_RPD]["AccuracyBonusProne"] 	         = 25
	g_PresetParamCache[WeaponComponents.MoW_Bip_NG7]["AccuracyBonusProne"] 	         = 25
	g_PresetParamCache[WeaponComponents.MoW_BipE_AANF1]["AccuracyBonusProne"] 	     = 25
	g_PresetParamCache[WeaponComponents.MoW_BipE_PKP]["AccuracyBonusProne"] 	     = 25
	g_PresetParamCache[WeaponComponents.MoW_Bip_Atlas]["AccuracyBonusProne"] 	     = 25
	g_PresetParamCache[WeaponComponents.MoW_BipE_RIS]["AccuracyBonusProne"] 	     = 25
	g_PresetParamCache[WeaponComponents.MoW_BipE_Civlife]["AccuracyBonusProne"] 	 = 25
end

local function TE_Grip_MoW(ratio)
    local eff_1 = {
        "CombatMod_AutoStrength",
	}

	--
    TE_Component("AK47_Handguard_basic",       0,  		    -25,    nil,    "n/a",  "n/a")
    TE_Component("AKSU_Hanguard_Basic",        0,  		    -25,    nil,    "n/a",  "n/a")
    TE_Component("RPK74_Hanguard_Basic",       0,  		    -25,    nil,    "n/a",  "n/a")
    TE_Component("FNFAL_Handguard",            0,  		    -25,    nil,    "n/a",  "n/a")
    TE_Component("Galil_Handguard_Default",    0,  		    -25,    nil,    "n/a",  "n/a")
    TE_Component("M16_Handguard",              0,  		    -25,    nil,    "n/a",  "n/a")
    TE_Component("Handguard_Commando",         0,  		    -25,    nil,    "n/a",  "n/a")
    TE_Component("MP5_Handguard",              0,  		    -25,    nil,    "n/a",  "n/a")
    TE_Component("TacGrip",                    10*ratio, 	0,      nil,    eff_1,  "n/a")
    TE_Component("AK47_TacGrip",               10*ratio, 	0,      nil,    eff_1,  "n/a")
    TE_Component("TacGrip_M14",                10*ratio, 	0,      nil,    eff_1,  "n/a")
    TE_Component("VerticalGrip",               10*ratio, 	0,      nil,    "n/a",  "n/a")
    TE_Component("AK47_VerticalGrip",          10*ratio, 	0,      nil,    "n/a",  "n/a")
    TE_Component("AKSU_VerticalGrip",          10*ratio, 	0,      nil,    "n/a",  "n/a")
    TE_Component("RPK74_VerticalGrip",         10*ratio, 	0,      nil,    "n/a",  "n/a")
    TE_Component("VerticalGrip_AUG",           10*ratio, 	0,      nil,    "n/a",  "n/a")
    TE_Component("VerticalGrip_M14",           10*ratio, 	0,      nil,    "n/a",  "n/a")
    TE_Component("VerticalGrip_M16",           10*ratio, 	0,      nil,    "n/a",  "n/a")
    TE_Component("VerticalGrip_Commando",      10*ratio, 	0,      nil,    "n/a",  "n/a")
    TE_Component("MoW_Gri_RK3",                10*ratio, 	0,      nil,    eff_1,  "n/a")
    TE_Component("MoW_Gri_Ergo",               10*ratio, 	0,      nil,    eff_1,  "n/a")
    TE_Component("MoW_Gri_Molded",             10*ratio, 	0,      nil,    eff_1,  "n/a")
    TE_Component("MoW_Gri_HB",                 10*ratio, 	0,      nil,    eff_1,  "n/a")
    TE_Component("MoW_Gri_R8",                 10*ratio, 	0,      nil,    eff_1,  "n/a")
    TE_Component("MoW_Gri_P226",               10*ratio, 	0,      nil,    eff_1,  "n/a")
    TE_Component("MoW_Gri_P226E2",             10*ratio, 	0,      nil,    eff_1,  "n/a")
    TE_Component("MoW_Gri_P226OM",             10*ratio, 	0,      nil,    eff_1,  "n/a")
    TE_Component("MoW_Gri_P228",               10*ratio, 	0,      nil,    eff_1,  "n/a")
    TE_Component("MoW_Gri_DRD",                10*ratio, 	0,      nil,    eff_1,  "n/a")
    TE_Component("MoW_Gri_SG750",              10*ratio, 	0,      nil,    eff_1,  "n/a")
    TE_Component("MoW_Gri_SG550_1",            10*ratio, 	0,      nil,    eff_1,  "n/a")
    TE_Component("MoW_Gri_M200",               10*ratio, 	0,      nil,    eff_1,  "n/a")
    TE_Component("MoW_Gri_G3",                 10*ratio, 	0,      nil,    eff_1,  "n/a")
    TE_Component("MoW_Gri_AMD65",              10*ratio, 	0,      nil,    eff_1,  "n/a")
    TE_Component("MoW_Gri_HK416A5",            10*ratio, 	0,      nil,    eff_1,  "n/a")
    TE_Component("MoW_Gri_CAR15",              10*ratio, 	0,      nil,    eff_1,  "n/a")
    TE_Component("MoW_Gri_HK416",              10*ratio, 	0,      nil,    eff_1,  "n/a")
    TE_Component("MoW_Gri_AK12",               10*ratio, 	0,      nil,    eff_1,  "n/a")
    TE_Component("MoW_Gri_AK74",               10*ratio, 	0,      nil,    eff_1,  "n/a")
    TE_Component("MoW_Gri_AK74M",              10*ratio, 	0,      nil,    eff_1,  "n/a")
    TE_Component("MoW_Gri_A2",                 10*ratio, 	0,      nil,    eff_1,  "n/a")
    TE_Component("MoW_Gri_RPD",                10*ratio, 	0,      nil,    eff_1,  "n/a")
    TE_Component("MoW_Gri_PKP",                10*ratio, 	0,      nil,    eff_1,  "n/a")
end

local function TE_GL_MoW(ratio)
	--
    TE_Component("GrenadeLauncher",            10*ratio, 	0,  	pipe,	"n/a",  "n/a")
    TE_Component("AK47_Launcher",              10*ratio, 	0,  	pipe,	"n/a",  "n/a")
    TE_Component("GrenadeLauncher_AUG",        10*ratio, 	0,  	pipe,	"n/a",  "n/a")
    TE_Component("GrenadeLauncher_Galil",      10*ratio, 	0,  	pipe,	"n/a",  "n/a")
    TE_Component("GrenadeLauncher_M14",        10*ratio, 	0,  	pipe,	"n/a",  "n/a")
    TE_Component("GrenadeLauncher_M16A1",      10*ratio, 	0,  	pipe,	"n/a",  "n/a")
    TE_Component("GrenadeLauncher_Commando",   10*ratio, 	0,  	pipe,	"n/a",  "n/a")
    TE_Component("MoW_UGL_AGC",                10*ratio, 	0,  	pipe,	"n/a",  "n/a")
    TE_Component("MoW_UGL_GP30",               10*ratio, 	0,  	pipe,	"n/a",  "n/a")
    TE_Component("MoW_UGL_M203",               10*ratio, 	0,  	pipe,	"n/a",  "n/a")
end

local function TE_Muzzle_MoW(ratio)
    local eff_1 = {
		"IncreasedSingleShotAccuracy",
        "CombatMod_ReduceAutoPenalty",
	}

	local eff_2 = {
		"IncreasedSingleShotAccuracy",
        "CombatMod_ReduceAutoPenalty",
		"ExtraBurstShots",
	}

    local eff_3 = {
        "IncreaseBuckshotAngle"
	}
    local para_3 = {
		PlaceObj('PresetParamNumber', {
			'Name', "BuckshotAngleIncrease",
			'Value', 120,
			'Tag', "<BuckshotAngleIncrease>",
		}),
	}

    local eff_4 = {
		"IncreaseRange",
		"DecreaseBuckshotAngle",
	}
    local para_4 = {
		PlaceObj('PresetParamNumber', {
			'Name', "RangeIncrease",
			'Value', range_mod,
			'Tag', "<RangeIncrease>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "BuckshotAngleDecrease",
			'Value', 80,
			'Tag', "<BuckshotAngleDecrease>",
		}),
	}

	--
    TE_Component("Compensator_cosmetic",       0,  		    -25,    nil,    "n/a",  "n/a")
    TE_Component("Galil_Brake_Default",        0,  		    -25,    nil,    "n/a",  "n/a")
    TE_Component("DefaultMuzzle_HK21",         0,  		    -25,    nil,    "n/a",  "n/a")
    TE_Component("M14_Default_Muzzle",         0,  		    -25,    nil,    "n/a",  "n/a")
    TE_Component("MuzzleBooster",              10*ratio,	0,      nil,    "n/a",  "n/a")
    TE_Component("MuzzleBooster_Glock18",      10*ratio,	0,      nil,    "n/a",  "n/a")
    TE_Component("Compensator",                10*ratio,	0,      nil,    eff_1,  "n/a")
    TE_Component("Compensator_Glock",          10*ratio,	0,      nil,    eff_1,  "n/a")
    TE_Component("AUGCompensator_01",          10*ratio,	0,      nil,    eff_1,  "n/a")
    TE_Component("AUGCompensator_03",          10*ratio,	0,      nil,    eff_2,  "n/a")
    TE_Component("DuckbillChoke",              10*ratio,	0,      nil,    eff_3,  para_3)
    TE_Component("FullChoke",                  10*ratio,	0,      nil,    eff_4,  para_4)
    TE_Component("MoW_Muz_KDW",                10*ratio,	0,      nil,    eff_1,  "n/a")
    TE_Component("MoW_Muz_T5000",              10*ratio,	0,      nil,    eff_1,  "n/a")
    TE_Component("MoW_Muz_M2010",              10*ratio,	0,      nil,    eff_1,  "n/a")
    TE_Component("MoW_Muz_Lynx",               10*ratio,	0,      nil,    eff_1,  "n/a")
    TE_Component("MoW_Muz_AK102",              10*ratio,	0,      nil,    eff_1,  "n/a")
    TE_Component("MoW_Muz_AMD65",              10*ratio,	0,      nil,    eff_1,  "n/a")
    TE_Component("MoW_Muz_AMD65long",          10*ratio,	0,      nil,    eff_1,  "n/a")
    TE_Component("MoW_Muz_AK12k",              10*ratio,	0,      nil,    eff_1,  "n/a")
    TE_Component("MoW_Muz_AK12",               10*ratio,	0,      nil,    eff_1,  "n/a")
    TE_Component("MoW_Muz_TAR21",              10*ratio,	0,      nil,    eff_1,  "n/a")
    TE_Component("MoW_Muz_ASR338",             10*ratio,	0,      nil,    eff_2,  "n/a")
    TE_Component("MoW_Muz_AACFlashH",          10*ratio,	0,      nil,    eff_2,  "n/a")
    TE_Component("MoW_Muz_KX3",                10*ratio,	0,      nil,    eff_2,  "n/a")
    TE_Component("MoW_Muz_HK417_3P",           10*ratio,	0,      nil,    eff_2,  "n/a")
    TE_Component("MoW_Muz_Warcomp",            10*ratio,	0,      nil,    eff_2,  "n/a")
    TE_Component("MoW_Muz_SF",                 10*ratio,	0,      nil,    eff_2,  "n/a")
    TE_Component("MoW_Muz_KM",                 10*ratio,	0,      nil,    eff_2,  "n/a")
    TE_Component("MoW_Muz_6P20",               10*ratio,	0,      nil,    eff_2,  "n/a")
    TE_Component("MoW_Muz_DTK1",               10*ratio,	0,      nil,    eff_2,  "n/a")
    TE_Component("MoW_Muz_DTK2",               10*ratio,	0,      nil,    eff_2,  "n/a")
    TE_Component("MoW_Muz_M240",               10*ratio,	0,      nil,    eff_2,  "n/a")
    TE_Component("MoW_Muz_NG7",                10*ratio,	0,      nil,    eff_2,  "n/a")
	--
	g_PresetParamCache[WeaponComponents.DuckbillChoke]["BuckshotAngleIncrease"] = 120
	g_PresetParamCache[WeaponComponents.FullChoke]["RangeIncrease"] 			= range_mod
	g_PresetParamCache[WeaponComponents.FullChoke]["BuckshotAngleDecrease"] 	= 80
end

local function TE_Suppressor_MoW(ratio)
    local eff_1 = {
		"SilentShots",
		"ReduceReliability",
	}
    local para_1 = {
		PlaceObj('PresetParamNumber', {
			'Name', "ReliabilityDecrease",
			'Value', dura_mod,
			'Tag', "<ReliabilityDecrease>",
		}),
	}

    local eff_2 = {
		"SilentShots",
		"StealthKillBonusPerAim",
	}
    local para_2 = {
		PlaceObj('PresetParamPercent', {
			'Name', "stealth_kill_bonus",
			'Value', stealth_kill,
			'Tag', "<stealth_kill_bonus>%",
		}),
	}

	--
    TE_Component("ImprovisedSuppressor",           5*ratio, 	-10,    nil,    eff_1,  para_1)
    TE_Component("ImprovisedSuppressor_Anaconda",  5*ratio, 	-10,    nil,    eff_1,  para_1)
    TE_Component("Suppressor",                     10*ratio, 	0,      pipe,   eff_2,  para_2)
    TE_Component("Suppressor_Anaconda",            10*ratio, 	0,      pipe,   eff_2,  para_2)
    TE_Component("MoW_Muz_Harvester",              10*ratio, 	0,      pipe,   eff_2,  para_2)
    TE_Component("MoW_Muz_AEM5",                   10*ratio, 	0,      pipe,   eff_2,  para_2)
    TE_Component("MoW_Muz_Omega45",                10*ratio, 	0,      pipe,   eff_2,  para_2)
    TE_Component("MoW_Muz_416SD",                  10*ratio, 	0,      pipe,   eff_2,  para_2)
    TE_Component("MoW_Muz_SF762RC2",               10*ratio, 	0,      pipe,   eff_2,  para_2)
    TE_Component("MoW_Muz_SF556RC2",               10*ratio, 	0,      pipe,   eff_2,  para_2)
    TE_Component("MoW_Muz_DTKP",                   10*ratio, 	0,      pipe,   eff_2,  para_2)
    TE_Component("MoW_Muz_M42000",                 10*ratio, 	0,      pipe,   eff_2,  para_2)
    TE_Component("MoW_Muz_SDN6",                   10*ratio, 	0,      pipe,   eff_2,  para_2)
    TE_Component("MoW_Muz_RotexIII",               10*ratio, 	0,      pipe,   eff_2,  para_2)
    TE_Component("MoW_Muz_PBS1",                   10*ratio, 	0,      pipe,   eff_2,  para_2)
    TE_Component("MoW_Muz_TGPA",                   10*ratio, 	0,      pipe,   eff_2,  para_2)
    TE_Component("MoW_Muz_Spectre",                10*ratio, 	0,      pipe,   eff_2,  para_2)
    TE_Component("MoW_Muz_Rev45",                  10*ratio, 	0,      pipe,   eff_2,  para_2)
    TE_Component("MoW_Muz_Rev9",                   10*ratio, 	0,      pipe,   eff_2,  para_2)
    TE_Component("MoW_Muz_Omega9",                 10*ratio, 	0,      pipe,   eff_2,  para_2)
    TE_Component("MoW_Muz_Obs9s",                  10*ratio, 	0,      pipe,   eff_2,  para_2)
    TE_Component("MoW_Muz_Obs9",                   10*ratio, 	0,      pipe,   eff_2,  para_2)
    TE_Component("MoW_Muz_N4",                     10*ratio, 	0,      pipe,   eff_2,  para_2)
    TE_Component("MoW_Muz_Phantom",                10*ratio, 	0,      pipe,   eff_2,  para_2)
    TE_Component("MoW_Muz_HB",                     10*ratio, 	0,      pipe,   eff_2,  para_2)
    TE_Component("MoW_Muz_MP7Supr",                10*ratio, 	0,      pipe,   eff_2,  para_2)
    TE_Component("MoW_Muz_PBS9",                   10*ratio, 	0,      pipe,   eff_2,  para_2)
    TE_Component("MoW_Muz_Vector",                 10*ratio, 	0,      pipe,   eff_2,  para_2)
    TE_Component("MoW_Muz_MP9",                    10*ratio, 	0,      pipe,   eff_2,  para_2)
    TE_Component("MoW_Muz_APS",                    10*ratio, 	0,      pipe,   eff_2,  para_2)
    TE_Component("MoW_Muz_PB",                     10*ratio, 	0,      pipe,   eff_2,  para_2)
    TE_Component("MoW_Muz_PM",                     10*ratio, 	0,      pipe,   eff_2,  para_2)
    TE_Component("MoW_Muz_DTSS338",                10*ratio, 	0,      pipe,   eff_2,  para_2)
    TE_Component("MoW_Muz_AWSM",                   10*ratio, 	0,      pipe,   eff_2,  para_2)
    TE_Component("MoW_Muz_M200Supr",               10*ratio, 	0,      pipe,   eff_2,  para_2)
    TE_Component("MoW_Muz_SR25",                   10*ratio, 	0,      pipe,   eff_2,  para_2)
	--
	g_PresetParamCache[WeaponComponents.ImprovisedSuppressor]["ReliabilityDecrease"] 	        = dura_mod
	g_PresetParamCache[WeaponComponents.ImprovisedSuppressor_Anaconda]["ReliabilityDecrease"] 	= dura_mod
	g_PresetParamCache[WeaponComponents.Suppressor]["stealth_kill_bonus"] 			            = stealth_kill
	g_PresetParamCache[WeaponComponents.Suppressor_Anaconda]["stealth_kill_bonus"] 		        = stealth_kill
	g_PresetParamCache[WeaponComponents.MoW_Muz_Harvester]["stealth_kill_bonus"] 	            = stealth_kill
	g_PresetParamCache[WeaponComponents.MoW_Muz_AEM5]["stealth_kill_bonus"] 	                = stealth_kill
	g_PresetParamCache[WeaponComponents.MoW_Muz_Omega45]["stealth_kill_bonus"] 	                = stealth_kill
	g_PresetParamCache[WeaponComponents.MoW_Muz_416SD]["stealth_kill_bonus"] 	                = stealth_kill
	g_PresetParamCache[WeaponComponents.MoW_Muz_SF762RC2]["stealth_kill_bonus"] 	            = stealth_kill
	g_PresetParamCache[WeaponComponents.MoW_Muz_SF556RC2]["stealth_kill_bonus"] 	            = stealth_kill
	g_PresetParamCache[WeaponComponents.MoW_Muz_DTKP]["stealth_kill_bonus"] 	                = stealth_kill
	g_PresetParamCache[WeaponComponents.MoW_Muz_M42000]["stealth_kill_bonus"] 	                = stealth_kill
	g_PresetParamCache[WeaponComponents.MoW_Muz_SDN6]["stealth_kill_bonus"] 	                = stealth_kill
	g_PresetParamCache[WeaponComponents.MoW_Muz_RotexIII]["stealth_kill_bonus"] 	            = stealth_kill
	g_PresetParamCache[WeaponComponents.MoW_Muz_PBS1]["stealth_kill_bonus"] 	                = stealth_kill
	g_PresetParamCache[WeaponComponents.MoW_Muz_TGPA]["stealth_kill_bonus"] 	                = stealth_kill
	g_PresetParamCache[WeaponComponents.MoW_Muz_Spectre]["stealth_kill_bonus"] 	                = stealth_kill
	g_PresetParamCache[WeaponComponents.MoW_Muz_Rev45]["stealth_kill_bonus"] 	                = stealth_kill
	g_PresetParamCache[WeaponComponents.MoW_Muz_Rev9]["stealth_kill_bonus"] 	                = stealth_kill
	g_PresetParamCache[WeaponComponents.MoW_Muz_Omega9]["stealth_kill_bonus"] 	                = stealth_kill
	g_PresetParamCache[WeaponComponents.MoW_Muz_Obs9s]["stealth_kill_bonus"] 	                = stealth_kill
	g_PresetParamCache[WeaponComponents.MoW_Muz_Obs9]["stealth_kill_bonus"] 	                = stealth_kill
	g_PresetParamCache[WeaponComponents.MoW_Muz_N4]["stealth_kill_bonus"] 	                    = stealth_kill
	g_PresetParamCache[WeaponComponents.MoW_Muz_Phantom]["stealth_kill_bonus"] 	                = stealth_kill
	g_PresetParamCache[WeaponComponents.MoW_Muz_HB]["stealth_kill_bonus"] 	                    = stealth_kill
	g_PresetParamCache[WeaponComponents.MoW_Muz_MP7Supr]["stealth_kill_bonus"] 	                = stealth_kill
	g_PresetParamCache[WeaponComponents.MoW_Muz_PBS9]["stealth_kill_bonus"] 	                = stealth_kill
	g_PresetParamCache[WeaponComponents.MoW_Muz_Vector]["stealth_kill_bonus"] 	                = stealth_kill
	g_PresetParamCache[WeaponComponents.MoW_Muz_MP9]["stealth_kill_bonus"] 	                    = stealth_kill
	g_PresetParamCache[WeaponComponents.MoW_Muz_APS]["stealth_kill_bonus"] 	                    = stealth_kill
	g_PresetParamCache[WeaponComponents.MoW_Muz_PB]["stealth_kill_bonus"] 	                    = stealth_kill
	g_PresetParamCache[WeaponComponents.MoW_Muz_PM]["stealth_kill_bonus"] 	                    = stealth_kill
	g_PresetParamCache[WeaponComponents.MoW_Muz_DTSS338]["stealth_kill_bonus"] 	                = stealth_kill
	g_PresetParamCache[WeaponComponents.MoW_Muz_AWSM]["stealth_kill_bonus"] 	                = stealth_kill
	g_PresetParamCache[WeaponComponents.MoW_Muz_M200Supr]["stealth_kill_bonus"] 	            = stealth_kill
	g_PresetParamCache[WeaponComponents.MoW_Muz_SR25]["stealth_kill_bonus"] 	                = stealth_kill
end

local function TE_Barrel_MoW(ratio)
    local eff_1 = {
		"HalfRangeDmgIncrease",
		"ReduceShootAP",
		"ReduceRange",
	}
    local para_1 = {
		PlaceObj('PresetParamNumber', {
			'Name', "ShootAPDecrease",
			'Value', 1,
			'Tag', "<ShootAPDecrease>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "RangeDecrease",
			'Value', range_mod,
			'Tag', "<RangeDecrease>",
		}),
	}

    local eff_2 = {
		"IncreaseRange",
		"IncreaseAimAccuracy",
	}
    local para_2 = {
		PlaceObj('PresetParamNumber', {
			'Name', "RangeIncrease",
			'Value', range_mod,
			'Tag', "<RangeIncrease>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "AimAccuracyIncrease",
			'Value', 2,
			'Tag', "<AimAccuracyIncrease>",
		}),
	}

    local eff_3 = {
		"AccuracyBonusProne",
		"CombatMod_BipodPenalty",
		"IncreaseRange",
		"IncreaseAimAccuracy",
	}
    local para_3 = {
		PlaceObj('PresetParamNumber', {
			'Name', "AccuracyBonusProne",
			'Value', 25,
			'Tag', "<AccuracyBonusProne>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "RangeIncrease",
			'Value', range_mod,
			'Tag', "<RangeIncrease>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "AimAccuracyIncrease",
			'Value', 2,
			'Tag', "<AimAccuracyIncrease>",
		}),
	}

    local eff_4 = {
		"IncreaseAimAccuracy",
		"IncreaseReliability",
	}
    local para_4 = {
		PlaceObj('PresetParamNumber', {
			'Name', "AimAccuracyIncrease",
			'Value', 1,
			'Tag', "<AimAccuracyIncrease>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "ReliabilityIncrease",
			'Value', dura_mod,
			'Tag', "<ReliabilityIncrease>",
		}),
	}

    local eff_5 = {
		"HalfRangeDmgIncrease",
		"ReduceShootAP",
		"ReduceRange",
        "IncreaseReliability",
	}
    local para_5 = {
		PlaceObj('PresetParamNumber', {
			'Name', "ShootAPDecrease",
			'Value', 1,
			'Tag', "<ShootAPDecrease>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "RangeDecrease",
			'Value', range_mod,
			'Tag', "<RangeDecrease>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "ReliabilityIncrease",
			'Value', dura_mod,
			'Tag', "<ReliabilityIncrease>",
		}),
	}

    local eff_6 = {
        "IncreaseRange",
		"IncreaseAimAccuracy",
		"IncreaseReliability",
	}
    local para_6 = {
		PlaceObj('PresetParamNumber', {
			'Name', "RangeIncrease",
			'Value', range_mod,
			'Tag', "<RangeIncrease>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "AimAccuracyIncrease",
			'Value', 2,
			'Tag', "<AimAccuracyIncrease>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "ReliabilityIncrease",
			'Value', dura_mod,
			'Tag', "<ReliabilityIncrease>",
		}),
	}

    local eff_7 = {
		"AccuracyBonusProne",
		"CombatMod_BipodPenalty",
		"IncreaseRange",
		"IncreaseAimAccuracy",
		"IncreaseReliability",
	}
    local para_7 = {
		PlaceObj('PresetParamNumber', {
			'Name', "AccuracyBonusProne",
			'Value', 25,
			'Tag', "<AccuracyBonusProne>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "RangeIncrease",
			'Value', range_mod,
			'Tag', "<RangeIncrease>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "AimAccuracyIncrease",
			'Value', 2,
			'Tag', "<AimAccuracyIncrease>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "ReliabilityIncrease",
			'Value', dura_mod,
			'Tag', "<ReliabilityIncrease>",
		}),
	}

    local eff_8 = {
		"AccuracyBonusSameTarget",
		"IncreaseDamage",
		"IncreaseAimAccuracy"
	}
    local para_8 = {
		PlaceObj('PresetParamNumber', {
			'Name', "DamageIncrease",
			'Value', 7,
			'Tag', "<DamageIncrease>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "AimAccuracyIncrease",
			'Value', 1,
			'Tag', "<AimAccuracyIncrease>",
		}),
	}

    local eff_9 = {
		"HalfRangeDmgIncrease",
		"ReduceShootAP",
		"ReduceRange",
		"ReduceMagazineSize",
	}
    local para_9 = {
		PlaceObj('PresetParamNumber', {
			'Name', "ShootAPDecrease",
			'Value', 1,
			'Tag', "<ShootAPDecrease>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "RangeDecrease",
			'Value', range_mod,
			'Tag', "<RangeDecrease>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "MagazineSizeDecrease",
			'Value', 2,
			'Tag', "<MagazineSizeDecrease>",
		}),
	}

    local eff_A = {
		"IncreaseDamage",
		"ChangeCaliberToBMG",
		"ReduceReliability",
	}
    local para_A = {
		PlaceObj('PresetParamNumber', {
			'Name', "DamageIncrease",
			'Value', 14,
			'Tag', "<DamageIncrease>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "ReliabilityDecrease",
			'Value', dura_mod,
			'Tag', "<ReliabilityDecrease>",
		}),
	}

	--
    TE_Component("BarrelNormal",               10*ratio, 	0, 		pipe,   nil,    nil)
    TE_Component("BarrelShort",                15*ratio, 	10,		pipe,   eff_1,  para_1)
    TE_Component("BarrelShort_AUG",            15*ratio, 	10,		pipe,   eff_1,  para_1)
    TE_Component("BarrelLong",                 15*ratio, 	10,		pipe,   eff_2,  para_2)
    TE_Component("BarrelLong_AUG",             15*ratio, 	10,		pipe,   eff_3,  para_3)
    TE_Component("BarrelNormalImproved",       15*ratio, 	10,		pipe,   eff_4,  para_4)
    TE_Component("BarrelShortImproved",        25*ratio, 	20,		pipe,   eff_5,  para_5)
    TE_Component("BarrelShortImproved_AUG",    25*ratio, 	20,		pipe,   eff_5,  para_5)
    TE_Component("BarrelLongImproved",         25*ratio, 	20,		pipe,   eff_6,  para_6)
    TE_Component("BarrelLongImproved_AUG",     25*ratio, 	20,		pipe,   eff_7,  para_7)
    TE_Component("BarrelHeavy",                25*ratio, 	20,		pipe,   eff_8,  para_8)
    TE_Component("BarrelShort_Winchester",     15*ratio, 	10,		pipe,   eff_9,  para_9)
    TE_Component("Barrel50BMG_DesertEagle",    15*ratio, 	10,		pipe,   eff_A,  para_A)
	--
	g_PresetParamCache[WeaponComponents.BarrelShort]["ShootAPDecrease"] 				= 1
	g_PresetParamCache[WeaponComponents.BarrelShort]["RangeDecrease"] 					= range_mod
	g_PresetParamCache[WeaponComponents.BarrelShort_AUG]["ShootAPDecrease"] 			= 1
	g_PresetParamCache[WeaponComponents.BarrelShort_AUG]["RangeDecrease"] 				= range_mod
	g_PresetParamCache[WeaponComponents.BarrelLong]["RangeIncrease"] 					= range_mod
	g_PresetParamCache[WeaponComponents.BarrelLong]["AimAccuracyIncrease"] 				= 2
	g_PresetParamCache[WeaponComponents.BarrelLong_AUG]["AccuracyBonusProne"] 			= 25
	g_PresetParamCache[WeaponComponents.BarrelLong_AUG]["RangeIncrease"] 				= range_mod
	g_PresetParamCache[WeaponComponents.BarrelLong_AUG]["AimAccuracyIncrease"] 			= 2
	g_PresetParamCache[WeaponComponents.BarrelNormalImproved]["AimAccuracyIncrease"] 	= 1
	g_PresetParamCache[WeaponComponents.BarrelNormalImproved]["ReliabilityIncrease"] 	= dura_mod
	g_PresetParamCache[WeaponComponents.BarrelShortImproved]["ShootAPDecrease"] 		= 1
	g_PresetParamCache[WeaponComponents.BarrelShortImproved]["RangeDecrease"] 			= range_mod
	g_PresetParamCache[WeaponComponents.BarrelShortImproved]["ReliabilityIncrease"] 	= dura_mod
	g_PresetParamCache[WeaponComponents.BarrelShortImproved_AUG]["ShootAPDecrease"] 	= 1
	g_PresetParamCache[WeaponComponents.BarrelShortImproved_AUG]["RangeDecrease"] 		= range_mod
	g_PresetParamCache[WeaponComponents.BarrelShortImproved_AUG]["ReliabilityIncrease"] = dura_mod
	g_PresetParamCache[WeaponComponents.BarrelLongImproved]["RangeIncrease"] 			= range_mod
	g_PresetParamCache[WeaponComponents.BarrelLongImproved]["AimAccuracyIncrease"] 	    = 2
	g_PresetParamCache[WeaponComponents.BarrelLongImproved]["ReliabilityIncrease"] 		= dura_mod
	g_PresetParamCache[WeaponComponents.BarrelLongImproved_AUG]["AccuracyBonusProne"] 	= 25
	g_PresetParamCache[WeaponComponents.BarrelLongImproved_AUG]["RangeIncrease"] 		= range_mod
	g_PresetParamCache[WeaponComponents.BarrelLongImproved_AUG]["AimAccuracyIncrease"]  = 2
	g_PresetParamCache[WeaponComponents.BarrelLongImproved_AUG]["ReliabilityIncrease"] 	= dura_mod
	g_PresetParamCache[WeaponComponents.BarrelHeavy]["DamageIncrease"] 					= 7
	g_PresetParamCache[WeaponComponents.BarrelHeavy]["AimAccuracyIncrease"] 			= 1
	g_PresetParamCache[WeaponComponents.BarrelShort_Winchester]["ShootAPDecrease"] 		= 1
	g_PresetParamCache[WeaponComponents.BarrelShort_Winchester]["RangeDecrease"] 		= range_mod
	g_PresetParamCache[WeaponComponents.BarrelShort_Winchester]["MagazineSizeDecrease"] = 2
	g_PresetParamCache[WeaponComponents.Barrel50BMG_DesertEagle]["DamageIncrease"] 		= 14
	g_PresetParamCache[WeaponComponents.Barrel50BMG_DesertEagle]["ReliabilityDecrease"] = dura_mod
end

local function TE_Barrel_Shotgun_MoW(ratio)
    local eff_1 = {
		"IncreaseRange",
		"IncreaseAimAccuracy",
	}
    local para_1 = {
		PlaceObj('PresetParamNumber', {
			'Name', "RangeIncrease",
			'Value', range_mod,
			'Tag', "<RangeIncrease>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "AimAccuracyIncrease",
			'Value', 2,
			'Tag', "<AimAccuracyIncrease>",
		}),
	}

    local eff_2 = {
		"ReduceShootAP",
		"ReduceRange",
		"HalfRangeDmgIncrease",
		"IncreaseBuckshotAngle",
	}
    local para_2 = {
		PlaceObj('PresetParamNumber', {
			'Name', "ShootAPDecrease",
			'Value', 1,
			'Tag', "<ShootAPDecrease>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "RangeDecrease",
			'Value', range_mod,
			'Tag', "<RangeDecrease>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "BuckshotAngleIncrease",
			'Value', 120,
			'Tag', "<BuckshotAngleIncrease>",
		}),
	}

    local eff_3 = {
		"ReduceMagazineSize",
		"ReduceShootAP",
        "ReduceRange",
		"HalfRangeDmgIncrease",
        "IncreaseBuckshotAngle",
	}
    local para_3 = {
        PlaceObj('PresetParamNumber', {
			'Name', "MagazineSizeDecrease",
			'Value', 2,
			'Tag', "<MagazineSizeDecrease>",
		}),
        PlaceObj('PresetParamNumber', {
			'Name', "ShootAPDecrease",
			'Value', 1,
			'Tag', "<ShootAPDecrease>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "RangeDecrease",
			'Value', range_mod,
			'Tag', "<RangeDecrease>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "BuckshotAngleIncrease",
			'Value', 120,
			'Tag', "<BuckshotAngleIncrease>",
		}),
	}

    local eff_4 = {
		"IncreaseRange",
		"IncreaseAimAccuracy",
		"MagazineSizeMultiplier",
	}
    local para_4 = {
		PlaceObj('PresetParamNumber', {
			'Name', "RangeIncrease",
			'Value', range_mod,
			'Tag', "<RangeIncrease>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "AimAccuracyIncrease",
			'Value', 2,
			'Tag', "<AimAccuracyIncrease>",
		}),
		PlaceObj('PresetParamPercent', {
			'Name', "MagazineSizeMultiplier",
			'Value', 150,
			'Tag', "<MagazineSizeMultiplier>%",
		}),
	}

    local eff_5 = {
        "MagazineSizeMultiplier",
	}
    local para_5 = {
		PlaceObj('PresetParamPercent', {
			'Name', "MagazineSizeMultiplier",
			'Value', 150,
			'Tag', "<MagazineSizeMultiplier>%",
		}),
	}

    local eff_6 = {
		"IncreaseRange",
		"IncreaseAimAccuracy",
	}
    local para_6 = {
		PlaceObj('PresetParamNumber', {
			'Name', "RangeIncrease",
			'Value', range_mod,
			'Tag', "<RangeIncrease>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "AimAccuracyIncrease",
			'Value', 2,
			'Tag', "<AimAccuracyIncrease>",
		}),
	}

    local eff_7 = {
		"ReduceShootAP",
		"ReduceRange",
		"HalfRangeDmgIncrease",
		"IncreaseBuckshotAngle",
	}
    local para_7 = {
		PlaceObj('PresetParamNumber', {
			'Name', "ShootAPDecrease",
			'Value', 1,
			'Tag', "<ShootAPDecrease>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "RangeDecrease",
			'Value', range_mod,
			'Tag', "<RangeDecrease>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "BuckshotAngleIncrease",
			'Value', 120,
			'Tag', "<BuckshotAngleIncrease>",
		}),
	}

	--
    TE_Component("BarrelLongShotgun",          15*ratio, 	10,		pipe,   eff_1,  para_1)
    TE_Component("BarrelShortShotgun",         15*ratio, 	10,		pipe,   eff_2,  para_2)
    TE_Component("BarrelShortShotgun_Benelli", 15*ratio, 	10,		pipe,   eff_3,  para_3)
    TE_Component("Auto5_Basic_NMag",           10*ratio, 	0, 		pipe,   nil,    nil)
    TE_Component("Auto5_Long_LMag",            25*ratio, 	20,		pipe,   eff_4,  para_4)
    TE_Component("Auto5_Basic_LMag",           15*ratio, 	10,		pipe,   eff_5,  para_5)
    TE_Component("Auto5_Long_NMag",            15*ratio, 	10,		pipe,   eff_6,  para_6)
    TE_Component("Auto5_Short_NMag",           15*ratio, 	10,		pipe,   eff_7,  para_7)
    TE_Component("MoW_Bar_MP153_280",          15*ratio, 	10,		pipe,   eff_1,  para_1)
	--
	g_PresetParamCache[WeaponComponents.BarrelLongShotgun]["RangeIncrease"] 					= range_mod
	g_PresetParamCache[WeaponComponents.BarrelLongShotgun]["AimAccuracyIncrease"] 				= 2
	g_PresetParamCache[WeaponComponents.BarrelShortShotgun]["ShootAPDecrease"] 					= 1
	g_PresetParamCache[WeaponComponents.BarrelShortShotgun]["RangeDecrease"] 					= range_mod
	g_PresetParamCache[WeaponComponents.BarrelShortShotgun]["BuckshotAngleIncrease"]			= 120
	g_PresetParamCache[WeaponComponents.BarrelShortShotgun_Benelli]["MagazineSizeDecrease"] 	= 2
	g_PresetParamCache[WeaponComponents.BarrelShortShotgun_Benelli]["ShootAPDecrease"] 			= 1
	g_PresetParamCache[WeaponComponents.BarrelShortShotgun_Benelli]["RangeDecrease"] 			= range_mod
	g_PresetParamCache[WeaponComponents.BarrelShortShotgun_Benelli]["BuckshotAngleIncrease"]	= 120
	g_PresetParamCache[WeaponComponents.Auto5_Long_LMag]["RangeIncrease"] 						= range_mod
	g_PresetParamCache[WeaponComponents.Auto5_Long_LMag]["AimAccuracyIncrease"] 				= 2
	g_PresetParamCache[WeaponComponents.Auto5_Long_LMag]["MagazineSizeMultiplier"] 				= 150
	g_PresetParamCache[WeaponComponents.Auto5_Long_NMag]["RangeIncrease"] 						= range_mod
	g_PresetParamCache[WeaponComponents.Auto5_Long_NMag]["AimAccuracyIncrease"] 				= 2
	g_PresetParamCache[WeaponComponents.Auto5_Basic_LMag]["MagazineSizeMultiplier"] 			= 150
	g_PresetParamCache[WeaponComponents.Auto5_Short_NMag]["ShootAPDecrease"] 					= 1
	g_PresetParamCache[WeaponComponents.Auto5_Short_NMag]["RangeDecrease"] 						= range_mod
	g_PresetParamCache[WeaponComponents.Auto5_Short_NMag]["BuckshotAngleIncrease"]				= 120
	g_PresetParamCache[WeaponComponents.MoW_Bar_MP153_280]["RangeIncrease"] 					= range_mod
	g_PresetParamCache[WeaponComponents.MoW_Bar_MP153_280]["AimAccuracyIncrease"] 				= 2
end

local function TE_Stock_MoW(ratio)
    local eff_1 = {
		"ReduceShootAP",
		"ReduceAimAccuracy",
		"FreeWeaponSwap",
		"CombatMod_AimAccuracyLimit",
	}
    local para_1 = {
		PlaceObj('PresetParamNumber', {
			'Name', "ShootAPDecrease",
			'Value', 2,
			'Tag', "<ShootAPDecrease>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "accuracy_penalty",
			'Value', -75,
			'Tag', "<accuracy_penalty>",
		}),
	}

    local eff_2 = {
		"IncreasedSingleShotAccuracy",
		"AccuracyBonusSameTarget",
		"CombatMod_IncreaseShootAP",
	}
    local para_2 = {
		PlaceObj('PresetParamNumber', {
			'Name', "ShootAPIncrease",
			'Value', 1,
			'Tag', "<ShootAPIncrease>",
		}),
	}

	local eff_3 = {
		"ReduceShootAP",
		"ReduceAimAccuracy",
	}
    local para_3 = {
		PlaceObj('PresetParamNumber', {
			'Name', "ShootAPDecrease",
			'Value', 1,
			'Tag', "<ShootAPDecrease>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "accuracy_penalty",
			'Value', -50,
			'Tag', "<accuracy_penalty>",
		}),
	}

    local eff_4 = {
        "NoFullAuto",
    }

    local eff_5 = {
		"IncreasedSingleShotAccuracy",
		"AccuracyBonusSameTarget",
        "NoFullAuto",
		"CombatMod_IncreaseShootAP",
	}

    local eff_6 = {
		"ReduceShootAP",
		"ReduceAimAccuracy",
        "NoFullAuto",
	}

    local eff_7 = {
        "EnableFullAuto",
    }

	--
    TE_Component("StockNo",                    0,  		    -25,  	nil,    eff_1,  para_1)
    TE_Component("StockFolded",                0,  		    -25,  	nil,    eff_1,  para_1)
    TE_Component("StockNormal",                10*ratio,  	0,    	nil,    nil,    nil)
    TE_Component("StockHeavy",                 15*ratio,  	10,   	nil,    eff_2,  para_2)
    TE_Component("StockLight",                 15*ratio,  	10,   	nil,    eff_3,  para_3)
    TE_Component("StockNormal_AR_BurstOnly",   10*ratio,  	0,    	nil,    eff_4,  nil)
    TE_Component("StockHeavy_AR_BurstOnly",    15*ratio,  	10,   	nil,    eff_5,  para_2)
    TE_Component("StockLight_AR_BurstOnly",    15*ratio,  	10,   	nil,    eff_6,  para_3)
    TE_Component("StockBump",                  15*ratio,  	10,   	nil,    eff_7,  nil)
    TE_Component("MoW_Sto_PRS3",               15*ratio,  	10,   	nil,    eff_2,  para_2)
    TE_Component("MoW_Sto_SG550_1",            15*ratio,  	10,   	nil,    eff_2,  para_2)
    TE_Component("MoW_Sto_M110",               15*ratio,  	10,   	nil,    eff_2,  para_2)
    TE_Component("MoW_Sto_A3G",                15*ratio,  	10,   	nil,    eff_2,  para_2)
    TE_Component("MoW_Sto_G28",                15*ratio,  	10,   	nil,    eff_2,  para_2)
    TE_Component("MoW_Sto_M16A2",              15*ratio,  	10,   	nil,    eff_2,  para_2)
    TE_Component("MoW_Sto_CAR15",              15*ratio,  	10,   	nil,    eff_3,  para_3)
    TE_Component("MoW_Sto_Minimal",            15*ratio,  	10,   	nil,    eff_3,  para_3)
    TE_Component("MoW_StoC_HB",                15*ratio,  	10,   	nil,    eff_3,  para_3)
    TE_Component("MoW_StoC_MP7",               15*ratio,  	10,   	nil,    eff_3,  para_3)
    TE_Component("MoW_StoC_Bizon",             15*ratio,  	10,   	nil,    eff_3,  para_3)
    TE_Component("MoW_StoC_Vector",            15*ratio,  	10,   	nil,    eff_3,  para_3)
    TE_Component("MoW_StoC_HK416C",            15*ratio,  	10,   	nil,    eff_3,  para_3)
    TE_Component("MoW_StoC_M45",               15*ratio,  	10,   	nil,    eff_3,  para_3)
    TE_Component("MoW_StoC_UMP",               15*ratio,  	10,   	nil,    eff_3,  para_3)
    TE_Component("MoW_StoC_APC9k",             15*ratio,  	10,   	nil,    eff_3,  para_3)
    TE_Component("MoW_StoC_MP9",               15*ratio,  	10,   	nil,    eff_3,  para_3)
    TE_Component("MoW_StoC_vz26",              15*ratio,  	10,   	nil,    eff_3,  para_3)
    TE_Component("MoW_Sto_AK102",              15*ratio,  	10,   	nil,    eff_3,  para_3)
    TE_Component("MoW_Sto_G3A4",               15*ratio,  	10,   	nil,    eff_3,  para_3)
    TE_Component("MoW_StoC_G3A4",              15*ratio,  	10,   	nil,    eff_3,  para_3)
    TE_Component("MoW_Sto_AMD65",              15*ratio,  	10,   	nil,    eff_3,  para_3)
    TE_Component("MoW_Sto_AKS74",              15*ratio,  	10,   	nil,    eff_3,  para_3)
    TE_Component("MoW_Sto_MP153p",             15*ratio,  	10,   	nil,    eff_3,  para_3)
    TE_Component("MoW_StoC_MP153p",            15*ratio,  	10,   	nil,    eff_3,  para_3)
	--
	g_PresetParamCache[WeaponComponents.StockNo]["ShootAPDecrease"] 					= 2
	g_PresetParamCache[WeaponComponents.StockNo]["accuracy_penalty"] 					= -75
	g_PresetParamCache[WeaponComponents.StockFolded]["ShootAPDecrease"] 				= 2
	g_PresetParamCache[WeaponComponents.StockFolded]["accuracy_penalty"] 				= -75
	g_PresetParamCache[WeaponComponents.StockHeavy]["ShootAPIncrease"] 					= 1
	g_PresetParamCache[WeaponComponents.StockLight]["ShootAPDecrease"] 					= 1
	g_PresetParamCache[WeaponComponents.StockLight]["accuracy_penalty"] 				= -50
	g_PresetParamCache[WeaponComponents.StockHeavy_AR_BurstOnly]["ShootAPIncrease"] 	= 1
	g_PresetParamCache[WeaponComponents.StockLight_AR_BurstOnly]["ShootAPDecrease"] 	= 1
	g_PresetParamCache[WeaponComponents.StockLight_AR_BurstOnly]["accuracy_penalty"] 	= -50
	g_PresetParamCache[WeaponComponents.MoW_Sto_PRS3]["ShootAPIncrease"] 				= 1
	g_PresetParamCache[WeaponComponents.MoW_Sto_SG550_1]["ShootAPIncrease"] 			= 1
	g_PresetParamCache[WeaponComponents.MoW_Sto_M110]["ShootAPIncrease"] 			    = 1
	g_PresetParamCache[WeaponComponents.MoW_Sto_A3G]["ShootAPIncrease"] 			    = 1
	g_PresetParamCache[WeaponComponents.MoW_Sto_G28]["ShootAPIncrease"] 			    = 1
	g_PresetParamCache[WeaponComponents.MoW_Sto_M16A2]["ShootAPIncrease"] 			    = 1
	g_PresetParamCache[WeaponComponents.MoW_Sto_CAR15]["ShootAPDecrease"] 				= 1
	g_PresetParamCache[WeaponComponents.MoW_Sto_CAR15]["accuracy_penalty"] 				= -50
	g_PresetParamCache[WeaponComponents.MoW_Sto_Minimal]["ShootAPDecrease"] 			= 1
	g_PresetParamCache[WeaponComponents.MoW_Sto_Minimal]["accuracy_penalty"] 			= -50
	g_PresetParamCache[WeaponComponents.MoW_StoC_HB]["ShootAPDecrease"] 				= 1
	g_PresetParamCache[WeaponComponents.MoW_StoC_HB]["accuracy_penalty"] 				= -50
	g_PresetParamCache[WeaponComponents.MoW_StoC_MP7]["ShootAPDecrease"] 				= 1
	g_PresetParamCache[WeaponComponents.MoW_StoC_MP7]["accuracy_penalty"] 				= -50
	g_PresetParamCache[WeaponComponents.MoW_StoC_Bizon]["ShootAPDecrease"] 				= 1
	g_PresetParamCache[WeaponComponents.MoW_StoC_Bizon]["accuracy_penalty"] 			= -50
	g_PresetParamCache[WeaponComponents.MoW_StoC_Vector]["ShootAPDecrease"] 			= 1
	g_PresetParamCache[WeaponComponents.MoW_StoC_Vector]["accuracy_penalty"] 			= -50
	g_PresetParamCache[WeaponComponents.MoW_StoC_HK416C]["ShootAPDecrease"] 			= 1
	g_PresetParamCache[WeaponComponents.MoW_StoC_HK416C]["accuracy_penalty"] 			= -50
	g_PresetParamCache[WeaponComponents.MoW_StoC_M45]["ShootAPDecrease"] 			    = 1
	g_PresetParamCache[WeaponComponents.MoW_StoC_M45]["accuracy_penalty"] 			    = -50
	g_PresetParamCache[WeaponComponents.MoW_StoC_UMP]["ShootAPDecrease"] 			    = 1
	g_PresetParamCache[WeaponComponents.MoW_StoC_UMP]["accuracy_penalty"] 			    = -50
	g_PresetParamCache[WeaponComponents.MoW_StoC_APC9k]["ShootAPDecrease"] 			    = 1
	g_PresetParamCache[WeaponComponents.MoW_StoC_APC9k]["accuracy_penalty"] 			= -50
	g_PresetParamCache[WeaponComponents.MoW_StoC_MP9]["ShootAPDecrease"] 			    = 1
	g_PresetParamCache[WeaponComponents.MoW_StoC_MP9]["accuracy_penalty"] 			    = -50
	g_PresetParamCache[WeaponComponents.MoW_StoC_vz26]["ShootAPDecrease"] 			    = 1
	g_PresetParamCache[WeaponComponents.MoW_StoC_vz26]["accuracy_penalty"] 			    = -50
	g_PresetParamCache[WeaponComponents.MoW_Sto_AK102]["ShootAPDecrease"] 			    = 1
	g_PresetParamCache[WeaponComponents.MoW_Sto_AK102]["accuracy_penalty"] 			    = -50
	g_PresetParamCache[WeaponComponents.MoW_Sto_G3A4]["ShootAPDecrease"] 			    = 1
	g_PresetParamCache[WeaponComponents.MoW_Sto_G3A4]["accuracy_penalty"] 			    = -50
	g_PresetParamCache[WeaponComponents.MoW_StoC_G3A4]["ShootAPDecrease"] 			    = 1
	g_PresetParamCache[WeaponComponents.MoW_StoC_G3A4]["accuracy_penalty"] 			    = -50
	g_PresetParamCache[WeaponComponents.MoW_Sto_AMD65]["ShootAPDecrease"] 			    = 1
	g_PresetParamCache[WeaponComponents.MoW_Sto_AMD65]["accuracy_penalty"] 			    = -50
	g_PresetParamCache[WeaponComponents.MoW_Sto_AKS74]["ShootAPDecrease"] 			    = 1
	g_PresetParamCache[WeaponComponents.MoW_Sto_AKS74]["accuracy_penalty"] 			    = -50
	g_PresetParamCache[WeaponComponents.MoW_Sto_MP153p]["ShootAPDecrease"] 			    = 1
	g_PresetParamCache[WeaponComponents.MoW_Sto_MP153p]["accuracy_penalty"] 			= -50
	g_PresetParamCache[WeaponComponents.MoW_StoC_MP153p]["ShootAPDecrease"] 			= 1
	g_PresetParamCache[WeaponComponents.MoW_StoC_MP153p]["accuracy_penalty"] 			= -50
end

local function TE_Scope_MoW(ratio)
    local eff_1 = {
        "MinorAccuracyBonus",
	}

    local eff_2 = {
		"AccuracyBonusWhenAimed",
		"BonusAccuracyWhenFullyAimed",
	}

    local eff_3 = {
		"AccuracyBonusWhenAimed",
		"MinAim",
	}

    local eff_4 = {
		"FirstShotIncreasedAim",
		"IncreaseMaxAimActions",
		"CombatMod_IncreaseAutoPenalty",
		"CombatMod_IncreaseShootAP",
	}
    local para_4 = {
		PlaceObj('PresetParamNumber', {
			'Name', "MaxAimActionsIncrease",
			'Value', 1,
			'Tag', "<MaxAimActionsIncrease>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "ShootAPIncrease",
			'Value', 1,
			'Tag', "<ShootAPIncrease>",
		}),
	}

    local eff_5 = {
		"FirstShotIncreasedAim",
		"IncreaseMaxAimActions",
        "IgnoreCoverCtHWhenFullyAimed",
		"IgnoreLightOfSightWhenFullyAimed",
		"CombatMod_IncreaseAutoPenalty",
		"CombatMod_IncreaseShootAP",
	}
    local eff_10 = {
		"FirstShotIncreasedAim",
		"BonusAccuracyWhenFullyAimed",
		"IncreaseMaxAimActions",
        "IgnoreCoverCtHWhenFullyAimed",
		"IgnoreLightOfSightWhenFullyAimed",
		"CombatMod_IncreaseAutoPenalty",
		"CombatMod_IncreaseShootAP",
	}
    local para_5 = {
		PlaceObj('PresetParamNumber', {
			'Name', "MaxAimActionsIncrease",
			'Value', 2,
			'Tag', "<MaxAimActionsIncrease>",
		}),
		PlaceObj('PresetParamNumber', {
			'Name', "ShootAPIncrease",
			'Value', 2,
			'Tag', "<ShootAPIncrease>",
		}),
	}

    local eff_6 = {
		"IgnoreCoverCtHWhenFullyAimed",
		"IgnoreGrazingHitsWhenFullyAimed",
		"IgnoreInTheDarkWhenFullyAimed",
		"IgnoreLightOfSightWhenFullyAimed",
		"CombatMod_NoExtraAimCost",
		"CombatMod_AimAccuracyLimit",
	}

    local eff_7 = {
		"OpportunityAttackBonusCth",
		"IncreaseOverwatchAngle",
		"MinorAccuracyBonus",
	}
    local eff_9 = {
		"OpportunityAttackBonusCth",
		"IncreaseOverwatchAngle",
		"ExtraOverwatchShots",
		"MinAim",
	}
    local para_7 = {
		PlaceObj('PresetParamNumber', {
			'Name', "OverwatchAngleIncrease",
			'Value', 150,
			'Tag', "<OverwatchAngleIncrease>",
		}),
	}

    local eff_8 = {
		"OpportunityAttackBonusCth",
		"ExtraOverwatchShots",
		"MinAim",
	}

	--
    TE_Component("BaseIronsight_Anaconda",     0,  		    -25, 	nil,    nil,    nil)
    TE_Component("GewehrDefaultSight",         0,  		    -25, 	nil,    nil,    nil)
    TE_Component("DefaultIronsight_AR15",      0,  		    -25, 	nil,    nil,    nil)
    TE_Component("DefaultIronsight_M82",       0,  		    -25, 	nil,    nil,    nil)
    TE_Component("ImprovedIronsight",          5*ratio, 	-10, 	nil,    eff_1,  nil)
    TE_Component("ImprovedIronsight_AR15",     5*ratio, 	-10, 	nil,    eff_1,  nil)
    TE_Component("ScopeCOG",                   10*ratio, 	0,   	lens,   eff_2,  nil)
    TE_Component("AUGScope_Default",           10*ratio, 	0,   	lens,   eff_2,  nil)
    TE_Component("ScopeCOGQuick",              10*ratio, 	0,   	lens,   eff_3,  nil)
    TE_Component("LROptics",                   15*ratio, 	10,  	lens,   eff_4,  para_4)
    TE_Component("LROptics_DragunovDefault",   15*ratio, 	10,  	lens,   eff_4,  para_4)
    TE_Component("PSG_DefaultScope",           15*ratio, 	10,  	lens,   eff_4,  para_4)
    TE_Component("LROpticsAdvanced",           15*ratio, 	10,  	lens,   eff_5,  para_5)
    TE_Component("ThermalScope",               25*ratio, 	20,  	chip,   eff_6,  nil)
    TE_Component("ReflexSight",                10*ratio, 	0,   	chip,   eff_7,  para_7)
    TE_Component("ReflexSightAdvanced",        10*ratio, 	0,   	chip,   eff_8,  nil)
    TE_Component("ReflexSightAdvanced_Glock",  10*ratio, 	0,   	chip,   eff_8,  nil)
    TE_Component("MoW_ScoR_MPHoney",           5*ratio, 	-10, 	nil,    eff_1,  nil)
    TE_Component("MoW_Sco_MP7",                5*ratio, 	-10, 	nil,    eff_1,  nil)
    TE_Component("MoW_ScoR_ACR",               5*ratio, 	-10, 	nil,    eff_1,  nil)
    TE_Component("MoW_ScoR_KACBUIS",           5*ratio, 	-10, 	nil,    eff_1,  nil)
    TE_Component("MoW_ScoR_HK416C",            5*ratio, 	-10, 	nil,    eff_1,  nil)
    TE_Component("MoW_ScoR_HK416",             5*ratio, 	-10, 	nil,    eff_1,  nil)
    TE_Component("MoW_ScoR_HK417",             5*ratio, 	-10, 	nil,    eff_1,  nil)
    TE_Component("MoW_Sco_M16",                5*ratio, 	-10, 	nil,    eff_1,  nil)
    TE_Component("MoW_Sco_vz54",               10*ratio, 	0,   	lens,   eff_2,  nil)
    TE_Component("MoW_Mou_APProCarry",         10*ratio, 	0,   	lens,   eff_2,  nil)
    TE_Component("MoW_Sco_Spectre",            10*ratio, 	0,   	lens,   eff_2,  nil)
    TE_Component("MoW_Sco_PKAS",               10*ratio, 	0,   	lens,   eff_2,  nil)
    TE_Component("MoW_Sco_M68",                10*ratio, 	0,   	lens,   eff_2,  nil)
    TE_Component("MoW_Sco_ACOGM16",            10*ratio, 	0,   	lens,   eff_3,  nil)
    TE_Component("MoW_Sco_TA31",               10*ratio, 	0,   	lens,   eff_3,  nil)
    TE_Component("MoW_Sco_TA01",               10*ratio, 	0,   	lens,   eff_3,  nil)
    TE_Component("MoW_Sco_1P29",               10*ratio, 	0,   	lens,   eff_3,  nil)
    TE_Component("MoW_Sco_Vudu",               15*ratio, 	10,  	lens,   eff_4,  para_4)
    TE_Component("MoW_Mou_Fero",               15*ratio, 	10,  	lens,   eff_4,  para_4)
    TE_Component("MoW_Sco_PSO1",               15*ratio, 	10,  	lens,   eff_4,  para_4)
    TE_Component("MoW_Sco_RazorHDII",          15*ratio, 	10,  	lens,   eff_4,  para_4)
    TE_Component("MoW_Sco_ShortDot_14",        15*ratio, 	10,  	lens,   eff_4,  para_4)
    TE_Component("MoW_Sco_AP5000",             15*ratio, 	10,  	lens,   eff_4,  para_4)
    TE_Component("MoW_Sco_NF420",              15*ratio, 	10,  	lens,   eff_5,  para_5)
    TE_Component("MoW_Sco_NF420RAPTAR",        15*ratio, 	10,  	lens,   eff_10, para_5)
    TE_Component("MoW_Sco_NF416",              15*ratio, 	10,  	lens,   eff_5,  para_5)
    TE_Component("MoW_Sco_NXS2510",            15*ratio, 	10,  	lens,   eff_5,  para_5)
    TE_Component("MoW_Sco_Mk4_310",            15*ratio, 	10,  	lens,   eff_5,  para_5)
    TE_Component("MoW_Sco_Mk3_39",             15*ratio, 	10,  	lens,   eff_5,  para_5)
    TE_Component("MoW_Sco_HD_525",             15*ratio, 	10,  	lens,   eff_5,  para_5)
    TE_Component("MoW_Sco_HD_525_RAPTAR",      15*ratio, 	10,  	lens,   eff_10, para_5)
    TE_Component("MoW_Sco_M3_824",             15*ratio, 	10,  	lens,   eff_5,  para_5)
    TE_Component("MoW_Sco_DummyIR",            25*ratio, 	20,  	chip,   eff_6,  nil)
    TE_Component("MoW_Sco_ReapIR",             25*ratio, 	20,  	chip,   eff_6,  nil)
    TE_Component("MoW_Sco_Kobra",              10*ratio, 	0,   	chip,   eff_7,  para_7)
    TE_Component("MoW_Sco_R8",                 10*ratio, 	0,   	chip,   eff_7,  para_7)
    TE_Component("MoW_Sco_P1",                 10*ratio, 	0,   	chip,   eff_8,  nil)
    TE_Component("MoW_Sco_T2low",              10*ratio, 	0,   	chip,   eff_8,  nil)
    TE_Component("MoW_Sco_1P87",               10*ratio, 	10,   	chip,   eff_9,  para_7)
    TE_Component("MoW_Sco_EXPS",               10*ratio, 	10,   	chip,   eff_9,  para_7)
    TE_Component("MoW_Sco_552",                10*ratio, 	10,   	chip,   eff_9,  para_7)
    TE_Component("MoW_Sco_T2High",             10*ratio, 	10,   	chip,   eff_9,  para_7)
    TE_Component("MoW_Sco_MRO",                10*ratio, 	10,   	chip,   eff_9,  para_7)
    TE_Component("MoW_Sco_RMR",                20*ratio, 	10,   	chip,   eff_9,  para_7)
    TE_Component("MoW_Sco_DPP",                20*ratio, 	10,   	chip,   eff_9,  para_7)
    TE_Component("MoW_Sco_EXPSg33",            20*ratio, 	10,   	chip,   eff_9,  para_7)
    TE_Component("MoW_Sco_T2x3",               20*ratio, 	10,   	chip,   eff_9,  para_7)
	--
	g_PresetParamCache[WeaponComponents.LROptics]["MaxAimActionsIncrease"] 					= 1
	g_PresetParamCache[WeaponComponents.LROptics]["ShootAPIncrease"] 					    = 1
	g_PresetParamCache[WeaponComponents.LROptics_DragunovDefault]["MaxAimActionsIncrease"]	= 1
	g_PresetParamCache[WeaponComponents.LROptics_DragunovDefault]["ShootAPIncrease"]	    = 1
	g_PresetParamCache[WeaponComponents.PSG_DefaultScope]["MaxAimActionsIncrease"] 			= 1
	g_PresetParamCache[WeaponComponents.PSG_DefaultScope]["ShootAPIncrease"] 			    = 1
	g_PresetParamCache[WeaponComponents.LROpticsAdvanced]["MaxAimActionsIncrease"] 			= 2
	g_PresetParamCache[WeaponComponents.LROpticsAdvanced]["ShootAPIncrease"] 				= 2
	g_PresetParamCache[WeaponComponents.ReflexSight]["OverwatchAngleIncrease"] 				= 150
	g_PresetParamCache[WeaponComponents.MoW_Sco_Vudu]["MaxAimActionsIncrease"] 				= 1
	g_PresetParamCache[WeaponComponents.MoW_Sco_Vudu]["ShootAPIncrease"] 					= 1
	g_PresetParamCache[WeaponComponents.MoW_Mou_Fero]["MaxAimActionsIncrease"] 				= 1
	g_PresetParamCache[WeaponComponents.MoW_Mou_Fero]["ShootAPIncrease"] 					= 1
	g_PresetParamCache[WeaponComponents.MoW_Sco_PSO1]["MaxAimActionsIncrease"] 				= 1
	g_PresetParamCache[WeaponComponents.MoW_Sco_PSO1]["ShootAPIncrease"] 					= 1
	g_PresetParamCache[WeaponComponents.MoW_Sco_RazorHDII]["MaxAimActionsIncrease"] 		= 1
	g_PresetParamCache[WeaponComponents.MoW_Sco_RazorHDII]["ShootAPIncrease"] 				= 1
	g_PresetParamCache[WeaponComponents.MoW_Sco_ShortDot_14]["MaxAimActionsIncrease"] 		= 1
	g_PresetParamCache[WeaponComponents.MoW_Sco_ShortDot_14]["ShootAPIncrease"] 			= 1
	g_PresetParamCache[WeaponComponents.MoW_Sco_AP5000]["MaxAimActionsIncrease"] 			= 1
	g_PresetParamCache[WeaponComponents.MoW_Sco_AP5000]["ShootAPIncrease"] 					= 1
	g_PresetParamCache[WeaponComponents.MoW_Sco_NF420]["MaxAimActionsIncrease"] 			= 2
	g_PresetParamCache[WeaponComponents.MoW_Sco_NF420]["ShootAPIncrease"] 				    = 2
	g_PresetParamCache[WeaponComponents.MoW_Sco_NF420RAPTAR]["MaxAimActionsIncrease"] 		= 2
	g_PresetParamCache[WeaponComponents.MoW_Sco_NF420RAPTAR]["ShootAPIncrease"] 			= 2
	g_PresetParamCache[WeaponComponents.MoW_Sco_NF416]["MaxAimActionsIncrease"] 			= 2
	g_PresetParamCache[WeaponComponents.MoW_Sco_NF416]["ShootAPIncrease"] 				    = 2
	g_PresetParamCache[WeaponComponents.MoW_Sco_NXS2510]["MaxAimActionsIncrease"] 			= 2
	g_PresetParamCache[WeaponComponents.MoW_Sco_NXS2510]["ShootAPIncrease"] 				= 2
	g_PresetParamCache[WeaponComponents.MoW_Sco_Mk4_310]["MaxAimActionsIncrease"] 			= 2
	g_PresetParamCache[WeaponComponents.MoW_Sco_Mk4_310]["ShootAPIncrease"] 				= 2
	g_PresetParamCache[WeaponComponents.MoW_Sco_Mk3_39]["MaxAimActionsIncrease"] 			= 2
	g_PresetParamCache[WeaponComponents.MoW_Sco_Mk3_39]["ShootAPIncrease"] 				    = 2
	g_PresetParamCache[WeaponComponents.MoW_Sco_HD_525]["MaxAimActionsIncrease"] 			= 2
	g_PresetParamCache[WeaponComponents.MoW_Sco_HD_525]["ShootAPIncrease"] 				    = 2
	g_PresetParamCache[WeaponComponents.MoW_Sco_HD_525_RAPTAR]["MaxAimActionsIncrease"] 	= 2
	g_PresetParamCache[WeaponComponents.MoW_Sco_HD_525_RAPTAR]["ShootAPIncrease"] 			= 2
	g_PresetParamCache[WeaponComponents.MoW_Sco_M3_824]["MaxAimActionsIncrease"] 			= 2
	g_PresetParamCache[WeaponComponents.MoW_Sco_M3_824]["ShootAPIncrease"] 				    = 2
	g_PresetParamCache[WeaponComponents.MoW_Sco_Kobra]["OverwatchAngleIncrease"] 			= 150
	g_PresetParamCache[WeaponComponents.MoW_Sco_R8]["OverwatchAngleIncrease"] 				= 150
	g_PresetParamCache[WeaponComponents.MoW_Sco_1P87]["OverwatchAngleIncrease"] 			= 150
	g_PresetParamCache[WeaponComponents.MoW_Sco_EXPS]["OverwatchAngleIncrease"] 			= 150
	g_PresetParamCache[WeaponComponents.MoW_Sco_552]["OverwatchAngleIncrease"] 				= 150
	g_PresetParamCache[WeaponComponents.MoW_Sco_T2High]["OverwatchAngleIncrease"] 			= 150
	g_PresetParamCache[WeaponComponents.MoW_Sco_MRO]["OverwatchAngleIncrease"] 				= 150
	g_PresetParamCache[WeaponComponents.MoW_Sco_RMR]["OverwatchAngleIncrease"] 				= 150
	g_PresetParamCache[WeaponComponents.MoW_Sco_DPP]["OverwatchAngleIncrease"] 				= 150
end

local function TE_Side_MoW(ratio)
    local eff_1 = {
        "IgnoreInTheDark",
        "CombatMod_Illumination",
	}

    local eff_2 = {
		"IgnoreInTheDarkWhenFullyAimed",
		"StealthKillBonusPerAim",
	}
    local para_2 = {
		PlaceObj('PresetParamPercent', {
			'Name', "stealth_kill_bonus",
			'Value', stealth_kill,
			'Tag', "<stealth_kill_bonus>%",
		}),
	}

    local eff_3 = {
		"CritBonusSameTarget",
		"CritBonusWhenFullyAimed",
	}

    local eff_4 = {
		"IgnoreGrazingHitsWhenFullyAimed",
		"MarkWhenFullyAimed",
	}

	--
    TE_Component("Flashlight",             5*ratio,  	-10, 	nil,	eff_1,  nil)
    TE_Component("FlashlightDot",          10*ratio,  	10, 	chip, 	eff_2,  para_2)
    TE_Component("LaserDot",               10*ratio,  	10, 	chip, 	eff_3,  nil)
    TE_Component("UVDot",                  10*ratio,  	10, 	chip, 	eff_4,  nil)
    TE_Component("Flashlight_aa12",        5*ratio,  	-10, 	nil,	eff_1,  nil)
    TE_Component("FlashlightDot_aa12",     10*ratio,  	10, 	chip, 	eff_2,  para_2)
    TE_Component("LaserDot_aa12",          10*ratio,  	10, 	chip, 	eff_3,  nil)
    TE_Component("UVDot_aa12",             10*ratio,  	10, 	chip, 	eff_4,  nil)
    TE_Component("Flashlight_PSG_M1",      5*ratio,  	-10, 	nil,	eff_1,  nil)
    TE_Component("FlashlightDot_PSG_M1",   10*ratio,  	10, 	chip, 	eff_2,  para_2)
    TE_Component("LaserDot_PSG_M1",        10*ratio,  	10, 	chip, 	eff_3,  nil)
    TE_Component("UVDot_PSG_M1",           10*ratio,  	10, 	chip, 	eff_4,  nil)
    TE_Component("Flashlight_Anaconda",    5*ratio,  	-10, 	nil,	eff_1,  nil)
    TE_Component("FlashlightDot_Anaconda", 10*ratio,  	10, 	chip, 	eff_2,  para_2)
    TE_Component("LaserDot_Anaconda",      10*ratio,  	10, 	chip, 	eff_3,  nil)
    TE_Component("UVDot_Anaconda",         10*ratio,  	10, 	chip, 	eff_4,  nil)
    TE_Component("MoW_Sid_CQBL1",          10*ratio,  	10, 	chip, 	eff_3,  nil)
    TE_Component("Mow_Sid_WML",            5*ratio,  	-10, 	nil,	eff_1,  nil)
    TE_Component("MoW_Sid_PEQ15",          10*ratio,  	10, 	chip, 	eff_4,  nil)
    TE_Component("MoW_Sid_PEQ15_Side3",    10*ratio,  	10, 	chip, 	eff_4,  nil)
    TE_Component("MoW_MoFro_SF600l",       5*ratio,  	-10, 	nil,	eff_1,  nil)
    TE_Component("MoW_Sid_PEQ2",           10*ratio,  	10, 	chip, 	eff_2,  para_2)
    TE_Component("MoW_Sid_PEQ2_Side3",     10*ratio,  	10, 	chip, 	eff_2,  para_2)
    TE_Component("MoW_Sid_SF600U",         5*ratio,  	-10, 	nil,	eff_1,  nil)
    TE_Component("MoW_Sid_DBAL",           10*ratio,  	10, 	chip, 	eff_3,  nil)
    TE_Component("MoW_Sid_DBAL_Side3",     10*ratio,  	10, 	chip, 	eff_3,  nil)
    TE_Component("MoW_Sid_M952",           5*ratio,  	-10, 	nil,	eff_1,  nil)
    TE_Component("MoW_Sid_Perst4",         10*ratio,  	10, 	chip, 	eff_2,  para_2)
    TE_Component("MoW_Sid_Perst4_Side3",   10*ratio,  	10, 	chip, 	eff_2,  para_2)
    TE_Component("MoW_Sid_TLR2",           5*ratio,  	-10, 	nil,	eff_1,  nil)
    TE_Component("MoW_Sid_X300",           5*ratio,  	-10, 	nil,	eff_1,  nil)
    TE_Component("MoW_Sid_X400",           10*ratio,  	10, 	chip, 	eff_2,  para_2)
	--
	g_PresetParamCache[WeaponComponents.FlashlightDot]["stealth_kill_bonus"] 			= stealth_kill
	g_PresetParamCache[WeaponComponents.FlashlightDot_aa12]["stealth_kill_bonus"] 		= stealth_kill
	g_PresetParamCache[WeaponComponents.FlashlightDot_PSG_M1]["stealth_kill_bonus"] 	= stealth_kill
	g_PresetParamCache[WeaponComponents.FlashlightDot_Anaconda]["stealth_kill_bonus"] 	= stealth_kill
	g_PresetParamCache[WeaponComponents.MoW_Sid_PEQ2]["stealth_kill_bonus"] 	        = stealth_kill
	g_PresetParamCache[WeaponComponents.MoW_Sid_PEQ2_Side3]["stealth_kill_bonus"] 	    = stealth_kill
	g_PresetParamCache[WeaponComponents.MoW_Sid_Perst4]["stealth_kill_bonus"] 	        = stealth_kill
	g_PresetParamCache[WeaponComponents.MoW_Sid_Perst4_Side3]["stealth_kill_bonus"] 	= stealth_kill
	g_PresetParamCache[WeaponComponents.MoW_Sid_X400]["stealth_kill_bonus"] 	        = stealth_kill
end

local function Cost_Apply()
	return 2
end

-- Load Changes
function OnMsg.ModsReloaded()
	if CurrentModOptions["Gunfight_Rework"] then
		local ratio = Cost_Apply()
		if table.find(ModsLoaded, "id", "XQNrmnC") then
			TE_Bipod_MoW(ratio)
			TE_Grip_MoW(ratio)
			TE_GL_MoW(ratio)
			TE_Muzzle_MoW(ratio)
			TE_Suppressor_MoW(ratio)
			TE_Barrel_MoW(ratio)
			TE_Barrel_Shotgun_MoW(ratio)
			TE_Stock_MoW(ratio)
			TE_Scope_MoW(ratio)
			TE_Side_MoW(ratio)
		else
			TE_Bipod(ratio)
			TE_Grip(ratio)
			TE_GL(ratio)
			TE_Muzzle(ratio)
			TE_Suppressor(ratio)
			TE_Barrel(ratio)
			TE_Barrel_Shotgun(ratio)
			TE_Stock(ratio)
			TE_Scope(ratio)
			TE_Side(ratio)
		end
	end
end
function OnMsg.DataLoaded()
	if CurrentModOptions["Gunfight_Rework"] then
		local ratio = Cost_Apply()
		if table.find(ModsLoaded, "id", "XQNrmnC") then
			TE_Bipod_MoW(ratio)
			TE_Grip_MoW(ratio)
			TE_GL_MoW(ratio)
			TE_Muzzle_MoW(ratio)
			TE_Suppressor_MoW(ratio)
			TE_Barrel_MoW(ratio)
			TE_Barrel_Shotgun_MoW(ratio)
			TE_Stock_MoW(ratio)
			TE_Scope_MoW(ratio)
			TE_Side_MoW(ratio)
		else
			TE_Bipod(ratio)
			TE_Grip(ratio)
			TE_GL(ratio)
			TE_Muzzle(ratio)
			TE_Suppressor(ratio)
			TE_Barrel(ratio)
			TE_Barrel_Shotgun(ratio)
			TE_Stock(ratio)
			TE_Scope(ratio)
			TE_Side(ratio)
		end
	end
end
function OnMsg.OptionsApply()
	if CurrentModOptions["Gunfight_Rework"] then
		local ratio = Cost_Apply()
		if table.find(ModsLoaded, "id", "XQNrmnC") then
			TE_Bipod_MoW(ratio)
			TE_Grip_MoW(ratio)
			TE_GL_MoW(ratio)
			TE_Muzzle_MoW(ratio)
			TE_Suppressor_MoW(ratio)
			TE_Barrel_MoW(ratio)
			TE_Barrel_Shotgun_MoW(ratio)
			TE_Stock_MoW(ratio)
			TE_Scope_MoW(ratio)
			TE_Side_MoW(ratio)
		else
			TE_Bipod(ratio)
			TE_Grip(ratio)
			TE_GL(ratio)
			TE_Muzzle(ratio)
			TE_Suppressor(ratio)
			TE_Barrel(ratio)
			TE_Barrel_Shotgun(ratio)
			TE_Stock(ratio)
			TE_Scope(ratio)
			TE_Side(ratio)
		end
	end
end