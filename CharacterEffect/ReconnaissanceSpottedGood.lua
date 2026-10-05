UndefineClass('ReconnaissanceSpottedGood')
DefineClass.ReconnaissanceSpottedGood = {
	__parents = { "CharacterEffect" },
	__generated_by_class = "ModItemCharacterEffectCompositeDef",


	comment = "Target Spotted (Day & Fog)",
	object_class = "CharacterEffect",
	unit_reactions = {
		PlaceObj('UnitReaction', {
			Event = "OnCalcSightModifier",
			Handler = function (self, target, value, observer, other, step_pos, darkness)
				if target == other then
					return value + self:ResolveValue("reconnaissance_spotted_good")
				end
			end,
		}),
	},
	OnAdded = function (self, obj)
		obj:AddStatusEffectImmunity("ReconnaissanceSpottedBad", self.class)
		obj:AddStatusEffectImmunity("ReconnaissanceSpottedNVG", self.class)
	end,
	OnRemoved = function (self, obj)
		obj:RemoveStatusEffectImmunity("ReconnaissanceSpottedBad", self.class)
		obj:RemoveStatusEffectImmunity("ReconnaissanceSpottedNVG", self.class)
	end,
	lifetime = "Until End of Turn",
	Icon = "Mod/JA3_TacticianEnhanced/Images/enemy_spotted.png",
	RemoveOnEndCombat = true,
}

