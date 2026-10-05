UndefineClass('InfectedHyena')
DefineClass.InfectedHyena = {
	__parents = { "UnitData" },
	__generated_by_class = "ModItemUnitDataCompositeDef",


	comment = "B.O.W. Infected Hyena",
	object_class = "UnitData",
	Health = 95,
	Agility = 95,
	Dexterity = 95,
	Strength = 95,
	Wisdom = 5,
	Leadership = 5,
	Marksmanship = 5,
	Mechanical = 5,
	Explosives = 5,
	Medical = 5,
	Name = T(850140851420, --[[ModItemUnitDataCompositeDef InfectedHyena Name]] "Zombie Hyena"),
	Randomization = true,
	Affiliation = "Secret",
	StartingLevel = 10,
	neutral_retaliate = true,
	archetype = "Beast_Hyena",
	role = "Beast",
	CanManEmplacements = false,
	RepositionArchetype = "Scout_LastLocation",
	OpeningAttackType = "PinDown",
	MaxHitPoints = 125,
	StartingPerks = {
		"ZombiePerk",
		"NaturalCamouflage",
		"LightningReactionNPC",
		"FleetingShadow",
		"MakeThemBleed",
		"MeleeTraining",
		"NightOps",
		"BeefedUp",
		"Berserker",
		"SwiftStrike",
		"Flanker",
		"ColdHeart",
		"BloodlustPerk",
		"HardBlow",
		"BloodScent",
		"Hobbler",
	},
	AppearancesList = {
		PlaceObj('AppearanceWeight', {
			'Preset', "Infected_Hyena_01",
		}),
		PlaceObj('AppearanceWeight', {
			'Preset', "Infected_Hyena_02",
		}),
		PlaceObj('AppearanceWeight', {
			'Preset', "Infected_Hyena_03",
		}),
		PlaceObj('AppearanceWeight', {
			'Preset', "Infected_Hyena_04",
		}),
		PlaceObj('AppearanceWeight', {
			'Preset', "Infected_Hyena_05",
		}),
	},
	Equipment = {
		"BOW_Hunter_Gear",
	},
	species = "Hyena",
	body_type = "Small animal",
	infected = true,
}

