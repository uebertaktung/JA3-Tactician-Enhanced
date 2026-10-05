UndefineClass('LightStepRemake')
DefineClass.LightStepRemake = {
	__parents = { "Perk" },
	__generated_by_class = "ModItemCharacterEffectCompositeDef",


	comment = '"Light-footed" Remake (Illustrative Purposes)',
	object_class = "Perk",
	unit_reactions = {
		PlaceObj('UnitReaction', {
			Event = "OnCalcMoveModifier",
			Handler = function (self, target, value, action)
				--JA3 Light-footed Remake [!MUST HAVE!] -- !!!Do NOT Change this one!!! (TE Core Logic)
				if target:HasStatusEffect("Hidden") and action.id == "Move" then
					return value - self:ResolveValue("sneaking_move_modifier")
				end
			end,
		}),
	},
	DisplayName = T(952723645410, --[[ModItemCharacterEffectCompositeDef LightStepRemake DisplayName]] "Light-footed"),
	Description = T(448296624879, --[[ModItemCharacterEffectCompositeDef LightStepRemake Description]] "Dramatically increased <em>Movement Range</em> while <GameTerm('Sneaking')> in <em>Combat</em>."),
	OnAdded = function (self, obj)
		obj:AddStatusEffectImmunity("LightStep", self.class)
		obj:RemoveStatusEffect("LightStep")
	end,
	OnRemoved = function (self, obj)
		obj:RemoveStatusEffectImmunity("LightStep", self.class)
		obj:AddStatusEffect("LightStep")
	end,
	Icon = "UI/Icons/Perks/LightStep",
	RemoveOnEndCombat = true,
	RemoveOnSatViewTravel = true,
}

