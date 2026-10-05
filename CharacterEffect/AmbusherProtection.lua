UndefineClass('AmbusherProtection')
DefineClass.AmbusherProtection = {
	__parents = { "CharacterEffect" },
	__generated_by_class = "ModItemCharacterEffectCompositeDef",


	comment = "Ambusher Raid Phase",
	object_class = "CharacterEffect",
	OnAdded = function (self, obj)
		--Enemy Ambusher NOT shooting on DiceRoll!
		if g_Combat then obj:ConsumeAP(14 * const.Scale.AP) end
		
		--Enemy Ambusher is raiding!
		obj:AddStatusEffect("TacticalEnemy")
		obj:AddStatusEffect("TacticalAmbusher")
		obj:AddStatusEffect("SidneyPerkBuff")
		obj:AddStatusEffect("Hidden")
	end,
	OnRemoved = function (self, obj)
		obj:AddStatusEffect("Inspired")
		obj:AddStatusEffect("FreeMove")
		obj:RemoveStatusEffect("Hidden")
	end,
	lifetime = "Until End of Turn",
	Icon = "UI/Hud/Status effects/sidney_perk_buff",
	RemoveOnEndCombat = true,
}

