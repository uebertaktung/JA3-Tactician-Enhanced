UndefineClass('GlobalCoverProtection')
DefineClass.GlobalCoverProtection = {
	__parents = { "CharacterEffect" },
	__generated_by_class = "ModItemCharacterEffectCompositeDef",


	comment = "Global Cover Grazing (Illustrative Purposes)",
	object_class = "CharacterEffect",
	DisplayName = T(121215159633, --[[ModItemCharacterEffectCompositeDef GlobalCoverProtection DisplayName]] "Protected"),
	Description = T(861766217804, --[[ModItemCharacterEffectCompositeDef GlobalCoverProtection Description]] "Attacks from the <em>other side</em> of the <em>Cover</em> against this character have a HIGH chance (based on Agility VS an opposed Dexterity check) to become <em>Grazing hits</em> (GUARANTEED while <em>Taking Cover</em> or character holding <em>Lightning Reactions</em> Perk)."),
	AddEffectText = T(207882580702, --[[ModItemCharacterEffectCompositeDef GlobalCoverProtection AddEffectText]] "<color EmStyle><DisplayName></color> is <em>Protected</em>!"),
	OnAdded = function (self, obj)  end,
	OnRemoved = function (self, obj)  end,
	Icon = "Mod/JA3_TacticianEnhanced/Images/take_cover.png",
	Shown = true,
	HasFloatingText = true,
}

