UndefineClass('EnemyFullAlert')
DefineClass.EnemyFullAlert = {
	__parents = { "CharacterEffect" },
	__generated_by_class = "ModItemCharacterEffectCompositeDef",


	comment = "Enemy Anti-SneakyKill Exploits (Illustrative Purposes)",
	object_class = "CharacterEffect",
	DisplayName = T(503045433787, --[[ModItemCharacterEffectCompositeDef EnemyFullAlert DisplayName]] "Full Alert"),
	Description = T(323399699834, --[[ModItemCharacterEffectCompositeDef EnemyFullAlert Description]] "Sector enemies check security status regularly with each other via Military <em>Walkie-Talkie</em>. Any enemy is either not responding to others (<em>Sneaky Killed</em>) or is under <em>Attacked</em> will trigger the ENTIRE Sector being fully <em>Alerted</em>!"),
	OnAdded = function (self, obj)  end,
	OnRemoved = function (self, obj)  end,
	Icon = "Mod/JA3_TacticianEnhanced/Images/full_alert.png",
	RemoveOnSatViewTravel = true,
	Shown = true,
	HasFloatingText = true,
}

