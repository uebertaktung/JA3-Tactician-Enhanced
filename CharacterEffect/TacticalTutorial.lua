UndefineClass('TacticalTutorial')
DefineClass.TacticalTutorial = {
	__parents = { "Perk" },
	__generated_by_class = "ModItemCharacterEffectCompositeDef",


	comment = "Tactical Tutorial INFO (Illustrative Purposes)",
	object_class = "Perk",
	DisplayName = T(840223577235, --[[ModItemCharacterEffectCompositeDef TacticalTutorial DisplayName]] "Tactical Tutorial"),
	Description = T(487815747211, --[[ModItemCharacterEffectCompositeDef TacticalTutorial Description]] '<color EmStyle>"Know yourself and know your enemy, and you will win a hundred battles."</color>\n\n<bullet_point> On Combat Started, <GameTerm(\'Sneaking\')> is ONLY allowed while staying <em>Statically</em> and CANNOT gain <GameTerm(\'FreeMove\')>! Instead, The character gains <GameTerm(\'TE_Concealed\')> and is harder to spot while in <em>Cover</em> or on <em>Prone</em> stance <em>Statically</em>. <em>Crouch</em> stance with <em>Untraceable</em> or <em>Stealthy</em> Perk or <em>Standing</em> with <em>Fleeting Shadow</em> Perk will gain the same benefit if staying <GameTerm(\'TE_Concealed\')>. <em>Reveals</em> yourself as soon as you start ANY <em>Movement</em> in your turn!\n\n<bullet_point> Attacks from the <em>other side</em> of the <em>Cover</em> against the opponent have a HIGH chance (based on <em>Agility</em> VS an opposed <em>Dexterity</em> check) to become <em>Grazing hits</em> (GUARANTEED while <em>Taking Cover</em> or with <em>Lightning Reactions</em> Perk). ALL Solid-Timber, Double-Brick, Metal & Steel, Concrete & Stone <em>Cover Material</em> is GREATLY <em>Reforged</em> & <em>Reinforced</em>!\n\n<bullet_point> The character will gain <em>Camouflage</em> with <em>Camo Armor</em> or <em>Ambusher</em> Perk. Will be MUCH harder to spot by opponents. <em>Darkness</em> and some <em>Adverse</em> weather severely reduce <em>Sight Range</em> and will NOT spot the opponents with <em>Camouflage</em> until reach <GameTerm(\'PointBlankRange\')>!\n\n<bullet_point> Use <color 225 25 150>Binoculars</color> <GameTerm(\'TE_Reconnaissance\')> <GameTerm(\'Overwatch\')> to detect all enemies in <GameTerm(\'Overwatch\')> covered area. Will NOT work under <em>Darkness</em> unless with <em>Night Ops</em> or wear <em>NVGs</em> (Night Vision Goggles)!\n\n<bullet_point> Suffer <em>5</em> stacks <GameTerm(\'Wounded\')> cause <em>Arrhythmia</em>: Perform any <em>Attack</em> based action will force the character <em>Maximum AP</em> to <em>ZERO</em> (Except <GameTerm(\'Interrupt\')> attacks) and CANNOT gain <GameTerm(\'FreeMove\')>.'),
	OnAdded = function (self, obj)  end,
	OnRemoved = function (self, obj)  end,
	Icon = "UI/Hud/Status effects/suspicious",
	RemoveOnSatViewTravel = true,
}

