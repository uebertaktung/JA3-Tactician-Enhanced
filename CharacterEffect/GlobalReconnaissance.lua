UndefineClass('GlobalReconnaissance')
DefineClass.GlobalReconnaissance = {
	__parents = { "CharacterEffect" },
	__generated_by_class = "ModItemCharacterEffectCompositeDef",


	comment = "Global Reconnaissance Task (Illustrative Purposes)",
	object_class = "CharacterEffect",
	DisplayName = T(999098599965, --[[ModItemCharacterEffectCompositeDef GlobalReconnaissance DisplayName]] "Reconnaissance"),
	Description = T(230121375625, --[[ModItemCharacterEffectCompositeDef GlobalReconnaissance Description]] "Detect all enemies in <GameTerm('Overwatch')> covered area <em>Instantly</em> during the <em>Exploration</em> mode or at the <em>NEXT</em> turn during <em>Combat</em>. Will NOT fire any <GameTerm('Interrupt')> attack."),
	AddEffectText = T(994047694248, --[[ModItemCharacterEffectCompositeDef GlobalReconnaissance AddEffectText]] "<color EmStyle><DisplayName></color> is on <color 225 25 150>Reconnaissance</color>!"),
	OnAdded = function (self, obj)  end,
	OnRemoved = function (self, obj)  end,
	Icon = "Mod/JA3_TacticianEnhanced/Images/recon_spotter.png",
	Shown = true,
	HasFloatingText = true,
}

