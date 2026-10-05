UndefineClass('InnerInfoRemake')
DefineClass.InnerInfoRemake = {
	__parents = { "Perk" },
	__generated_by_class = "ModItemCharacterEffectCompositeDef",


	comment = '"Inside Dope" Remake (Illustrative Purposes)',
	object_class = "Perk",
	DisplayName = T(735717310475, --[[ModItemCharacterEffectCompositeDef InnerInfoRemake DisplayName]] "Inside Dope"),
	Description = T(495725410406, --[[ModItemCharacterEffectCompositeDef InnerInfoRemake Description]] "<em>Reveals</em> all <em>Enemies</em> if you have <em>Intel</em> for the Sector.\n\n<em>Intel</em> hack is NOT working if enemies <em>Alerted</em> in the Sector.\n\n<em>Intel</em> hack will be auto-restored on <em>Combat End</em> or on <em>Satellite Travel</em>."),
	OnAdded = function (self, obj)
		obj:AddStatusEffectImmunity("InnerInfo", self.class)
		obj:RemoveStatusEffect("InnerInfo")
	end,
	OnRemoved = function (self, obj)
		obj:RemoveStatusEffectImmunity("InnerInfo", self.class)
		obj:AddStatusEffect("InnerInfo")
	end,
	Icon = "UI/Icons/Perks/InnerInfo",
	RemoveOnEndCombat = true,
	RemoveOnSatViewTravel = true,
}

