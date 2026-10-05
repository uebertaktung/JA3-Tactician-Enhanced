UndefineClass('BOWSuperMK1')
DefineClass.BOWSuperMK1 = {
	__parents = { "UnitData" },
	__generated_by_class = "ModItemUnitDataCompositeDef",


	comment = "B.O.W. Super Soldier MK.I",
	object_class = "UnitData",
	Health = 100,
	Agility = 100,
	Dexterity = 100,
	Strength = 100,
	Wisdom = 100,
	Leadership = 100,
	Marksmanship = 100,
	Mechanical = 100,
	Explosives = 100,
	Medical = 100,
	Name = T(676596095717, --[[ModItemUnitDataCompositeDef BOWSuperMK1 Name]] "Über Soldat"),
	Randomization = true,
	Affiliation = "Secret",
	StartingLevel = 10,
	neutral_retaliate = true,
	AIKeywords = {
		"Soldier",
		"Sniper",
		"Control",
		"Smoke",
		"Ordnance",
		"Explosives",
	},
	role = "Soldier",
	RepositionArchetype = "Scout_LastLocation",
	OpeningAttackType = "PinDown",
	PickCustomArchetype = function (self, proto_context)
		local enemy, dist = GetNearestEnemy(self)
		local enemies = self:GetVisibleEnemies()
		local weapon = self:GetActiveWeapons()
		local slot = self.current_weapon
		local archetype = self.archetype
		
		if enemy and dist <= 25 * const.SlabSizeX then
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
	end,
	CustomEquipGear = function (self, items)
		self:TryEquip(items, "Handheld A", "AssaultRifle")
		self:TryEquip(items, "Handheld A", "SniperRifle")
		self:TryEquip(items, "Handheld A", "MachineGun")
		self:TryEquip(items, "Handheld A", "SubmachineGun")
		self:TryEquip(items, "Handheld A", "SubmachineGun")
		self:TryEquip(items, "Handheld A", "Shotgun")
		self:TryEquip(items, "Handheld A", "MeleeWeapon")
		self:TryEquip(items, "Handheld A", "HeavyWeapon")
		self:TryEquip(items, "Handheld B", "Pistol")
		self:TryEquip(items, "Handheld B", "Pistol")
		self:TryEquip(items, "Handheld B", "Revolver")
		self:TryEquip(items, "Handheld B", "Revolver")
		self:TryEquip(items, "Handheld B", "FlareGun")
		self:TryEquip(items, "Handheld B", "Grenade")
		self:TryEquip(items, "Handheld B", "Grenade")
		self:TryLoadAmmo("Handheld A", "MachineGun", "_7_92x57_AP")
		self:TryLoadAmmo("Handheld A", "MachineGun", "_762NATO_AP")
		self:TryLoadAmmo("Handheld A", "MachineGun", "_44CAL_AP")
		self:TryLoadAmmo("Handheld A", "SniperRifle", "_50BMG_SLAP")
	end,
	MaxHitPoints = 125,
	StartingPerks = {
		"DieselPerk",
		"NaturalCamouflage",
		"FleetingShadow",
		"KillingWind",
		"HeavyWeaponsTraining",
		"AutoWeapons",
		"NightOps",
		"Throwing",
		"HitTheDeck",
		"BeefedUp",
		"Berserker",
		"HoldPosition",
		"BattleFocus",
		"TakeAim",
		"Ironclad",
		"CollateralDamage",
		"Hobbler",
		"LastWarning",
	},
	AppearancesList = {
		PlaceObj('AppearanceWeight', {
			'Preset', "HellGate_Super_MK1",
		}),
	},
	Equipment = {
		"Super_MK1_Gear",
	},
	Tier = "Elite",
	pollyvoice = "Joey",
	gender = "Male",
	VoiceResponseId = "SuperSoldier_Assault",
}

