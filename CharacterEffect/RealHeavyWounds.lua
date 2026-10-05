UndefineClass('RealHeavyWounds')
DefineClass.RealHeavyWounds = {
	__parents = { "StatusEffect" },
	__generated_by_class = "ModItemCharacterEffectCompositeDef",


	comment = "Heavy Wounds Overhaul (Arrhythmia Effect)",
	object_class = "StatusEffect",
	unit_reactions = {
		PlaceObj('UnitReaction', {
			Event = "OnUnitAttackResolved",
			Handler = function (self, target, attacker, attack_target, action, attack_args, results, can_retaliate, combat_starting)
				--TE Global Real HeavyWounds! [!MUST HAVE!] -- !!!Do NOT Change this one!!! (TE Core Logic)
				local effect = target:GetStatusEffect("Wounded")
				if g_Combat or g_StartingCombat or g_TestingSaveLoadSystem then
					if target == attacker and not attack_args.opportunity_attack_type and effect.stacks >= 5 then
						attacker.ActionPoints = 0 -- force to re-stabilize the heart rhythm
					end
					ObjModified(attacker)
				end
			end,
		}),
	},
	DisplayName = T(534745740964, --[[ModItemCharacterEffectCompositeDef RealHeavyWounds DisplayName]] "Arrhythmia"),
	Description = T(831231106141, --[[ModItemCharacterEffectCompositeDef RealHeavyWounds Description]] "Suffer <em>5</em> stacks <GameTerm('Wounded')> cause <em>Arrhythmia</em>:\nPerform any <em>Attack</em> based action will force <em>Maximum AP</em> to <em>ZERO</em> (Except <GameTerm('Interrupt')> attacks).\nCannot gain <GameTerm('FreeMove')>."),
	AddEffectText = T(625592681059, --[[ModItemCharacterEffectCompositeDef RealHeavyWounds AddEffectText]] "<color EmStyle><DisplayName></color> is <em>Arrhythmia</em>!"),
	OnAdded = function (self, obj)
		obj:AddStatusEffectImmunity("FreeMove", self.class)
	end,
	OnRemoved = function (self, obj)
		obj:RemoveStatusEffectImmunity("FreeMove", self.class)
	end,
	Icon = "Mod/JA3_TacticianEnhanced/Images/heavy_wounds.png",
	RemoveOnEndCombat = true,
	RemoveOnSatViewTravel = true,
	Shown = true,
	HasFloatingText = true,
}

