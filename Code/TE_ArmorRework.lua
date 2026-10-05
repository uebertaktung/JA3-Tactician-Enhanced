--Defs_Armor
local function checkID(id)
    if not InventoryItemDefs[id] then
        return false
    end
    if not _G[id] then
        return false
    end
    return true
end

local function TE_Armor(id, loss, repair, dr, drExtra, armorP, protectBP, hint)
    if checkID(id) == false then
        return
    end

    local defs = InventoryItemDefs[id]
    local load = _G[id]

    defs.Degradation            = loss
    defs.RepairCost             = repair
    defs.DamageReduction        = dr
    defs.AdditionalReduction    = drExtra
    defs.PenetrationClass       = armorP
    defs.ProtectedBodyParts     = protectBP
    
    load.Degradation            = loss
    load.RepairCost             = repair
    load.DamageReduction        = dr
    load.AdditionalReduction    = drExtra
    load.PenetrationClass       = armorP
    load.ProtectedBodyParts     = protectBP
    
    if hint then
        defs.AdditionalHint     = hint
        load.AdditionalHint     = hint
    end
end

local Helmet = set( "Head" )
local Chest = set( "Torso" )
local Vest = set( "Torso", "Arms" )
local Leggings = set( "Groin", "Legs" )
local Hide = set( "Head", "Torso", "Legs" )
local Skin = set( "Head", "Arms", "Groin", "Legs", "Torso" )
local hint_Weave = T(30072476860701, "<bullet_point> Penetrated damage reduction and durability improved by Weave Padding")
local hint_Plate = T(30072476860702, "<bullet_point> Damage reduction greatly improved by Ceramic Plates\n<bullet_point> The ceramic plates will break after taking <GameColorG><RevertConditionCounter></GameColorG> hits")

local function TE_ArmorL(deg)
    --                                                 loss,   repair,     dr, drExtra,    armorP,     protectBP,          hint
    TE_Armor("NightVisionGoggles",                     deg*2,  20,         0,  0,          1,          Helmet,             nil)
    TE_Armor("GasMask",                                deg*2,  20,         0,  0,          1,          Helmet,             nil)
    TE_Armor("CamoArmor_Light",                        deg*2,  20,         0,  50,         2,          Chest,              nil)
    TE_Armor("CamoArmor_Light_Kompositum",             deg,    20,         20, 50,         2,          Chest,              nil)
    TE_Armor("FlakArmor",                              deg*2,  20,         0,  50,         2,          Vest,               nil)
    TE_Armor("FlakVest",                               deg*2,  20,         0,  50,         2,          Chest,              nil)
    TE_Armor("FlakLeggings",                           deg*2,  20,         0,  50,         2,          Leggings,           nil)
    TE_Armor("LightHelmet",                            deg*2,  20,         0,  50,         2,          Helmet,             nil)
    TE_Armor("FlakArmor_CeramicPlates",                deg*2,  20,         0,  70,         3,          Vest,               hint_Plate)
    TE_Armor("FlakVest_CeramicPlates",                 deg*2,  20,         0,  70,         3,          Chest,              hint_Plate)
    TE_Armor("FlakArmor_WeavePadding",                 deg,    20,         20, 30,         2,          Vest,               hint_Weave)
    TE_Armor("FlakVest_WeavePadding",                  deg,    20,         20, 30,         2,          Chest,              hint_Weave)
    TE_Armor("FlakLeggings_WeavePadding",              deg,    20,         20, 30,         2,          Leggings,           hint_Weave)
    TE_Armor("LightHelmet_WeavePadding",               deg,    20,         20, 30,         2,          Helmet,             hint_Weave)
    TE_Armor("FlakArmor_Kompositum",                   deg,    20,         20, 50,         2,          Vest,               nil)
    TE_Armor("FlakVest_Kompositum",                    deg,    20,         20, 50,         2,          Chest,              nil)
    TE_Armor("FlakLeggings_Kompositum",                deg,    20,         20, 50,         2,          Leggings,           nil)
    TE_Armor("LightHelmet_Kompositum",                 deg,    20,         20, 50,         2,          Helmet,             nil)
end

local function TE_ArmorM(deg)
    --                                                 loss,   repair,     dr, drExtra,    armorP,     protectBP,          hint
    TE_Armor("Gasmaskenhelm",                          deg*2,  20,         0,  60,         3,          Helmet,             nil)
    TE_Armor("CamoArmor_Medium",                       deg*2,  30,         0,  60,         3,          Vest,               nil)
    TE_Armor("CamoArmor_Medium_Kompositum",            deg,    30,         20, 60,         3,          Vest,               nil)
    TE_Armor("KevlarChestplate",                       deg*2,  30,         0,  60,         3,          Chest,              nil)
    TE_Armor("KevlarVest",                             deg*2,  30,         0,  60,         3,          Vest,               nil)
    TE_Armor("KevlarLeggings",                         deg*2,  30,         0,  60,         3,          Leggings,           nil)
    TE_Armor("KevlarHelmet",                           deg*2,  30,         0,  60,         3,          Helmet,             nil)
    TE_Armor("KevlarVest_CeramicPlates",               deg*2,  30,         0,  80,         4,          Vest,               hint_Plate)
    TE_Armor("KevlarChestplate_CeramicPlates",         deg*2,  30,         0,  80,         4,          Chest,              hint_Plate)
    TE_Armor("KevlarVest_WeavePadding",                deg,    30,         20, 40,         3,          Vest,               hint_Weave)
    TE_Armor("KevlarChestplate_WeavePadding",          deg,    30,         20, 40,         3,          Chest,              hint_Weave)
    TE_Armor("KevlarLeggings_WeavePadding",            deg,    30,         20, 40,         3,          Leggings,           hint_Weave)
    TE_Armor("KevlarHelmet_WeavePadding",              deg,    30,         20, 40,         3,          Helmet,             hint_Weave)
    TE_Armor("KevlarChestplate_Kompositum",            deg,    30,         20, 60,         3,          Chest,              nil)
    TE_Armor("KevlarVest_Kompositum",                  deg,    30,         20, 60,         3,          Vest,               nil)
    TE_Armor("KevlarLeggings_Kompositum",              deg,    30,         20, 60,         3,          Leggings,           nil)
    TE_Armor("KevlarHelmet_Kompositum",                deg,    30,         20, 60,         3,          Helmet,             nil)
    TE_Armor("CrocodileHide",                          0,      0,          20, 60,         4,          Hide,               nil)
    TE_Armor("Infected_HardenedSkin",                  0,      0,          20, 60,         4,          Skin,               nil)
end

local function TE_ArmorH(deg)
    --                                                 loss,   repair,     dr, drExtra,    armorP,     protectBP,          hint
    TE_Armor("PostApoHelmet",                          deg*2,  40,         0,  80,         4,          Helmet,             nil)
    TE_Armor("ShamanHelmet",                           deg*2,  40,         0,  80,         4,          Helmet,             nil)
    TE_Armor("ShamanTorso",                            deg*2,  40,         0,  80,         4,          Vest,               nil)
    TE_Armor("ShamanLeggings",                         deg*2,  40,         0,  80,         4,          Leggings,           nil)
    TE_Armor("HeavyArmorTorso",                        deg*2,  40,         0,  80,         4,          Vest,               nil)
    TE_Armor("HeavyArmorChestplate",                   deg*2,  40,         0,  80,         4,          Chest,              nil)
    TE_Armor("HeavyArmorLeggings",                     deg*2,  40,         0,  80,         4,          Leggings,           nil)
    TE_Armor("HeavyArmorHelmet",                       deg*2,  40,         0,  80,         4,          Helmet,             nil)
    TE_Armor("HeavyArmorTorso_CeramicPlates",          deg*2,  40,         0,  90,         5,          Vest,               hint_Plate)
    TE_Armor("HeavyArmorChestplate_CeramicPlates",     deg*2,  40,         0,  90,         5,          Chest,              hint_Plate)
    TE_Armor("HeavyArmorTorso_WeavePadding",           deg,    40,         20, 60,         4,          Vest,               hint_Weave)
    TE_Armor("HeavyArmorChestplate_WeavePadding",      deg,    40,         20, 60,         4,          Chest,              hint_Weave)
    TE_Armor("HeavyArmorLeggings_WeavePadding",        deg,    40,         20, 60,         4,          Leggings,           hint_Weave)
    TE_Armor("HeavyArmorHelmet_WeavePadding",          deg,    40,         20, 60,         4,          Helmet,             hint_Weave)
    TE_Armor("HeavyArmorChestplate_Kompositum",        deg,    40,         20, 70,         5,          Chest,              nil)
    TE_Armor("HeavyArmorTorso_Kompositum",             deg,    40,         20, 70,         5,          Vest,               nil)
    TE_Armor("HeavyArmorLeggings_Kompositum",          deg,    40,         20, 70,         5,          Leggings,           nil)
    TE_Armor("HeavyArmorHelmet_Kompositum",            deg,    40,         20, 70,         5,          Helmet,             nil)
end

local function ArmorDeg_Apply()
    return 3
end

-- Load Changes
function OnMsg.ModsReloaded()
	if CurrentModOptions["Gunfight_Rework"] then
    	local deg = ArmorDeg_Apply()
		
    	TE_ArmorL(deg)
    	TE_ArmorM(deg)
    	TE_ArmorH(deg)
	end
end
function OnMsg.DataLoaded()
	if CurrentModOptions["Gunfight_Rework"] then
    	local deg = ArmorDeg_Apply()
		
    	TE_ArmorL(deg)
    	TE_ArmorM(deg)
    	TE_ArmorH(deg)
	end
end
function OnMsg.OptionsApply()
	if CurrentModOptions["Gunfight_Rework"] then
    	local deg = ArmorDeg_Apply()
		
    	TE_ArmorL(deg)
    	TE_ArmorM(deg)
    	TE_ArmorH(deg)
	end
end