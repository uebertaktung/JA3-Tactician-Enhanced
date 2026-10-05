UndefineClass('TacticalBOW')
DefineClass.TacticalBOW = {
	__parents = { "CharacterEffect" },
	__generated_by_class = "ModItemCharacterEffectCompositeDef",


	comment = "B.O.W. from The Hell Gate!",
	object_class = "CharacterEffect",
	msg_reactions = {
		PlaceObj('MsgActorReaction', {
			ActorParam = "unit",
			Event = "UnitAnyMovementStart",
			Handler = function (self, unit, target, toDoStance)
				local reaction_def = (self.msg_reactions or empty_table)[1]
				if self:VerifyReaction("UnitAnyMovementStart", reaction_def, unit, unit, target, toDoStance) then
					--B.O.W. Stealth Advancement [!OPTIONAL!]
				if g_Combat and unit:HasStatusEffect("TacticalBOW") then
					unit:AddStatusEffect("Hidden")
					unit:RemoveStatusEffect("Revealed")
					return
				end
				end
			end,
			HandlerCode = function (self, unit, target, toDoStance)
				--B.O.W. Stealth Advancement [!OPTIONAL!]
				if g_Combat and unit:HasStatusEffect("TacticalBOW") then
					unit:AddStatusEffect("Hidden")
					unit:RemoveStatusEffect("Revealed")
					return
				end
			end,
		}),
	},
	unit_reactions = {
		PlaceObj('UnitReaction', {
			Event = "OnBeginTurn",
			Handler = function (self, target)
				--B.O.W. Traits [!OPTIONAL!]
				local allEnemies = GetAllEnemyUnits(target)
				for _, enemy in ipairs(allEnemies) do
					local enemyDist = DivCeil(target:GetDist(enemy), const.SlabSizeX)
					if HasVisibilityTo(enemy, target) and (enemyDist < 16) then
						enemy:AddStatusEffect("Burning") -- B.O.W. Hellfire!
						enemy:AddStatusEffect("GlobalVisualContact")
						enemy:AddStatusEffect("Revealed")
					end
				end
				
				--B.O.W. Stealth Concealed [!OPTIONAL!]
				target:AddStatusEffect("Hidden")
				target:RemoveStatusEffect("Revealed")
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnEndTurn",
			Handler = function (self, target)
				--B.O.W. Traits [!OPTIONAL!]
				local allEnemies = GetAllEnemyUnits(target)
				for _, enemy in ipairs(allEnemies) do
					local enemyDist = DivCeil(target:GetDist(enemy), const.SlabSizeX)
					if HasVisibilityTo(enemy, target) and (enemyDist < 16) then
						enemy:AddStatusEffect("Burning") -- B.O.W. Hellfire!
						enemy:AddStatusEffect("GlobalVisualContact")
						enemy:AddStatusEffect("Revealed")
					end
				end
				
				--B.O.W. Stealth Concealed [!OPTIONAL!]
				target:AddStatusEffect("Hidden")
				target:RemoveStatusEffect("Revealed")
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnCalcMoveModifier",
			Handler = function (self, target, value, action)
				--B.O.W. Stealth Advancement [!OPTIONAL!]
				if target:HasStatusEffect("Hidden") and action.id == "Move" then
					return value - self:ResolveValue("bow_move_modifier")
				end
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnDamageDone",
			Handler = function (self, target, attack_target, dmg, hit_descr)
				--B.O.W. MeleeStrike WILL DESTROY ALL Armour [!OPTIONAL!]
				if target and (attack_target ~= nil and target:IsOnEnemySide(attack_target)) and IsKindOf(attack_target, "Unit") then
					local armourItems = attack_target:GetEquipedArmour()
					local weapon = target:GetActiveWeapons("Firearm")
					for _, item in ipairs(armourItems) do
						if (item.Repairable and item.Condition > 0) and not hit_descr.weapon then
							item.Condition = 0
						end
					end
				end
			end,
		}),
	},
	DisplayName = T(434515142707, --[[ModItemCharacterEffectCompositeDef TacticalBOW DisplayName]] "Hellfire"),
	Description = T(690391720911, --[[ModItemCharacterEffectCompositeDef TacticalBOW Description]] "Inflict <em>Burning</em> within this B.O.W. <em>Vicinity</em> at EACH TURN START!"),
	OnAdded = function (self, obj)
		obj:AddStatusEffectImmunity("Burning", self.class) -- B.O.W. Never Burning!
		obj:AddStatusEffectImmunity("Choking", self.class) -- B.O.W. Never Choking!
		obj:AddStatusEffectImmunity("Blinded", self.class) -- B.O.W. Never Blinded!
		obj:AddStatusEffectImmunity("Panicked", self.class) -- B.O.W. Never Panicked!
		obj:AddStatusEffectImmunity("Revealed", self.class) -- B.O.W. Never Revealed!
		obj:AddStatusEffectImmunity("EnemyBioInfection", self.class) -- B.O.W. Never Infected!
	end,
	OnRemoved = function (self, obj)
		obj:RemoveStatusEffectImmunity("Burning", self.class)
		obj:RemoveStatusEffectImmunity("Choking", self.class)
		obj:RemoveStatusEffectImmunity("Blinded", self.class)
		obj:RemoveStatusEffectImmunity("Panicked", self.class)
		obj:RemoveStatusEffectImmunity("Revealed", self.class)
		obj:RemoveStatusEffectImmunity("EnemyBioInfection", self.class)
	end,
	Icon = "Mod/JA3_TacticianEnhanced/Images/perk_bow.png",
	Shown = true,
}

