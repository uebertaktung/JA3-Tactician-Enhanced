UndefineClass('GlobalSightRange')
DefineClass.GlobalSightRange = {
	__parents = { "CharacterEffect" },
	__generated_by_class = "ModItemCharacterEffectCompositeDef",


	comment = "Global Sight Overhaul (Illustrative Purposes)",
	object_class = "CharacterEffect",
	unit_reactions = {
		PlaceObj('UnitReaction', {
			Event = "OnCalcSightModifier",
			Handler = function (self, target, value, observer, other, step_pos, darkness)
				--TE Global Visibility Overhaul [!MUST HAVE!] -- !!!Do NOT Change this one!!! (TE Core Logic)
				if target == other then
					return value + self:ResolveValue("global_sight_range_mod")
				end
			end,
		}),
	},
	OnAdded = function (self, obj)  end,
	OnRemoved = function (self, obj)  end,
	Icon = "UI/Hud/Status effects/hidden",
}

