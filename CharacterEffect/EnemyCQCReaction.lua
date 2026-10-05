UndefineClass('EnemyCQCReaction')
DefineClass.EnemyCQCReaction = {
	__parents = { "CharacterEffect" },
	__generated_by_class = "ModItemCharacterEffectCompositeDef",


	comment = "Enemy CQC Retaliates (Illustrative Purposes)",
	object_class = "CharacterEffect",
	DisplayName = T(928259246463, --[[ModItemCharacterEffectCompositeDef EnemyCQCReaction DisplayName]] "CQC Reaction"),
	Description = T(195064196693, --[[ModItemCharacterEffectCompositeDef EnemyCQCReaction Description]] "Launch <GameTerm('Interrupt')> attacks in <em>Close Quarters</em> when you attack another target <em>in this enemy vicinity</em> at YOUR TURN. Will NOT trigger while <em>Taking Cover</em> or being <em>Overwatch</em>."),
	OnAdded = function (self, obj)  end,
	OnRemoved = function (self, obj)  end,
	Icon = "UI/Hud/Status effects/concentrate",
	RemoveOnEndCombat = true,
	Shown = true,
	HasFloatingText = true,
}

