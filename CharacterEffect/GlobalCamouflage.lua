UndefineClass('GlobalCamouflage')
DefineClass.GlobalCamouflage = {
	__parents = { "CharacterEffect" },
	__generated_by_class = "ModItemCharacterEffectCompositeDef",


	comment = "Global Camouflage Effect (Illustrative Purposes)",
	object_class = "CharacterEffect",
	DisplayName = T(340700194349, --[[ModItemCharacterEffectCompositeDef GlobalCamouflage DisplayName]] "Camouflage"),
	Description = T(283171897623, --[[ModItemCharacterEffectCompositeDef GlobalCamouflage Description]] "<color EmStyle>Camo-Kit</color> has being applied to this character and will be MUCH HARDER to spot by the opponents."),
	OnAdded = function (self, obj)  end,
	OnRemoved = function (self, obj)  end,
	Icon = "Mod/JA3_TacticianEnhanced/Images/camo_activated.png",
	Shown = true,
}

