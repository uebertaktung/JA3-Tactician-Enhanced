UndefineClass('ReconnaissanceSpottedBad')
DefineClass.ReconnaissanceSpottedBad = {
	__parents = { "CharacterEffect" },
	__generated_by_class = "ModItemCharacterEffectCompositeDef",


	comment = "Target Spotted (Night & Fog)",
	object_class = "CharacterEffect",
	unit_reactions = {
		PlaceObj('UnitReaction', {
			Event = "OnCalcSightModifier",
			Handler = function (self, target, value, observer, other, step_pos, darkness)
				if target == other then
					return value + self:ResolveValue("reconnaissance_spotted_bad")
				end
			end,
		}),
	},
	OnAdded = function (self, obj)  end,
	OnRemoved = function (self, obj)  end,
	lifetime = "Until End of Turn",
	Icon = "Mod/JA3_TacticianEnhanced/Images/enemy_spotted.png",
	RemoveOnEndCombat = true,
}

