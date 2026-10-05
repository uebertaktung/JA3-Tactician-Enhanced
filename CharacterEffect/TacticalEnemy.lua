UndefineClass('TacticalEnemy')
DefineClass.TacticalEnemy = {
	__parents = { "CharacterEffect" },
	__generated_by_class = "ModItemCharacterEffectCompositeDef",


	comment = "Tactical Enemy Battleplan",
	object_class = "CharacterEffect",
	msg_reactions = {
		PlaceObj('MsgActorReaction', {
			ActorParam = "unit",
			Event = "UnitAnyMovementStart",
			Handler = function (self, unit, target, toDoStance)
				local reaction_def = (self.msg_reactions or empty_table)[1]
				if self:VerifyReaction("UnitAnyMovementStart", reaction_def, unit, unit, target, toDoStance) then
					--TE Static Cover Protection [!MUST HAVE!] -- !!!Do NOT Change this one!!! (JA2 Core Logic)
				if g_Combat and unit:HasStatusEffect("TacticalEnemy") then
					unit:RemoveStatusEffect("GlobalCoverProtection")
					return
				end
				end
			end,
			HandlerCode = function (self, unit, target, toDoStance)
				--TE Static Cover Protection [!MUST HAVE!] -- !!!Do NOT Change this one!!! (JA2 Core Logic)
				if g_Combat and unit:HasStatusEffect("TacticalEnemy") then
					unit:RemoveStatusEffect("GlobalCoverProtection")
					return
				end
			end,
		}),
		PlaceObj('MsgActorReaction', {
			ActorParam = "unit",
			Event = "UnitMovementDone",
			Handler = function (self, unit, action_id, prev_pos)
				local reaction_def = (self.msg_reactions or empty_table)[2]
				if self:VerifyReaction("UnitMovementDone", reaction_def, unit, unit, action_id, prev_pos) then
					--TE Static Cover Protection [!MUST HAVE!] -- !!!Do NOT Change this one!!! (JA2 Core Logic)
				if g_Combat and unit:CanTakeCover() and unit:IsUsingCover() and unit:HasStatusEffect("TacticalEnemy") then
					unit:AddStatusEffect("GlobalCoverProtection")
				else
					unit:RemoveStatusEffect("GlobalCoverProtection")
				end
				end
			end,
			HandlerCode = function (self, unit, action_id, prev_pos)
				--TE Static Cover Protection [!MUST HAVE!] -- !!!Do NOT Change this one!!! (JA2 Core Logic)
				if g_Combat and unit:CanTakeCover() and unit:IsUsingCover() and unit:HasStatusEffect("TacticalEnemy") then
					unit:AddStatusEffect("GlobalCoverProtection")
				else
					unit:RemoveStatusEffect("GlobalCoverProtection")
				end
			end,
		}),
		PlaceObj('MsgActorReaction', {
			ActorParam = "unit",
			Event = "UnitStanceChanged",
			Handler = function (self, unit)
				local reaction_def = (self.msg_reactions or empty_table)[3]
				if self:VerifyReaction("UnitStanceChanged", reaction_def, unit, unit) then
					--TE Static Cover Protection [!MUST HAVE!] -- !!!Do NOT Change this one!!! (JA2 Core Logic)
				if g_Combat and unit:CanTakeCover() and unit:IsUsingCover() and unit:HasStatusEffect("TacticalEnemy") then
					unit:AddStatusEffect("GlobalCoverProtection")
				else
					unit:RemoveStatusEffect("GlobalCoverProtection")
				end
				end
			end,
			HandlerCode = function (self, unit)
				--TE Static Cover Protection [!MUST HAVE!] -- !!!Do NOT Change this one!!! (JA2 Core Logic)
				if g_Combat and unit:CanTakeCover() and unit:IsUsingCover() and unit:HasStatusEffect("TacticalEnemy") then
					unit:AddStatusEffect("GlobalCoverProtection")
				else
					unit:RemoveStatusEffect("GlobalCoverProtection")
				end
			end,
		}),
	},
	unit_reactions = {
		PlaceObj('UnitReaction', {
			Event = "OnEndTurn",
			Handler = function (self, target)
				--JA3 Tactician Enhanced Activation [!MUST HAVE!] -- !!!Do NOT Change this one!!! (TE Core Logic)
				local allEnemies = GetAllEnemyUnits(target)
				for _, enemy in ipairs(allEnemies) do
					if enemy:HasStatusEffect("TacticalEnemy") and (enemy:IsLocalPlayerControlled() or enemy:IsMerc() or IsMerc(enemy)) then
						enemy:RemoveStatusEffect("TacticalEnemy")
					end
					if not enemy:HasStatusEffect("TEActivation") then
						enemy:AddStatusEffect("TEActivation")
					end
				end
				
				--Enemy CanSeekCover & Self-Heal [!MUST HAVE!] -- !!!Do NOT Change this one!!! (TE Core Logic)
				local weapon = target:GetActiveWeapons()
				if not IsKindOf(weapon, "HeavyWeapon") then
					if not g_Overwatch[target] and not g_Pindown[target] then
						if target:CanTakeCover() then
							target:SetActionCommand("ChangeStance", nil, nil, "Crouch") -- Take Cover!
							target:AddStatusEffect("GlobalCoverProtection")
						else
							if not IsKindOf(weapon, "MeleeWeapon") then
								target:SetActionCommand("ChangeStance", nil, nil, "Prone") -- Hit The Deck!
							end
						end
						if target:IsUsingCover() then -- Self-Heal!
							target:RemoveStatusEffect("Blinded")
							target:RemoveStatusEffect("Bleeding")
							target:RemoveStatusEffect("Choking")
						end
						if CurrentModOptions["Tactical_Hardcore"] == "<GameTerm('TE_HARD_BOILED')>" or CurrentModOptions["Tactical_Hardcore"] == "<GameTerm('TE_DEAD_ON_ARRIVAL')>" or CurrentModOptions["Hell_Gate"] == "<GameTerm('TE_NIGHTMARE_A')>" or CurrentModOptions["Hell_Gate"] == "<GameTerm('TE_NIGHTMARE_B')>" then
							target:AddStatusEffect("EnemyCQCReaction") -- Enemy CQC Reaction Retaliates [!OPTIONAL!]
						end
					end
				end
				
				--TE Global Real HeavyWounds! [!MUST HAVE!] -- !!!Do NOT Change this one!!! (TE Core Logic)
				local effect = target:GetStatusEffect("Wounded")
				if effect and effect.stacks >= 5 and not target:HasStatusEffect("RealHeavyWounds") then
					target:AddStatusEffect("RealHeavyWounds")
				else
					target:RemoveStatusEffect("RealHeavyWounds")
				end
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnCalcFreeMove",
			Handler = function (self, target, data)
				--JA3 NPC Global Vanilla Perk! [!MUST HAVE!] -- !!!Do NOT Change this one!!! (TE Core Logic)
				data.min = 7 -- NPC [MinFreeMove]
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnCalcChanceToHit",
			Handler = function (self, target, attacker, action, attack_target, weapon1, weapon2, data)
				--JA3 NPC Global MinCth! [!MUST HAVE!] -- !!!Do NOT Change this one!!! (TE Core Logic)
				if target == attacker then
					data.min = 3 -- NPC [MinAccuracy]
				end
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnCalcMinAimActions",
			Handler = function (self, target, value, attacker, attack_target, action, weapon)
				--JA3 NPC CanFullyAimedShots [!MUST HAVE!] -- !!!Do NOT Change this one!!! (TE Core Logic)
				if target == attacker then
					return value + 3 -- NPC [FullyAimedShots]
				end
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnCalcOverwatchAttacks",
			Handler = function (self, target, value, action, args)
				--JA3 NPC OverwatchExpert [!MUST HAVE!] -- !!!Do NOT Change this one!!! (TE Core Logic)
				return value + 2 -- NPC [OverwatchExpert]
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnCalcStealthKillChance",
			Handler = function (self, target, value, attacker, attack_target, weapon, target_spot_group, aim)
				--JA3 NPC StealthKillDefense [!MUST HAVE!] -- !!!Do NOT Change this one!!! (TE Core Logic)
				if target == attack_target then
					return value - 45 -- NPC [StealthKillDefensePerk]
				end
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnCalcCritChance",
			Handler = function (self, target, attacker, attack_target, action, weapon, data)
				--JA3 NPC OpportunityAttack CanCrits! [!MUST HAVE!] -- !!!Do NOT Change this one!!! (TE Core Logic)
				if target == attacker and (attack_target ~= nil and attacker:IsOnEnemySide(attack_target)) and IsKindOf(attack_target, "Unit") then
					-- treat attacks equally (allow crits on opportunity attacks)
					data.opportunity_attack = false
				end
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnCalcDamageAndEffects",
			Handler = function (self, target, attacker, attack_target, action, weapon, attack_args, hit, data)
				--Enemy StealthKill || MartialArts || HoldPosition [!OPTIONAL!]
				if target == attacker and (attack_target ~= nil and attacker:IsOnEnemySide(attack_target)) and IsKindOf(attack_target, "Unit") then
					local visual_contact = attacker.enemy_visual_contact
					local isRetaliation = (attack_args and attack_args.opportunity_attack_type) and (attack_args and attack_args.opportunity_attack_type) == "Retaliation"
					local fatalityMod = Max(attack_target:GetTotalHitPoints(), 125) + Max(const.Combat.MaxGrit, 45)
					if attacker:HasStatusEffect("TacticalBOW") and isRetaliation then
						hit.stealth_kill = true -- B.O.W. Retaliation <GameTerm('Interrupt')> attacks might trigger instant Fatality [!OPTIONAL!]
						data.base_damage = fatalityMod
					end
					if attack_args and attack_args.opportunity_attack_type and not visual_contact and not hit.grazing then
						if (CurrentModOptions["Tactical_Hardcore"] == "<GameTerm('TE_DEAD_ON_ARRIVAL')>" or CurrentModOptions["Hell_Gate"] == "<GameTerm('TE_NIGHTMARE_A')>" or CurrentModOptions["Hell_Gate"] == "<GameTerm('TE_NIGHTMARE_B')>") and attacker:HasStatusEffect("NaturalCamouflage") then
							hit.stealth_kill = true -- Enemy Stealth <GameTerm('Interrupt')> attacks might trigger instant Fatality [!OPTIONAL!]
							data.base_damage = fatalityMod
						end
					end
					if (action and action.ActionType) == "Melee Attack" and not (attack_args and attack_args.opportunity_attack_type) and attack_target:HasStatusEffect("MartialArts") and attack_target.Dexterity >= 85 then
						hit.grazing = true -- [MartialArts] will trigger Grazing hit (Parry)!
					end
					if (action and action.ActionType) == "Ranged Attack" and (g_Overwatch[attack_target] or g_Pindown[attack_target]) and attack_target:HasStatusEffect("HoldPosition") and attack_target.Health >= 90 then
						hit.critical = nil -- [HoldPosition] will invalidate Critical hit!
					end
				end
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnDamageDone",
			Handler = function (self, target, attack_target, dmg, hit_descr)
				--Enemy AutoWeapons Tracers & Distracting Shot! [!MUST HAVE!] -- !!!Do NOT Change this one!!! (TE Core Logic)
				if target and (attack_target ~= nil and target:IsOnEnemySide(attack_target)) and IsKindOf(attack_target, "Unit") then
					local weapon = target:GetActiveWeapons("Firearm")
					if hit_descr.weapon and IsKindOfClasses(weapon, "AssaultRifle", "MachineGun", "SubmachineGun") and not attack_target:HasStatusEffect("IlluminationSpotted") then
						attack_target:AddStatusEffect("IlluminationSpotted") -- Enemy Tracers inflict "Illuminated"!
					end
					if not attack_target:HasStatusEffect("HoldPosition") then
						attack_target:AddStatusEffect("CancelShot") -- DMG & HIT cancel <GameTerm('Overwatch')> and <GameTerm('PinDown')>!
					end
					if not hit_descr.weapon then
						attack_target:AddStatusEffect("CancelShot") -- Enemy Melee & Explosives cancel <GameTerm('Overwatch')> and <GameTerm('PinDown')>!
						attack_target:AddStatusEffect("Suppressed") -- Enemy Melee & Explosives inflict "Suppressed"!
					end
				end
				
				--Enemy CQC Reaction CD [!OPTIONAL!]
				target:RemoveStatusEffect("EnemyCQCReaction")
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnDamageTaken",
			Handler = function (self, target, attacker, dmg, hit_descr)
				--Enemy Suppressive Fire Support! [!MUST HAVE!] -- !!!Do NOT Change this one!!! (TE Core Logic)
				for _, ally in ipairs(target.team.units) do
					if ally:HasStatusEffect("Protected") or ally:HasStatusEffect("Panicked") or ally:HasStatusEffect("Unconscious") then return end
					
					if (ally ~= target and ally ~= attacker) and (ally:IsAware() and not ally:IsDead() and not ally:IsDowned()) then
						if not g_Overwatch[ally] and not g_Pindown[ally] then
							if attacker and attacker:IsOnEnemySide(target) and IsKindOf(attacker, "Unit") and (attacker:IsAware() and not attacker:IsDead() and not attacker:IsDowned() and not attacker:HasStatusEffect("Unconscious")) then
								local action = CombatActions['GrenadeLauncherFire']
								local actions = CombatActions['Bombard']
								local weapon = attacker:GetActiveWeapons("Firearm")
								local weapons = action:GetAttackWeapons(ally)
								local weapon_rocket = ally:GetActiveWeapons("RocketLauncher")
								local weapon_mortar = ally:GetActiveWeapons("Mortar")
								local enemyPos = ResolveGrenadeTargetPos(attacker, ally:GetPos(), weapons)
								local args = {target = enemyPos}
								local results = TE_SafeActionResults(action, ally, args, weapons)
								local explosionPos = (results and results.explosion_pos) or enemyPos
								local dropDist = (IsPoint(enemyPos) and IsPoint(explosionPos)) and DivCeil(enemyPos:Dist2D(explosionPos), const.SlabSizeX) or 99
								local enemyDist = DivCeil(ally:GetDist(attacker), const.SlabSizeX)
								if (g_Overwatch[attacker] or g_Pindown[attacker]) and hit_descr.weapon then
									if (enemyDist > 4 and enemyDist <= 45) and ((weapons and (dropDist <= 1)) and not weapon_rocket) and not ally:HasStatusEffect("LauncherRetaliationCounter") then
										StartCombatAction(action.id, ally, 0, args) -- Enemy GrenadeLauncher Fire Support!
										ally:AddStatusEffect("LauncherRetaliationCounter")
									end
									if (enemyDist > 8 and enemyDist <= 70) and (weapon_rocket or weapon_mortar) and not ally:HasStatusEffect("MortarRetaliationCounter") and not attacker:HasStatusEffect("MortarRetaliationCounter") and not attacker:HasStatusEffect("ArtilleryRetaliationCounter") then
										StartCombatAction(actions.id, ally, 0, args) -- Enemy RocketLauncher & Mortar Fire Support!
										ally:AddStatusEffect("MortarRetaliationCounter")
										attacker:AddStatusEffect("MortarRetaliationCounter")
									end
								else -- Enemy CQC Reaction Retaliates [!OPTIONAL!]
									if hit_descr.weapon or not hit_descr.raw_damage or hit_descr.raw_damage <= 0 or not ally:HasStatusEffect("EnemyCQCReaction") then return end
									
									if ((enemyDist < 16) or (ally:HasStatusEffect("TacticalBOW") and (enemyDist <= 20))) and not ally:HasStatusEffect("MortarRetaliationCounter") then
										local weapon = ally:GetActiveWeapons()
										local weaponRange = weapon and weapon.WeaponRange or 0
										if HasVisibilityTo(attacker, ally) and (weaponRange >= enemyDist) and not IsKindOf(weapon, "HeavyWeapon") then
											ally:Retaliate(attacker) -- Enemy CQC Retaliate Attacks!
										elseif (not HasVisibilityTo(attacker, ally) or (weaponRange < enemyDist)) and not ally:IsPointBlankRange(attacker) and not ally:HasStatusEffect("ThrowingRetaliationCounter") then
											local actions = { "ThrowGrenadeA", "ThrowGrenadeB", "ThrowGrenadeC", "ThrowGrenadeD" }
											for _, id in ipairs(actions) do
												local action = CombatActions[id]
												local weapons = action:GetAttackWeapons(ally)
												if (weapons and (dropDist <= 1)) and not IsKindOfClasses(weapons, "FlareStick", "GlowStick", "SmokeGrenade") and not attacker:HasStatusEffect("ThrowingRetaliationCounter") then
													StartCombatAction(action.id, ally, 0, args) -- Enemy CQC Grenades/Explosives Attacks!
													ally:AddStatusEffect("ThrowingRetaliationCounter")
													attacker:AddStatusEffect("ThrowingRetaliationCounter")
													break
												end
											end
										end
									end
								end
							end
						end
					end
				end
				
				--B.O.W. Fatal Retaliation [!OPTIONAL!]
				if target and target:IsOnEnemySide(attacker) and IsKindOf(attacker, "Unit") then
					if not target:HasStatusEffect("TacticalBOW") or target:HasStatusEffect("Protected") or target:HasStatusEffect("Panicked") or target:HasStatusEffect("Unconscious") then return end
					if attacker:IsDead() or attacker:IsDowned() or attacker:HasStatusEffect("Unconscious") then return end
					
					local weapon = target:GetActiveWeapons()
					local weaponRange = weapon and weapon.WeaponRange or 0
					local enemyDist = DivCeil(target:GetDist(attacker), const.SlabSizeX)
					if (not g_Overwatch[target] and not g_Pindown[target]) and (target:IsAware() and not target:IsDead() and not target:IsDowned()) then
						if HasVisibilityTo(attacker, target) and (weaponRange >= enemyDist) then
							target:Retaliate(attacker) -- B.O.W. Revenge Retaliation!
						elseif (not HasVisibilityTo(attacker, target) or (weaponRange < enemyDist)) and not target:IsPointBlankRange(attacker) and not attacker:HasStatusEffect("ThrowingRetaliationCounter") then
							local actions = { "ThrowGrenadeA", "ThrowGrenadeB", "ThrowGrenadeC", "ThrowGrenadeD" }
							for _, id in ipairs(actions) do
								local action = CombatActions[id]
								local weapons = action:GetAttackWeapons(target)
								local enemyPos = ResolveGrenadeTargetPos(attacker, target:GetPos(), weapons)
								local args = {target = enemyPos}
								local results = TE_SafeActionResults(action, target, args, weapons)
								local explosionPos = (results and results.explosion_pos) or enemyPos
								local dropDist = (IsPoint(enemyPos) and IsPoint(explosionPos)) and DivCeil(enemyPos:Dist2D(explosionPos), const.SlabSizeX) or 99
								if (enemyDist <= 20) and (weapons and (dropDist <= 1)) and not IsKindOfClasses(weapons, "FlareStick", "GlowStick", "SmokeGrenade", "TearGasGrenade", "ToxicGasGrenade") then
									StartCombatAction(action.id, target, 0, args) -- B.O.W. Revenge Retaliation (Bombs)!
									attacker:AddStatusEffect("ThrowingRetaliationCounter")
									break
								end
							end
						end
					end
				end
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnFirearmAttackStart",
			Handler = function (self, target, attacker, attack_target, action, attack_args)
				--Enemy OpportunityAttack || DistractingShot || Suppression Matters! [!MUST HAVE!] -- !!!Do NOT Change this one!!! (TE Core Logic)
				if target == attacker and (attack_target ~= nil and attacker:IsOnEnemySide(attack_target)) and IsKindOf(attack_target, "Unit") then
					local weapon = attacker:GetActiveWeapons()
					if attack_args and attack_args.opportunity_attack_type then
						if (action.id == "SingleShot" or action.id == "BurstFire") and table.find(weapon.AvailableAttacks, "AutoFire") then
							attack_args.replace_action = "AutoFire" -- AutoWeapons OpportunityAttack Area of Fire Suppression!
							PlayVoiceResponse(attacker, "Psycho")
						end
						attacker:AddStatusEffect("Inspired") -- Successful OpportunityAttack will boost enemy combat efficiency!
						attack_target:AddStatusEffect("SuppressionShocked") -- Successful OpportunityAttack will hinder player combat efficiency!
					end
					if IsKindOfClasses(weapon, "SniperRifle", "Pistol", "Revolver") then
						if IsKindOf(weapon, "SniperRifle") then
							attack_args.replace_action = "SingleShot" -- Sniper will fire SingleShot ONLY!
						end
						attack_args.chance_to_hit = 1000 -- Sniper & Handgun will NOT miss the target!
					end
					if action.id == "CancelShot" or action.id == "CancelShotCone" then
						attack_args.chance_to_hit = 1000 -- DistractingShot will NOT miss the target!
					end
				end
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnUnitAttackReaction",
			Handler = function (self, target, attacker, attack_target, action, attack_args, results, can_retaliate)
				--Enemy CQC Reaction CD [!OPTIONAL!]
				target:RemoveStatusEffect("EnemyCQCReaction")
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnUnitAttackResolved",
			Handler = function (self, target, attacker, attack_target, action, attack_args, results, can_retaliate, combat_starting)
				--TE Global Fire Suppression Overhaul! [!MUST HAVE!] -- !!!Do NOT Change this one!!! (TE Core Logic)
				if target == attacker and (attack_target ~= nil and attacker:IsOnEnemySide(attack_target)) and IsKindOf(attack_target, "Unit") then
					if not attack_target:IsAware() or attack_target:IsDead() or attack_target:IsDowned() or attack_target:HasStatusEffect("Protected") or attack_target:HasStatusEffect("Panicked") or attack_target:HasStatusEffect("Unconscious") then return end
					
					local weapon = attacker:GetActiveWeapons()
					local weaponRange = weapon and weapon.WeaponRange or 0
					local enemyDist = DivCeil(attacker:GetDist(attack_target), const.SlabSizeX)
					local allEnemies = GetAllEnemyUnits(attacker)
					if not (results and results.obstructed) then
						if IsKindOf(results.weapon, "Firearm") then
							if (attack_args and attack_args.opportunity_attack_type) then
								attack_target:AddStatusEffect("Suppressed")
							end
							if (weaponRange >= enemyDist) and HasVisibilityTo(attack_target, attacker) then
								if attack_target.stance == "Standing" and not (attack_args and attack_args.opportunity_attack_type) then
									TE_SafeCrouch(attack_target)
								end
								attack_target:AddStatusEffect("SuppressionShocked")
							end
						end
						for _, enemy in ipairs(allEnemies) do -- <GameTerm('PointBlankRange')> Area of Fire Suppression -- !!!Do NOT Change this one!!! (JA2 Core Logic)
							if enemy:HasStatusEffect("Protected") or enemy:HasStatusEffect("Panicked") or enemy:HasStatusEffect("Unconscious") then return end
							
							if enemy ~= attack_target and enemy:IsAware() and not enemy:IsDead() and not enemy:IsDowned() then
								if enemy:IsPointBlankRange(attack_target) and (attack_target ~= nil and enemy:IsOnAllySide(attack_target)) and IsKindOf(enemy, "Unit") then
									if IsKindOf(results.weapon, "Firearm") then
										if (attack_args and attack_args.opportunity_attack_type) then
											enemy:AddStatusEffect("Suppressed")
										end
										if (weaponRange >= enemyDist) and HasVisibilityTo(attack_target, attacker) then
											if enemy.stance == "Standing" and not (attack_args and attack_args.opportunity_attack_type) then
												TE_SafeCrouch(enemy)
											end
											enemy:AddStatusEffect("SuppressionShocked")
										end
									end
								end
							end
						end
					end
				end
			end,
		}),
	},
	DisplayName = T(517805702942, --[[ModItemCharacterEffectCompositeDef TacticalEnemy DisplayName]] "Tactical Enemy"),
	Description = T(805918094617, --[[ModItemCharacterEffectCompositeDef TacticalEnemy Description]] '<color EmStyle>"JUST AS THE MAJOR TAUGHT US !"</color>\nWill REMOVE your VISIBLE <GameTerm(\'Overwatch\')> and <GameTerm(\'PinDown\')> by <em>Distracting Shot</em>.\nWill use <em>Grenades</em>|<em>Explosives</em>|<em>Smoke</em> against your <GameTerm(\'Interrupt\')> attacks.\nWill fire ALL AVAILABLE SHOTS in <em>Close Quarters</em> BEFORE YOUR TURN.'),
	OnAdded = function (self, obj)
		obj:AddStatusEffect("GlobalSightRange") -- TE Global Visibility Overhaul! [!MUST HAVE!] -- !!!Do NOT Change this one!!! (TE Core Logic)
		obj:AddStatusEffectImmunity("TEActivation", self.class) -- Enemy Avoid Player Effects! [!MUST HAVE!]
		obj:AddStatusEffectImmunity("GlobalTacticalTutorial", self.class) -- Enemy Avoid Player Effects! [!MUST HAVE!]
		obj:AddStatusEffectImmunity("GlobalCombatConcealed", self.class) -- Enemy Avoid Player Effects! [!MUST HAVE!]
		obj:AddStatusEffectImmunity("GlobalVisualContact", self.class) -- Enemy Avoid Player Effects! [!MUST HAVE!]
		obj:AddStatusEffectImmunity("TutorialMinion", self.class) -- Enemy Avoid Minion Effects! [!MUST HAVE!]
		obj:AddStatusEffectImmunity("Exhausted", self.class) -- Enemy Never Exhausted! [!MUST HAVE!]
		obj:AddStatusEffectImmunity("Tired", self.class) -- Enemy Never Tired! [!MUST HAVE!]
	end,
	OnRemoved = function (self, obj)
		obj:RemoveStatusEffectImmunity("TEActivation", self.class)
		obj:RemoveStatusEffectImmunity("GlobalTacticalTutorial", self.class)
		obj:RemoveStatusEffectImmunity("GlobalCombatConcealed", self.class)
		obj:RemoveStatusEffectImmunity("GlobalVisualContact", self.class)
		obj:RemoveStatusEffectImmunity("TutorialMinion", self.class)
		obj:RemoveStatusEffectImmunity("Exhausted", self.class)
		obj:RemoveStatusEffectImmunity("Tired", self.class)
	end,
	Icon = "UI/Hud/Status effects/battle_focus",
	Shown = true,
}

