UndefineClass('TacticalAmbusher')
DefineClass.TacticalAmbusher = {
	__parents = { "CharacterEffect" },
	__generated_by_class = "ModItemCharacterEffectCompositeDef",


	comment = "Ambusher from Sector DiceRoll!",
	object_class = "CharacterEffect",
	unit_reactions = {
		PlaceObj('UnitReaction', {
			Event = "OnBeginTurn",
			Handler = function (self, target)
				--Ambusher Traits [!OPTIONAL!]
				local allEnemies = GetAllEnemyUnits(target)
				for _, enemy in ipairs(allEnemies) do
					local enemyDist = DivCeil(target:GetDist(enemy), const.SlabSizeX)
					if HasVisibilityTo(enemy, target) and (enemyDist < 16) then
						enemy:AddStatusEffect("IlluminationSpotted") -- Ambusher ReconOps!
						enemy:AddStatusEffect("GlobalVisualContact")
						enemy:AddStatusEffect("Revealed")
					end
				end
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnEndTurn",
			Handler = function (self, target)
				--Ambusher Traits [!OPTIONAL!]
				local allEnemies = GetAllEnemyUnits(target)
				for _, enemy in ipairs(allEnemies) do
					local enemyDist = DivCeil(target:GetDist(enemy), const.SlabSizeX)
					if HasVisibilityTo(enemy, target) and (enemyDist < 16) then
						enemy:AddStatusEffect("IlluminationSpotted") -- Ambusher ReconOps!
						enemy:AddStatusEffect("GlobalVisualContact")
						enemy:AddStatusEffect("Revealed")
					end
				end
			end,
		}),
	},
	OnAdded = function (self, obj)
		obj:AddStatusEffect("NaturalCamouflage")
		obj:AddStatusEffect("Stealthy")
		obj:AddStatusEffect("Infiltrator")
	end,
	OnRemoved = function (self, obj)  end,
	Icon = "UI/Icons/Perks/Stealthy",
}

