UndefineClass('IlluminationSpotted')
DefineClass.IlluminationSpotted = {
	__parents = { "CharacterEffect" },
	__generated_by_class = "ModItemCharacterEffectCompositeDef",


	comment = "Target Illuminated (Flashlight & Tracers)",
	object_class = "CharacterEffect",
	unit_reactions = {
		PlaceObj('UnitReaction', {
			Event = "OnStatusEffectAdded",
			Handler = function (self, target, id, stacks)
				if CharacterEffectDefs.IlluminationSpotted then
					for _, other in ipairs(target.team.units) do
						if other ~= target and other:IsPointBlankRange(target) then
							other:AddStatusEffect("IlluminationSpotted")
						end
					end
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

