UndefineClass('TutorialMinion')
DefineClass.TutorialMinion = {
	__parents = { "Perk" },
	__generated_by_class = "ModItemCharacterEffectCompositeDef",


	comment = "FlagHill (I1) Tutorial Enemies (Illustrative Purposes)",
	object_class = "Perk",
	DisplayName = T(153563717564, --[[ModItemCharacterEffectCompositeDef TutorialMinion DisplayName]] "Tutorial Minion"),
	Description = T(964142353878, --[[ModItemCharacterEffectCompositeDef TutorialMinion Description]] "<color EmStyle>Tactician Enhanced is NOT fully activated in the current Sector!</color>"),
	OnAdded = function (self, obj)
		obj:AddStatusEffectImmunity("TacticalEnemy", self.class)
		obj:AddStatusEffectImmunity("EnemyCQCReaction", self.class)
	end,
	OnRemoved = function (self, obj)
		obj:RemoveStatusEffectImmunity("TacticalEnemy", self.class)
		obj:RemoveStatusEffectImmunity("EnemyCQCReaction", self.class)
	end,
	Icon = "UI/Hud/Status effects/tired",
	Shown = true,
}

