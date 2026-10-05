UndefineClass('GlobalEnemySpotted')
DefineClass.GlobalEnemySpotted = {
	__parents = { "CharacterEffect" },
	__generated_by_class = "ModItemCharacterEffectCompositeDef",


	comment = "Enemy Spotted by spotter (Illustrative Purposes)",
	object_class = "CharacterEffect",
	DisplayName = T(340189696024, --[[ModItemCharacterEffectCompositeDef GlobalEnemySpotted DisplayName]] "Spotted"),
	Description = T(851807716454, --[[ModItemCharacterEffectCompositeDef GlobalEnemySpotted Description]] "Enemy is <em>Spotted</em> by <color 225 25 150>Reconnaissance</color>"),
	AddEffectText = T(175573219044, --[[ModItemCharacterEffectCompositeDef GlobalEnemySpotted AddEffectText]] "<color EmStyle><DisplayName></color> is <em>Spotted</em>!"),
	OnAdded = function (self, obj)  end,
	OnRemoved = function (self, obj)  end,
	lifetime = "Until End of Turn",
	Icon = "Mod/JA3_TacticianEnhanced/Images/enemy_spotted.png",
	RemoveOnEndCombat = true,
	Shown = true,
	HasFloatingText = true,
}

