UndefineClass('TE_Binoculars')
DefineClass.TE_Binoculars = {
	__parents = { "UnarmedWeapon" },
	__generated_by_class = "ModItemInventoryItemCompositeDef",


	comment = "Binoculars Reconnaissance Task",
	NameColor = 4292942230,
	object_class = "UnarmedWeapon",
	ScrapParts = 3,
	Reliability = 100,
	Icon = "Mod/JA3_TacticianEnhanced/Images/te_binoculars.png",
	ItemType = "MeleeWeapon",
	DisplayName = T(945730532346, --[[ModItemInventoryItemCompositeDef TE_Binoculars DisplayName]] "Binoculars"),
	DisplayNamePlural = T(773828194326, --[[ModItemInventoryItemCompositeDef TE_Binoculars DisplayNamePlural]] "Binoculars"),
	Description = T(127020491494, --[[ModItemInventoryItemCompositeDef TE_Binoculars Description]] "Binoculars have a long history of military use. Galilean designs were widely used up to the end of the 19th century when they gave way to porro prism types. Binoculars constructed for general military use tend to be more rugged than their civilian counterparts. They generally avoid fragile center focus arrangements in favor of independent focus, which also makes for easier, more effective weatherproofing. Prism sets in military binoculars may have redundant aluminized coatings on their prism sets to guarantee they do not lose their reflective qualities if they get wet. A combination of binoculars and periscope, often used for artillery spotting purposes. It projected only a few inches above the parapet, thus keeping the viewer's head safely in the trench. Military binoculars can and were also used as measuring and aiming devices, and can feature filters and illuminated reticles."),
	AdditionalHint = T(451215863724, --[[ModItemInventoryItemCompositeDef TE_Binoculars AdditionalHint]] "<bullet_point> Can perform <color 225 25 150>Reconnaissance</color> <GameTerm('Overwatch')> while holding <em>RIFLES</em>\n\n<bullet_point> <GameTerm('Overwatch')> Cone Angle is limited while being in <em>Reconnaissance</em>\n\n<bullet_point> Detect all enemies in <GameTerm('Overwatch')> covered area on <em>Exploration</em> mode or at the <em>NEXT Turn</em> during <em>Combat</em>\n\n<bullet_point> <em>Darkness</em> and <em>Adverse</em> weather may reduce the <em>Reconnaissance</em> range\n\n<bullet_point> Will NOT work under <em>Darkness</em> unless with <em>Night Ops</em> or wear <em>NVGs</em>\n\n<bullet_point> Will NOT fire any <GameTerm('Interrupt')> attack while being in <GameTerm('Overwatch')>"),
	UnitStat = "Dexterity",
	Cost = 3000,
	CanAppearInShop = true,
	PenetrationClass = 4,
	WeaponRange = 0,
	IsUnarmed = true,
	AttackAP = 3000,
	MaxAimActions = 1,
	Noise = 1,
	NeckAttackType = "choke",
	CanAppearUsed = false,
}

