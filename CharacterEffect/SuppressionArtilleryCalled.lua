UndefineClass('SuppressionArtilleryCalled')
DefineClass.SuppressionArtilleryCalled = {
	__parents = { "CharacterEffect" },
	__generated_by_class = "ModItemCharacterEffectCompositeDef",


	comment = "Tactical Artillery Strike (Off-Map 120mm Mortar)",
	object_class = "CharacterEffect",
	unit_reactions = {
		PlaceObj('UnitReaction', {
			Event = "OnUnitAttackResolved",
			Handler = function (self, target, attacker, attack_target, action, attack_args, results, can_retaliate, combat_starting)
				--TE Off-Map Artillery Strike [!OPTIONAL!]
				if target == attacker and (attack_target ~= nil and attacker:IsOnEnemySide(attack_target)) and IsKindOf(attack_target, "Unit") then
					local effect = attacker:GetStatusEffect("SuppressionArtilleryCalled")
					local weapon = attacker:GetActiveWeapons()
					local enemyDist = DivCeil(attacker:GetDist(attack_target), const.SlabSizeX)
					if effect.stacks > 2 then
						local allEnemies = GetAllEnemyUnits(attacker)
						for _, enemy in ipairs(allEnemies) do -- Enemy Signaller Calling Off-Map Artillery Strike!
							if (enemy:IsAware() and not enemy:IsDead() and not enemy:IsDowned()) and (not enemy:HasStatusEffect("Protected") and not enemy:HasStatusEffect("Panicked") and not enemy:HasStatusEffect("Unconscious") and not enemy:HasStatusEffect("ZombiePerk")) then
								if enemy ~= attack_target and (attack_target ~= nil and enemy:IsOnAllySide(attack_target)) and IsKindOf(enemy, "Unit") then
									if (attack_args and attack_args.opportunity_attack_type) and IsKindOf(results.weapon, "Firearm") then
										enemy:TE_AIArtilleryStrike(attacker)
									elseif not (attack_args and attack_args.opportunity_attack_type) and ((enemyDist > 25) or IsKindOfClasses(results.weapon, "Grenade", "HeavyWeapon")) then
										enemy:TE_AIArtilleryStrike(attacker)
									end
								end
							end
						end
					end
				end
			end,
		}),
	},
	DisplayName = T(151418136923, --[[ModItemCharacterEffectCompositeDef SuppressionArtilleryCalled DisplayName]] "Artillery Zeroing"),
	Description = T(135539236572, --[[ModItemCharacterEffectCompositeDef SuppressionArtilleryCalled Description]] "<GameTerm('Interrupt')> attacks or <em>Long Range</em> Targeted-Shots may suffer enemies <em>Off-Map Artillery</em> strike. The Artillery barrage is launched after <color EmStyle>3</color> stacks <em>Artillery Zeroing</em>. Firing <em>Grenade\\Rocket Launcher</em> or <em>Mortar</em> at <em>Long Range</em> cause enemies counter-barrage INSTANTLY!"),
	AddEffectText = T(527309936465, --[[ModItemCharacterEffectCompositeDef SuppressionArtilleryCalled AddEffectText]] "<color EmStyle><DisplayName></color> is under <em>Artillery Zeroing</em>!"),
	lifetime = "Until End of Next Turn",
	Icon = "Mod/JA3_TacticianEnhanced/Images/artillery_zeroing.png",
	max_stacks = 3,
	RemoveOnEndCombat = true,
	Shown = true,
	HasFloatingText = true,
}

