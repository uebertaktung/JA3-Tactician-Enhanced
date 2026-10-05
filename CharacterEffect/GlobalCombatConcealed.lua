UndefineClass('GlobalCombatConcealed')
DefineClass.GlobalCombatConcealed = {
	__parents = { "CharacterEffect" },
	__generated_by_class = "ModItemCharacterEffectCompositeDef",


	comment = "Global Combat Sneaking (Illustrative Purposes)",
	object_class = "CharacterEffect",
	DisplayName = T(731994328856, --[[ModItemCharacterEffectCompositeDef GlobalCombatConcealed DisplayName]] "Concealed"),
	Description = T(586484838268, --[[ModItemCharacterEffectCompositeDef GlobalCombatConcealed Description]] "<GameTerm('Sneaking')> is ONLY allowed while staying <em>Statically</em> during <em>Combat</em> and CANNOT gain <GameTerm('FreeMove')>! Instead, the character gains <GameTerm('TE_Concealed')> and is harder to spot while in <em>Cover</em> or on <em>Prone</em> stance <em>Statically</em>. <em>Reveals</em> yourself as soon as you start ANY <em>Movement</em>!"),
	AddEffectText = T(359210480741, --[[ModItemCharacterEffectCompositeDef GlobalCombatConcealed AddEffectText]] "<color EmStyle><DisplayName></color> is <em>Concealed</em>!"),
	OnAdded = function (self, obj)
		obj:AddStatusEffectImmunity("FreeMove", self.class)
	end,
	OnRemoved = function (self, obj)
		obj:AddStatusEffect("Revealed")
		obj:AddStatusEffect("GlobalVisualContact")
		obj:RemoveStatusEffectImmunity("FreeMove", self.class)
	end,
	Icon = "Mod/JA3_TacticianEnhanced/Images/concealed_on.png",
	RemoveOnEndCombat = true,
	Shown = true,
	HasFloatingText = true,
}

