UndefineClass('GlobalVisualContact')
DefineClass.GlobalVisualContact = {
	__parents = { "CharacterEffect" },
	__generated_by_class = "ModItemCharacterEffectCompositeDef",


	comment = "Global Visual Overhaul (Illustrative Purposes)",
	object_class = "CharacterEffect",
	OnAdded = function (self, obj)  end,
	OnRemoved = function (self, obj)  end,
	lifetime = "Until End of Turn",
	Icon = "UI/Hud/Status effects/revealed",
	RemoveOnEndCombat = true,
}

