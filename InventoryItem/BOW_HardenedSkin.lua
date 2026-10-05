UndefineClass('BOW_HardenedSkin')
DefineClass.BOW_HardenedSkin = {
	__parents = { "Armor" },
	__generated_by_class = "ModItemInventoryItemCompositeDef",


	NameColor = 4289795598,
	object_class = "Armor",
	RepairCost = 0,
	Repairable = false,
	Degradation = 0,
	Icon = "UI/Icons/Items/shaman_armor",
	SubIcon = "UI/Icons/Items/kompositum58.png",
	DisplayName = T(963293413235, --[[ModItemInventoryItemCompositeDef BOW_HardenedSkin DisplayName]] "Resilience"),
	DisplayNamePlural = T(466287168405, --[[ModItemInventoryItemCompositeDef BOW_HardenedSkin DisplayNamePlural]] "Resilience"),
	locked = true,
	CategoryPair = "Heavy",
	PenetrationClass = 5,
	DamageReduction = 35,
	AdditionalReduction = 60,
	ProtectedBodyParts = set( "Arms", "Groin", "Head", "Legs", "Torso" ),
	Camouflage = true,
}

