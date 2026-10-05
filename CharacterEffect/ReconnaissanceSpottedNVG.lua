UndefineClass('ReconnaissanceSpottedNVG')
DefineClass.ReconnaissanceSpottedNVG = {
	__parents = { "CharacterEffect" },
	__generated_by_class = "ModItemCharacterEffectCompositeDef",


	comment = "Target Spotted (DARKNESS)",
	object_class = "CharacterEffect",
	unit_reactions = {
		PlaceObj('UnitReaction', {
			Event = "OnCalcSightModifier",
			Handler = function (self, target, value, observer, other, step_pos, darkness)
				if target == other then
					return value + self:ResolveValue("reconnaissance_spotted_nvg")
				end
			end,
		}),
	},
	OnAdded = function (self, obj)
		obj:AddStatusEffectImmunity("ReconnaissanceSpottedBad", self.class)
		obj:AddStatusEffectImmunity("ReconnaissanceSpottedGood", self.class)
	end,
	OnRemoved = function (self, obj)
		obj:RemoveStatusEffectImmunity("ReconnaissanceSpottedBad", self.class)
		obj:RemoveStatusEffectImmunity("ReconnaissanceSpottedGood", self.class)
	end,
	lifetime = "Until End of Turn",
	Icon = "Mod/JA3_TacticianEnhanced/Images/enemy_spotted.png",
	RemoveOnEndCombat = true,
}

