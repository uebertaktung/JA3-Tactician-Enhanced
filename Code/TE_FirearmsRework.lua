--Defs_Firearm
local function checkID(id)
    if not InventoryItemDefs[id] and not _G[id] then
        return false
    end
    return true
end

local function TE_Firearm(id, dura, repair, apS, apR, range, damage, armorP, crit, critLv, aim, owAngle, noise, pbRange, cumber, hint)
    if checkID(id) == false then
        return
    end

    local defs = InventoryItemDefs[id]
    local load = _G[id]

    defs.Reliability             = dura
    defs.RepairCost              = repair
    defs.ShootAP                 = apS * 1000
    defs.ReloadAP                = apR * 1000
    defs.WeaponRange             = range * 2
    defs.Damage                  = damage
    defs.PenetrationClass        = armorP
    defs.CritChance              = crit
    defs.CritChanceScaled        = critLv
    defs.AimAccuracy             = aim
    defs.OverwatchAngle          = owAngle * 60
    defs.Noise                   = noise
    defs.PointBlankBonus         = pbRange
    defs.Cumbersome              = cumber
    defs.AdditionalHint = hint

    load.Reliability             = dura
    load.base_Reliability        = dura
    load.RepairCost              = repair
    load.base_RepairCost         = repair
    load.ShootAP                 = apS * 1000
    load.base_ShootAP            = apS * 1000
    load.ReloadAP                = apR * 1000
    load.base_ReloadAP           = apR * 1000
    load.WeaponRange             = range * 2
    load.base_WeaponRange        = range * 2
    load.Damage                  = damage
    load.base_Damage             = damage
    load.PenetrationClass        = armorP
    load.base_PenetrationClass   = armorP
    load.CritChance              = crit
    load.base_CritChance         = crit
    load.CritChanceScaled        = critLv
    load.base_CritChanceScaled   = critLv
    load.AimAccuracy             = aim
    load.base_AimAccuracy        = aim
    load.OverwatchAngle          = owAngle * 60
    load.base_OverwatchAngle     = owAngle * 60
    load.Noise                   = noise
    load.base_Noise              = noise
    load.PointBlankBonus         = pbRange
    load.base_PointBlankBonus    = pbRange
    load.Cumbersome              = cumber
    load.base_Cumbersome         = cumber
    load.AdditionalHint = hint
end

local function TE_ExtraMode(id, fireMode)
    if checkID(id) == false then
        return
    end

    local defs = InventoryItemDefs[id]
    local load = _G[id]

    defs.AvailableAttacks  = fireMode
    load.AvailableAttacks  = fireMode
end

local function TE_ExtraSlots(id, slots)
    if checkID(id) == false then
        return
    end

    local defs = InventoryItemDefs[id]
    local load = _G[id]

    defs.ComponentSlots    = slots
    load.ComponentSlots    = slots
end

local Inc_Damage        = "<bullet_point> Increased Damage"
local Inc_Range         = "<bullet_point> Increased Range"
local Inc_Aim           = "<bullet_point> Increased Aiming Bonus"
local Inc_Crit          = "<bullet_point> Increased Crit Chance"
local Inc_Dura          = "<bullet_point> Increased Reliability"
local Inc_AP            = "<bullet_point> Increased Attack AP"

local Dec_Damage        = "<bullet_point> Decreased Damage"
local Dec_Range         = "<bullet_point> Decreased Range"
local Dec_Aim           = "<bullet_point> Decreased Aiming Bonus"
local Dec_Crit          = "<bullet_point> Decreased Crit Chance"
local Dec_Dura          = "<bullet_point> Decreased Reliability"
local Dec_AP            = "<bullet_point> Decreased Attack AP"

local Spec_Dura         = "<bullet_point> Greatest Reliability"
local Spec_Cumber       = "<bullet_point> Cumbersome (No Free Move)"
local Spec_NoAuto       = "<bullet_point> No Auto Firing Mode"
local Spec_FireMode     = "<bullet_point> Special Firing Mode"
local Spec_OW           = "<bullet_point> Good Overwatch Angle"
local Spec_Noise        = "<bullet_point> Very Noisy"
local Spec_Repair       = "<bullet_point> Easy to Repair"
local Spec_LeverAction  = "<bullet_point> Lever-Action (Low AP Cost, Low Range)"
local Spec_Worn         = "<bullet_point> Worn Rifling (Low Aiming Bonus, Low Range)"
local Spec_HMG          = "<bullet_point> Stationary"

local function TE_Handgun()
    local tab_1 = {Inc_Damage, "\n", Dec_Crit}
    local tab_2 = {Inc_Crit, "\n", Inc_Aim}
    local tab_3 = {Inc_Crit, "\n", Spec_FireMode}
    local tab_4 = {Spec_Dura}
    local tab_5 = {Inc_Range, "\n", Inc_Damage, "\n", Inc_Dura}
    local tab_6 = {Inc_Range, "\n", Inc_Damage, "\n", Spec_Noise}
    local tab_7 = {Inc_Crit, "\n", Spec_Dura}

    local hint_1 = T(30072476860101, table.concat(tab_1))
    local hint_2 = T(30072476860102, table.concat(tab_2))
    local hint_3 = T(30072476860103, table.concat(tab_3))
    local hint_4 = T(30072476860104, table.concat(tab_4))
    local hint_5 = T(30072476860105, table.concat(tab_5))
    local hint_6 = T(30072476860106, table.concat(tab_6))
    local hint_7 = T(30072476860107, table.concat(tab_7))

    --                                  dura, repair, apS, apR, range, damage, armorP, crit, critLv, aim, owAngle, noise, pbRange, cumber, hint
    TE_Firearm("HiPower",               50,   70,     4,   2,   7,     18,     1,      5,    15,     2,   40,      50,    1,       0,      hint_1)
    TE_Firearm("Bereta92",              75,   70,     4,   2,   6,     15,     1,      10,   20,     4,   40,      40,    1,       0,      hint_2)
    TE_Firearm("Glock18",               50,   70,     4,   2,   6,     15,     1,      10,   20,     2,   40,      40,    1,       0,      hint_3)
    TE_Firearm("ColtPeacemaker",        95,   30,     4,   2,   8,     18,     1,      5,    15,     2,   40,      60,    1,       0,      hint_4)
    TE_Firearm("ColtAnaconda",          75,   50,     4,   2,   9,     21,     1,      5,    15,     2,   40,      80,    1,       0,      hint_5)
    TE_Firearm("DesertEagle",           50,   70,     4,   2,   9,     21,     1,      5,    15,     2,   40,      80,    1,       0,      hint_6)
    TE_Firearm("TexRevolver",           95,   30,     4,   2,   8,     18,     1,      10,   20,     2,   40,      60,    1,       0,      hint_7)
    TE_Firearm("MoW_Pistol_PL14",       75,   70,     4,   2,   6,     15,     1,      10,   20,     4,   40,      50,    1,       0,      hint_2)
    TE_Firearm("MoW_Pistol_R8",         75,   50,     4,   2,   9,     21,     1,      5,    15,     2,   40,      80,    1,       0,      hint_5)
    TE_Firearm("MoW_Pistol_USPTac",     75,   70,     4,   2,   7,     18,     1,      10,   20,     4,   40,      50,    1,       0,      hint_2)
    TE_Firearm("MoW_Pistol_APS",        75,   70,     4,   2,   6,     15,     1,      10,   20,     2,   40,      40,    1,       0,      hint_3)
    TE_Firearm("MoW_Pistol_QSZ92",      90,   70,     4,   2,   6,     15,     1,      10,   20,     4,   40,      40,    1,       0,      hint_2)
    TE_Firearm("MoW_Pistol_PB",         75,   70,     4,   2,   6,     15,     1,      10,   20,     4,   40,      10,    1,       0,      hint_2)
    TE_Firearm("MoW_Pistol_P99",        75,   70,     4,   2,   6,     15,     1,      10,   20,     4,   40,      40,    1,       0,      hint_2)
    TE_Firearm("MoW_Pistol_Police",     75,   30,     4,   2,   8,     18,     1,      5,    15,     2,   40,      60,    1,       0,      hint_4)
    TE_Firearm("MoW_Pistol_PM",         95,   70,     4,   2,   6,     15,     1,      5,    15,     2,   40,      50,    1,       0,      hint_4)
    TE_Firearm("MoW_Pistol_WCVE",       75,   70,     4,   2,   7,     18,     1,      5,    15,     2,   40,      50,    1,       0,      hint_1)
    TE_Firearm("MoW_Pistol_P220",       75,   70,     4,   2,   7,     18,     1,      5,    15,     2,   40,      50,    1,       0,      hint_1)
    TE_Firearm("MoW_Pistol_TT33",       90,   70,     4,   2,   7,     18,     1,      5,    15,     2,   40,      50,    1,       0,      hint_1)
    TE_Firearm("MoW_Pistol_GSH18",      90,   70,     4,   2,   6,     15,     1,      10,   20,     4,   40,      40,    1,       0,      hint_2)
    TE_Firearm("MoW_Pistol_CZ75B",      90,   70,     4,   2,   6,     15,     1,      10,   20,     4,   40,      40,    1,       0,      hint_2)
    TE_Firearm("MoW_Pistol_G17",        50,   70,     4,   2,   6,     15,     1,      10,   20,     2,   40,      40,    1,       0,      hint_3)
    TE_Firearm("MoW_Pistol_G19x",       75,   70,     4,   2,   6,     15,     1,      10,   20,     4,   40,      40,    1,       0,      hint_2)
    TE_Firearm("MoW_Pistol_G19",        75,   70,     4,   2,   6,     15,     1,      10,   20,     4,   40,      40,    1,       0,      hint_2)
    TE_Firearm("MoW_Pistol_G45",        90,   70,     4,   2,   6,     15,     1,      10,   20,     4,   40,      40,    1,       0,      hint_2)
    TE_Firearm("MoW_Pistol_KDW",        75,   70,     4,   2,   7,     18,     1,      5,    15,     4,   40,      50,    1,       0,      hint_1)
    TE_Firearm("MoW_Pistol_M1911A1",    75,   70,     4,   2,   7,     18,     1,      5,    15,     2,   40,      50,    1,       0,      hint_1)
    TE_Firearm("MoW_Pistol_P226R",      75,   70,     4,   2,   6,     15,     1,      10,   20,     4,   40,      40,    1,       0,      hint_2)
    TE_Firearm("MoW_Pistol_P228",       75,   70,     4,   2,   6,     15,     1,      10,   20,     4,   40,      40,    1,       0,      hint_2)
    TE_Firearm("MoW_Pistol_P320",       90,   70,     4,   2,   6,     15,     1,      10,   20,     4,   40,      40,    1,       0,      hint_2)
    TE_Firearm("MoW_Pistol_P320F",      95,   70,     4,   2,   6,     15,     1,      10,   20,     6,   40,      40,    1,       0,      hint_2)
    TE_Firearm("MoW_Pistol_SP1",        50,   70,     4,   2,   6,     15,     1,      10,   20,     4,   40,      40,    1,       0,      hint_2)
end

local function TE_Shotgun()
    local tab_1 = {Inc_Crit, "\n", Spec_FireMode}
    local tab_2 = {Inc_Dura, "\n", Spec_Repair}
    local tab_3 = {Inc_Range, "\n", Inc_Aim, "\n", Spec_FireMode}
    local tab_4 = {Inc_Range, "\n", Inc_Damage, "\n", Spec_Cumber, "\n", Spec_FireMode}

    local hint_1 = T(30072476860601, table.concat(tab_1))
    local hint_2 = T(30072476860602, table.concat(tab_2))
    local hint_3 = T(30072476860603, table.concat(tab_3))
    local hint_4 = T(30072476860604, table.concat(tab_4))

    --                                  dura, repair, apS, apR, range, damage, armorP, crit, critLv, aim, owAngle, noise, pbRange, cumber, hint
    TE_Firearm("DoubleBarrelShotgun",   50,   70,     5,   2,   6,     25,     1,      5,    15,     2,   40,      80,    1,       0,      hint_1)
    TE_Firearm("Auto5",                 75,   10,     5,   2,   6,     25,     1,      0,    10,     2,   40,      80,    1,       0,      hint_2)
    TE_Firearm("Auto5_quest",           95,   10,     5,   2,   6,     25,     1,      0,    10,     2,   40,      80,    1,       0,      hint_2)
    TE_Firearm("M41Shotgun",            50,   70,     5,   2,   9,     25,     1,      0,    10,     4,   40,      80,    1,       0,      hint_3)
    TE_Firearm("AA12",                  50,   70,     5,   2,   8,     30,     1,      0,    10,     2,   40,      80,    1,       1,      hint_4)
    TE_Firearm("MoW_Shot_MP153",        75,   10,     5,   2,   6,     25,     1,      0,    10,     2,   40,      80,    1,       0,      hint_2)
end

local function TE_SMG()
    local tab_1 = {Dec_Range, "\n", Dec_AP}
    local tab_2 = {Inc_Dura, "\n", Spec_Repair}
    local tab_3 = {Inc_Crit}
    local tab_4 = {Inc_Range, "\n", Inc_Aim}
    local tab_5 = {Inc_Range, "\n", Inc_Damage, "\n", Inc_Dura}
    local tab_6 = {Inc_Range, "\n", Inc_Crit, "\n", Inc_Aim}

    local hint_1 = T(30072476860201, table.concat(tab_1))
    local hint_2 = T(30072476860202, table.concat(tab_2))
    local hint_3 = T(30072476860203, table.concat(tab_3))
    local hint_4 = T(30072476860204, table.concat(tab_4))
    local hint_5 = T(30072476860205, table.concat(tab_5))
    local hint_6 = T(30072476860206, table.concat(tab_6))

    --                                  dura, repair, apS, apR, range, damage, armorP, crit, critLv, aim, owAngle, noise, pbRange, cumber, hint
    TE_Firearm("UZI",                   50,   70,     4,   3,   6,     15,     1,      5,    15,     2,   40,      40,    1,       0,      hint_1)
    TE_Firearm("LionRoar",              75,   70,     4,   3,   6,     15,     1,      5,    15,     2,   40,      40,    1,       0,      hint_1)
    TE_Firearm("MP40",                  95,   10,     5,   3,   6,     15,     1,      5,    15,     2,   40,      40,    1,       0,      hint_2)
    TE_Firearm("MP5K",                  75,   70,     5,   3,   7,     16,     1,      10,   20,     2,   40,      40,    1,       0,      hint_3)
    TE_Firearm("MP5",                   75,   70,     5,   3,   7,     16,     1,      5,    15,     4,   40,      50,    1,       0,      hint_4)
    TE_Firearm("AKSU",                  90,   50,     5,   3,   9,     19,     2,      5,    15,     2,   40,      70,    1,       0,      hint_5)
    TE_Firearm("M4Commando",            75,   70,     5,   3,   9,     18,     2,      10,   20,     4,   40,      60,    1,       0,      hint_6)
    TE_Firearm("MoW_SMG_MC51",          75,   50,     5,   3,   10,    23,     3,      5,    15,     4,   40,      70,    1,       0,      hint_5)
    TE_Firearm("MoW_SMG_HB",            75,   70,     5,   3,   9,     21,     2,      10,   20,     4,   40,      60,    1,       0,      hint_6)
    TE_Firearm("MoW_SMG_MP7A1",         90,   70,     5,   3,   8,     18,     1,      10,   20,     4,   40,      50,    1,       0,      hint_6)
    TE_Firearm("MoW_SMG_Bizon",         75,   70,     4,   3,   6,     15,     1,      5,    15,     2,   40,      40,    1,       0,      hint_1)
    TE_Firearm("MoW_SMG_Vector45",      75,   70,     5,   3,   8,     18,     1,      10,   20,     4,   40,      50,    1,       0,      hint_6)
    TE_Firearm("MoW_SMG_HK416C",        75,   70,     5,   3,   9,     21,     2,      10,   20,     6,   40,      60,    1,       0,      hint_6)
    TE_Firearm("MoW_SMG_M45",           95,   10,     5,   3,   7,     16,     1,      5,    15,     2,   40,      40,    1,       0,      hint_2)
    TE_Firearm("MoW_SMG_UMP",           75,   70,     5,   3,   8,     18,     1,      10,   20,     4,   40,      50,    1,       0,      hint_6)
    TE_Firearm("MoW_SMG_APC9k",         75,   70,     5,   3,   7,     16,     1,      10,   20,     2,   40,      40,    1,       0,      hint_3)
    TE_Firearm("MoW_SMG_MP9",           75,   70,     5,   3,   7,     16,     1,      10,   20,     2,   40,      40,    1,       0,      hint_3)
    TE_Firearm("MoW_SMG_vz26",          95,   10,     5,   3,   6,     15,     1,      5,    15,     2,   40,      40,    1,       0,      hint_2)
end

local function TE_AssaultRifle()
    local tab_1 = {Spec_Dura}
    local tab_2 = {Inc_Dura, "\n", Inc_Damage, "\n", Inc_Crit}
    local tab_3 = {Dec_AP, "\n", Dec_Range}
    local tab_4 = {Inc_Range, "\n", Spec_NoAuto}
    local tab_5 = {Inc_Damage, "\n", Inc_Aim, "\n", Dec_Dura}
    local tab_6 = {Inc_Damage, "\n", Inc_Crit, "\n", Spec_NoAuto}
    local tab_7 = {Inc_Crit, "\n", Dec_AP}
    local tab_8 = {Inc_Crit}
    local tab_9 = {Inc_Range}
    local tab_A = {Inc_Dura}

    local hint_1 = T(30072476860301, table.concat(tab_1))
    local hint_2 = T(30072476860302, table.concat(tab_2))
    local hint_3 = T(30072476860303, table.concat(tab_3))
    local hint_4 = T(30072476860304, table.concat(tab_4))
    local hint_5 = T(30072476860305, table.concat(tab_5))
    local hint_6 = T(30072476860306, table.concat(tab_6))
    local hint_7 = T(30072476860307, table.concat(tab_7))
    local hint_8 = T(30072476860308, table.concat(tab_8))
    local hint_9 = T(30072476860309, table.concat(tab_9))
    local hint_A = T(30072476860310, table.concat(tab_A))

    --                                  dura, repair, apS, apR, range, damage, armorP, crit, critLv, aim, owAngle, noise, pbRange, cumber, hint
    TE_Firearm("AK47",                  95,   30,     6,   3,   19,    23,     2,      0,    10,     2,   30,      70,    1,       0,      hint_1)
    TE_Firearm("AK74",                  90,   50,     6,   3,   21,    25,     3,      5,    15,     4,   30,      70,    1,       0,      hint_2)
    TE_Firearm("FAMAS",                 75,   70,     5,   3,   17,    21,     2,      5,    15,     4,   30,      60,    1,       0,      hint_3)
    TE_Firearm("M16A2",                 75,   70,     6,   3,   21,    21,     2,      5,    15,     4,   30,      60,    1,       0,      hint_4)
    TE_Firearm("AUG",                   50,   90,     6,   3,   21,    21,     2,      5,    15,     6,   30,      60,    1,       0,      hint_5)
    TE_Firearm("AR15",                  75,   70,     6,   3,   19,    21,     2,      10,   20,     4,   30,      60,    1,       0,      hint_6)
    TE_Firearm("G36",                   75,   70,     5,   3,   19,    21,     2,      10,   20,     6,   30,      60,    1,       0,      hint_7)
    TE_Firearm("FNFAL",                 75,   70,     7,   3,   21,    27,     3,      5,    15,     2,   30,      70,    1,       0,      hint_8)
    TE_Firearm("M14SAW",                75,   70,     7,   3,   23,    27,     3,      0,    10,     4,   30,      70,    1,       0,      hint_9)
    TE_Firearm("Galil",                 90,   50,     7,   3,   21,    27,     3,      0,    10,     2,   30,      70,    1,       0,      hint_A)
    TE_Firearm("Galil_FlagHill",        90,   50,     7,   3,   21,    27,     3,      0,    10,     2,   30,      70,    1,       0,      hint_A)
    TE_Firearm("MoW_AR_AK12",           95,   70,     6,   3,   21,    25,     3,      5,    15,     6,   30,      70,    1,       0,      hint_2)
    TE_Firearm("MoW_AR_AK12K",          95,   70,     5,   3,   17,    21,     3,      5,    15,     6,   30,      70,    1,       0,      hint_7)
    TE_Firearm("MoW_AR_AK15",           90,   50,     6,   3,   23,    27,     3,      5,    15,     6,   30,      70,    1,       0,      hint_2)
    TE_Firearm("MoW_AR_AK15k",          95,   70,     5,   3,   19,    23,     3,      5,    15,     6,   30,      70,    1,       0,      hint_7)
    TE_Firearm("MoW_AR_AK74M",          90,   50,     6,   3,   21,    25,     3,      5,    15,     4,   30,      70,    1,       0,      hint_2)
    TE_Firearm("MoW_AR_AK101",          90,   50,     6,   3,   21,    21,     2,      5,    15,     4,   30,      70,    1,       0,      hint_2)
    TE_Firearm("MoW_AR_AK102",          90,   50,     6,   3,   21,    21,     2,      5,    15,     4,   30,      70,    1,       0,      hint_2)
    TE_Firearm("MoW_AR_AK103",          90,   50,     6,   3,   21,    21,     2,      5,    15,     4,   30,      70,    1,       0,      hint_2)
    TE_Firearm("MoW_AR_AK104",          90,   50,     6,   3,   21,    21,     2,      5,    15,     4,   30,      70,    1,       0,      hint_2)
    TE_Firearm("MoW_AR_AK105",          90,   50,     6,   3,   21,    21,     2,      5,    15,     4,   30,      70,    1,       0,      hint_2)
    TE_Firearm("MoW_AR_N3",             75,   70,     5,   3,   19,    21,     2,      10,   20,     4,   30,      60,    1,       0,      hint_7)
    TE_Firearm("MoW_AR_N4",             75,   70,     5,   3,   19,    21,     2,      10,   20,     4,   30,      60,    1,       0,      hint_7)
    TE_Firearm("MoW_AR_G3A3",           75,   70,     7,   3,   23,    27,     3,      5,    15,     2,   30,      70,    1,       0,      hint_8)
    TE_Firearm("MoW_AR_G3KA4",          75,   70,     6,   3,   19,    23,     3,      5,    15,     2,   30,      70,    1,       0,      hint_7)
    TE_Firearm("MoW_AR_AMD65",          95,   30,     6,   3,   19,    23,     2,      0,    10,     2,   30,      70,    1,       0,      hint_1)
    TE_Firearm("MoW_AR_ACR",            50,   90,     6,   3,   21,    21,     2,      5,    15,     6,   30,      60,    1,       0,      hint_5)
    TE_Firearm("MoW_AR_URGI",           75,   70,     5,   3,   19,    21,     2,      10,   20,     4,   30,      60,    1,       0,      hint_7)
    TE_Firearm("MoW_AR_HK416",          75,   70,     5,   3,   19,    21,     2,      10,   20,     4,   30,      60,    1,       0,      hint_7)
    TE_Firearm("MoW_AR_HK417",          75,   70,     7,   3,   23,    27,     3,      5,    15,     4,   30,      70,    1,       0,      hint_2)
    TE_Firearm("MoW_AR_MARSL",          75,   70,     5,   3,   19,    21,     2,      10,   20,     4,   30,      60,    1,       0,      hint_7)
    TE_Firearm("MoW_AR_M723",           75,   70,     5,   3,   19,    21,     2,      10,   20,     4,   30,      60,    1,       0,      hint_7)
    TE_Firearm("MoW_AR_M4",             75,   70,     5,   3,   19,    21,     2,      10,   20,     4,   30,      60,    1,       0,      hint_7)
    TE_Firearm("MoW_AR_M16A4",          75,   70,     6,   3,   21,    21,     2,      5,    15,     4,   30,      60,    1,       0,      hint_4)
    TE_Firearm("MoW_AR_ACE22",          90,   50,     7,   3,   23,    27,     3,      0,    10,     4,   30,      70,    1,       0,      hint_A)
    TE_Firearm("MoW_AR_ACE32",          90,   50,     7,   3,   23,    27,     3,      0,    10,     4,   30,      70,    1,       0,      hint_A)
    TE_Firearm("MoW_AR_ACE52",          90,   50,     7,   3,   23,    27,     3,      0,    10,     4,   30,      70,    1,       0,      hint_A)
    TE_Firearm("MoW_AR_TAR21",          50,   90,     6,   3,   21,    21,     2,      5,    15,     6,   30,      60,    1,       0,      hint_5)
end

local function TE_MachineGun()
    local tab_1 = {Spec_Cumber, "\n", Spec_Noise, "\n", Spec_Repair}
    local tab_2 = {Inc_Dura}
    local tab_3 = {Inc_Crit, "\n", Inc_Aim, "\n", Spec_OW}
    local tab_4 = {Inc_Damage, "\n", Inc_Aim, "\n", Spec_Cumber, "\n", Spec_Noise}
    local tab_5 = {Spec_Cumber, "\n", Spec_Noise, "\n", Spec_HMG}

    local hint_1 = T(30072476860501, table.concat(tab_1))
    local hint_2 = T(30072476860502, table.concat(tab_2))
    local hint_3 = T(30072476860503, table.concat(tab_3))
    local hint_4 = T(30072476860504, table.concat(tab_4))
    local hint_5 = T(30072476860505, table.concat(tab_5))

    --                                  dura, repair, apS, apR, range, damage, armorP, crit, critLv, aim, owAngle, noise, pbRange, cumber, hint
    TE_Firearm("MG42",                  75,   10,     6,   7,   26,    32,     3,      0,    10,     2,   30,      80,    1,       1,      hint_1)
    TE_Firearm("MG58",                  75,   10,     6,   7,   26,    32,     3,      0,    10,     3,   30,      80,    1,       1,      hint_1)
    TE_Firearm("RPK74",                 90,   50,     5,   7,   23,    28,     3,      0,    10,     2,   30,      70,    1,       0,      hint_2)
    TE_Firearm("FNMinimi",              75,   70,     5,   7,   24,    26,     2,      5,    15,     4,   40,      70,    1,       0,      hint_3)
    TE_Firearm("HK21",                  75,   70,     6,   7,   26,    35,     3,      0,    10,     4,   30,      80,    1,       1,      hint_4)
    TE_Firearm("BrowningM2HMG",         90,   70,     6,   7,   30,    60,     4,      0,    10,     2,   30,      90,    1,       1,      hint_5)
    TE_Firearm("MoW_MG_MAG",            75,   70,     6,   7,   26,    35,     3,      0,    10,     4,   30,      80,    1,       1,      hint_4)
    TE_Firearm("MoW_MG_M240",           75,   70,     6,   7,   26,    35,     3,      0,    10,     4,   30,      80,    1,       1,      hint_4)
    TE_Firearm("MoW_MG_RPD",            90,   50,     6,   7,   26,    30,     3,      0,    10,     2,   30,      80,    1,       1,      hint_2)
    TE_Firearm("MoW_MG_NG5",            75,   70,     5,   7,   24,    26,     2,      5,    15,     4,   40,      70,    1,       0,      hint_3)
    TE_Firearm("MoW_MG_AANF1",          75,   10,     6,   7,   26,    32,     3,      0,    10,     2,   30,      80,    1,       1,      hint_1)
    TE_Firearm("MoW_MG_PKP",            90,   50,     6,   7,   26,    35,     3,      0,    10,     4,   30,      80,    1,       1,      hint_4)
end

local function TE_SniperRifle()
    local tab_1 = {Spec_Worn, "\n", Spec_Repair}
    local tab_2 = {Spec_LeverAction, "\n", Dec_Aim, "\n", Spec_OW}
    local tab_3 = {Inc_Damage, "\n", Inc_Dura, "\n", Spec_FireMode}
    local tab_4 = {Inc_Range, "\n", Inc_Damage, "\n", Spec_Cumber}
    local tab_5 = {Inc_Range, "\n", Inc_Aim, "\n", Inc_Crit}
    local tab_6 = {Spec_Cumber, "\n", Spec_Noise}

    local hint_1 = T(30072476860401, table.concat(tab_1))
    local hint_2 = T(30072476860402, table.concat(tab_2))
    local hint_3 = T(30072476860403, table.concat(tab_3))
    local hint_4 = T(30072476860404, table.concat(tab_4))
    local hint_5 = T(30072476860405, table.concat(tab_5))
    local hint_6 = T(30072476860406, table.concat(tab_6))

    --                                  dura, repair, apS, apR, range, damage, armorP, crit, critLv, aim, owAngle, noise, pbRange, cumber, hint
    TE_Firearm("Gewehr98",              50,   10,     9,   5,   26,    36,     2,      5,    15,     2,   15,      80,    0,       0,      hint_1)
    TE_Firearm("Winchester1894",        50,   70,     5,   5,   24,    30,     1,      5,    15,     4,   20,      60,    0,       0,      hint_2)
    TE_Firearm("Winchester_Quest",      75,   70,     5,   5,   24,    30,     1,      5,    15,     4,   20,      60,    0,       0,      hint_2)
    TE_Firearm("GoldenGun",             95,   70,     7,   5,   24,    34,     3,      10,   20,     7,   15,      70,    0,       0,      hint_5)
    TE_Firearm("DragunovSVD",           90,   50,     8,   5,   30,    38,     3,      5,    15,     5,   15,      70,    0,       0,      hint_3)
    TE_Firearm("M24Sniper",             75,   70,     9,   5,   35,    48,     3,      5,    15,     6,   15,      80,    0,       1,      hint_4)
    TE_Firearm("PSG1",                  75,   70,     8,   5,   35,    40,     3,      10,   20,     7,   15,      70,    0,       0,      hint_5)
    TE_Firearm("BarretM82",             50,   70,     10,  5,   40,    60,     4,      5,    15,     6,   15,      90,    0,       1,      hint_6)
    TE_Firearm("MoW_Sniper_DRD",        75,   70,     8,   5,   35,    40,     3,      10,   20,     7,   15,      70,    0,       0,      hint_5)
    TE_Firearm("MoW_Sniper_SRS",        75,   70,     9,   5,   35,    48,     3,      5,    15,     6,   15,      80,    0,       1,      hint_4)
    TE_Firearm("MoW_Sniper_AWSM",       75,   70,     9,   5,   35,    48,     3,      5,    15,     6,   15,      80,    0,       1,      hint_4)
    TE_Firearm("MoW_Sniper_AWM",        75,   70,     9,   5,   35,    48,     3,      5,    15,     6,   15,      80,    0,       1,      hint_4)
    TE_Firearm("MoW_Sniper_Recce",      75,   70,     7,   5,   25,    34,     2,      10,   20,     7,   15,      60,    0,       0,      hint_5)
    TE_Firearm("MoW_Sniper_T5000",      75,   70,     9,   5,   35,    48,     3,      5,    15,     6,   15,      80,    0,       1,      hint_4)
    TE_Firearm("MoW_Sniper_T5000_308",  75,   70,     9,   5,   35,    48,     3,      5,    15,     6,   15,      80,    0,       1,      hint_4)
    TE_Firearm("MoW_Sniper_M2010",      75,   70,     8,   5,   35,    40,     3,      10,   20,     7,   15,      70,    0,       0,      hint_5)
    TE_Firearm("MoW_Sniper_SG750",      75,   70,     8,   5,   30,    40,     3,      10,   20,     7,   15,      70,    0,       0,      hint_5)
    TE_Firearm("MoW_Sniper_SG750_Creed",75,   70,     8,   5,   35,    40,     3,      10,   20,     7,   15,      70,    0,       0,      hint_5)
    TE_Firearm("MoW_Sniper_vz54",       50,   10,     8,   5,   26,    36,     2,      5,    15,     4,   15,      80,    0,       0,      hint_1)
    TE_Firearm("MoW_Sniper_M200",       75,   70,     10,  5,   40,    60,     4,      5,    15,     6,   15,      90,    0,       1,      hint_6)
    TE_Firearm("MoW_Sniper_SR25",       75,   70,     8,   5,   35,    40,     3,      10,   20,     7,   15,      80,    0,       0,      hint_5)
    TE_Firearm("MoW_Sniper_Lynx",       75,   70,     10,  5,   40,    60,     4,      5,    15,     6,   15,      90,    0,       1,      hint_6)
    TE_Firearm("MoW_Sniper_SPR",        75,   70,     9,   5,   35,    48,     3,      5,    15,     6,   15,      80,    0,       1,      hint_4)
end

local function TE_FireMode()
    --Handgun
    TE_ExtraMode("HiPower",            {"SingleShot", "DualShot", "BurstFire", "CancelShot", "MobileShot"})
    TE_ExtraMode("Bereta92",           {"SingleShot", "DualShot", "BurstFire", "CancelShot", "MobileShot"})
    TE_ExtraMode("Glock18",            {"BurstFire", "SingleShot", "DualShot", "AutoFire", "CancelShot", "MobileShot"})
    TE_ExtraMode("ColtPeacemaker",     {"SingleShot", "DualShot", "BurstFire", "CancelShot", "MobileShot"})
    TE_ExtraMode("ColtAnaconda",       {"SingleShot", "DualShot", "BurstFire", "CancelShot", "MobileShot"})
    TE_ExtraMode("DesertEagle",        {"SingleShot", "DualShot", "BurstFire", "CancelShot", "MobileShot"})
    TE_ExtraMode("TexRevolver",        {"SingleShot", "DualShot", "BurstFire", "CancelShot", "MobileShot"})
    TE_ExtraMode("MoW_Pistol_PL14",    {"SingleShot", "DualShot", "BurstFire", "CancelShot", "MobileShot"})
    TE_ExtraMode("MoW_Pistol_R8",      {"SingleShot", "DualShot", "BurstFire", "CancelShot", "MobileShot"})
    TE_ExtraMode("MoW_Pistol_USPTac",  {"SingleShot", "DualShot", "BurstFire", "CancelShot", "MobileShot"})
    TE_ExtraMode("MoW_Pistol_APS",     {"BurstFire", "SingleShot", "DualShot", "AutoFire", "CancelShot", "MobileShot"})
    TE_ExtraMode("MoW_Pistol_QSZ92",   {"SingleShot", "DualShot", "BurstFire", "CancelShot", "MobileShot"})
    TE_ExtraMode("MoW_Pistol_PB",      {"SingleShot", "DualShot", "BurstFire", "CancelShot", "MobileShot"})
    TE_ExtraMode("MoW_Pistol_P99",     {"SingleShot", "DualShot", "BurstFire", "CancelShot", "MobileShot"})
    TE_ExtraMode("MoW_Pistol_Police",  {"SingleShot", "DualShot", "BurstFire", "CancelShot", "MobileShot"})
    TE_ExtraMode("MoW_Pistol_PM",      {"SingleShot", "DualShot", "BurstFire", "CancelShot", "MobileShot"})
    TE_ExtraMode("MoW_Pistol_WCVE",    {"SingleShot", "DualShot", "BurstFire", "CancelShot", "MobileShot"})
    TE_ExtraMode("MoW_Pistol_P220",    {"SingleShot", "DualShot", "BurstFire", "CancelShot", "MobileShot"})
    TE_ExtraMode("MoW_Pistol_TT33",    {"SingleShot", "DualShot", "BurstFire", "CancelShot", "MobileShot"})
    TE_ExtraMode("MoW_Pistol_GSH18",   {"SingleShot", "DualShot", "BurstFire", "CancelShot", "MobileShot"})
    TE_ExtraMode("MoW_Pistol_CZ75B",   {"SingleShot", "DualShot", "BurstFire", "CancelShot", "MobileShot"})
    TE_ExtraMode("MoW_Pistol_G17",     {"BurstFire", "SingleShot", "DualShot", "AutoFire", "CancelShot", "MobileShot"})
    TE_ExtraMode("MoW_Pistol_G19x",    {"SingleShot", "DualShot", "BurstFire", "CancelShot", "MobileShot"})
    TE_ExtraMode("MoW_Pistol_G19",     {"SingleShot", "DualShot", "BurstFire", "CancelShot", "MobileShot"})
    TE_ExtraMode("MoW_Pistol_G45",     {"SingleShot", "DualShot", "BurstFire", "CancelShot", "MobileShot"})
    TE_ExtraMode("MoW_Pistol_KDW",     {"SingleShot", "DualShot", "BurstFire", "CancelShot", "MobileShot"})
    TE_ExtraMode("MoW_Pistol_M1911A1", {"SingleShot", "DualShot", "BurstFire", "CancelShot", "MobileShot"})
    TE_ExtraMode("MoW_Pistol_P226R",   {"SingleShot", "DualShot", "BurstFire", "CancelShot", "MobileShot"})
    TE_ExtraMode("MoW_Pistol_P228",    {"SingleShot", "DualShot", "BurstFire", "CancelShot", "MobileShot"})
    TE_ExtraMode("MoW_Pistol_P320",    {"SingleShot", "DualShot", "BurstFire", "CancelShot", "MobileShot"})
    TE_ExtraMode("MoW_Pistol_P320F",   {"SingleShot", "DualShot", "BurstFire", "CancelShot", "MobileShot"})
    TE_ExtraMode("MoW_Pistol_SP1",     {"SingleShot", "DualShot", "BurstFire", "CancelShot", "MobileShot"})
	--Shotgun
    TE_ExtraMode("M41Shotgun",         {"BuckshotBurst", "Buckshot", "CancelShotCone"})
end

local function TE_ComponentSlot()
    TE_ExtraSlots("Gewehr98",	{
		PlaceObj('WeaponComponentSlot', {
			'SlotType', "Scope",
			'AvailableComponents', {
				"LROptics",
				"LROpticsAdvanced",
				"ReflexSight",
				"ScopeCOG",
				"GewehrDefaultSight",
				"ImprovedIronsight",
				"ReflexSightAdvanced",
				"ScopeCOGQuick",
				"ThermalScope",
			},
			'DefaultComponent', "GewehrDefaultSight",
		}),
		PlaceObj('WeaponComponentSlot', {
			'SlotType', "Muzzle",
			'CanBeEmpty', true,
			'AvailableComponents', {
				"ImprovisedSuppressor",
				"Suppressor",
			},
		}),
	})
end

-- Load Changes
function OnMsg.ModsReloaded()
	if CurrentModOptions["Gunfight_Rework"] then
		TE_Handgun()
		TE_Shotgun()
		TE_SMG()
		TE_AssaultRifle()
		TE_MachineGun()
		TE_SniperRifle()
		TE_FireMode()
		TE_ComponentSlot()
	end
end
function OnMsg.DataLoaded()
	if CurrentModOptions["Gunfight_Rework"] then
		TE_Handgun()
		TE_Shotgun()
		TE_SMG()
		TE_AssaultRifle()
		TE_MachineGun()
		TE_SniperRifle()
		TE_FireMode()
		TE_ComponentSlot()
	end
end
function OnMsg.OptionsApply()
	if CurrentModOptions["Gunfight_Rework"] then
		TE_Handgun()
		TE_Shotgun()
		TE_SMG()
		TE_AssaultRifle()
		TE_MachineGun()
		TE_SniperRifle()
		TE_FireMode()
		TE_ComponentSlot()
	end
end