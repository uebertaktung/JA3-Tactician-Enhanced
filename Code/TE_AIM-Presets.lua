-- ========== TE Tactical A.I.M. Overhaul Begin ==========

--Defs_Unit_AIM
local function checkID(id)
    if not UnitDataDefs[id] then
        return false
    end
    if not _G[id] then
        return false
    end
    return true
end

local function TE_AIM(id, level, hp, agi, dex, str, wis, lds, mkm, mec, exps, med, perk, equip, gearFunc)
    if not checkID(id) then return end
    local defs = UnitDataDefs[id]
    local load = _G[id]

    if level then
        defs.StartingLevel   = level
        load.StartingLevel   = level
    end

    if hp then
        defs.Health          = hp
        load.Health          = hp
        load.base_Health     = hp
    end

    if agi then
        defs.Agility         = agi
        load.Agility         = agi
        load.base_Agility    = agi
    end

    if dex then
        defs.Dexterity       = dex
        load.Dexterity       = dex
        load.base_Dexterity  = dex
    end

    if str then
        defs.Strength        = str
        load.Strength        = str
        load.base_Strength   = str
    end

    if wis then
        defs.Wisdom          = wis
        load.Wisdom          = wis
        load.base_Wisdom     = wis
    end

    if lds then
        defs.Leadership      = lds
        load.Leadership      = lds
        load.base_Leadership = lds
    end

    if mkm then
        defs.Marksmanship      = mkm
        load.Marksmanship      = mkm
        load.base_Marksmanship = mkm
    end

    if mec then
        defs.Mechanical      = mec
        load.Mechanical      = mec
        load.base_Mechanical = mec
    end

    if exps then
        defs.Explosives      = exps
        load.Explosives      = exps
        load.base_Explosives = exps
    end

    if med then
        defs.Medical         = med
        load.Medical         = med
        load.base_Medical    = med
    end

    if perk then
        defs.StartingPerks   = perk
        load.StartingPerks   = perk
    end

    if equip then
        defs.Equipment       = equip
        load.Equipment       = equip
    end
	
    if gearFunc then
        defs.CustomEquipGear = gearFunc
        load.CustomEquipGear = gearFunc
    end
end

local function TE_Nationality(id, nation)
    if not UnitDataDefs[id] or not _G[id] then return end
    local defs = UnitDataDefs[id]
    local load = _G[id]

    if nation then
        defs.Nationality   = nation
        load.Nationality   = nation
    end
end

local TE_IMP_Perk = {
		--Perk-Personality 佣兵个性
--		"Psycho",--精神病
--		"Negotiator",--谈判家
--		"Scoundrel",--恶棍

		--Perk-Specialization 佣兵专精
--		"Ambidextrous",--左右开弓
--		"AutoWeapons",--自动武器
--		"CQCTraining",--CQC 训练
--		"HeavyWeaponsTraining",--重型武器
--		"MartialArts",--武术
--		"MeleeTraining",--短兵相接
--		"MrFixit",--大拿
--		"NightOps",--夜间行动
--		"Stealthy",--隐秘
--		"Teacher",--教导
--		"Throwing",--投掷

		--Perk-Quirk 佣兵癖好
--		"Loner",--独狼
--		"Optimist",--乐天派
--		"Spiritual",--精神信仰
--		"Claustrophobic",--幽闭症
--		"Hemophobic",--恐血症
--		"OldDog",--老态龙钟
--		"Pessimist",--悲观主义者
--		"Zoophobic",--动物恐惧症

        --Perk-Personal 独有天赋
--		"BuildingConfidence",--站稳脚跟
--		"BulletHell",--子弹地狱
--		"BunsPerk",--无所不能
--		"DanceForMe",--为我舞蹈
--		"DangerClose",--危险距离
--		"DedicatedCamper",--巧胜于勤
--		"DesignerExplosives",--精品炸药
--		"DoubleToss",--双抛
--		"ExplodingPalm",--爆裂掌
--		"EyesOnTheBack",--背后有眼
--		"FleetingShadow",--飞逝之影
--		"FoxPerk",--相貌出众
--		"GloryHog",--爱慕虚荣
--		"GrizzlyPerk",--腰间射击
--		"GruntyPerk",--Überraschung来一个惊喜吧！
--		"HaveABlast",--接招吧
--		"HawksEye",--鹰眼
--		"HundredKnives",--飞刀
--		"IcePerk",--冰风暴
--		"InnerInfo",--内部消息
--		"JackOfAllTrades",--万事通
--		"KalynaPerk",--必中打击
--		"KillingWind",--重载突击
--		"LightStep",--脚步轻盈
--		"MakeThemBleed",--血流成河
--		"NailsPerk",--一针见血
--		"NaturalHealing",--自然恩赐
--		"Nazdarovya",--Vashe zdorovye为了您的健康!
--		"OnMyTarget",--听我号令
--		"RecklessAssault",--鲁莽冲锋
--		"SecondStoryMan",--窃贼
--		"ShoulderToShoulder",--肩并肩
--		"SidneyPerk",--自鸣得意
--		"Spotter",--顶级侦查员
--		"SteroidPunch",--肌肉撞击！
--		"TagTeam",--双人组合
--		"TheGrim",--残酷命运
--		"VengefulTemperament",--心怀芥蒂
--		"WeGotThis",--目标清除
--		"WeaponPersonalization",--体力活
--		"YouSeeIgor",--你瞧，伊戈尔
  
		--Perk-NPC NPC天赋
--		"NaturalCamouflage",--天然伪装
--		"DieselPerk",--已强化

        --Perk-Health
--		"OptimalPerformance",               -- Health, Tier 1 - Gain 15 Grit on successful melee attack (Grit absorbs hits in place of health).
--		"HitTheDeck",                       -- Health, Tier 1 - Going Prone costs no AP. 20% less damage from explosives when Prone.
--		"BeefedUp",                         -- Health, Tier 1 - Extra 20% Max HP.
--		"Berserker",                        -- Health, Tier 2 - Deal 10% extra damage per wound on an enemy.
--		"Shatterhand",                      -- Health, Tier 2 - Make an Interrupt attack during enemy turn when badly damaged.
--		"TrueGrit",                         -- Health, Tier 2 - Gain 15 grit when ending turn out of cover or next to an enemy.
--		"Hardened",                         -- Health, Tier 3 - Carry up to 3 AP over to next turn on end turn, gain 5 Grit per AP carried over.
--		"HoldPosition",                     -- Health, Tier 3 - 32% damage reduction while using Overwatch or Pin Down moves.
--		"BattleFocus",                      -- Health, Tier 3 - Gain 2 AP when first hit in combat.
  
        --Perk-Agility
--		"SwiftStrike",                      -- Agility, Tier 1 - Gain Free Move (no AP cost) after landing a melee attack
--		"Flanker",                          -- Agility, Tier 1 - Deal 15% more damage to flanked enemies
--		"SteadyBreathing",                  -- Agility, Tier 1 - Free Move range increased when unarmoured or lightly armoured.
--		"DeathFromAbove",                   -- Agility, Tier 2 - Better accuracy from high ground. Moving on ladders costs less AP.
--		"RelentlessAdvance",                -- Agility, Tier 2 - Increased Free Move range when starting a turn behind cover.
--		"LightningReaction",                -- Agility, Tier 2 - Dodge first enemy attack by dropping Prone. Once per combat.
--		"LuckyStreak",                      -- Agility, Tier 3 - Become Inspired (free lump sum AP) when hitting two crit shots in one turn.
--		"ColdHeart",                        -- Agility, Tier 3 - Deal 50% more crit damage.
--		"SingularPurpose", 
  
        --Perk-Dexterity    
--		"Untraceable",                      -- Dexterity, Tier 1 - Harder to detect while sneaking.
--		"OpportunisticKiller",              -- Dexterity, Tier 1 - Enables crits during Interrupt attacks. Automatic reload if Overwatch was used last turn.
--		"Deadeye",                          -- Dexterity, Tier 1 - Gain 5% crit chance per Aim level (AP spent to increase accuracy).
--		"Counterfire",                      -- Dexterity, Tier 2 - Gain Inspired after landing 2 hits with Overwatch.
--		"Hotblood",                         -- Dexterity, Tier 2 - Make an Interrupt attack when an enemy misses you on their turn.
--		"Infiltrator",                      -- Dexterity, Tier 2 - Better chance for stealth kills while sneaking.
--		"Instagib",                         -- Dexterity, Tier 3 - Gain 2 Aims on your first attack each turn. 27% extra damage on first attack each turn.
--		"Killzone",                         -- Dexterity, Tier 3 - Make a bonus attack whenever you perform an Interrupt attack.
--		"Virtuoso",                         -- Dexterity, Tier 3 - Increased stealth kill chance on 3+ Aim levels.
  
        --Perk-Strength  
--		"TakeAim",                          -- Strength, Tier 1 - Increased accuracy on subsequent attacks against the same target.
--		"BreachAndClear",                   -- Strength, Tier 1 - Gain Free Move after making grenade or shotgun attacks.
--		"BloodlustPerk",                    -- Strength, Tier 1 - Melee attacks against different targets in the same turn deal 21% more damage.
--		"InstantAutopsy",                   -- Strength, Tier 2 - 30% extra crit chance for point-blank attacks.
--		"Ironclad",                         -- Strength, Tier 2 - Retain half of your Free Move range when in heavy armour.
--		"HardBlow",                         -- Strength, Tier 2 - Won’t trigger Interrupt with melee attacks. Successful melee attacks will cancel Overwatch and Pin Down.
--		"CollateralDamage",                 -- Strength, Tier 3 - Deal extra 30% damage to objects and 15% damage to enemies behind cover when using heavy weapons.
--		"LineBreaker",                      -- Strength, Tier 3 - Become Inspired after a point-blank range kill.
--		"BloodScent",                       -- Strength, Tier 3 - Successful melee attacks are crits, and apply Marked (which guarantees a crit next attack) to targets.
  
        --Perk-Wisdom
--		"Savior",                           -- Wisdom, Tier 1 - Heal 20% more HP with bandages, and gain Free Move when bandaging an ally.
--		"CancelShotPerk",                   -- Wisdom, Tier 1 - Special attack. Removes Overwatch and Pin down.
--		"Hobbler",                          -- Wisdom, Tier 1 - No damage penalty when hit in arms or legs.
--		"StressManagement",                 -- Wisdom, Tier 2 - Gain Inspired after first debuff in combat.
--		"LastWarning",                      -- Wisdom, Tier 2 - When Morale is High or Very High, gain 15% chance to inflict Panic on enemies with each successful shot.
--		"LeadFromTheFront",                 -- Wisdom, Tier 2 - Increase Morale when dealing more than 50 damage with a strike.
--		"Caretaker",                        -- Wisdom, Tier 3 - Grant 2 Grit to an ally when bandaging them.
--		"ShockAndAwe",                      -- Wisdom, Tier 3 - High Morale when starting combat. Deal 10% more damage when Morale is High or Very High.
--		"TrickShot"                         -- Wisdom, Tier 3 - Apply severe debuffs to targets when hitting limbs or groin.
	}

local TE_Barry_Perk = {
		"DesignerExplosives",
		"MrFixit",
		"Spiritual",
		"BreachAndClear",
	}

local TE_Blood_Perk = {
		"HundredKnives",
		"MartialArts",
		"Throwing",
		"SwiftStrike",
		"SteadyBreathing",
	}

local TE_Buns_Perk = {
		"BunsPerk",
		"Negotiator",
		"Teacher",
		"AutoWeapons",
		"Deadeye",
		"CancelShotPerk",
	}

local TE_DrQ_Perk = {
		"ExplodingPalm",
		"MartialArts",
		"MeleeTraining",
		"NightOps",
		"Savior",
		"StressManagement",
		"Caretaker",
	}

local TE_Fauda_Perk = {
		"KillingWind",
		"HeavyWeaponsTraining",
		"OldDog",
		"Spiritual",
		"HitTheDeck",
		"Berserker",
		"Flanker",
		"TakeAim",
		"Ironclad",
		"CollateralDamage",
	}

local TE_Fidel_Perk = {
		"DoubleToss",
		"Psycho",
		"MeleeTraining",
		"Throwing",
		"TakeAim",
		"BreachAndClear",
	}

local TE_Fox_Perk = {
		"FoxPerk",
		"Scoundrel",
		"Teacher",
		"Ambidextrous",
	}

local TE_Grizzly_Perk = {
		"GrizzlyPerk",
		"MeleeTraining",
		"HeavyWeaponsTraining",
		"BloodlustPerk",
	}

local TE_Grunty_Perk = {
		"GruntyPerk",
		"Optimist",
		"HeavyWeaponsTraining",
		"BeefedUp",
		"Shatterhand",
		"TakeAim",
	}

local TE_Gus_Perk = {
		"WeGotThis",
		"Negotiator",
		"HeavyWeaponsTraining",
		"OldDog",
		"TakeAim",
		"CancelShotPerk",
		"StressManagement",
		"LeadFromTheFront",
		"ShockAndAwe",
		"TrickShot",
	}

local TE_Hitman_Perk = {
		"DedicatedCamper",
		"AutoWeapons",
		"Teacher",
		"Loner",
		"HitTheDeck",
		"TakeAim",
		"Hobbler",
	}

local TE_Ice_Perk = {
		"IcePerk",
		"AutoWeapons",
		"Teacher",
		"Flanker",
		"LightningReaction",
	}

local TE_Igor_Perk = {
		"Nazdarovya",
		"Stealthy",
		"MeleeTraining",
		"OptimalPerformance",
	}

local TE_Ivan_Perk = {
		"YouSeeIgor",
		"AutoWeapons",
		"MeleeTraining",
		"BeefedUp",
		"Berserker",
		"BattleFocus",
		"TakeAim",
	}

local TE_Kalyna_Perk = {
		"KalynaPerk",
		"NightOps",
		"Optimist",
		"Spiritual",
	}

local TE_Len_Perk = {
		"OnMyTarget",
		"AutoWeapons",
		"OldDog",
		"BeefedUp",
		"OpportunisticKiller",
		"Counterfire",
		"Hotblood",
		"Killzone",
		"Hobbler",
		"StressManagement",
	}

local TE_Magic_Perk = {
		"SecondStoryMan",
		"Scoundrel",
		"Stealthy",
		"SteadyBreathing",
		"DeathFromAbove",
		"LuckyStreak",
		"Deadeye",
		"Infiltrator",
	}

local TE_Livewire_Perk = {
		"InnerInfo",
		"Scoundrel",
		"MrFixit",
		"Optimist",
	}

local TE_MD_Perk = {
		"BuildingConfidence",
		"Optimist",
		"Teacher",
		"Zoophobic",
		"Savior",
	}

local TE_Meltdown_Perk = {
		"VengefulTemperament",
		"Psycho",
		"Ambidextrous",
		"HeavyWeaponsTraining",
		"BeefedUp",
		"TakeAim",
	}

local TE_Mouse_Perk = {
		"LightStep",
		"Loner",
		"Hemophobic",
		"Stealthy",
		"Untraceable",
	}

local TE_Nails_Perk = {
		"NailsPerk",
		"Psycho",
		"MeleeTraining",
		"Claustrophobic",
		"BreachAndClear",
		"BloodlustPerk",
		"InstantAutopsy",
		"LineBreaker",
	}

local TE_Omryn_Perk = {
		"EyesOnTheBack",
		"AutoWeapons",
		"Spiritual",
		"Claustrophobic",
		"CancelShotPerk",
	}

local TE_Raider_Perk = {
		"TagTeam",
		"Negotiator",
		"CQCTraining",
		"Teacher",
		"BeefedUp",
		"BreachAndClear",
		"InstantAutopsy",
	}

local TE_Raven_Perk = {
		"Spotter",
		"AutoWeapons",
		"NightOps",
		"SteadyBreathing",
		"DeathFromAbove",
	}

local TE_Reaper_Perk = {
		"TheGrim",
		"NightOps",
		"Stealthy",
		"Loner",
		"Flanker",
		"DeathFromAbove",
		"ColdHeart",
		"Deadeye",
		"Hobbler",
		"LastWarning",
	}

local TE_Red_Perk = {
		"HaveABlast",
		"MrFixit",
		"Throwing",
		"Pessimist",
		"BeefedUp",
		"Shatterhand",
		"BreachAndClear",
	}

local TE_Scope_Perk = {
		"HawksEye",
		"NightOps",
		"Teacher",
		"Flanker",
		"SteadyBreathing",
		"DeathFromAbove",
		"SingularPurpose",
		"Deadeye",
		"CancelShotPerk",
	}

local TE_Scully_Perk = {
		"ShoulderToShoulder",
		"Optimist",
		"MeleeTraining",
		"BeefedUp",
		"TrueGrit",
		"HoldPosition",
		"TakeAim",
		"HardBlow",
	}

local TE_Shadow_Perk = {
		"FleetingShadow",
		"AutoWeapons",
		"Stealthy",
		"Loner",
		"SwiftStrike",
		"RelentlessAdvance",
		"LightningReaction",
		"Untraceable",
		"Infiltrator",
		"Virtuoso",
	}

local TE_Sidney_Perk = {
		"SidneyPerk",
		"Negotiator",
		"Throwing",
		"Deadeye",
		"Hotblood",
		"Instagib",
		"BreachAndClear",
		"CancelShotPerk",
	}

local TE_Steroid_Perk = {
		"SteroidPunch",
		"MrFixit",
		"MeleeTraining",
		"BeefedUp",
	}

local TE_Tex_Perk = {
		"DanceForMe",
		"Ambidextrous",
		"CQCTraining",
		"Claustrophobic",
		"BeefedUp",
		"Shatterhand",
		"OpportunisticKiller",
	}

local TE_Thor_Perk = {
		"NaturalHealing",
		"Stealthy",
		"Spiritual",
		"Savior",
		"StressManagement",
	}

local TE_Vicki_Perk = {
		"WeaponPersonalization",
		"Ambidextrous",
		"MrFixit",
		"Claustrophobic",
		"Flanker",
		"LightningReaction",
		"Hobbler",
	}

local TE_Wolf_Perk = {
		"JackOfAllTrades",
		"NightOps",
		"Teacher",
		"BeefedUp",
		"BreachAndClear",
	}

local TE_GearEquip = function (self, items)
    self:TryEquip(items, "Handheld A", "AssaultRifle")
    self:TryEquip(items, "Handheld A", "SniperRifle")
    self:TryEquip(items, "Handheld A", "Shotgun")
    self:TryEquip(items, "Handheld A", "MachineGun")
    self:TryEquip(items, "Handheld A", "SubmachineGun")
    self:TryEquip(items, "Handheld A", "SubmachineGun")
    self:TryEquip(items, "Handheld A", "Pistol")
    self:TryEquip(items, "Handheld A", "Pistol")
    self:TryEquip(items, "Handheld A", "Revolver")
    self:TryEquip(items, "Handheld A", "Revolver")
    self:TryEquip(items, "Handheld A", "Grenade")
    self:TryEquip(items, "Handheld B", "FlareGun")
    self:TryEquip(items, "Handheld B", "SubmachineGun")
    self:TryEquip(items, "Handheld B", "SubmachineGun")
    self:TryEquip(items, "Handheld B", "Pistol")
    self:TryEquip(items, "Handheld B", "Pistol")
    self:TryEquip(items, "Handheld B", "Revolver")
    self:TryEquip(items, "Handheld B", "Revolver")
    self:TryEquip(items, "Handheld B", "MeleeWeapon")
    self:TryEquip(items, "Handheld B", "HeavyWeapon")
    self:TryEquip(items, "Handheld B", "Grenade")
    self:TryEquip(items, "Handheld B", "Grenade")
end

local function gen_TacticalAIM()
    --A.I.M.
    TE_AIM("Barry",    2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,     TE_Barry_Perk,       { "Barry_TEgear" },     TE_GearEquip)
    TE_AIM("Blood",    3, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,     TE_Blood_Perk,       { "Blood_TEgear" },     TE_GearEquip)
    TE_AIM("Buns",     3, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,     TE_Buns_Perk,        { "Buns_TEgear" },      TE_GearEquip)
    TE_AIM("DrQ",      4, nil, nil, 85,  70,  90,  nil, nil, nil, 16,  nil,     TE_DrQ_Perk,         { "DrQ_TEgear" },       TE_GearEquip)
    TE_AIM("Fauda",    7, 80,  nil, 35,  90,  nil, nil, nil, nil, nil, nil,     TE_Fauda_Perk,       { "Fauda_TEgear" },     TE_GearEquip)
    TE_AIM("Fidel",    3, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,     TE_Fidel_Perk,       { "Fidel_TEgear" },     TE_GearEquip)
    TE_AIM("Fox",      1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,     TE_Fox_Perk,         { "Fox_TEgear" },       TE_GearEquip)
    TE_AIM("Grizzly",  2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,     TE_Grizzly_Perk,     { "Grizzly_TEgear" },   TE_GearEquip)
    TE_AIM("Grunty",   4, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,     TE_Grunty_Perk,      { "Grunty_TEgear" },    TE_GearEquip)
    TE_AIM("Gus",      7, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,     TE_Gus_Perk,         { "Gus_TEgear" },       TE_GearEquip)
    TE_AIM("Hitman",   4, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,     TE_Hitman_Perk,      { "Hitman_TEgear" },    TE_GearEquip)
    TE_AIM("Ice",      3, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,     TE_Ice_Perk,         { "Ice_TEgear" },       TE_GearEquip)
    TE_AIM("Igor",     2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,     TE_Igor_Perk,        { "Igor_TEgear" },      TE_GearEquip)
    TE_AIM("Ivan",     5, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,     TE_Ivan_Perk,        { "Ivan_TEgear" },      TE_GearEquip)
    TE_AIM("Kalyna",   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,     TE_Kalyna_Perk,      { "Kalyna_TEgear" },    TE_GearEquip)
    TE_AIM("Len",      8, nil, 76,  90,  nil, nil, nil, nil, nil, nil, nil,     TE_Len_Perk,         { "Len_TEgear" },       TE_GearEquip)
    TE_AIM("Livewire", 1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,     TE_Livewire_Perk,    { "Livewire_TEgear" },  TE_GearEquip)
    TE_AIM("Magic",    6, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,     TE_Magic_Perk,       { "Magic_TEgear" },     TE_GearEquip)
    TE_AIM("MD",       2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,     TE_MD_Perk,          { "MD_TEgear" },        TE_GearEquip)
    TE_AIM("Meltdown", 3, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,     TE_Meltdown_Perk,    { "Meltdown_TEgear" },  TE_GearEquip)
    TE_AIM("Mouse",    2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,     TE_Mouse_Perk,       { "Mouse_TEgear" },     TE_GearEquip)
    TE_AIM("Nails",    5, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,     TE_Nails_Perk,       { "Nails_TEgear" },     TE_GearEquip)
    TE_AIM("Omryn",    2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,     TE_Omryn_Perk,       { "Omryn_TEgear" },     TE_GearEquip)
    TE_AIM("Raider",   4, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,     TE_Raider_Perk,      { "Raider_TEgear" },    TE_GearEquip)
    TE_AIM("Raven",    3, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,     TE_Raven_Perk,       { "Raven_TEgear" },     TE_GearEquip)
    TE_AIM("Reaper",   7, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,     TE_Reaper_Perk,      { "Reaper_TEgear" },    TE_GearEquip)
    TE_AIM("Red",      4, 86,  nil, nil, 71,  nil, 11,  nil, 22,  nil, nil,     TE_Red_Perk,         { "Red_TEgear" },       TE_GearEquip)
    TE_AIM("Scope",    7, nil, 90,  nil, nil, nil, nil, 98,  nil, nil, nil,     TE_Scope_Perk,       { "Scope_TEgear" },     TE_GearEquip)
    TE_AIM("Scully",   6, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,     TE_Scully_Perk,      { "Scully_TEgear" },    TE_GearEquip)
    TE_AIM("Shadow",   7, nil, nil, 91,  83,  nil, nil, nil, nil, nil, nil,     TE_Shadow_Perk,      { "Shadow_TEgear" },    TE_GearEquip)
    TE_AIM("Sidney",   6, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,     TE_Sidney_Perk,      { "Sidney_TEgear" },    TE_GearEquip)
    TE_AIM("Steroid",  2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,     TE_Steroid_Perk,     { "Steroid_TEgear" },   TE_GearEquip)
    TE_AIM("Tex",      4, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,     TE_Tex_Perk,         { "Tex_TEgear" },       TE_GearEquip)
    TE_AIM("Thor",     3, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,     TE_Thor_Perk,        { "Thor_TEgear" },      TE_GearEquip)
    TE_AIM("Vicki",    4, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,     TE_Vicki_Perk,       { "Vicki_TEgear" },     TE_GearEquip)
    TE_AIM("Wolf",     3, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,     TE_Wolf_Perk,        { "Wolf_TEgear" },      TE_GearEquip)
end

local function gen_AIM_Nationality()
    TE_Nationality("Omryn", "France")
end

PlaceObj('LootDef', {
	comment = "Barry Starting Gear",
	group = "Mercs",
	id = "Barry_TEgear",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		item = "_762WP_AP",
		stack_max = 30,
		stack_min = 30,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "ShapedCharge",
		stack_max = 2,
		stack_min = 2,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "RemoteC4",
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "FlakVest",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "FlakLeggings",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "Detonator",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		weapon = "AK47",
	}),
})
		
PlaceObj('LootDef', {
	comment = "Blood Starting Gear",
	group = "Mercs",
	id = "Blood_TEgear",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		item = "_9mm_HP",
		stack_max = 30,
		stack_min = 30,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "Meds",
		stack_max = 10,
		stack_min = 10,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "ToxicGasGrenade",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "Molotov",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "CamoArmor_Light",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "FirstAidKit",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "EndlessKnives",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		upgrades = {
			"Suppressor",
		},
		weapon = "MP5K",
	}),
})
		
PlaceObj('LootDef', {
	comment = "Buns Starting Gear",
	group = "Mercs",
	id = "Buns_TEgear",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		item = "_762NATO_Match",
		stack_max = 30,
		stack_min = 30,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "_44CAL_Match",
		stack_max = 12,
		stack_min = 12,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "FlareStick",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "LightHelmet",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "FlakArmor",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "FlakLeggings",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "FirstAidKit",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		weapon = "FNFAL",
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		weapon = "ColtPeacemaker",
	}),
})
		
PlaceObj('LootDef', {
	comment = "Dr. Q Starting Gear",
	group = "Mercs",
	id = "DrQ_TEgear",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		item = "_9mm_Subsonic",
		stack_max = 15,
		stack_min = 15,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "Meds",
		stack_max = 15,
		stack_min = 15,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "SmokeGrenade",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "TearGasGrenade",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "ConcussiveGrenade",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "LightHelmet",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "CamoArmor_Light",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "FlakLeggings",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "Medkit",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		upgrades = {
			"Suppressor",
		},
		weapon = "Bereta92",
	}),
})
		
PlaceObj('LootDef', {
	comment = "Fauda Starting Gear",
	group = "Mercs",
	id = "Fauda_TEgear",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		item = "_762WP_AP",
		stack_max = 60,
		stack_min = 60,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "Warhead_Frag",
		stack_max = 2,
		stack_min = 2,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "HeavyArmorHelmet",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "HeavyArmorTorso",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "HeavyArmorLeggings",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		upgrades = {
			"Bipod",
		},
		weapon = "RPK74",
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		weapon = "RPG7",
	}),
})
		
PlaceObj('LootDef', {
	comment = "Fidel Starting Gear",
	group = "Mercs",
	id = "Fidel_TEgear",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		item = "_762WP_AP",
		stack_max = 30,
		stack_min = 30,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "FragGrenade",
		stack_max = 2,
		stack_min = 2,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "Molotov",
		stack_max = 2,
		stack_min = 2,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "LightHelmet",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "FlakArmor",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "FlakLeggings",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		weapon = "AKSU",
	}),
})
		
PlaceObj('LootDef', {
	comment = "Fox Starting Gear",
	group = "Mercs",
	id = "Fox_TEgear",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		item = "_9mm_HP",
		stack_max = 30,
		stack_min = 30,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "_44CAL_Shock",
		stack_max = 12,
		stack_min = 12,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "Meds",
		stack_max = 12,
		stack_min = 12,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "Medkit",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		weapon = "MP5K",
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		upgrades = {
			"BarrelShort",
		},
		weapon = "ColtPeacemaker",
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		upgrades = {
			"BarrelShort",
		},
		weapon = "ColtPeacemaker",
	}),
})
		
PlaceObj('LootDef', {
	comment = "Grizzly Starting Gear",
	group = "Mercs",
	id = "Grizzly_TEgear",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		item = "_556_AP",
		stack_max = 30,
		stack_min = 30,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "_40mmFragGrenade",
		stack_max = 2,
		stack_min = 2,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "FlakVest",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "FlakLeggings",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		upgrades = {
			"GrenadeLauncher_Commando",
		},
		weapon = "M4Commando",
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		weapon = "Machete_Balanced",
	}),
})
		
PlaceObj('LootDef', {
	comment = "Grunty Starting Gear",
	group = "Mercs",
	id = "Grunty_TEgear",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		item = "_9mm_AP",
		stack_max = 30,
		stack_min = 30,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "_44CAL_AP",
		stack_max = 12,
		stack_min = 12,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "HE_Grenade",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "KevlarChestplate",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "FlakLeggings",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		weapon = "MP5",
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		weapon = "ColtAnaconda",
	}),
})
		
PlaceObj('LootDef', {
	comment = "Gus Starting Gear",
	group = "Mercs",
	id = "Gus_TEgear",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		item = "_762NATO_AP",
		stack_max = 20,
		stack_min = 20,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "_44CAL_AP",
		stack_max = 12,
		stack_min = 12,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "Meds",
		stack_max = 12,
		stack_min = 12,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "_40mmFragGrenade",
		stack_max = 2,
		stack_min = 2,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "_40mmFlashbangGrenade",
		stack_max = 2,
		stack_min = 2,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "HE_Grenade",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "KevlarHelmet",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "KevlarVest",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "KevlarLeggings",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "Medkit",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		upgrades = {
			"GrenadeLauncher_M14",
		},
		weapon = "M14SAW",
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		weapon = "ColtAnaconda",
	}),
})
		
PlaceObj('LootDef', {
	comment = "Hitman Starting Gear",
	group = "Mercs",
	id = "Hitman_TEgear",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		item = "_762NATO_Match",
		stack_max = 30,
		stack_min = 30,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "_44CAL_Match",
		stack_max = 15,
		stack_min = 15,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "SmokeGrenade",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "KevlarHelmet",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "KevlarVest",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "KevlarLeggings",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		weapon = "Galil",
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		weapon = "DesertEagle",
	}),
})
		
PlaceObj('LootDef', {
	comment = "Ice Starting Gear",
	group = "Mercs",
	id = "Ice_TEgear",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		item = "_9mm_Shock",
		stack_max = 30,
		stack_min = 30,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "_762NATO_Match",
		stack_max = 10,
		stack_min = 10,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "SmokeGrenade",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "LightHelmet",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "FlakArmor",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "FlakLeggings",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		weapon = "UZI",
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		weapon = "M24Sniper",
	}),
})
		
PlaceObj('LootDef', {
	comment = "Igor Starting Gear",
	group = "Mercs",
	id = "Igor_TEgear",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		item = "_762WP_HP",
		stack_max = 30,
		stack_min = 30,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "Molotov",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		upgrades = {
			"Suppressor",
		},
		weapon = "AKSU",
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		weapon = "Knife_Balanced",
	}),
})
		
PlaceObj('LootDef', {
	comment = "Ivan Starting Gear",
	group = "Mercs",
	id = "Ivan_TEgear",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		item = "_762WP_AP",
		stack_max = 30,
		stack_min = 30,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "Molotov",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "HE_Grenade",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "IvanUshanka",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "KevlarVest",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "KevlarLeggings",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "Crowbar",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		weapon = "AK74",
	}),
})
		
PlaceObj('LootDef', {
	comment = "Kalyna Starting Gear",
	group = "Mercs",
	id = "Kalyna_TEgear",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		item = "_762WP_Match",
		stack_max = 10,
		stack_min = 10,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "Molotov",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "FlareStick",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "Wirecutter",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		weapon = "DragunovSVD",
	}),
})
		
PlaceObj('LootDef', {
	comment = "Len Starting Gear",
	group = "Mercs",
	id = "Len_TEgear",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		item = "_12gauge_Breacher",
		stack_max = 15,
		stack_min = 15,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "_9mm_AP",
		stack_max = 30,
		stack_min = 30,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "Meds",
		stack_max = 10,
		stack_min = 10,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "HE_Grenade",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "HeavyArmorHelmet",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "HeavyArmorChestplate",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "HeavyArmorLeggings",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "FirstAidKit",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		weapon = "AA12",
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		weapon = "MP5K",
	}),
})
		
PlaceObj('LootDef', {
	comment = "Livewire Starting Gear",
	group = "Mercs",
	id = "Livewire_TEgear",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		item = "_9mm_Tracer",
		stack_max = 15,
		stack_min = 15,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "Meds",
		stack_max = 10,
		stack_min = 10,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "GlowStick",
		stack_max = 2,
		stack_min = 2,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "ConcussiveGrenade",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "SmokeGrenade",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "FirstAidKit",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "Lockpick",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "CustomPDA",
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		upgrades = {
			"Compensator_Glock",
		},
		weapon = "Glock18",
	}),
})
		
PlaceObj('LootDef', {
	comment = "Magic Starting Gear",
	group = "Mercs",
	id = "Magic_TEgear",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		item = "_556_Match",
		stack_max = 30,
		stack_min = 30,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "_9mm_Subsonic",
		stack_max = 15,
		stack_min = 15,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "TearGasGrenade",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "LightHelmet",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "CamoArmor_Light",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "FlakLeggings",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "Lockpick",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		upgrades = {
			"AUGCompensator_03",
		},
		weapon = "AUG",
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		upgrades = {
			"Suppressor",
		},
		weapon = "Bereta92",
	}),
})
		
PlaceObj('LootDef', {
	comment = "MD Starting Gear",
	group = "Mercs",
	id = "MD_TEgear",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		item = "_9mm_Shock",
		stack_max = 15,
		stack_min = 15,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "Meds",
		stack_max = 15,
		stack_min = 15,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "SmokeGrenade",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "TearGasGrenade",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "FlakVest",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "FlakLeggings",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "Medkit",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		weapon = "MP5",
	}),
})
		
PlaceObj('LootDef', {
	comment = "Meltdown Starting Gear",
	group = "Mercs",
	id = "Meltdown_TEgear",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		item = "_9mm_AP",
		stack_max = 30,
		stack_min = 30,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "HE_Grenade",
		stack_max = 2,
		stack_min = 2,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "PipeBomb",
		stack_max = 2,
		stack_min = 2,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "LightHelmet",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "FlakArmor",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "FlakLeggings",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		weapon = "Bereta92",
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		weapon = "Bereta92",
	}),
})
		
PlaceObj('LootDef', {
	comment = "Mouse Starting Gear",
	group = "Mercs",
	id = "Mouse_TEgear",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		item = "_9mm_Subsonic",
		stack_max = 15,
		stack_min = 15,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "Meds",
		stack_max = 10,
		stack_min = 10,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "ToxicGasGrenade",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "SmokeGrenade",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "FirstAidKit",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		upgrades = {
			"Suppressor",
		},
		weapon = "Bereta92",
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		weapon = "Knife_Sharpened",
	}),
})
		
PlaceObj('LootDef', {
	comment = "Nails Starting Gear",
	group = "Mercs",
	id = "Nails_TEgear",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		item = "_12gauge_Flechette",
		stack_max = 10,
		stack_min = 10,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "FragGrenade",
		stack_max = 2,
		stack_min = 2,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "ProximityPETN",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "LightHelmet",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "NailsLeatherVest",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "FlakLeggings",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "Wirecutter",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		weapon = "DoubleBarrelShotgun",
	}),
})

PlaceObj('LootDef', {
	comment = "Omryn Starting Gear",
	group = "Mercs",
	id = "Omryn_TEgear",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		item = "_556_Match",
		stack_max = 25,
		stack_min = 25,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "Molotov",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "FlakVest",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "FlakLeggings",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "GutHookKnife",
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		weapon = "FAMAS",
	}),
})
		
PlaceObj('LootDef', {
	comment = "Raider Starting Gear",
	group = "Mercs",
	id = "Raider_TEgear",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		item = "_12gauge_Breacher",
		stack_max = 12,
		stack_min = 12,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "TearGasGrenade",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "ConcussiveGrenade",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "KevlarHelmet",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "KevlarVest",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "KevlarLeggings",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		weapon = "M41Shotgun",
	}),
})
		
PlaceObj('LootDef', {
	comment = "Raven Starting Gear",
	group = "Mercs",
	id = "Raven_TEgear",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		item = "_556_Tracer",
		stack_max = 30,
		stack_min = 30,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "SmokeGrenade",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "TearGasGrenade",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "ConcussiveGrenade",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "LightHelmet",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "FlakArmor",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "FlakLeggings",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		weapon = "M16A2",
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		weapon = "TE_Binoculars",
	}),
})
		
PlaceObj('LootDef', {
	comment = "Reaper Starting Gear",
	group = "Mercs",
	id = "Reaper_TEgear",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		item = "_50BMG_SLAP",
		stack_max = 10,
		stack_min = 10,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "_50BMG_Incendiary",
		stack_max = 15,
		stack_min = 15,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "ToxicGasGrenade",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "KevlarHelmet",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "CamoArmor_Medium",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "KevlarLeggings",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "Lockpick",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		upgrades = {
			"LROpticsAdvanced",
			"Suppressor",
		},
		weapon = "BarretM82",
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		upgrades = {
			"Barrel50BMG_DesertEagle",
			"Suppressor",
		},
		weapon = "DesertEagle",
	}),
})
		
PlaceObj('LootDef', {
	comment = "Red Starting Gear",
	group = "Mercs",
	id = "Red_TEgear",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		item = "_44CAL_HP",
		stack_max = 12,
		stack_min = 12,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "HE_Grenade",
		stack_max = 2,
		stack_min = 2,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "ProximityTNT",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "RemoteTNT",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "KevlarHelmet",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "KevlarChestplate",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "KevlarLeggings",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "Detonator",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		weapon = "ColtAnaconda",
	}),
})
		
PlaceObj('LootDef', {
	comment = "Scope Starting Gear",
	group = "Mercs",
	id = "Scope_TEgear",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		item = "_762NATO_Match",
		stack_max = 10,
		stack_min = 10,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "FlareStick",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "FlareAmmo",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "LightHelmet",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "CamoArmor_Light",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "FlakLeggings",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "Cookie",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		weapon = "PSG1",
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		weapon = "FlareHandgun",
	}),
})
		
PlaceObj('LootDef', {
	comment = "Scully Starting Gear",
	group = "Mercs",
	id = "Scully_TEgear",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		item = "_556_Tracer",
		stack_max = 100,
		stack_min = 100,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "Meds",
		stack_max = 10,
		stack_min = 10,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "HE_Grenade",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "HeavyArmorHelmet",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "HeavyArmorChestplate",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "HeavyArmorLeggings",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "FirstAidKit",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		upgrades = {
			"Bipod",
		},
		weapon = "FNMinimi",
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		weapon = "Knife_Sharpened",
	}),
})
		
PlaceObj('LootDef', {
	comment = "Shadow Starting Gear",
	group = "Mercs",
	id = "Shadow_TEgear",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		item = "_556_Match",
		stack_max = 30,
		stack_min = 30,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "TimedC4",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "KevlarHelmet",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "CamoArmor_Medium",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "KevlarLeggings",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		upgrades = {
			"Suppressor",
		},
		weapon = "G36",
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		weapon = "Knife_Sharpened",
	}),
})
		
PlaceObj('LootDef', {
	comment = "Sidney Starting Gear",
	group = "Mercs",
	id = "Sidney_TEgear",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		item = "_556_Match",
		stack_max = 30,
		stack_min = 30,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "_9mm_Match",
		stack_max = 30,
		stack_min = 30,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "Meds",
		stack_max = 10,
		stack_min = 10,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "HE_Grenade",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "KevlarHelmet",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "KevlarChestplate",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "KevlarLeggings",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "FirstAidKit",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		upgrades = {
			"LROpticsAdvanced",
		},
		weapon = "AR15",
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		weapon = "UZI",
	}),
})
		
PlaceObj('LootDef', {
	comment = "Steroid Starting Gear",
	group = "Mercs",
	id = "Steroid_TEgear",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		item = "_12gauge_Breacher",
		stack_max = 6,
		stack_min = 6,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "Molotov",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "FlareStick",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "CombatStim",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "Crowbar",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		upgrades = {
			"BarrelShortShotgun",
		},
		weapon = "DoubleBarrelShotgun",
	}),
})
		
PlaceObj('LootDef', {
	comment = "Tex Starting Gear",
	group = "Mercs",
	id = "Tex_TEgear",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		item = "_44CAL_Match",
		stack_max = 14,
		stack_min = 14,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "_44CAL_Shock",
		stack_max = 28,
		stack_min = 28,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "LightHelmet",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "FlakArmor",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "FlakLeggings",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "TexRevolver",
		stack_max = 2,
		stack_min = 2,
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		upgrades = {
			"BarrelShort_Winchester",
		},
		weapon = "Winchester1894",
	}),
})
		
PlaceObj('LootDef', {
	comment = "Thor Starting Gear",
	group = "Mercs",
	id = "Thor_TEgear",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		item = "_9mm_Subsonic",
		stack_max = 30,
		stack_min = 30,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "Meds",
		stack_max = 15,
		stack_min = 15,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "Medkit",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "SmokeGrenade",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "TearGasGrenade",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "LightHelmet",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "CamoArmor_Light",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "FlakLeggings",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		upgrades = {
			"Suppressor",
		},
		weapon = "MP5",
	}),
})
		
PlaceObj('LootDef', {
	comment = "Vicki Starting Gear",
	group = "Mercs",
	id = "Vicki_TEgear",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		item = "_44CAL_AP",
		stack_max = 60,
		stack_min = 60,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "ToxicGasGrenade",
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "SmokeGrenade",
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "LightHelmet",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "FlakArmor",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "FlakLeggings",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "Personal_Vicki_CustomTools",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		weapon = "UZI",
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		weapon = "UZI",
	}),
})
		
PlaceObj('LootDef', {
	comment = "Wolf Starting Gear",
	group = "Mercs",
	id = "Wolf_TEgear",
	loot = "all",
	PlaceObj('LootEntryInventoryItem', {
		item = "_12gauge_Saltshot",
		stack_max = 8,
		stack_min = 8,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "FragGrenade",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "LightHelmet",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "FlakArmor",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "FlakLeggings",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "FirstAidKit",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryInventoryItem', {
		item = "Wirecutter",
		stack_max = 1,
		stack_min = 1,
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		upgrades = {
			"Auto5_Long_LMag",
		},
		weapon = "Auto5",
	}),
	PlaceObj('LootEntryUpgradedWeapon', {
		weapon = "Knife_Balanced",
	}),
})

PlaceObj('MercNationalities', {
	DisplayName = T(3042581131110003, --[[MercNationalities Default France DisplayName]] "France"),
	Icon = "Mod/JA3_TacticianEnhanced/Images/nationality_france",
	group = "Default",
	id = "France",
})


--Tactician Enhanced Tactical A.I.M. Overhaul Loaded
function OnMsg.ModsReloaded()
	if not TE_DataReady() then return end
	if CurrentModOptions["Tactical_AIM"] then
		gen_TacticalAIM()
		gen_AIM_Nationality()
	end
end
function OnMsg.DataLoaded()
	if CurrentModOptions["Tactical_AIM"] then
		gen_TacticalAIM()
		gen_AIM_Nationality()
	end
end
function OnMsg.OptionsApply()
	if not TE_DataReady() then return end
	if CurrentModOptions["Tactical_AIM"] then
		gen_TacticalAIM()
		gen_AIM_Nationality()
	end
end