UndefineClass('BOWSummoned')
DefineClass.BOWSummoned = {
	__parents = { "CharacterEffect" },
	__generated_by_class = "ModItemCharacterEffectCompositeDef",


	comment = "B.O.W. Arrival Phase",
	object_class = "CharacterEffect",
	OnAdded = function (self, obj)
		--B.O.W. NOT Shooting at the Hell Gate!
		if g_Combat then obj:ConsumeAP(25 * const.Scale.AP) end
		
		--B.O.W. Summoned!
		obj:AddStatusEffect("FleetingShadow")
		obj:AddStatusEffect("TacticalEnemy")
		obj:AddStatusEffect("TacticalBOW")
		obj:AddStatusEffect("EnemyCQCReaction")
		obj:AddStatusEffect("Bloodthirst")
		obj:AddStatusEffect("Hidden")
	end,
	OnRemoved = function (self, obj)
		obj:AddStatusEffect("Inspired")
	end,
	lifetime = "Until End of Turn",
	Icon = "UI/Hud/Status effects/bloodthirst",
	RemoveOnEndCombat = true,
}

