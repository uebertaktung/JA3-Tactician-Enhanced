UndefineClass('ReinforcementProtection')
DefineClass.ReinforcementProtection = {
	__parents = { "CharacterEffect" },
	__generated_by_class = "ModItemCharacterEffectCompositeDef",


	comment = "Reinforcement Arrival Phase",
	object_class = "CharacterEffect",
	OnAdded = function (self, obj)
		--Enemy Reinforcements NOT shooting on arrival!
		if g_Combat then obj:ConsumeAP(14 * const.Scale.AP) end
		
		--Enemy Reinforcements can disarm all traps on arrival!
		for _, trap in ipairs(g_Traps) do
			local disarmCheck = DivRound(obj:GetDist(trap), const.SlabSizeX)
			local partsCount = 1 + obj:Random(2)
			if disarmCheck < 16 and (not trap.done and (trap.TriggerType == "Timed" or trap.TriggerType == "Proximity" or trap.TriggerType == "Remote" or trap.TriggerType == "Proximity-Timed")) then
				trap.disarmed = true
				trap.done = true
				ObjModified("combat_bar_traps")
				PlayFX("ExplosiveTick", "failed", trap)
				CreateFloatingText(trap:GetVisualPos(), T{178669996888, "Salvaged <Amount> parts", Amount = partsCount})
			end
		end
		
		--Enemy Reinforcements have arrived!
		obj:AddStatusEffect("TacticalEnemy")
		obj:AddStatusEffect("LightStep")
		obj:AddStatusEffect("FreeMove")
		obj:AddStatusEffect("SidneyPerkBuff")
	end,
	OnRemoved = function (self, obj)
		obj:AddStatusEffect("Inspired")
		obj:RemoveStatusEffect("LightStep")
	end,
	lifetime = "Until End of Turn",
	Icon = "UI/Hud/Status effects/sidney_perk_buff",
	RemoveOnEndCombat = true,
}

