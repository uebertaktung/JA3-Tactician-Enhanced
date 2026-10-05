-- ========== TE AIArchetype Overhaul Begin ==========

--Defs_Unit_AI
local function checkID(id)
    if not UnitDataDefs[id] then
        return false
    end
    if not _G[id] then
        return false
    end
    return true
end

local function TE_AI_Major(id, archetype, attacks, perk, model, voice, equip, gearFunc)
    if checkID(id) == false then
        return
    end

    local defs = UnitDataDefs[id]
    local load = _G[id]

    defs.PickCustomArchetype    = archetype
    load.PickCustomArchetype    = archetype

    defs.MaxAttacks             = attacks
    load.MaxAttacks             = attacks

    if perk and (CurrentModOptions["Hell_Gate"] == "<GameTerm('TE_NIGHTMARE_A')>" or CurrentModOptions["Hell_Gate"] == "<GameTerm('TE_NIGHTMARE_B')>") then
        defs.StartingPerks      = perk
        load.StartingPerks      = perk
    end
	
    if model and CurrentModOptions["Tactical_Legion"] then
        defs.AppearancesList    = model
        load.AppearancesList    = model
    end
	
    if voice and CurrentModOptions["Tactical_Legion"] then
        defs.VoiceResponseId = voice
        load.VoiceResponseId = voice
    end
	
    if equip and CurrentModOptions["Tactical_Enemy"] then
        defs.Equipment       = equip
        load.Equipment       = equip
    end
	
    if gearFunc and CurrentModOptions["Tactical_Enemy"] then
        defs.CustomEquipGear = gearFunc
        load.CustomEquipGear = gearFunc
    end
end

local function TE_AI_Minion(id, archetype, attacks, perk)
    if checkID(id) == false then
        return
    end

    local defs = UnitDataDefs[id]
    local load = _G[id]

    defs.PickCustomArchetype    = archetype
    load.PickCustomArchetype    = archetype
	
    defs.MaxAttacks             = attacks
    load.MaxAttacks             = attacks

    if perk then
        defs.StartingPerks      = perk
        load.StartingPerks      = perk
    end
end

local function gen_TacticianEnhanced()
    local Adept_Proto = function (self, proto_context)
local enemy, dist = GetNearestEnemy(self)
local enemies = self:GetVisibleEnemies()
local weapon = self:GetActiveWeapons()
local slot = self.current_weapon
local archetype = self.archetype

if enemy and dist < 8 * const.SlabSizeX then
	if IsKindOf(weapon, "HeavyWeapon") then
	    slot = "Handheld B"
	    AIPlayCombatAction("ChangeWeapon", self, 0)
	end
	archetype = "Warrior_Archetype"
	PlayVoiceResponse(self, "AIArchetypeAngry")
elseif enemy and dist > 8 * const.SlabSizeX then
	if not IsKindOf(weapon, "HeavyWeapon") then
	    slot = "Handheld A"
	    AIPlayCombatAction("ChangeWeapon", self, 0)
	end
	if IsKindOf(weapon, "RocketLauncher") then
	    archetype = "AdeptRPG_Archetype"
	end
	if IsKindOf(weapon, "Mortar") then
	    archetype = "AdeptMortar_Archetype"
	end
elseif #enemies == 0 then
	if not IsKindOf(weapon, "HeavyWeapon") then
	    slot = "Handheld A"
	    AIPlayCombatAction("ChangeWeapon", self, 0)
	end
	archetype = "ReconnaissanceHunter_Archetype"
end
return archetype
    end

    local Sentinel_Proto = function (self, proto_context)
local enemy, dist = GetNearestEnemy(self)
local enemies = self:GetVisibleEnemies()
local weapon = self:GetActiveWeapons()
local slot = self.current_weapon
local archetype = self.archetype

if enemy and dist < 5 * const.SlabSizeX then
	if IsKindOfClasses(weapon, "AssaultRifle", "SniperRifle", "MachineGun", "HeavyWeapon") then
	    slot = "Handheld B"
	    AIPlayCombatAction("ChangeWeapon", self, 0)
	end
	archetype = "Warrior_Archetype"
	PlayVoiceResponse(self, "AIArchetypeAngry")
elseif (enemy and dist >= 5 * const.SlabSizeX) and (enemy and dist <= 25 * const.SlabSizeX) then
	if not IsKindOfClasses(weapon, "AssaultRifle", "SniperRifle", "MachineGun", "SubmachineGun", "Shotgun") then
	    slot = "Handheld A"
	    AIPlayCombatAction("ChangeWeapon", self, 0)
	end
	if IsKindOf(weapon, "AssaultRifle") then
	    archetype = "SentinelAR_Archetype"
	end
	if IsKindOf(weapon, "SniperRifle") then
	    archetype = "SentinelSR_Archetype"
	end
	if IsKindOf(weapon, "MachineGun") then
	    archetype = "SentinelMG_Archetype"
	end
	if IsKindOfClasses(weapon, "SubmachineGun", "Shotgun") then
	    archetype = "Vanguard_Archetype"
	end
elseif (enemy and dist > 25 * const.SlabSizeX) or (#enemies == 0) then
	if not IsKindOfClasses(weapon, "AssaultRifle", "SniperRifle", "MachineGun", "SubmachineGun", "Shotgun") then
	    slot = "Handheld A"
	    AIPlayCombatAction("ChangeWeapon", self, 0)
	end
	archetype = "ReconnaissanceHunter_Archetype"
end
return archetype
    end

    local Vanguard_Proto = function (self, proto_context)
local enemy, dist = GetNearestEnemy(self)
local enemies = self:GetVisibleEnemies()
local weapon = self:GetActiveWeapons()
local slot = self.current_weapon
local archetype = self.archetype

if enemy and dist < 8 * const.SlabSizeX then
	if IsKindOfClasses(weapon, "SubmachineGun", "Shotgun", "MeleeWeapon") then
		archetype = "Warrior_Archetype"
		PlayVoiceResponse(self, "AIArchetypeAngry")
	end
elseif (enemy and dist >= 8 * const.SlabSizeX) and (enemy and dist <= 16 * const.SlabSizeX) then
	if not IsKindOfClasses(weapon, "AssaultRifle", "SniperRifle", "MachineGun", "SubmachineGun", "Shotgun", "MeleeWeapon") then
	    slot = "Handheld A"
	    AIPlayCombatAction("ChangeWeapon", self, 0)
	end
	if IsKindOf(weapon, "AssaultRifle") then
	    archetype = "SentinelAR_Archetype"
	end
	if IsKindOf(weapon, "SniperRifle") then
	    archetype = "SentinelSR_Archetype"
	end
	if IsKindOf(weapon, "MachineGun") then
	    archetype = "SentinelMG_Archetype"
	end
	if IsKindOfClasses(weapon, "SubmachineGun", "Shotgun") then
	    archetype = "Vanguard_Archetype"
	end
elseif (enemy and dist > 16 * const.SlabSizeX) or (#enemies == 0) then
	if not IsKindOfClasses(weapon, "AssaultRifle", "SniperRifle", "MachineGun", "SubmachineGun", "Shotgun", "MeleeWeapon") then
	    slot = "Handheld A"
	    AIPlayCombatAction("ChangeWeapon", self, 0)
	end
	archetype = "ReconnaissanceScouter_Archetype"
end
return archetype
    end

    local Warrior_Proto = function (self, proto_context)
local enemy, dist = GetNearestEnemy(self)
local enemies = self:GetVisibleEnemies()
local slot = self.current_weapon
local archetype = self.archetype

if enemy and dist < 16 * const.SlabSizeX then
	if not self:GetActiveWeapons("MeleeWeapon") then
	    slot = "Handheld A"
	    AIPlayCombatAction("ChangeWeapon", self, 0)
	end
	archetype = "Warrior_Archetype"
	PlayVoiceResponse(self, "AIArchetypeAngry")
elseif (enemy and dist >= 16 * const.SlabSizeX) and (enemy and dist <= 25 * const.SlabSizeX) then
	if not self:GetActiveWeapons("MeleeWeapon") then
	    slot = "Handheld A"
	    AIPlayCombatAction("ChangeWeapon", self, 0)
	end
	archetype = "Vanguard_Archetype"
elseif (enemy and dist > 25 * const.SlabSizeX) or (#enemies == 0) then
	if not self:GetActiveWeapons("MeleeWeapon") then
	    slot = "Handheld A"
	    AIPlayCombatAction("ChangeWeapon", self, 0)
	end
	archetype = "ReconnaissanceScouter_Archetype"
end
return archetype
    end

	local Tactical_Brute =   { "NaturalCamouflage", "MartialArts", "MeleeTraining", "NightOps", "Throwing", "OptimalPerformance", "BeefedUp", "BloodlustPerk", "Berserker", "HardBlow", "BloodScent" }
	local Tactical_Stormer = { "AutoWeapons", "MeleeTraining", "CQCTraining", "NightOps", "Throwing", "BeefedUp", "Flanker", "BreachAndClear", "TrueGrit", "InstantAutopsy", "LineBreaker" }
	local Tactical_Soldier = { "AutoWeapons", "CQCTraining", "HeavyWeaponsTraining", "NightOps", "Throwing", "HitTheDeck", "BeefedUp", "TakeAim", "Ironclad", "BattleFocus", "CollateralDamage" }
	local Tactical_Sniper =  { "LightningReactionNPC", "NaturalCamouflage", "CQCTraining", "NightOps", "Throwing", "HitTheDeck", "Hobbler", "Deadeye", "DeathFromAbove", "Infiltrator", "Instagib" }
	local Tactical_Super =   { "DieselPerk", "MeleeTraining", "AutoWeapons", "CQCTraining", "NightOps", "Throwing", "BeefedUp", "TakeAim", "BreachAndClear", "InstantAutopsy", "HardBlow", "Berserker", "BattleFocus", "BloodScent", "LineBreaker" }

    local AI_GearEquip = function (self, items)
self:TryEquip(items, "Handheld A", "HeavyWeapon")
self:TryEquip(items, "Handheld A", "SniperRifle")
self:TryEquip(items, "Handheld A", "MachineGun")
self:TryEquip(items, "Handheld A", "AssaultRifle")
self:TryEquip(items, "Handheld A", "Shotgun")
self:TryEquip(items, "Handheld A", "SubmachineGun")
self:TryEquip(items, "Handheld A", "SubmachineGun")
self:TryEquip(items, "Handheld A", "MeleeWeapon")
self:TryEquip(items, "Handheld B", "Pistol")
self:TryEquip(items, "Handheld B", "Pistol")
self:TryEquip(items, "Handheld B", "Revolver")
self:TryEquip(items, "Handheld B", "Revolver")
self:TryEquip(items, "Handheld B", "Grenade")
self:TryEquip(items, "Handheld B", "Grenade")
    end

    --Legion
    local Legion_Soldier = {
        PlaceObj('AppearanceWeight', { 'Preset', "Tactical_Legion_E1", 'Weight', 200, }),
        PlaceObj('AppearanceWeight', { 'Preset', "Tactical_Legion_E2", 'Weight', 150, }),
        PlaceObj('AppearanceWeight', { 'Preset', "Tactical_Legion_E3", 'Weight', 150, }),
        PlaceObj('AppearanceWeight', { 'Preset', "Tactical_Legion_E4", 'Weight', 150, }),
    }
    local Legion_Stormer = {
        PlaceObj('AppearanceWeight', { 'Preset', "Tactical_Legion_A1", 'Weight', 200, }),
        PlaceObj('AppearanceWeight', { 'Preset', "Tactical_Legion_A2", 'Weight', 150, }),
        PlaceObj('AppearanceWeight', { 'Preset', "Tactical_Legion_A3", 'Weight', 150, }),
        PlaceObj('AppearanceWeight', { 'Preset', "Tactical_Legion_A4", 'Weight', 150, }),
    }
    local Legion_Brute = {
        PlaceObj('AppearanceWeight', { 'Preset', "Tactical_Legion_B1", 'Weight', 300, }),
        PlaceObj('AppearanceWeight', { 'Preset', "Tactical_Legion_B2", 'Weight', 150, }),
    }
    local Legion_Medic = {
        PlaceObj('AppearanceWeight', { 'Preset', "Tactical_Legion_M1", 'Weight', 300, }),
        PlaceObj('AppearanceWeight', { 'Preset', "Tactical_Legion_M2", 'Weight', 150, }),
    }
    local Legion_Hyena = {
        PlaceObj('AppearanceWeight', { 'Preset', "Hyena_Base",   'Weight', 150, }),
        PlaceObj('AppearanceWeight', { 'Preset', "Hyena_Base_1", 'Weight', 150, }),
        PlaceObj('AppearanceWeight', { 'Preset', "Hyena_Base_2", 'Weight', 250, }),
        PlaceObj('AppearanceWeight', { 'Preset', "Hyena_Base_4", 'Weight', 250, }),
        PlaceObj('AppearanceWeight', { 'Preset', "Hyena_Base_5", 'Weight', 250, }),
    }
    TE_AI_Major("LegionGoon",                        Vanguard_Proto,    2,    Tactical_Stormer,    Legion_Stormer,    nil,    {"TE_LegionGoon"},                           AI_GearEquip)
    TE_AI_Major("LegionGoon_Stronger",               Vanguard_Proto,    2,    Tactical_Stormer,    Legion_Stormer,    nil,    {"TE_LegionGoon_Stronger"},                  AI_GearEquip)
    TE_AI_Major("LegionGoon_Stronger_Elite",         Vanguard_Proto,    2,    Tactical_Stormer,    Legion_Stormer,    nil,    {"TE_LegionGoon_Stronger_Elite"},            AI_GearEquip)
    TE_AI_Major("LegionGrenadier",                   Vanguard_Proto,    2,    Tactical_Stormer,    Legion_Stormer,    nil,    {"TE_LegionGrenadier"},                      AI_GearEquip)
    TE_AI_Major("LegionGrenadier_Stronger",          Vanguard_Proto,    2,    Tactical_Stormer,    Legion_Stormer,    nil,    {"TE_LegionGrenadier_Stronger"},             AI_GearEquip)
    TE_AI_Major("LegionGrenadier_Stronger_Elite",    Vanguard_Proto,    2,    Tactical_Stormer,    Legion_Stormer,    nil,    {"TE_LegionGrenadier_Stronger_Elite"},       AI_GearEquip)
    TE_AI_Major("LegionScout",                       Vanguard_Proto,    2,    Tactical_Stormer,    Legion_Stormer,    nil,    {"TE_LegionScout"},                          AI_GearEquip)
    TE_AI_Major("LegionScout_Stronger",              Vanguard_Proto,    2,    Tactical_Stormer,    Legion_Stormer,    nil,    {"TE_LegionScout_Stronger"},                 AI_GearEquip)
    TE_AI_Major("LegionScout_Stronger_Elite",        Vanguard_Proto,    2,    Tactical_Stormer,    Legion_Stormer,    nil,    {"TE_LegionScout_Stronger_Elite"},           AI_GearEquip)
    TE_AI_Major("LegionMedic",                       Vanguard_Proto,    2,    Tactical_Stormer,    Legion_Medic,      nil,    {"TE_LegionMedic"},                          AI_GearEquip)
    TE_AI_Major("LegionMedic_Stronger",              Vanguard_Proto,    2,    Tactical_Stormer,    Legion_Medic,      nil,    {"TE_LegionMedic_Stronger"},                 AI_GearEquip)
    TE_AI_Major("LegionManiac",                      Vanguard_Proto,    2,    Tactical_Stormer,    Legion_Brute,      nil,    {"TE_LegionBerserker"},                      AI_GearEquip)
    TE_AI_Major("LegionManiac_Stronger",             Vanguard_Proto,    2,    Tactical_Stormer,    Legion_Brute,      nil,    {"TE_LegionBerserker_Stronger"},             AI_GearEquip)
    TE_AI_Major("LegionManiac_Stronger_Elite",       Vanguard_Proto,    2,    Tactical_Stormer,    Legion_Brute,      nil,    {"TE_LegionBerserker_Stronger_Elite"},       AI_GearEquip)
    TE_AI_Major("LegionButcher",                     Warrior_Proto,     3,    Tactical_Brute,      Legion_Brute,      nil,    {"TE_LegionMeleeFighter"},                   AI_GearEquip)
    TE_AI_Major("LegionButcher_Stronger",            Warrior_Proto,     3,    Tactical_Brute,      Legion_Brute,      nil,    {"TE_LegionMeleeFighter_Stronger"},          AI_GearEquip)
    TE_AI_Major("LegionButcher_Stronger_Elite",      Warrior_Proto,     3,    Tactical_Brute,      Legion_Brute,      nil,    {"TE_LegionMeleeFighter_Stronger_Elite"},    AI_GearEquip)
    TE_AI_Major("LegionBrawler_SavannaCamp",         Warrior_Proto,     3,    Tactical_Brute,      Legion_Brute,      nil,    {"TE_LegionBrawler"},                        AI_GearEquip)
    TE_AI_Major("LegionHyena",                       nil,               3,    Tactical_Brute,      Legion_Hyena,      nil,    {"TE_LegionHyena"},                          AI_GearEquip)
    TE_AI_Major("LegionHyenaHandler",                Sentinel_Proto,    2,    Tactical_Soldier,    Legion_Soldier,    nil,    {"TE_LegionSentry"},                         AI_GearEquip)
    TE_AI_Major("LegionHyenaHandler_Stronger",       Sentinel_Proto,    2,    Tactical_Soldier,    Legion_Soldier,    nil,    {"TE_LegionSentry_Stronger"},                AI_GearEquip)
    TE_AI_Major("LegionSniper",                      Sentinel_Proto,    2,    Tactical_Sniper,     Legion_Soldier,    nil,    {"TE_LegionSniper"},                         AI_GearEquip)
    TE_AI_Major("LegionSniper_Stronger",             Sentinel_Proto,    2,    Tactical_Sniper,     Legion_Soldier,    nil,    {"TE_LegionSniper_Stronger"},                AI_GearEquip)
    TE_AI_Major("LegionSniper_Stronger_Elite",       Sentinel_Proto,    2,    Tactical_Sniper,     Legion_Soldier,    nil,    {"TE_LegionSniper_Stronger_Elite"},          AI_GearEquip)
    TE_AI_Major("LegionGunner",                      Sentinel_Proto,    2,    Tactical_Soldier,    Legion_Soldier,    nil,    {"TE_LegionGunner"},                         AI_GearEquip)
    TE_AI_Major("LegionGunner_Stronger",             Sentinel_Proto,    2,    Tactical_Soldier,    Legion_Soldier,    nil,    {"TE_LegionGunner_Stronger"},                AI_GearEquip)
    TE_AI_Major("LegionRocketeer",                   Adept_Proto,       2,    Tactical_Soldier,    Legion_Soldier,    nil,    {"TE_LegionRocketeer"},                      AI_GearEquip)
    TE_AI_Major("LegionRocketeer_Stronger",          Adept_Proto,       2,    Tactical_Soldier,    Legion_Soldier,    nil,    {"TE_LegionRocketeer_Stronger"},             AI_GearEquip)
    TE_AI_Major("LegionRocketeer_SlowReloader",      Adept_Proto,       2,    Tactical_Soldier,    Legion_Soldier,    nil,    {"TE_LegionRocketeer_SlowReloader"},         AI_GearEquip)
    TE_AI_Major("LegionMortarman",                   Adept_Proto,       2,    Tactical_Soldier,    Legion_Soldier,    nil,    {"TE_LegionMortarman"},                      AI_GearEquip)
    TE_AI_Major("LegionRaider",                      Sentinel_Proto,    2,    Tactical_Soldier,    Legion_Soldier,    nil,    {"TE_LegionRaiders"},                        AI_GearEquip)
    TE_AI_Major("LegionRaider_Stronger",             Sentinel_Proto,    2,    Tactical_Soldier,    Legion_Soldier,    nil,    {"TE_LegionRaider_Stronger"},                AI_GearEquip)
    TE_AI_Major("LegionRaider_PresidentGuard",       Sentinel_Proto,    2,    Tactical_Soldier,    Legion_Soldier,    nil,    {"TE_LegionRaider_Stronger"},                AI_GearEquip)
    TE_AI_Major("LegionRaider_Ernie_Elite",          Sentinel_Proto,    2,    Tactical_Soldier,    Legion_Soldier,    nil,    {"TE_LegionRaider_Stronger"},                AI_GearEquip)
    TE_AI_Major("LegionRaider_Stronger_Elite",       Sentinel_Proto,    2,    Tactical_Soldier,    Legion_Soldier,    nil,    {"TE_LegionRaider_Stronger_Elite"},          AI_GearEquip)
    TE_AI_Major("LegionRaidLeader",                  Sentinel_Proto,    2,    Tactical_Soldier,    Legion_Soldier,    nil,    {"TE_LegionSentry"},                         AI_GearEquip)
    TE_AI_Major("LegionRaidLeader_Stronger",         Sentinel_Proto,    2,    Tactical_Soldier,    Legion_Soldier,    nil,    {"TE_LegionSentry_Stronger"},                AI_GearEquip)
    TE_AI_Major("LegionRaidLeader_Stronger_Elite",   Sentinel_Proto,    2,    Tactical_Soldier,    Legion_Soldier,    nil,    {"TE_LegionSentry_Stronger_Elite"},          AI_GearEquip)
    TE_AI_Major("PierreGuard",                       Sentinel_Proto,    2,    Tactical_Soldier,    Legion_Soldier,    nil,    {"TE_PierreGuard"},                          AI_GearEquip)
    TE_AI_Major("PierreGuard_Ordnance",              Sentinel_Proto,    2,    Tactical_Soldier,    Legion_Soldier,    nil,    {"TE_PierreGuard_Ordnance"},                 AI_GearEquip)
	
    --Thugs
    TE_AI_Major("ThugCutter",                        Warrior_Proto,     3,    Tactical_Brute,      nil,    nil,    {"TE_ThugCutter"},                AI_GearEquip)
    TE_AI_Major("ThugCutter_Stronger",               Warrior_Proto,     3,    Tactical_Brute,      nil,    nil,    {"TE_ThugCutter_Stronger"},       AI_GearEquip)
    TE_AI_Major("ThugCutter_Stronger_Elite",         Warrior_Proto,     3,    Tactical_Brute,      nil,    nil,    {"TE_ThugCutter_Stronger"},       AI_GearEquip)
    TE_AI_Major("ThugGoon",                          Vanguard_Proto,    2,    Tactical_Stormer,    nil,    nil,    {"TE_ThugGoon"},                  AI_GearEquip)
    TE_AI_Major("ThugGoon_Stronger",                 Vanguard_Proto,    2,    Tactical_Stormer,    nil,    nil,    {"TE_ThugGoon_Stronger"},         AI_GearEquip)
    TE_AI_Major("ThugGoon_Stronger_Elite",           Vanguard_Proto,    2,    Tactical_Stormer,    nil,    nil,    {"TE_ThugGoon_Stronger"},         AI_GearEquip)
    TE_AI_Major("ThugGrenadier",                     Vanguard_Proto,    2,    Tactical_Stormer,    nil,    nil,    {"TE_ThugGrenadier"},             AI_GearEquip)
    TE_AI_Major("ThugGrenadier_Stronger",            Vanguard_Proto,    2,    Tactical_Stormer,    nil,    nil,    {"TE_ThugGrenadier_Stronger"},    AI_GearEquip)
    TE_AI_Major("ThugGrenadier_Stronger_Elite",      Vanguard_Proto,    2,    Tactical_Stormer,    nil,    nil,    {"TE_ThugGrenadier_Stronger"},    AI_GearEquip)
    TE_AI_Major("ThugSniper",                        Sentinel_Proto,    2,    Tactical_Sniper,     nil,    nil,    {"TE_ThugSniper"},                AI_GearEquip)
    TE_AI_Major("ThugSniper_Stronger",               Sentinel_Proto,    2,    Tactical_Sniper,     nil,    nil,    {"TE_ThugSniper_Stronger"},       AI_GearEquip)
    TE_AI_Major("ThugSniper_Stronger_Elite",         Sentinel_Proto,    2,    Tactical_Sniper,     nil,    nil,    {"TE_ThugSniper_Stronger"},       AI_GearEquip)
    TE_AI_Major("ThugGunner",                        Sentinel_Proto,    2,    Tactical_Soldier,    nil,    nil,    {"TE_ThugGunner"},                AI_GearEquip)
    TE_AI_Major("ThugGunner_Stronger",               Sentinel_Proto,    2,    Tactical_Soldier,    nil,    nil,    {"TE_ThugGunner_Stronger"},       AI_GearEquip)
    TE_AI_Major("ThugGunner_Stronger_Elite",         Sentinel_Proto,    2,    Tactical_Soldier,    nil,    nil,    {"TE_ThugGunner_Stronger"},       AI_GearEquip)
    TE_AI_Major("ThugEnforcer",                      Sentinel_Proto,    2,    Tactical_Soldier,    nil,    nil,    {"TE_ThugEnforcer"},              AI_GearEquip)
    TE_AI_Major("ThugEnforcer_Stronger",             Sentinel_Proto,    2,    Tactical_Soldier,    nil,    nil,    {"TE_ThugEnforcer_Stronger"},     AI_GearEquip)
    TE_AI_Major("ThugEnforcer_Stronger_Elite",       Sentinel_Proto,    2,    Tactical_Soldier,    nil,    nil,    {"TE_ThugEnforcer_Stronger"},     AI_GearEquip)
    TE_AI_Major("ThugBoss",                          Sentinel_Proto,    2,    Tactical_Soldier,    nil,    nil,    {"TE_ThugBoss"},                  AI_GearEquip)
    TE_AI_Major("ThugBoss_Stronger",                 Sentinel_Proto,    2,    Tactical_Soldier,    nil,    nil,    {"TE_ThugBoss_Stronger"},         AI_GearEquip)
    TE_AI_Major("ThugBoss_Stronger_Elite",           Sentinel_Proto,    2,    Tactical_Soldier,    nil,    nil,    {"TE_ThugBoss_Stronger"},         AI_GearEquip)
    TE_AI_Major("ThugBoss_Foreman",                  Sentinel_Proto,    2,    Tactical_Soldier,    nil,    nil,    nil,                              AI_GearEquip)
	
    --Army
    local Army_1 = {
        PlaceObj('AppearanceWeight', { 'Preset', "Tactical_Army_E1", }),
    }
    local Army_2 = {
        PlaceObj('AppearanceWeight', { 'Preset', "GrandChien_CommanderFemale", }),
    }
    TE_AI_Major("ArmyScout",                         Vanguard_Proto,    2,    Tactical_Stormer,    nil,       nil,    {"TE_ArmyScout"},        AI_GearEquip)
    TE_AI_Major("ArmyStormer",                       Vanguard_Proto,    2,    Tactical_Stormer,    nil,       nil,    {"TE_ArmyStormer"},      AI_GearEquip)
    TE_AI_Major("ArmyDemo",                          Vanguard_Proto,    2,    Tactical_Stormer,    nil,       nil,    {"TE_ArmyDemo"},         AI_GearEquip)
    TE_AI_Major("ArmyDemo_Elite",                    Vanguard_Proto,    2,    Tactical_Stormer,    nil,       nil,    {"TE_ArmyDemo"},         AI_GearEquip)
    TE_AI_Major("ArmyMedic",                         Vanguard_Proto,    2,    Tactical_Stormer,    nil,       nil,    {"TE_ArmyMedic"},        AI_GearEquip)
    TE_AI_Major("ArmySniper",                        Sentinel_Proto,    2,    Tactical_Sniper,     nil,       nil,    {"TE_ArmySniper"},       AI_GearEquip)
    TE_AI_Major("ArmySniper_Elite",                  Sentinel_Proto,    2,    Tactical_Sniper,     nil,       nil,    {"TE_ArmySniper"},       AI_GearEquip)
    TE_AI_Major("ArmyHeavy",                         Sentinel_Proto,    2,    Tactical_Soldier,    nil,       nil,    {"TE_ArmyHeavy"},        AI_GearEquip)
    TE_AI_Major("ArmyRPG",                           Adept_Proto,       2,    Tactical_Soldier,    nil,       nil,    {"TE_ArmyRPG"},          AI_GearEquip)
    TE_AI_Major("ArmyMortar",                        Adept_Proto,       2,    Tactical_Soldier,    nil,       nil,    {"TE_ArmyMortar"},       AI_GearEquip)
    TE_AI_Major("ArmySoldier",                       Sentinel_Proto,    2,    Tactical_Soldier,    nil,       nil,    {"TE_ArmySoldier"},      AI_GearEquip)
    TE_AI_Major("ArmyCommander",                     Sentinel_Proto,    2,    Tactical_Soldier,    Army_1,    nil,    {"TE_ArmyCommander"},    AI_GearEquip)
    TE_AI_Major("ArmyCommander_Elite",               Sentinel_Proto,    2,    Tactical_Soldier,    Army_1,    nil,    {"TE_ArmyCommander"},    AI_GearEquip)
    TE_AI_Major("ArmyCommanderFemale",               Sentinel_Proto,    2,    Tactical_Soldier,    Army_2,    nil,    nil,                     AI_GearEquip)
	
    --Adonis
    local Adonis_1 = {
        PlaceObj('AppearanceWeight', { 'Preset', "Tactical_Adonis_A1", }),
    }
    local Adonis_2 = {
        PlaceObj('AppearanceWeight', { 'Preset', "Tactical_Adonis_E1", }),
        PlaceObj('AppearanceWeight', { 'Preset', "Tactical_Adonis_E2", }),
    }
    TE_AI_Major("AdonisFlanker",                     Vanguard_Proto,    2,    Tactical_Stormer,    nil,         nil,    {"TE_AdonisFlanker"},          AI_GearEquip)
    TE_AI_Major("AdonisFlanker_Elite",               Vanguard_Proto,    2,    Tactical_Stormer,    nil,         nil,    {"TE_AdonisFlanker"},          AI_GearEquip)
    TE_AI_Major("AdonisStormer",                     Vanguard_Proto,    2,    Tactical_Stormer,    nil,         nil,    {"TE_AdonisStormer"},          AI_GearEquip)
    TE_AI_Major("AdonisStormer_Elite",               Vanguard_Proto,    2,    Tactical_Stormer,    nil,         nil,    {"TE_AdonisStormer"},          AI_GearEquip)
    TE_AI_Major("AdonisDemolitions",                 Vanguard_Proto,    2,    Tactical_Stormer,    nil,         nil,    {"TE_AdonisDemolitions"},      AI_GearEquip)
    TE_AI_Major("AdonisDemolitions_Elite",           Vanguard_Proto,    2,    Tactical_Stormer,    nil,         nil,    {"TE_AdonisDemolitions"},      AI_GearEquip)
    TE_AI_Major("AdonisMedic",                       Vanguard_Proto,    2,    Tactical_Stormer,    nil,         nil,    {"TE_AdonisMedic"},            AI_GearEquip)
    TE_AI_Major("AdonisSniper",                      Sentinel_Proto,    2,    Tactical_Sniper,     nil,         nil,    {"TE_AdonisSniper"},           AI_GearEquip)
    TE_AI_Major("AdonisSniper_Elite",                Sentinel_Proto,    2,    Tactical_Sniper,     nil,         nil,    {"TE_AdonisSniper"},           AI_GearEquip)
    TE_AI_Major("AdonisHeavy",                       Sentinel_Proto,    2,    Tactical_Soldier,    nil,         nil,    {"TE_AdonisHeavy"},            AI_GearEquip)
    TE_AI_Major("AdonisMortar",                      Adept_Proto,       2,    Tactical_Soldier,    nil,         nil,    {"TE_AdonisMortar"},           AI_GearEquip)
    TE_AI_Major("AdonisAssault",                     Sentinel_Proto,    2,    Tactical_Soldier,    Adonis_1,    nil,    {"TE_AdonisAssault"},          AI_GearEquip)
    TE_AI_Major("AdonisAssault_Elite",               Sentinel_Proto,    2,    Tactical_Soldier,    Adonis_1,    nil,    {"TE_AdonisAssault_Elite"},    AI_GearEquip)
    TE_AI_Major("AdonisDedicatedGunner_Elite",       Sentinel_Proto,    2,    Tactical_Soldier,    Adonis_1,    nil,    {"TE_AdonisAssault_Elite"},    AI_GearEquip)
    TE_AI_Major("AdonisSquadLeader",                 Sentinel_Proto,    2,    Tactical_Soldier,    Adonis_2,    nil,    {"TE_AdonisSquadLeader"},      AI_GearEquip)
    TE_AI_Major("AdonisSquadLeader_Elite",           Sentinel_Proto,    2,    Tactical_Soldier,    Adonis_2,    nil,    {"TE_AdonisSquadLeader"},      AI_GearEquip)
    TE_AI_Major("CorazonGuard",                      Sentinel_Proto,    2,    Tactical_Soldier,    Adonis_2,    nil,    {"TE_AdonisGuard"},            AI_GearEquip)
	
    --SiegfriedSuperSoldiers
    TE_AI_Major("SuperSoldier_Linebreaker",          Warrior_Proto,     3,    Tactical_Super,      nil,    nil,    {"TE_SuperSoldier_Linebreaker"},             AI_GearEquip)
    TE_AI_Major("SuperSoldier_Linebreaker_Stronger", Warrior_Proto,     3,    Tactical_Super,      nil,    nil,    {"TE_SuperSoldier_Linebreaker_Stronger"},    AI_GearEquip)
    TE_AI_Major("SuperSoldier_Skirmisher",           Vanguard_Proto,    2,    Tactical_Super,      nil,    nil,    {"TE_SuperSoldier_Skirmisher"},              AI_GearEquip)
    TE_AI_Major("SuperSoldier_Skirmisher_Stronger",  Vanguard_Proto,    2,    Tactical_Super,      nil,    nil,    {"TE_SuperSoldier_Skirmisher_Stronger"},     AI_GearEquip)
    TE_AI_Major("SuperSoldier_Stormer",              Vanguard_Proto,    2,    Tactical_Super,      nil,    nil,    {"TE_SuperSoldier_Stormer"},                 AI_GearEquip)
    TE_AI_Major("SuperSoldier_Stormer_Stronger",     Vanguard_Proto,    2,    Tactical_Super,      nil,    nil,    {"TE_SuperSoldier_Stormer_Stronger"},        AI_GearEquip)
    TE_AI_Major("SuperSoldier_Medic",                Vanguard_Proto,    2,    Tactical_Super,      nil,    nil,    {"TE_SuperSoldier_Medic"},                   AI_GearEquip)
    TE_AI_Major("SuperSoldier_EmplacementGunner",    Sentinel_Proto,    2,    Tactical_Super,      nil,    nil,    {"TE_SuperSoldier_Assault"},                 AI_GearEquip)
    TE_AI_Major("SuperSoldier_Assault",              Sentinel_Proto,    2,    Tactical_Super,      nil,    nil,    {"TE_SuperSoldier_Assault"},                 AI_GearEquip)
    TE_AI_Major("SuperSoldier_Assault_Stronger",     Sentinel_Proto,    2,    Tactical_Super,      nil,    nil,    {"TE_SuperSoldier_Assault_Stronger"},        AI_GearEquip)
    TE_AI_Major("SuperSoldier_Ordnance",             Sentinel_Proto,    2,    Tactical_Super,      nil,    nil,    {"TE_SuperSoldier_Ordnance"},                AI_GearEquip)
	
    --Other Combatants
    TE_AI_Major("Landsbach_SuperSoldier_Skirmisher", Vanguard_Proto,    2,    Tactical_Stormer,    nil,    nil,    {"TE_SuperSoldier_Skirmisher"},    AI_GearEquip)
    TE_AI_Major("Landsbach_SuperSoldier_Stormer",    Vanguard_Proto,    2,    Tactical_Stormer,    nil,    nil,    {"TE_SuperSoldier_Stormer"},       AI_GearEquip)
    TE_AI_Major("Landsbach_SuperSoldier_Assault",    Sentinel_Proto,    2,    Tactical_Soldier,    nil,    nil,    {"TE_SuperSoldier_Assault"},       AI_GearEquip)
    TE_AI_Major("Landsbach_Thug_Diesel",             Sentinel_Proto,    2,    Tactical_Soldier,    nil,    nil,    {"TE_ThugEnforcer_Stronger"},      AI_GearEquip)
    TE_AI_Major("Landsbach_Thug",                    Sentinel_Proto,    2,    Tactical_Soldier,    nil,    nil,    {"TE_ThugEnforcer_Stronger"},      AI_GearEquip)
    TE_AI_Major("Freebooter",                        Sentinel_Proto,    2,    Tactical_Soldier,    nil,    nil,    {"TE_ArmySoldier"},                AI_GearEquip)
    TE_AI_Major("MERCSurvivor",                      Sentinel_Proto,    2,    Tactical_Soldier,    nil,    nil,    nil,                               AI_GearEquip)
	
    --Rebel
    TE_AI_Major("RebelFlanker",                      Vanguard_Proto,    2,    Tactical_Stormer,    nil,    nil,    {"TE_RebelFlanker"},      AI_GearEquip)
    TE_AI_Major("RebelGrenadier",                    Vanguard_Proto,    2,    Tactical_Stormer,    nil,    nil,    {"TE_RebelGrenadier"},    AI_GearEquip)
    TE_AI_Major("RebelSniper",                       Sentinel_Proto,    2,    Tactical_Sniper,     nil,    nil,    {"TE_AdonisGuard"},       AI_GearEquip)
    TE_AI_Major("RebelSniper_female",                Sentinel_Proto,    2,    Tactical_Sniper,     nil,    nil,    {"TE_AdonisGuard"},       AI_GearEquip)
    TE_AI_Major("RebelGunner",                       Sentinel_Proto,    2,    Tactical_Soldier,    nil,    nil,    {"TE_RebelGunner"},       AI_GearEquip)
    TE_AI_Major("RebelSentry",                       Sentinel_Proto,    2,    Tactical_Soldier,    nil,    nil,    {"TE_RebelSentry"},       AI_GearEquip)
    TE_AI_Major("RebelSoldier",                      Sentinel_Proto,    2,    Tactical_Soldier,    nil,    nil,    {"TE_RebelSoldier"},      AI_GearEquip)
	
    -- Minion & Militia
	TE_AI_Minion("LegionRaider_WeakFlagHill",        Vanguard_Proto,    2,    {"TutorialMinion"})
	TE_AI_Minion("Bonecrusher",                      nil,               3,    {"TutorialMinion", "ColdHeart", "Berserker", "BloodScent", "BeefedUp", "OptimalPerformance"})
--	TE_AI_Minion("MilitiaRookie",                    Vanguard_Proto,    2,    nil)
--	TE_AI_Minion("MilitiaVeteran",                   Sentinel_Proto,    2,    nil)
--	TE_AI_Minion("MilitiaElite",                     Sentinel_Proto,    3,    nil)
	
end

local function gen_AIArchetype()
    --Adept (RocketLauncher)
	PlaceObj('AIArchetype', {
	BaseMovementWeight = 10,
	Behaviors = {
		PlaceObj('StandardAI', {
			'EndTurnPolicies', {
				PlaceObj('AIPolicyDealDamage', nil),
		        PlaceObj('AIPolicyTakeCover', nil),
			},
			'TakeCoverChance', 0,
		}),
	},
	Comment = "Keywords: Soldier, Control, Smoke, Ordnance, Explosives",
	MoveStance = "Standing",
	OptLocPolicies = {
		PlaceObj('AIPolicyHighGround', {
			'Weight', 300,
		}),
		PlaceObj('AIPolicyWeaponRange', {
			'RangeBase', "Absolute",
			'RangeMin', 25,
			'RangeMax', 50,
		}),
		PlaceObj('AIPolicyTakeCover', nil),
	},
	OptLocSearchRadius = 100,
	PrefStance = "Standing",
	SignatureActions = {
		PlaceObj('AIActionHeavyWeaponAttack', {
			'BiasId', "RocketFire",
			'Weight', 200,
			'OnActivationBiases', {
				PlaceObj('AIBiasModification', {
					'BiasId', "RocketFire",
					'Effect', "disable",
				}),
			},
			'team_score', 0,
			'min_score', 0,
			'self_score_mod', -1000,
			'MinDist', 8000,
			'action_id', "RocketLauncherFire",
		}),
		PlaceObj('AIActionThrowGrenade', {
			'BiasId', "WildThrowGrenade",
			'Weight', 300,
			'Priority', true,
			'OnActivationBiases', {
				PlaceObj('AIBiasModification', {
					'BiasId', "WildThrowGrenade",
					'Effect', "disable",
					'Value', -300,
					'Period', 0,
				}),
			},
			'team_score', 0,
			'min_score', 0,
			'self_score_mod', -1000,
			'MinDist', 4000,
			'AllowedAoeTypes', set( "fire", "none", "teargas", "toxicgas" ),
		}),
		PlaceObj('AIActionHeavyWeaponAttack', {
			'BiasId', "PierreGuardLauncherFire",
			'Weight', 200,
			'OnActivationBiases', {
				PlaceObj('AIBiasModification', {
					'BiasId', "PierreGuardLauncherFire",
					'Effect', "disable",
				}),
			},
			'team_score', 0,
			'min_score', 0,
			'self_score_mod', -1000,
			'MinDist', 4000,
		}),
	},
	TargetScoreRandomization = 10,
	TargetingPolicies = {
		PlaceObj('AITargetingEnemyHealth', {
			'Health', 50,
			'AboveHealth', true,
		}),
		PlaceObj('AITargetingEnemyWeapon', {
			'EnemyWeapon', "Sniper",
		}),
		PlaceObj('AITargetingEnemyWeapon', {
			'EnemyWeapon', "MachineGun",
		}),
		PlaceObj('AITargetingEnemyWeapon', {
			'EnemyWeapon', "HeavyWeapon",
		}),
	},
	group = "Tactician_Enhanced",
	id = "AdeptRPG_Archetype",
	})
	
    --Adept (Mortar)
	PlaceObj('AIArchetype', {
	BaseMovementWeight = 10,
	Behaviors = {
		PlaceObj('StandardAI', {
			'EndTurnPolicies', {
				PlaceObj('AIPolicyDealDamage', {
						'CheckLOS', false,
				}),
		        PlaceObj('AIPolicyTakeCover', nil),
			},
			'TakeCoverChance', 0,
		}),
	},
	Comment = "Keywords: Soldier, Control, Smoke, Ordnance, Explosives",
	MoveStance = "Standing",
	OptLocPolicies = {
		PlaceObj('AIPolicyWeaponRange', {
			'RangeBase', "Absolute",
			'RangeMin', 25,
			'RangeMax', 70,
		}),
		PlaceObj('AIPolicyTakeCover', nil),
	},
	OptLocSearchRadius = 100,
	PrefStance = "Standing",
	SignatureActions = {
		PlaceObj('AIActionHeavyWeaponAttack', {
			'BiasId', "MortarShot",
			'Weight', 200,
			'OnActivationBiases', {
				PlaceObj('AIBiasModification', {
					'BiasId', "MortarShot",
					'Effect', "disable",
				}),
			},
			'team_score', 0,
			'min_score', 0,
			'self_score_mod', -1000,
			'MinDist', 8000,
			'action_id', "Bombard",
		}),
		PlaceObj('AIActionThrowGrenade', {
			'BiasId', "WildThrowGrenade",
			'Weight', 300,
			'Priority', true,
			'OnActivationBiases', {
				PlaceObj('AIBiasModification', {
					'BiasId', "WildThrowGrenade",
					'Effect', "disable",
					'Value', -300,
					'Period', 0,
				}),
			},
			'team_score', 0,
			'min_score', 0,
			'self_score_mod', -1000,
			'MinDist', 4000,
			'AllowedAoeTypes', set( "fire", "none", "teargas", "toxicgas" ),
		}),
		PlaceObj('AIActionHeavyWeaponAttack', {
			'BiasId', "PierreGuardLauncherFire",
			'Weight', 200,
			'OnActivationBiases', {
				PlaceObj('AIBiasModification', {
					'BiasId', "PierreGuardLauncherFire",
					'Effect', "disable",
				}),
			},
			'team_score', 0,
			'min_score', 0,
			'self_score_mod', -1000,
			'MinDist', 4000,
		}),
	},
	TargetScoreRandomization = 10,
	TargetingPolicies = {
		PlaceObj('AITargetingEnemyHealth', {
			'Health', 50,
			'AboveHealth', true,
		}),
		PlaceObj('AITargetingEnemyWeapon', {
			'EnemyWeapon', "Sniper",
		}),
		PlaceObj('AITargetingEnemyWeapon', {
			'EnemyWeapon', "MachineGun",
		}),
		PlaceObj('AITargetingEnemyWeapon', {
			'EnemyWeapon', "HeavyWeapon",
		}),
	},
	group = "Tactician_Enhanced",
	id = "AdeptMortar_Archetype",
	})
	
	--Sentinel (DedicatedGunner)
	PlaceObj('AIArchetype', {
	BaseAttackTargeting = set( "Arms", "BlindFire", "Groin", "Head", "InCover", "Legs", "Torso", "Trap" ),
	BaseMovementWeight = 10,
	Behaviors = {
		PlaceObj('StandardAI', {
			'BiasId', "Standard",
			'Weight', 150,
			'EndTurnPolicies', {
		        PlaceObj('AIPolicyTakeCover', nil),
				PlaceObj('AIPolicyDealDamage', nil),
			},
			'TakeCoverChance', 0,
		}),
	},
	Comment = "Keywords: Soldier, Control, Smoke, Ordnance, Explosives",
	MoveStance = "Crouch",
	OptLocPolicies = {
		PlaceObj('AIPolicyHighGround', {
			'Weight', 300,
		}),
		PlaceObj('AIPolicyWeaponRange', {
			'Weight', 150,
			'RangeBase', "Absolute",
			'RangeMin', 20,
			'RangeMax', 40,
		}),
		PlaceObj('AIPolicyTakeCover', nil),
	},
	OptLocSearchRadius = 100,
	PrefStance = "Prone",
	SignatureActions = {
		PlaceObj('AIAttackSingleTarget', {
			'BiasId', "Autofire",
			'Weight', 70,
			'OnActivationBiases', {
				PlaceObj('AIBiasModification', {
					'BiasId', "Autofire",
					'Value', -500,
					'Period', 2,
				}),
			},
			'NotificationText', "",
			'action_id', "AutoFire",
			'Aiming', "Maximum",
			'AttackTargeting', set( "Arms", "BlindFire", "Groin", "Head", "InCover", "Legs", "Torso", "Trap" ),
		}),
		PlaceObj('AIActionThrowGrenade', {
			'BiasId', "WildThrowGrenade",
			'Weight', 300,
			'Priority', true,
			'OnActivationBiases', {
				PlaceObj('AIBiasModification', {
					'BiasId', "WildThrowGrenade",
					'Effect', "disable",
					'Value', -300,
					'Period', 0,
				}),
			},
			'team_score', 0,
			'min_score', 0,
			'self_score_mod', -1000,
			'MinDist', 4000,
			'AllowedAoeTypes', set( "fire", "none", "teargas", "toxicgas" ),
		}),
		PlaceObj('AIActionHeavyWeaponAttack', {
			'BiasId', "PierreGuardLauncherFire",
			'Weight', 200,
			'OnActivationBiases', {
				PlaceObj('AIBiasModification', {
					'BiasId', "PierreGuardLauncherFire",
					'Effect', "disable",
				}),
			},
			'team_score', 0,
			'min_score', 0,
			'self_score_mod', -1000,
			'MinDist', 4000,
		}),
	},
	TargetScoreRandomization = 10,
	TargetingPolicies = {
		PlaceObj('AITargetingEnemyHealth', {
			'Health', 50,
		}),
		PlaceObj('AITargetingEnemyWeapon', {
			'EnemyWeapon', "MeleeWeapon",
		}),
		PlaceObj('AITargetingEnemyWeapon', {
			'EnemyWeapon', "Handgun",
		}),
		PlaceObj('AITargetingEnemyWeapon', {
			'EnemyWeapon', "SMG",
		}),
		PlaceObj('AITargetingEnemyWeapon', {
			'EnemyWeapon', "Shotgun",
		}),
	},
	group = "Tactician_Enhanced",
	id = "SentinelAR_Archetype",
	})
	
	--Sentinel (Sniper)
	PlaceObj('AIArchetype', {
	BaseAttackTargeting = set( "Arms", "BlindFire", "Groin", "Head", "InCover", "Legs", "Torso", "Trap" ),
	BaseMovementWeight = 10,
	Behaviors = {
		PlaceObj('StandardAI', {
			'BiasId', "Standard",
			'Weight', 150,
			'EndTurnPolicies', {
		        PlaceObj('AIPolicyTakeCover', nil),
				PlaceObj('AIPolicyDealDamage', nil),
			},
			'TakeCoverChance', 0,
		}),
	},
	Comment = "Keywords: Sniper, Soldier, Smoke, Ordnance, Explosives",
	MoveStance = "Crouch",
	OptLocPolicies = {
		PlaceObj('AIPolicyHighGround', {
			'Weight', 500,
		}),
		PlaceObj('AIPolicyWeaponRange', {
			'Weight', 150,
			'RangeBase', "Absolute",
			'RangeMin', 30,
			'RangeMax', 60,
		}),
		PlaceObj('AIPolicyTakeCover', nil),
	},
	OptLocSearchRadius = 100,
	PrefStance = "Prone",
	SignatureActions = {
		PlaceObj('AIActionPinDown', {
			'BiasId', "PinDownAttack",
			'Weight', 80,
			'OnActivationBiases', {
				PlaceObj('AIBiasModification', {
					'BiasId', "PinDownAttack",
					'Value', -50,
					'ApplyTo', "Team",
				}),
			},
		}),
		PlaceObj('AIActionThrowGrenade', {
			'BiasId', "WildThrowGrenade",
			'Weight', 300,
			'Priority', true,
			'OnActivationBiases', {
				PlaceObj('AIBiasModification', {
					'BiasId', "WildThrowGrenade",
					'Effect', "disable",
					'Value', -300,
					'Period', 0,
				}),
			},
			'team_score', 0,
			'min_score', 0,
			'self_score_mod', -1000,
			'MinDist', 4000,
			'AllowedAoeTypes', set( "fire", "none", "teargas", "toxicgas" ),
		}),
		PlaceObj('AIActionHeavyWeaponAttack', {
			'BiasId', "PierreGuardLauncherFire",
			'Weight', 200,
			'OnActivationBiases', {
				PlaceObj('AIBiasModification', {
					'BiasId', "PierreGuardLauncherFire",
					'Effect', "disable",
				}),
			},
			'team_score', 0,
			'min_score', 0,
			'self_score_mod', -1000,
			'MinDist', 4000,
		}),
	},
	TargetScoreRandomization = 10,
	TargetingPolicies = {
		PlaceObj('AITargetingEnemyHealth', {
			'Health', 50,
		}),
		PlaceObj('AITargetingEnemyWeapon', {
			'EnemyWeapon', "Sniper",
		}),
		PlaceObj('AITargetingEnemyWeapon', {
			'EnemyWeapon', "MachineGun",
		}),
		PlaceObj('AITargetingEnemyWeapon', {
			'EnemyWeapon', "HeavyWeapon",
		}),
	},
	group = "Tactician_Enhanced",
	id = "SentinelSR_Archetype",
	})
	
	--Sentinel (LMG)
	PlaceObj('AIArchetype', {
	BaseAttackTargeting = set( "Arms", "BlindFire", "Groin", "Head", "InCover", "Legs", "Torso", "Trap" ),
	BaseMovementWeight = 10,
	Behaviors = {
		PlaceObj('StandardAI', {
			'BiasId', "Standard",
			'Weight', 150,
			'EndTurnPolicies', {
		        PlaceObj('AIPolicyTakeCover', nil),
				PlaceObj('AIPolicyDealDamage', nil),
			},
			'TakeCoverChance', 0,
		}),
	},
	Comment = "Keywords: Soldier, Control, Smoke, Ordnance, Explosives",
	MoveStance = "Crouch",
	OptLocPolicies = {
		PlaceObj('AIPolicyHighGround', {
			'Weight', 200,
		}),
		PlaceObj('AIPolicyWeaponRange', {
			'Weight', 150,
			'RangeBase', "Absolute",
			'RangeMin', 25,
			'RangeMax', 50,
		}),
		PlaceObj('AIPolicyTakeCover', nil),
	},
	OptLocSearchRadius = 100,
	PrefStance = "Prone",
	SignatureActions = {
		PlaceObj('AIActionMGSetup', {
			'Weight', 200,
			'team_score', 0,
			'min_score', 100,
			'cur_zone_mod', 140,
		}),
		PlaceObj('AIActionThrowGrenade', {
			'BiasId', "WildThrowGrenade",
			'Weight', 300,
			'Priority', true,
			'OnActivationBiases', {
				PlaceObj('AIBiasModification', {
					'BiasId', "WildThrowGrenade",
					'Effect', "disable",
					'Value', -300,
					'Period', 0,
				}),
			},
			'team_score', 0,
			'min_score', 0,
			'self_score_mod', -1000,
			'MinDist', 4000,
			'AllowedAoeTypes', set( "fire", "none", "teargas", "toxicgas" ),
		}),
		PlaceObj('AIActionHeavyWeaponAttack', {
			'BiasId', "PierreGuardLauncherFire",
			'Weight', 200,
			'OnActivationBiases', {
				PlaceObj('AIBiasModification', {
					'BiasId', "PierreGuardLauncherFire",
					'Effect', "disable",
				}),
			},
			'team_score', 0,
			'min_score', 0,
			'self_score_mod', -1000,
			'MinDist', 4000,
		}),
	},
	TargetScoreRandomization = 10,
	TargetingPolicies = {
		PlaceObj('AITargetingEnemyHealth', {
			'Health', 50,
			'AboveHealth', true,
		}),
		PlaceObj('AITargetingEnemyWeapon', {
			'EnemyWeapon', "MeleeWeapon",
		}),
		PlaceObj('AITargetingEnemyWeapon', {
			'EnemyWeapon', "Handgun",
		}),
		PlaceObj('AITargetingEnemyWeapon', {
			'EnemyWeapon', "SMG",
		}),
		PlaceObj('AITargetingEnemyWeapon', {
			'EnemyWeapon', "Shotgun",
		}),
	},
	group = "Tactician_Enhanced",
	id = "SentinelMG_Archetype",
	})
	
	--Vanguard (Stormer)
	PlaceObj('AIArchetype', {
	BaseAttackTargeting = set( "Arms", "BlindFire", "Groin", "Head", "InCover", "Legs", "Neck", "Torso", "Trap" ),
	BaseMovementWeight = 10,
	Behaviors = {
		PlaceObj('StandardAI', {
			'Weight', 10,
			'EndTurnPolicies', {
		        PlaceObj('AIPolicyTakeCover', nil),
				PlaceObj('AIPolicyDealDamage', nil),
			},
			'TakeCoverChance', 0,
		}),
		PlaceObj('PositioningAI', {
			'BiasId', "Flanking",
			'Weight', 500,
			'Fallback', false,
			'OptLocWeight', 20,
			'EndTurnPolicies', {
				PlaceObj('AIPolicyFlanking', {
					'Weight', 1000,
					'Required', true,
					'ReserveAttackAP', true,
				}),
		        PlaceObj('AIPolicyTakeCover', nil),
				PlaceObj('AIPolicyDealDamage', nil),
			},
			'TakeCoverChance', 0,
			'VoiceResponse', "AIFlanking",
		}),
	},
	Comment = "Keywords: Flank, RunAndGun, Smoke, Ordnance, Explosives",
	MoveStance = "Crouch",
	OptLocPolicies = {
		PlaceObj('AIPolicyWeaponRange', {
			'RangeBase', "Absolute",
			'RangeMin', 2,
			'RangeMax', 8,
		}),
		PlaceObj('AIPolicyTakeCover', nil),
	},
	OptLocSearchRadius = 100,
	PrefStance = "Crouch",
	SignatureActions = {
		PlaceObj('AIActionCharge', {
			'BiasId', "PierreCharge",
			'Weight', 300,
			'Priority', true,
			'DestPreference', "nearest",
		}),
		PlaceObj('AIActionMobileShot', {
			'Weight', 200,
			'NotificationText', "",
			'action_id', "RunAndGun",
		}),
		PlaceObj('AIActionThrowGrenade', {
			'BiasId', "WildThrowGrenade",
			'Weight', 300,
			'Priority', true,
			'OnActivationBiases', {
				PlaceObj('AIBiasModification', {
					'BiasId', "WildThrowGrenade",
					'Effect', "disable",
					'Value', -300,
					'Period', 0,
				}),
			},
			'team_score', 0,
			'min_score', 0,
			'self_score_mod', -1000,
			'MinDist', 4000,
			'AllowedAoeTypes', set( "fire", "none", "teargas", "toxicgas" ),
		}),
		PlaceObj('AIActionHeavyWeaponAttack', {
			'BiasId', "PierreGuardLauncherFire",
			'Weight', 200,
			'OnActivationBiases', {
				PlaceObj('AIBiasModification', {
					'BiasId', "PierreGuardLauncherFire",
					'Effect', "disable",
				}),
			},
			'team_score', 0,
			'min_score', 0,
			'self_score_mod', -1000,
			'MinDist', 4000,
		}),
	},
	TargetScoreRandomization = 10,
	TargetingPolicies = {
		PlaceObj('AITargetingEnemyHealth', {
			'Health', 50,
		}),
		PlaceObj('AITargetingEnemyWeapon', {
			'EnemyWeapon', "MeleeWeapon",
		}),
		PlaceObj('AITargetingEnemyWeapon', {
			'EnemyWeapon', "Handgun",
		}),
		PlaceObj('AITargetingEnemyWeapon', {
			'EnemyWeapon', "SMG",
		}),
		PlaceObj('AITargetingEnemyWeapon', {
			'EnemyWeapon', "Shotgun",
		}),
	},
	group = "Tactician_Enhanced",
	id = "Vanguard_Archetype",
	})
	
	--Warrior (Brute)
	PlaceObj('AIArchetype', {
	BaseAttackTargeting = set( "Arms", "Groin", "Head", "Neck", "Torso" ),
	BaseMovementWeight = 10,
	Behaviors = {
		PlaceObj('StandardAI', {
			'BiasId', "Standard",
			'EndTurnPolicies', {
		        PlaceObj('AIPolicyTakeCover', nil),
				PlaceObj('AIPolicyDealDamage', nil),
			},
			'TakeCoverChance', 0,
		}),
	},
	Comment = "Keywords: Nova, RunAndGun, Smoke, Ordnance, Explosives",
	MoveStance = "Standing",
	OptLocPolicies = {
		PlaceObj('AIPolicyWeaponRange', {
			'RangeBase', "Melee",
			'RangeMin', 0,
			'RangeMax', 6,
		}),
		PlaceObj('AIPolicyTakeCover', nil),
		PlaceObj('AIPolicyLosToEnemy', nil),
	},
	OptLocSearchRadius = 100,
	PrefStance = "Standing",
	SignatureActions = {
		PlaceObj('AIActionCharge', {
			'BiasId', "PierreCharge",
			'Weight', 300,
			'Priority', true,
			'DestPreference', "nearest",
		}),
		PlaceObj('AIActionMobileShot', {
			'Weight', 200,
			'NotificationText', "",
			'action_id', "RunAndGun",
		}),
		PlaceObj('AIActionThrowGrenade', {
			'BiasId', "WildThrowGrenade",
			'Weight', 300,
			'Priority', true,
			'OnActivationBiases', {
				PlaceObj('AIBiasModification', {
					'BiasId', "WildThrowGrenade",
					'Effect', "disable",
					'Value', -300,
					'Period', 0,
				}),
			},
			'team_score', 0,
			'min_score', 0,
			'self_score_mod', -1000,
			'MinDist', 4000,
			'AllowedAoeTypes', set( "fire", "none", "teargas", "toxicgas" ),
		}),
		PlaceObj('AIActionHeavyWeaponAttack', {
			'BiasId', "PierreGuardLauncherFire",
			'Weight', 200,
			'OnActivationBiases', {
				PlaceObj('AIBiasModification', {
					'BiasId', "PierreGuardLauncherFire",
					'Effect', "disable",
				}),
			},
			'team_score', 0,
			'min_score', 0,
			'self_score_mod', -1000,
			'MinDist', 4000,
		}),
	},
	TargetScoreRandomization = 10,
	TargetingPolicies = {
		PlaceObj('AITargetingEnemyHealth', {
			'Health', 50,
		}),
		PlaceObj('AITargetingEnemyWeapon', {
			'EnemyWeapon', "MeleeWeapon",
		}),
		PlaceObj('AITargetingEnemyWeapon', {
			'EnemyWeapon', "Handgun",
		}),
		PlaceObj('AITargetingEnemyWeapon', {
			'EnemyWeapon', "SMG",
		}),
		PlaceObj('AITargetingEnemyWeapon', {
			'EnemyWeapon', "Shotgun",
		}),
	},
	group = "Tactician_Enhanced",
	id = "Warrior_Archetype",
	})
	
	--Reconnaissance (Scouting)
	PlaceObj('AIArchetype', {
	Behaviors = {
		PlaceObj('StandardAI', {
			'EndTurnPolicies', {
		        PlaceObj('AIPolicyTakeCover', nil),
				PlaceObj('AIPolicyDealDamage', nil),
			},
			'TakeCoverChance', 0,
		}),
	},
	Comment = "used to advance toward last known enemy location",
	MoveStance = "Crouch",
	OptLocPolicies = {
		PlaceObj('AIPolicyWeaponRange', {
			'RangeBase', "Absolute",
			'RangeMin', 8,
			'RangeMax', 16,
		}),
		PlaceObj('AIPolicyTakeCover', nil),
		PlaceObj('AIPolicyLastEnemyPos', nil),
	},
	OptLocSearchRadius = 100,
	PrefStance = "Crouch",
	FallbackAction = "overwatch",
	group = "Tactician_Enhanced",
	id = "ReconnaissanceScouter_Archetype",
	})
	
	--Reconnaissance (Hunting)
	PlaceObj('AIArchetype', {
	Behaviors = {
		PlaceObj('StandardAI', {
			'EndTurnPolicies', {
		        PlaceObj('AIPolicyTakeCover', nil),
				PlaceObj('AIPolicyDealDamage', nil),
			},
			'TakeCoverChance', 0,
		}),
	},
	Comment = "used to advance toward last known enemy location",
	MoveStance = "Crouch",
	OptLocPolicies = {
		PlaceObj('AIPolicyWeaponRange', {
			'RangeBase', "Absolute",
			'RangeMin', 20,
			'RangeMax', 40,
		}),
		PlaceObj('AIPolicyTakeCover', nil),
		PlaceObj('AIPolicyLastEnemyPos', nil),
	},
	OptLocSearchRadius = 100,
	PrefStance = "Crouch",
	FallbackAction = "overwatch",
	group = "Tactician_Enhanced",
	id = "ReconnaissanceHunter_Archetype",
	})
end

-- ========== TE AIArchetype Overhaul End ==========


-- ========== TE AIArtillery Fire Support Begin ==========

--AIArtillery Notification
PlaceObj('TacticalNotification', {
	SortKey = -9000,
	combatLog = true,
	combatLogType = "important",
	id = "ArtilleryCalling",
	style = "yellow",
	text = T(3042581131200000, 'Enemy signaller is calling for artillery strike!'),
	duration = 5000,
})

--AIArtillery Zeroing
function Unit:TE_AIArtilleryCall(pos, radius, ordnance)
	local time
	if not g_Combat then time = 5000 end
	
	local shots = math.random(3, 5)
	local zonepos = pos:SetTerrainZ()
	local zone = PlaceObject("BombardZone")
	zone.attacker = self
	zone:Setup(zonepos, radius, self.team.side, ordnance, shots, time)

	Sleep(const.Combat.BombardSetupHoldTime)
end

--AIArtillery Bombard
function Unit:TE_AIArtilleryStrike(target)
	if not g_Combat or GameState.Underground or (self:HasStatusEffect("Surprised") or self:HasStatusEffect("TutorialMinion") or target:HasStatusEffect("ArtilleryRetaliationCounter")) then return end
	
	local pos = target:GetPos() + Rotate(point(InteractionRand(5*guim), 0, 0, InteractionRand(360*60)))
	local radius = 3
	local ordnance

	if not target.indoor then
		ordnance = "Warhead_Frag"
	end
	target:AddStatusEffect("ArtilleryRetaliationCounter")
	ShowTacticalNotification('ArtilleryCalling')
	self:TE_AIArtilleryCall(pos, radius, ordnance)
end

-- ========== TE AIArtillery Fire Support End ==========


-- ========== TE AI-SmokeCover Gas Support Begin ==========

--SmokeCover GasPos
function TE_GasPosClose(nearUnit, distTile, toFace)
	nearUnit = nearUnit or GetTerrainCursorXY(UIL.GetScreenSize() / 2)
	distTile = distTile or 1

	local dirFlag = toFace and 1 or -1
	local dist = const.SlabSizeX * distTile * 1.5
	
	local startPos, direction
	if IsKindOf(nearUnit, "Unit") then
		startPos = GetClosestExitZoneInteractable(nearUnit)
		direction = Rotate(point(const.SlabSizeX, 0), nearUnit:GetAngle())
	else
		startPos = nearUnit
		direction = Rotate(point(const.SlabSizeX, 0), AsyncRand(60 * 360))
	end
	
	local pt = startPos + SetLen(direction, dist) * dirFlag
	local freePoint = DbgFindFreePassPositions(pt, 1, 10, xxhash(pt))
	while not next(freePoint) do
		freePoint = DbgFindFreePassPositions(pt, 1, 10, xxhash(pt))
	end
	
	return freePoint[1]
end

--SmokeCover Propagated
function Unit:TE_SmokePropagated(gas, pos)
	if (not pos or not (IsPoint(pos) or IsValidPos(pos))) or (not gas or gas <= 0) then return end
	
    local positions = {}
    for i = 1, gas do
        local spawnPos = TE_GasPosClose(pos, 2, false)
        table.insert(positions, spawnPos)
    end

    for i = 1, #positions do
		CreateGameTimeThread(function()
        	local zone = SmokeZone:new{smoke_dx = 0.8, smoke_dy = 0.8, remaining_time = 10000, gas_type = 'smoke'}
        	zone:SetPos(positions[i])
        	zone:PropagateSmoke()
        	Sleep(1000)
		end)
        Sleep(500)
    end
end

--SmokeCover Support
function Unit:TE_SmokeCover(target)
	if not g_Combat or (self:HasStatusEffect("Surprised") or self:HasStatusEffect("TutorialMinion") or target:HasStatusEffect("SmokeCoverCounter")) then return end
	
	local pos = target:GetPos()
	local gas = 1
	self:TE_SmokePropagated(gas, pos)
end

-- ========== TE AI-SmokeCover Gas Support End ==========


-- ========== GENERATED BY LootDef Editor (Ctrl-L) DO NOT EDIT MANUALLY! ==========

--Legion
PlaceObj('LootDef', {
	Comment = "enemy legion",
	group = "Enemy - Legion",
	id = "TE_LegionsExplosives",
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "HE_Grenade",
		stack_max = 5,
		stack_min = 5,
		weight = 5000,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "TimedPETN",
		stack_max = 5,
		stack_min = 5,
		weight = 2500,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "Molotov",
		stack_max = 5,
		stack_min = 5,
		weight = 1500,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "TearGasGrenade",
		stack_max = 5,
		stack_min = 5,
		weight = 1000,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "ToxicGasGrenade",
		stack_max = 5,
		stack_min = 5,
		weight = 500,
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy legion",
	group = "Enemy - Legion",
	id = "TE_LegionMeleeFighter",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 92,
		RandomizeCondition = true,
		drop_chance_mod = 0,
		item = "Machete_Sharpened",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "SmokeGrenade",
		stack_max = 5,
		stack_min = 5,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarHelmet",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarChestplate_CeramicPlates",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarLeggings",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_LegionsExplosives",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy legion",
	group = "Enemy - Legion",
	id = "TE_LegionMeleeFighter_Stronger",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 92,
		RandomizeCondition = true,
		drop_chance_mod = 0,
		item = "Machete_Sharpened",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "SmokeGrenade",
		stack_max = 5,
		stack_min = 5,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarHelmet_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarChestplate_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarLeggings_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_LegionsExplosives",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy legion",
	group = "Enemy - Legion",
	id = "TE_LegionMeleeFighter_Stronger_Elite",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 92,
		RandomizeCondition = true,
		drop_chance_mod = 0,
		item = "Machete_Sharpened",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "SmokeGrenade",
		stack_max = 5,
		stack_min = 5,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarHelmet_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "CamoArmor_Medium_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarLeggings_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_LegionsExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "EnemyValuables",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy legion",
	group = "Enemy - Legion",
	id = "TE_LegionHyena",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "HyenaJaws",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "CrocodileHide",
		stack_max = 1,
		stack_min = 1,
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy legion",
	group = "Enemy - Legion",
	id = "TE_LegionBrawler",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 92,
		RandomizeCondition = true,
		drop_chance_mod = 0,
		item = "Machete_Sharpened",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "SmokeGrenade",
		stack_max = 5,
		stack_min = 5,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "PostApoHelmet",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarChestplate_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarLeggings_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_LegionsExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "EnemyValuables",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy legion",
	group = "Enemy - Legion",
	id = "TE_LegionBerserker",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 92,
		RandomizeCondition = true,
		item = "Auto5",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "SmokeGrenade",
		stack_max = 5,
		stack_min = 5,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "PostApoHelmet",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarChestplate_CeramicPlates",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarLeggings",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_LegionsExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_12gauge_Varied_Legion",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy legion",
	group = "Enemy - Legion",
	id = "TE_LegionBerserker_Stronger",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 92,
		RandomizeCondition = true,
		item = "Auto5",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "SmokeGrenade",
		stack_max = 5,
		stack_min = 5,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "PostApoHelmet",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarChestplate_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarLeggings_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_LegionsExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_12gauge_Varied_Legion",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "EnemyValuables",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy legion",
	group = "Enemy - Legion",
	id = "TE_LegionBerserker_Stronger_Elite",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 92,
		RandomizeCondition = true,
		item = "Auto5",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "SmokeGrenade",
		stack_max = 5,
		stack_min = 5,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "PostApoHelmet",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarVest_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarLeggings_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_LegionsExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_12gauge_Varied_Legion",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "EnemyValuables",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy legion",
	group = "Enemy - Legion",
	id = "TE_LegionGoon",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 81,
		RandomizeCondition = true,
		item = "Bereta92",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "SmokeGrenade",
		stack_max = 5,
		stack_min = 5,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarHelmet",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarChestplate_CeramicPlates",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarLeggings",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_LegionsExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_9mm_Varied_Legion",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy legion",
	group = "Enemy - Legion",
	id = "TE_LegionGoon_Stronger",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 81,
		RandomizeCondition = true,
		item = "Bereta92",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "SmokeGrenade",
		stack_max = 5,
		stack_min = 5,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarHelmet_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarChestplate_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarLeggings_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_LegionsExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_9mm_Varied_Legion",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy legion",
	group = "Enemy - Legion",
	id = "TE_LegionGoon_Stronger_Elite",
	loot = "all",
	PlaceObj('LootEntryUpgradedWeapon', {
		Condition = 81,
		RandomizeCondition = true,
		upgrades = {
			"Compensator_Glock",
		},
		weapon = "Glock18",
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "SmokeGrenade",
		stack_max = 5,
		stack_min = 5,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarHelmet_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarVest_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarLeggings_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_LegionsExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_9mm_Varied_Legion",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "EnemyValuables",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy legion",
	group = "Enemy - Legion",
	id = "TE_LegionGrenadier",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 81,
		RandomizeCondition = true,
		item = "Auto5",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "SmokeGrenade",
		stack_max = 5,
		stack_min = 5,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarHelmet",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarChestplate_CeramicPlates",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarLeggings",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_LegionsExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_12gauge_Varied_Legion",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "ExplosiveComponents",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy legion",
	group = "Enemy - Legion",
	id = "TE_LegionGrenadier_Stronger",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 81,
		RandomizeCondition = true,
		item = "M41Shotgun",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "SmokeGrenade",
		stack_max = 5,
		stack_min = 5,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarHelmet_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarChestplate_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarLeggings_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_LegionsExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_12gauge_Varied_Legion",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "ExplosiveComponents",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy legion",
	group = "Enemy - Legion",
	id = "TE_LegionGrenadier_Stronger_Elite",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 81,
		RandomizeCondition = true,
		item = "M41Shotgun",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "SmokeGrenade",
		stack_max = 5,
		stack_min = 5,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarHelmet_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarVest_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarLeggings_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_LegionsExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_12gauge_Varied_Legion",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "ExplosiveComponents",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "EnemyValuables",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy legion",
	group = "Enemy - Legion",
	id = "TE_LegionGrenadier_Stronger_Elite_Molotov",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 81,
		RandomizeCondition = true,
		item = "M41Shotgun",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "SmokeGrenade",
		stack_max = 5,
		stack_min = 5,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarHelmet_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarVest_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarLeggings_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_LegionsExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_12gauge_Varied_Legion",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "ExplosiveComponents",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "EnemyValuables",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy legion",
	group = "Enemy - Legion",
	id = "TE_LegionGunner",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 81,
		RandomizeCondition = true,
		item = "MG42",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorHelmet",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorChestplate_CeramicPlates",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorLeggings",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_LegionsExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		amount_modifier = 2000000,
		loot_def = "Drop_762NATO_Varied_Legion",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy legion",
	group = "Enemy - Legion",
	id = "TE_LegionGunner_Stronger",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 81,
		RandomizeCondition = true,
		item = "FNMinimi",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorHelmet_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorTorso_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorLeggings_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_LegionsExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		amount_modifier = 2000000,
		loot_def = "Drop_556_Varied_Legion",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "EnemyValuables",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy legion",
	group = "Enemy - Legion",
	id = "TE_LegionMedic",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 80,
		RandomizeCondition = true,
		item = "MP5",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "Medkit",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "CombatStim",
		stack_max = 2,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "SmokeGrenade",
		stack_max = 5,
		stack_min = 5,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarHelmet",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarChestplate_CeramicPlates",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarLeggings",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_LegionsExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "MedsDrop",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_9mm_Varied_Legion",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy legion",
	group = "Enemy - Legion",
	id = "TE_LegionMedic_Stronger",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 80,
		RandomizeCondition = true,
		item = "MP5",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "Medkit",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "CombatStim",
		stack_max = 3,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "SmokeGrenade",
		stack_max = 5,
		stack_min = 5,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarHelmet_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarVest_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarLeggings_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_LegionsExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "MedsDrop",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_9mm_Varied_Legion",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy legion",
	group = "Enemy - Legion",
	id = "TE_LegionRocketeer",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 81,
		RandomizeCondition = true,
		item = "RPG7",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorHelmet",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorChestplate_CeramicPlates",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorLeggings",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_LegionsExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_Warhead",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy legion",
	group = "Enemy - Legion",
	id = "TE_LegionRocketeer_SlowReloader",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 81,
		RandomizeCondition = true,
		item = "RPG7",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorHelmet",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorChestplate_CeramicPlates",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorLeggings",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_LegionsExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_Warhead",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy legion",
	group = "Enemy - Legion",
	id = "TE_LegionRocketeer_Stronger",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 81,
		RandomizeCondition = true,
		item = "RPG7",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorHelmet_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorTorso_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorLeggings_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_LegionsExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_Warhead",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "EnemyValuables",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy legion",
	group = "Enemy - Legion",
	id = "TE_LegionMortarman",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 81,
		RandomizeCondition = true,
		item = "MortarInventoryItem",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorHelmet_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorTorso_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorLeggings_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_LegionsExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_MortarShell_HE",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy legion",
	group = "Enemy - Legion",
	id = "TE_LegionRaiders",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 83,
		RandomizeCondition = true,
		item = "FAMAS",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarHelmet",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarVest_CeramicPlates",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarLeggings",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_LegionsExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_762WP_Varied_Legion",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy legion",
	group = "Enemy - Legion",
	id = "TE_LegionRaider_Stronger",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 97,
		RandomizeCondition = true,
		item = "FNFAL",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarHelmet_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarVest_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarLeggings_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_LegionsExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_762NATO_Varied_Legion",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy legion",
	group = "Enemy - Legion",
	id = "TE_LegionRaider_Stronger_Elite",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 97,
		RandomizeCondition = true,
		item = "FNFAL",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarHelmet_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarVest_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarLeggings_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_LegionsExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_762NATO_Varied_Legion",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "EnemyValuables",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy legion",
	group = "Enemy - Legion",
	id = "TE_LegionScout",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 82,
		RandomizeCondition = true,
		item = "MP5",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "SmokeGrenade",
		stack_max = 5,
		stack_min = 5,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarHelmet",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarChestplate_CeramicPlates",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarLeggings",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_LegionsExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_9mm_Varied_Legion",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy legion",
	group = "Enemy - Legion",
	id = "TE_LegionScout_Stronger",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 82,
		RandomizeCondition = true,
		item = "M4Commando",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "SmokeGrenade",
		stack_max = 5,
		stack_min = 5,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarHelmet_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarChestplate_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarLeggings_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_LegionsExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_556_Varied_Legion",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy legion",
	group = "Enemy - Legion",
	id = "TE_LegionScout_Stronger_Elite",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 82,
		RandomizeCondition = true,
		item = "M4Commando",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "SmokeGrenade",
		stack_max = 5,
		stack_min = 5,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarHelmet_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "CamoArmor_Medium_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarLeggings_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_LegionsExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_556_Varied_Legion",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "EnemyValuables",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy legion",
	group = "Enemy - Legion",
	id = "TE_LegionSentry",
	loot = "all",
	PlaceObj('LootEntryUpgradedWeapon', {
		Condition = 85,
		RandomizeCondition = true,
		upgrades = {
			"ReflexSight",
		},
		weapon = "FAMAS",
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorHelmet",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorTorso_CeramicPlates",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorLeggings",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_556_Varied_Legion",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy legion",
	group = "Enemy - Legion",
	id = "TE_LegionSentry_Stronger",
	loot = "all",
	PlaceObj('LootEntryUpgradedWeapon', {
		Condition = 85,
		RandomizeCondition = true,
		upgrades = {
			"GrenadeLauncher_M16A1",
		},
		weapon = "M16A2",
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorHelmet_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorTorso_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorLeggings_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_LegionsExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_556_Varied_Legion",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "EnemyValuables",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy legion",
	group = "Enemy - Legion",
	id = "TE_LegionSentry_Stronger_Elite",
	loot = "all",
	PlaceObj('LootEntryUpgradedWeapon', {
		Condition = 85,
		RandomizeCondition = true,
		upgrades = {
			"GrenadeLauncher_Galil",
		},
		weapon = "Galil",
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorHelmet_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorTorso_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorLeggings_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_LegionsExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_40mm_Frag",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_762NATO_Varied_Legion",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "EnemyValuables",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy legion",
	group = "Enemy - Legion",
	id = "TE_LegionSniper",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 75,
		RandomizeCondition = true,
		item = "Gewehr98",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarHelmet",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "CamoArmor_Medium",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarLeggings",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_LegionsExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_762NATO_Varied_Legion",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy legion",
	group = "Enemy - Legion",
	id = "TE_LegionSniper_Stronger",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 92,
		RandomizeCondition = true,
		item = "M24Sniper",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarHelmet_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "CamoArmor_Medium",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarLeggings_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_LegionsExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_762NATO_Varied_Legion",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "EnemyValuables",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy legion",
	group = "Enemy - Legion",
	id = "TE_LegionSniper_Stronger_Elite",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 92,
		RandomizeCondition = true,
		item = "M24Sniper",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarHelmet_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "CamoArmor_Medium_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarLeggings_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_LegionsExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_762NATO_Varied_Legion",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "EnemyValuables",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy legion",
	group = "Enemy - Legion",
	id = "TE_PierreGuard",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 95,
		RandomizeCondition = true,
		item = "MG42",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorHelmet_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorTorso_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorLeggings_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_LegionsExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		amount_modifier = 2000000,
		loot_def = "Drop_762NATO_Varied_Legion",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy legion",
	group = "Enemy - Legion",
	id = "TE_PierreGuard_Ordnance",
	loot = "all",
	PlaceObj('LootEntryUpgradedWeapon', {
		Condition = 95,
		RandomizeCondition = true,
		upgrades = {
			"GrenadeLauncher_Galil",
		},
		weapon = "Galil",
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorHelmet_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorTorso_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorLeggings_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_LegionsExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_40mm_Frag",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_762NATO_Varied_Legion",
	}),
})

--Thugs
PlaceObj('LootDef', {
	Comment = "enemy thugs",
	group = "Enemy - Thugs",
	id = "TE_ThugsExplosives",
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "FragGrenade",
		stack_max = 5,
		stack_min = 5,
		weight = 5000,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "TimedTNT",
		stack_max = 5,
		stack_min = 5,
		weight = 2500,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "Molotov",
		stack_max = 5,
		stack_min = 5,
		weight = 1500,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "TearGasGrenade",
		stack_max = 5,
		stack_min = 5,
		weight = 1000,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "ToxicGasGrenade",
		stack_max = 5,
		stack_min = 5,
		weight = 500,
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy thugs boss",
	group = "Enemy - Thugs",
	id = "Jackhammer",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		guaranteed = true,
		item = "AA12",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "SmokeGrenade",
		stack_max = 5,
		stack_min = 5,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorHelmet_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorTorso_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorLeggings_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_ThugsExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		amount_modifier = 2000000,
		loot_def = "Drop_12gauge_Varied",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "EnemyValuables",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy thugs",
	group = "Enemy - Thugs",
	id = "TE_ThugBoss",
	loot = "all",
	PlaceObj('LootEntryUpgradedWeapon', {
		Condition = 86,
		RandomizeCondition = true,
		upgrades = {
			"GrenadeLauncher_M16A1",
		},
		weapon = "M16A2",
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorHelmet_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorTorso_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorLeggings_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_ThugsExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_40mm_Frag",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_556_Varied",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "EnemyValuables",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy thugs",
	group = "Enemy - Thugs",
	id = "TE_ThugBoss_Stronger",
	loot = "all",
	PlaceObj('LootEntryUpgradedWeapon', {
		Condition = 86,
		RandomizeCondition = true,
		upgrades = {
			"GrenadeLauncher_M16A1",
		},
		weapon = "M16A2",
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorHelmet_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorTorso_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorLeggings_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_ThugsExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_40mm_Frag",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_556_Varied",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "EnemyValuables",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy thugs",
	group = "Enemy - Thugs",
	id = "TE_ThugCutter",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 82,
		RandomizeCondition = true,
		drop_chance_mod = 0,
		item = "Machete_Sharpened",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "SmokeGrenade",
		stack_max = 5,
		stack_min = 5,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarHelmet_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarChestplate_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarLeggings_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_ThugsExplosives",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy thugs",
	group = "Enemy - Thugs",
	id = "TE_ThugCutter_Stronger",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 82,
		RandomizeCondition = true,
		drop_chance_mod = 0,
		item = "Machete_Sharpened",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "SmokeGrenade",
		stack_max = 5,
		stack_min = 5,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarHelmet_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "CamoArmor_Medium_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarLeggings_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_ThugsExplosives",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy thugs",
	group = "Enemy - Thugs",
	id = "TE_ThugEnforcer",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 68,
		RandomizeCondition = true,
		item = "AR15",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarHelmet_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarVest_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarLeggings_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_ThugsExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_556_Varied",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "EnemyValuables",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy thugs",
	group = "Enemy - Thugs",
	id = "TE_ThugEnforcer_Stronger",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 68,
		RandomizeCondition = true,
		item = "AR15",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarHelmet_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarVest_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarLeggings_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_ThugsExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_556_Varied",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "EnemyValuables",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy thugs",
	group = "Enemy - Thugs",
	id = "TE_ThugGoon",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 75,
		RandomizeCondition = true,
		item = "MP5K",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "SmokeGrenade",
		stack_max = 5,
		stack_min = 5,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarHelmet_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarChestplate_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarLeggings_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_ThugsExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_9mm_Varied",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy thugs",
	group = "Enemy - Thugs",
	id = "TE_ThugGoon_Stronger",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 75,
		RandomizeCondition = true,
		item = "MP5K",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "SmokeGrenade",
		stack_max = 5,
		stack_min = 5,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarHelmet_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarVest_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarLeggings_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_ThugsExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_9mm_Varied",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy thugs",
	group = "Enemy - Thugs",
	id = "TE_ThugGrenadier",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 77,
		RandomizeCondition = true,
		item = "M41Shotgun",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "SmokeGrenade",
		stack_max = 5,
		stack_min = 5,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarHelmet_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarChestplate_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarLeggings_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_ThugsExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_12gauge_Varied",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "ExplosiveComponents",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy thugs",
	group = "Enemy - Thugs",
	id = "TE_ThugGrenadier_Stronger",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 77,
		RandomizeCondition = true,
		item = "M41Shotgun",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "SmokeGrenade",
		stack_max = 5,
		stack_min = 5,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarHelmet_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarVest_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarLeggings_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_ThugsExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_12gauge_Varied",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "ExplosiveComponents",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "EnemyValuables",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy thugs",
	group = "Enemy - Thugs",
	id = "TE_ThugGunner",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 78,
		RandomizeCondition = true,
		item = "FNMinimi",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorHelmet_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorChestplate_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorLeggings_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_ThugsExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		amount_modifier = 2000000,
		loot_def = "Drop_556_Varied",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy thugs",
	group = "Enemy - Thugs",
	id = "TE_ThugGunner_Stronger",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 78,
		RandomizeCondition = true,
		item = "FNMinimi",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorHelmet_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorTorso_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorLeggings_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_ThugsExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		amount_modifier = 2000000,
		loot_def = "Drop_556_Varied",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "EnemyValuables",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy thugs",
	group = "Enemy - Thugs",
	id = "TE_ThugSniper",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 61,
		RandomizeCondition = true,
		item = "M24Sniper",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarHelmet_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "CamoArmor_Medium",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarLeggings_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_ThugsExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_762NATO_Varied",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy thugs",
	group = "Enemy - Thugs",
	id = "TE_ThugSniper_Stronger",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 61,
		RandomizeCondition = true,
		item = "M24Sniper",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarHelmet_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "CamoArmor_Medium_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarLeggings_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_ThugsExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_762NATO_Varied",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "EnemyValuables",
	}),
})

--Army
PlaceObj('LootDef', {
	Comment = "enemy army",
	group = "Enemy - Army",
	id = "TE_ArmysExplosives",
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "HE_Grenade",
		stack_max = 5,
		stack_min = 5,
		weight = 5000,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "TimedC4",
		stack_max = 5,
		stack_min = 5,
		weight = 2500,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "Molotov",
		stack_max = 5,
		stack_min = 5,
		weight = 1500,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "TearGasGrenade",
		stack_max = 5,
		stack_min = 5,
		weight = 1000,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "ToxicGasGrenade",
		stack_max = 5,
		stack_min = 5,
		weight = 500,
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy army",
	group = "Enemy - Army",
	id = "TE_ArmyCommander",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 58,
		RandomizeCondition = true,
		item = "M14SAW",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "ArmyArmor_Pants_Chest_Helmet_Heavy",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_ArmysExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_762NATO_Varied",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "EnemyValuables",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy army",
	group = "Enemy - Army",
	id = "TE_ArmyDemo",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 69,
		RandomizeCondition = true,
		item = "M41Shotgun",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "SmokeGrenade",
		stack_max = 5,
		stack_min = 5,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "Gasmaskenhelm",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "ArmyArmor_Pants_Body_Medium",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_ArmysExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_12gauge_Varied",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "ExplosiveComponents",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "EnemyValuables",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy army",
	group = "Enemy - Army",
	id = "TE_ArmyHeavy",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 67,
		RandomizeCondition = true,
		item = "FNMinimi",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "ArmyArmor_Pants_Chest_Helmet_Heavy",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_ArmysExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		amount_modifier = 2000000,
		loot_def = "Drop_556_Varied",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy army",
	group = "Enemy - Army",
	id = "TE_ArmyMedic",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 56,
		RandomizeCondition = true,
		item = "MP5",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "Medkit",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "CombatStim",
		stack_max = 3,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "SmokeGrenade",
		stack_max = 5,
		stack_min = 5,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "ArmyArmor_Pants_Chest_Helmet_Medium",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_ArmysExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_9mm_Varied",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "MedsDrop",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "EnemyValuables",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy army",
	group = "Enemy - Army",
	id = "TE_ArmyMortar",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 82,
		item = "MortarInventoryItem",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "ArmyArmor_Pants_Chest_Helmet_Heavy",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_ArmysExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_MortarShell_HE",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "EnemyValuables",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy army",
	group = "Enemy - Army",
	id = "TE_ArmyRPG",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 56,
		RandomizeCondition = true,
		item = "RPG7",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "ArmyArmor_Pants_Chest_Helmet_Heavy",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_ArmysExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_Warhead",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "EnemyValuables",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy army",
	group = "Enemy - Army",
	id = "TE_ArmyScout",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 58,
		RandomizeCondition = true,
		item = "M4Commando",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "SmokeGrenade",
		stack_max = 5,
		stack_min = 5,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "ArmyArmor_Pants_Chest_Helmet_Medium",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_ArmysExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_556_Varied",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy army",
	group = "Enemy - Army",
	id = "TE_ArmySniper",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 58,
		RandomizeCondition = true,
		drop_chance_mod = 50,
		item = "M24Sniper",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "ArmyArmor_Pants_Chest_Helmet_Medium",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_ArmysExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_762NATO_Varied",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "EnemyValuables",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy army",
	group = "Enemy - Army",
	id = "TE_ArmySoldier",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 82,
		RandomizeCondition = true,
		item = "FNFAL",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "ArmyArmor_Pants_Chest_Helmet_Medium",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_ArmysExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_762NATO_Varied",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy army",
	group = "Enemy - Army",
	id = "TE_ArmyStormer",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 58,
		RandomizeCondition = true,
		item = "M41Shotgun",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "SmokeGrenade",
		stack_max = 5,
		stack_min = 5,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "Gasmaskenhelm",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "ArmyArmor_Pants_Body_Medium",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_ArmysExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_12gauge_Varied",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "EnemyValuables",
	}),
})

PlaceObj('LootDef', {
	group = "Enemy - Army",
	id = "Faucheaux",
	loot = "all",
	PlaceObj('LootEntryUpgradedWeapon', {
		Condition = 97,
		RandomizeCondition = true,
		upgrades = {
			"GrenadeLauncher_AUG",
		},
		weapon = "AUG",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "ArmyArmor_Pants_Chest_Helmet_Heavy",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_ArmysExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_40mm_Frag",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_556_Varied",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "EnemyValuables",
	}),
})

--Adonis
PlaceObj('LootDef', {
	Comment = "enemy adonis",
	group = "Enemy - Adonis",
	id = "TE_Adonis_Explosives",
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "HE_Grenade",
		stack_max = 5,
		stack_min = 5,
		weight = 5000,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "TimedC4",
		stack_max = 5,
		stack_min = 5,
		weight = 2500,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "Molotov",
		stack_max = 5,
		stack_min = 5,
		weight = 1500,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "TearGasGrenade",
		stack_max = 5,
		stack_min = 5,
		weight = 1000,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "ToxicGasGrenade",
		stack_max = 5,
		stack_min = 5,
		weight = 500,
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy adonis",
	group = "Enemy - Adonis",
	id = "TE_AdonisAssault",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 92,
		RandomizeCondition = true,
		item = "G36",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarHelmet",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "AdonisArmor_Pants_Body_Medium",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_Adonis_Explosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_762NATO_Varied",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "EnemyValuables",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy adonis",
	group = "Enemy - Adonis",
	id = "TE_AdonisAssault_Elite",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 92,
		RandomizeCondition = true,
		item = "G36",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarHelmet_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "AdonisArmor_Pants_Body_MediumUp",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_Adonis_Explosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_762NATO_Varied",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "EnemyValuables",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy adonis",
	group = "Enemy - Adonis",
	id = "TE_AdonisDemolitions",
	loot = "all",
	PlaceObj('LootEntryUpgradedWeapon', {
		Condition = 92,
		RandomizeCondition = true,
		upgrades = {
			"GrenadeLauncher_Commando",
		},
		weapon = "M4Commando",
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "SmokeGrenade",
		stack_max = 5,
		stack_min = 5,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "AdonisArmor_Full_Heavy",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_Adonis_Explosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_40mm_Frag",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_556_Varied",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "ExplosiveComponents",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "EnemyValuables",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy adonis",
	group = "Enemy - Adonis",
	id = "TE_AdonisFlanker",
	loot = "all",
	PlaceObj('LootEntryUpgradedWeapon', {
		Condition = 92,
		RandomizeCondition = true,
		upgrades = {
			"ScopeCOGQuick",
		},
		weapon = "MP5",
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "SmokeGrenade",
		stack_max = 5,
		stack_min = 5,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarHelmet",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "AdonisArmor_Pants_Body_Medium",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_Adonis_Explosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_9mm_Varied",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "EnemyValuables",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy adonis",
	group = "Enemy - Adonis",
	id = "TE_AdonisFlanker_Elite",
	loot = "all",
	PlaceObj('LootEntryUpgradedWeapon', {
		Condition = 92,
		RandomizeCondition = true,
		upgrades = {
			"ScopeCOGQuick",
		},
		weapon = "MP5",
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "SmokeGrenade",
		stack_max = 5,
		stack_min = 5,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarHelmet_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "AdonisArmor_Pants_Body_MediumUp",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_Adonis_Explosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_9mm_Varied",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "EnemyValuables",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy quest",
	group = "Enemy - Adonis",
	id = "TE_AdonisGuard",
	loot = "all",
	PlaceObj('LootEntryUpgradedWeapon', {
		Condition = 92,
		RandomizeCondition = true,
		upgrades = {
			"ReflexSight",
		},
		weapon = "FAMAS",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "AdonisArmor_Full_Heavy",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_Adonis_Explosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_556_Varied",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "EnemyValuables",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy adonis",
	group = "Enemy - Adonis",
	id = "TE_AdonisHeavy",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		RandomizeCondition = true,
		item = "HK21",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "AdonisArmor_Full_Heavy",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_Adonis_Explosives",
	}),
	PlaceObj('LootEntryLootDef', {
		amount_modifier = 2000000,
		loot_def = "Drop_762NATO_Varied",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "EnemyValuables",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy adonis",
	group = "Enemy - Adonis",
	id = "TE_AdonisMedic",
	loot = "all",
	PlaceObj('LootEntryUpgradedWeapon', {
		Condition = 92,
		RandomizeCondition = true,
		upgrades = {
			"ReflexSight",
		},
		weapon = "MP5",
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "Medkit",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "CombatStim",
		stack_max = 4,
		stack_min = 2,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "SmokeGrenade",
		stack_max = 5,
		stack_min = 5,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarHelmet",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "AdonisArmor_Pants_Body_Medium",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_Adonis_Explosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_9mm_Varied",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "MedsDrop",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "EnemyValuables",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy adonis",
	group = "Enemy - Adonis",
	id = "TE_AdonisMortar",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 93,
		RandomizeCondition = true,
		item = "MortarInventoryItem",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "AdonisArmor_Full_Heavy",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_Adonis_Explosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_MortarShell_HE",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "EnemyValuables",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy adonis",
	group = "Enemy - Adonis",
	id = "TE_AdonisSniper",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 95,
		RandomizeCondition = true,
		item = "PSG1",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarHelmet",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "AdonisArmor_Pants_Body_Medium",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_Adonis_Explosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_762NATO_Varied",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "EnemyValuables",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy adonis",
	group = "Enemy - Adonis",
	id = "TE_AdonisSniper_Elite",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 95,
		RandomizeCondition = true,
		item = "PSG1",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "KevlarHelmet_WeavePadding",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "AdonisArmor_Pants_Body_MediumUp",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_Adonis_Explosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_762NATO_Varied",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "EnemyValuables",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy adonis",
	group = "Enemy - Adonis",
	id = "TE_AdonisSquadLeader",
	loot = "all",
	PlaceObj('LootEntryUpgradedWeapon', {
		Condition = 95,
		RandomizeCondition = true,
		upgrades = {
			"GrenadeLauncher_AUG",
		},
		weapon = "AUG",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "AdonisArmor_Full_Heavy",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_Adonis_Explosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_40mm_Frag",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_556_Varied",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "EnemyValuables",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy adonis",
	group = "Enemy - Adonis",
	id = "TE_AdonisSquadLeader_Elite",
	loot = "all",
	PlaceObj('LootEntryUpgradedWeapon', {
		Condition = 95,
		RandomizeCondition = true,
		upgrades = {
			"GrenadeLauncher_AUG",
		},
		weapon = "AUG",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "AdonisArmor_Full_Heavy",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_Adonis_Explosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_40mm_Frag",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_556_Varied",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "EnemyValuables",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy adonis",
	group = "Enemy - Adonis",
	id = "TE_AdonisStormer",
	loot = "all",
	PlaceObj('LootEntryUpgradedWeapon', {
		Condition = 93,
		RandomizeCondition = true,
		upgrades = {
			"UVDot",
		},
		weapon = "M41Shotgun",
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "SmokeGrenade",
		stack_max = 5,
		stack_min = 5,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "AdonisArmor_Full_Heavy",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_Adonis_Explosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_12gauge_Varied",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "EnemyValuables",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy adonis",
	group = "Enemy - Adonis",
	id = "TE_AdonisStormer_Elite",
	loot = "all",
	PlaceObj('LootEntryUpgradedWeapon', {
		Condition = 93,
		RandomizeCondition = true,
		upgrades = {
			"UVDot",
		},
		weapon = "M41Shotgun",
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "SmokeGrenade",
		stack_max = 5,
		stack_min = 5,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "AdonisArmor_Full_Heavy",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_Adonis_Explosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_12gauge_Varied",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "EnemyValuables",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy adonis boss",
	group = "Enemy - Adonis",
	id = "CorazonBoss",
	loot = "all",
	PlaceObj('LootEntryUpgradedWeapon', {
		Condition = 97,
		RandomizeCondition = true,
		upgrades = {
			"UVDot_aa12",
		},
		weapon = "AA12",
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "SmokeGrenade",
		stack_max = 5,
		stack_min = 5,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "AdonisArmor_Full_Heavy",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_Adonis_Explosives",
	}),
	PlaceObj('LootEntryLootDef', {
		amount_modifier = 2000000,
		loot_def = "Drop_12gauge_Varied",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "EnemyValuables",
	}),
})

--SiegfriedSuperSoldiers
PlaceObj('LootDef', {
	group = "SiegfriedSuperSoldiers",
	id = "TE_SuperSoldiersExplosives",
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "HE_Grenade",
		stack_max = 5,
		stack_min = 5,
		weight = 5000,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "TimedTNT",
		stack_max = 5,
		stack_min = 5,
		weight = 2500,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "Molotov",
		stack_max = 5,
		stack_min = 5,
		weight = 1500,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "FragGrenade",
		stack_max = 5,
		stack_min = 5,
		weight = 1000,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "ToxicGasGrenade",
		stack_max = 5,
		stack_min = 5,
		weight = 500,
	}),
})

PlaceObj('LootDef', {
	group = "SiegfriedSuperSoldiers",
	id = "TE_SuperSoldier_Assault",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 97,
		RandomizeCondition = true,
		item = "G36",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorHelmet_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorTorso_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorLeggings_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_SuperSoldiersExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_556_Varied",
	}),
})

PlaceObj('LootDef', {
	group = "SiegfriedSuperSoldiers",
	id = "TE_SuperSoldier_Assault_Stronger",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 97,
		RandomizeCondition = true,
		item = "G36",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorHelmet_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorTorso_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorLeggings_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_SuperSoldiersExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_556_Varied",
	}),
})

PlaceObj('LootDef', {
	group = "SiegfriedSuperSoldiers",
	id = "TE_SuperSoldier_Linebreaker",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 97,
		RandomizeCondition = true,
		item = "Machete_Crafted",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "ToxicGasGrenade",
		stack_max = 5,
		stack_min = 5,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorHelmet_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorTorso_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorLeggings_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_SuperSoldiersExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "ExplosiveComponents",
	}),
})

PlaceObj('LootDef', {
	group = "SiegfriedSuperSoldiers",
	id = "TE_SuperSoldier_Linebreaker_Stronger",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 97,
		RandomizeCondition = true,
		item = "Machete_Crafted",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "ToxicGasGrenade",
		stack_max = 5,
		stack_min = 5,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorHelmet_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorTorso_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorLeggings_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_SuperSoldiersExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "ExplosiveComponents",
	}),
})

PlaceObj('LootDef', {
	group = "SiegfriedSuperSoldiers",
	id = "TE_SuperSoldier_Medic",
	loot = "all",
	PlaceObj('LootEntryUpgradedWeapon', {
		Condition = 97,
		RandomizeCondition = true,
		upgrades = {
			"UVDot",
		},
		weapon = "M41Shotgun",
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "CombatStim",
		stack_max = 6,
		stack_min = 3,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "ToxicGasGrenade",
		stack_max = 5,
		stack_min = 5,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorHelmet_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorTorso_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorLeggings_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_SuperSoldiersExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		amount_modifier = 2000000,
		loot_def = "Drop_12gauge_Saltshot",
	}),
})

PlaceObj('LootDef', {
	group = "SiegfriedSuperSoldiers",
	id = "TE_SuperSoldier_Ordnance",
	loot = "all",
	PlaceObj('LootEntryUpgradedWeapon', {
		Condition = 97,
		RandomizeCondition = true,
		upgrades = {
			"GrenadeLauncher_AUG",
		},
		weapon = "AUG",
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorHelmet_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorTorso_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorLeggings_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_SuperSoldiersExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_40mm_Frag",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_556_Varied",
	}),
})

PlaceObj('LootDef', {
	group = "SiegfriedSuperSoldiers",
	id = "TE_SuperSoldier_Skirmisher",
	loot = "all",
	PlaceObj('LootEntryUpgradedWeapon', {
		Condition = 97,
		RandomizeCondition = true,
		upgrades = {
			"GrenadeLauncher_Commando",
		},
		weapon = "M4Commando",
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "ToxicGasGrenade",
		stack_max = 5,
		stack_min = 5,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorHelmet_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorTorso_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorLeggings_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_SuperSoldiersExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_40mm_Frag",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_556_Varied",
	}),
})

PlaceObj('LootDef', {
	group = "SiegfriedSuperSoldiers",
	id = "TE_SuperSoldier_Skirmisher_Stronger",
	loot = "all",
	PlaceObj('LootEntryUpgradedWeapon', {
		Condition = 97,
		RandomizeCondition = true,
		upgrades = {
			"GrenadeLauncher_Commando",
		},
		weapon = "M4Commando",
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "ToxicGasGrenade",
		stack_max = 5,
		stack_min = 5,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorHelmet_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorTorso_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorLeggings_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_SuperSoldiersExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_40mm_Frag",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_556_Varied",
	}),
})

PlaceObj('LootDef', {
	group = "SiegfriedSuperSoldiers",
	id = "TE_SuperSoldier_Stormer",
	loot = "all",
	PlaceObj('LootEntryUpgradedWeapon', {
		Condition = 97,
		RandomizeCondition = true,
		upgrades = {
			"UVDot_aa12",
		},
		weapon = "AA12",
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "ToxicGasGrenade",
		stack_max = 5,
		stack_min = 5,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorHelmet_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorTorso_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorLeggings_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_SuperSoldiersExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		amount_modifier = 2000000,
		loot_def = "Drop_12gauge_Sabot",
	}),
})

PlaceObj('LootDef', {
	group = "SiegfriedSuperSoldiers",
	id = "TE_SuperSoldier_Stormer_Stronger",
	loot = "all",
	PlaceObj('LootEntryUpgradedWeapon', {
		Condition = 97,
		RandomizeCondition = true,
		upgrades = {
			"UVDot_aa12",
		},
		weapon = "AA12",
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "ToxicGasGrenade",
		stack_max = 5,
		stack_min = 5,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorHelmet_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorTorso_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		Condition = 100,
		item = "HeavyArmorLeggings_Kompositum",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_SuperSoldiersExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		amount_modifier = 2000000,
		loot_def = "Drop_12gauge_Sabot",
	}),
})

--Rebels
PlaceObj('LootDef', {
	group = "Enemy - Rebels",
	id = "TE_RebelsExplosives",
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "FragGrenade",
		stack_max = 5,
		stack_min = 5,
		weight = 5000,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "TimedTNT",
		stack_max = 5,
		stack_min = 5,
		weight = 2500,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "Molotov",
		stack_max = 5,
		stack_min = 5,
		weight = 1500,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "TearGasGrenade",
		stack_max = 5,
		stack_min = 5,
		weight = 1000,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "ToxicGasGrenade",
		stack_max = 5,
		stack_min = 5,
		weight = 500,
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy rebels",
	group = "Enemy - Rebels",
	id = "TE_RebelFlanker",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 86,
		RandomizeCondition = true,
		item = "AKSU",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "SmokeGrenade",
		stack_max = 5,
		stack_min = 5,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "RebelsArmor_Full_Medium",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_RebelsExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_762WP_Varied",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy rebels",
	group = "Enemy - Rebels",
	id = "TE_RebelGrenadier",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 91,
		RandomizeCondition = true,
		item = "Auto5",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "SmokeGrenade",
		stack_max = 5,
		stack_min = 5,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "RebelsArmor_Full_Medium",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_RebelsExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		amount_modifier = 2000000,
		loot_def = "Drop_12gauge_Varied",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "ExplosiveComponents",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy rebels",
	group = "Enemy - Rebels",
	id = "TE_RebelGunner",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 78,
		RandomizeCondition = true,
		item = "RPK74",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "RebelsArmor_Full_Medium",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_RebelsExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		amount_modifier = 2000000,
		loot_def = "Drop_762WP_Varied",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy rebels",
	group = "Enemy - Rebels",
	id = "TE_RebelSentry",
	loot = "all",
	PlaceObj('LootEntryUpgradedWeapon', {
		Condition = 91,
		RandomizeCondition = true,
		upgrades = {
			"GrenadeLauncher",
		},
		weapon = "AK74",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "RebelsArmor_Full_Medium",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_RebelsExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_40mm_Frag",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_762WP_Varied",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "EnemyValuables",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy rebels",
	group = "Enemy - Rebels",
	id = "TE_RebelSniper",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 89,
		RandomizeCondition = true,
		item = "DragunovSVD",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "RebelsArmor_Full_Medium",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_RebelsExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_762WP_Varied",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "EnemyValuables",
	}),
})

PlaceObj('LootDef', {
	Comment = "enemy rebels",
	group = "Enemy - Rebels",
	id = "TE_RebelSoldier",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		Condition = 93,
		RandomizeCondition = true,
		item = "AK47",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "RebelsArmor_Full_Medium",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "TE_RebelsExplosives",
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Drop_762WP_Varied",
	}),
})

--B.O.W.
PlaceObj('LootDef', {
	Comment = "B.O.W. Zombie Gear",
	group = "B.O.W.",
	id = "BOW_Zombie_Gear",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "Unarmed_Infected",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "Infected_HardenedSkin",
		stack_max = 1,
		stack_min = 1,
	}),
})

PlaceObj('LootDef', {
	Comment = "B.O.W. Hunter Gear",
	group = "B.O.W.",
	id = "BOW_Hunter_Gear",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "BOW_SharpenedJaws",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "BOW_HardenedSkin",
		stack_max = 1,
		stack_min = 1,
	}),
})

PlaceObj('LootDef', {
	Comment = "B.O.W. MK.I Gear",
	group = "B.O.W.",
	id = "Super_MK1_Gear",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "_50BMG_SLAP",
		stack_max = 15,
		stack_min = 15,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "Super_HE_Grenade",
		stack_max = 5,
		stack_min = 5,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "ToxicGasGrenade",
		stack_max = 5,
		stack_min = 5,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "BOW_HardenedSkin",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Super_MK1_Armament",
	}),
})

PlaceObj('LootDef', {
	Comment = "B.O.W. MK.II Gear",
	group = "B.O.W.",
	id = "Super_MK2_Gear",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "_12gauge_Flechette",
		stack_max = 15,
		stack_min = 15,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "Super_HE_Grenade",
		stack_max = 5,
		stack_min = 5,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "ToxicGasGrenade",
		stack_max = 5,
		stack_min = 5,
	}),
	PlaceObj('LootEntryInventoryItem', {
		drop_chance_mod = 0,
		item = "BOW_HardenedSkin",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryLootDef', {
		loot_def = "Super_MK2_Armament",
	}),
})

PlaceObj('ModItemLootDef', {
	comment = "B.O.W. MK.I Armament",
	group = "B.O.W.",
	id = "Super_MK1_Armament",
	PlaceObj('LootEntryUpgradedWeapon', {
		drop_chance_mod = 0,
		weapon = "MG58",
		weight = 300000,
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		drop_chance_mod = 0,
		weapon = "BarretM82",
		weight = 150000,
	}),
})
		
PlaceObj('ModItemLootDef', {
	comment = "B.O.W. MK.II Armament",
	group = "B.O.W.",
	id = "Super_MK2_Armament",
	PlaceObj('LootEntryUpgradedWeapon', {
		drop_chance_mod = 0,
		weapon = "AA12",
		weight = 300000,
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		drop_chance_mod = 0,
		weapon = "Machete_Crafted",
		weight = 150000,
	}),
})
		
-- ========== TE LootDef Edit End ==========


--Tactician Enhanced AIArchetype Loaded
function OnMsg.ModsReloaded()
	gen_TacticianEnhanced()
	gen_AIArchetype()
end
function OnMsg.DataLoaded()
	gen_TacticianEnhanced()
	gen_AIArchetype()
end
function OnMsg.OptionsApply()
	gen_TacticianEnhanced()
	gen_AIArchetype()
end