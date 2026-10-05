UndefineClass('EnemyBioInfection')
DefineClass.EnemyBioInfection = {
	__parents = { "CharacterEffect" },
	__generated_by_class = "ModItemCharacterEffectCompositeDef",


	comment = "Enemy Infected Arising (Illustrative Purposes)",
	object_class = "CharacterEffect",
	DisplayName = T(231671256098, --[[ModItemCharacterEffectCompositeDef EnemyBioInfection DisplayName]] "B.O.W. Infection"),
	Description = T(930125021608, --[[ModItemCharacterEffectCompositeDef EnemyBioInfection Description]] "Might become a <em>Zombie</em> after <em>Death</em>."),
	OnAdded = function (self, obj)  end,
	OnRemoved = function (self, obj)  end,
	Icon = "Mod/JA3_TacticianEnhanced/Images/bio_infected.png",
	RemoveOnEndCombat = true,
	Shown = true,
}

