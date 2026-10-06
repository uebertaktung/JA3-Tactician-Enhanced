UndefineClass('TEActivation')
DefineClass.TEActivation = {
	__parents = { "CharacterEffect" },
	__generated_by_class = "ModItemCharacterEffectCompositeDef",


	comment = "Tactician Enhanced Activation",
	object_class = "CharacterEffect",
	msg_reactions = {
		PlaceObj('MsgReaction', {
			Event = "TurnStart",
			Handler = function (self, team)
				--Enemy Can Distracting Shot [!MUST HAVE!] -- !!!Do NOT Change this one!!! (TE Core Logic)
				for _, unit in ipairs(g_Units) do
					if unit.team.player_enemy and (g_Teams[g_CurrentTeam].side == 'enemy1' or g_Teams[g_CurrentTeam].side == 'enemy2') then
						if unit:HasStatusEffect("Protected") or unit:HasStatusEffect("Panicked") or unit:HasStatusEffect("Unconscious") or unit:HasStatusEffect("ZombiePerk") or unit:HasStatusEffect("ReinforcementProtection") or unit:HasStatusEffect("AmbusherProtection") or unit:HasStatusEffect("BOWSummoned") then return end
						
						if (not g_Overwatch[unit] and not g_Pindown[unit]) and (unit:IsAware() and not unit:IsDead() and not unit:IsDowned()) then
							local allEnemies = GetAllEnemyUnits(unit)
							for _, enemy in ipairs(allEnemies) do
								if g_Overwatch[enemy] or g_Pindown[enemy] then
									local weapon = unit:GetActiveWeapons()
									local weaponRange = weapon and weapon.WeaponRange or 0
									local enemyDist = DivCeil(unit:GetDist(enemy), const.SlabSizeX)
									local action = unit:GetDefaultAttackAction()
									local action1 = CombatActions['CancelShot']
									local action1a = CombatActions['CancelShotCone']
									local args = {target = enemy}
									local results = action:GetActionResults(unit, args)
									if not (results and results.obstructed) then -- Enemy Distracting Shot!
										if ((weaponRange >= enemyDist) or (IsKindOf(weapon, "AssaultRifle") and (enemyDist <= 45)) or (IsKindOf(weapon, "SniperRifle") and (enemyDist <= 70))) and not unit:HasStatusEffect("DistractingRetaliationCounter") then
											if enemy.enemy_visual_contact and not enemy:HasStatusEffect("DistractingRetaliationCounter") and not enemy:HasStatusEffect("HoldPosition") then
												if IsKindOfClasses(weapon, "SniperRifle", "AssaultRifle", "SubmachineGun", "Pistol", "Revolver") then
													StartCombatAction(action1.id, unit, 0, args)
													unit:AddStatusEffect("DistractingRetaliationCounter")
													enemy:AddStatusEffect("DistractingRetaliationCounter")
												elseif IsKindOf(weapon, "Shotgun") then
													StartCombatAction(action1a.id, unit, 0, args)
													unit:AddStatusEffect("DistractingRetaliationCounter")
													enemy:AddStatusEffect("DistractingRetaliationCounter")
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end,
		}),
		PlaceObj('MsgReaction', {
			Event = "TurnEnded",
			Handler = function (self, teamEnded, combatEnd)
				--Enemy Can Ambush Overwatch & CQC Reaction [!MUST HAVE!] -- !!!Do NOT Change this one!!! (TE Core Logic)
				for _, unit in ipairs(g_Units) do
					if unit.team.player_enemy and (g_Teams[g_CurrentTeam].side == 'enemy1' or g_Teams[g_CurrentTeam].side == 'enemy2') then
						if unit:HasStatusEffect("Protected") or unit:HasStatusEffect("Panicked") or unit:HasStatusEffect("Unconscious") or unit:HasStatusEffect("ZombiePerk") or unit:HasStatusEffect("ReinforcementProtection") or unit:HasStatusEffect("AmbusherProtection") or unit:HasStatusEffect("BOWSummoned") then return end
						
						if (not g_Overwatch[unit] and not g_Pindown[unit]) and (unit:IsAware() and not unit:IsDead() and not unit:IsDowned()) then
							local allEnemies = GetAllEnemyUnits(unit)
							for _, enemy in ipairs(allEnemies) do
								if (enemy:IsLocalPlayerControlled() or enemy:IsMerc() or enemy:HasStatusEffect("TEActivation")) and not enemy:IsDead() then
									local weapon = unit:GetActiveWeapons()
									local weaponRange = weapon and weapon.WeaponRange or 0
									local enemyDist = DivCeil(unit:GetDist(enemy), const.SlabSizeX)
									local enemyPos = TE_ScatterPos(enemy:GetClosestEnemy(), enemy, 20*guim)
									local enemyPoz = TE_ToPos(unit:GetClosestEnemy()) or unit:GetPos()
									local action = unit:GetDefaultAttackAction()
									local action1 = CombatActions['Overwatch']
									local action1a = CombatActions['MGSetup']
									local action2 = CombatActions['AutoFire']
									local action2a = CombatActions['MGBurstFire']
									local actionz = CombatActions['Charge']
									local arg = {target = enemy}
									local args = {target = enemyPos}
									local argz = {target = enemyPoz}
									local results = action and action:GetActionResults(unit, arg)
									local ap = unit:GetMaxActionPoints()
									local attacks, aim = unit:GetOverwatchAttacksAndAim(action, args, ap)
									if IsMeleeRangeTarget(unit, nil, nil, enemy) and IsKindOf(weapon, "MeleeWeapon") then -- Enemy Sudden Strike!
										StartCombatAction(actionz.id, unit, 0, argz)
									end
									if enemyDist > 20 then -- Enemy Ambush Overwatch!
										if IsKindOf(weapon, "AssaultRifle") and (enemyDist <= 40) and not unit.enemy_visual_contact then
											args.num_attacks = attacks + 1
											args.aim = 1
											StartCombatAction(action1.id, unit, 0, args)
										end
										if IsKindOf(weapon, "SniperRifle") and (enemyDist <= 60) then
											args.num_attacks = attacks + 1
											args.aim = 2
											StartCombatAction(action1.id, unit, 0, args)
										end
										if IsKindOf(weapon, "MachineGun") and (enemyDist <= 50) then
											args.num_attacks = attacks + 2
											args.aim = 1
											StartCombatAction(action1a.id, unit, 0, args)
										end
									end
									if (weaponRange >= enemyDist) and ((enemyDist < 16) or (unit:HasStatusEffect("TacticalBOW") and (enemyDist <= 20))) and not results.obstructed then -- Enemy CQC Reaction!
										if HasVisibilityTo(enemy, unit) and not unit:HasStatusEffect("SuppressingRetaliationCounter") and not enemy:HasStatusEffect("SuppressingRetaliationCounter") then
											if IsKindOfClasses(weapon, "SniperRifle", "Shotgun", "Pistol", "Revolver") then
												StartCombatAction(action.id, unit, 0, arg)
												unit:AddStatusEffect("SuppressingRetaliationCounter")
												enemy:AddStatusEffect("SuppressingRetaliationCounter")
											end
											if IsKindOfClasses(weapon, "AssaultRifle", "SubmachineGun") then
												StartCombatAction(action2.id, unit, 0, arg)
												unit:AddStatusEffect("SuppressingRetaliationCounter")
												enemy:AddStatusEffect("SuppressingRetaliationCounter")
											end
											if IsKindOf(weapon, "MachineGun") then
												StartCombatAction(action2a.id, unit, 0, arg)
												unit:AddStatusEffect("SuppressingRetaliationCounter")
												enemy:AddStatusEffect("SuppressingRetaliationCounter")
											end
										end
									end
									if (not HasVisibilityTo(enemy, unit) or (weaponRange < enemyDist)) and not unit:HasStatusEffect("SuppressingRetaliationCounter") and not unit:HasStatusEffect("ThrowingRetaliationCounter") and not unit:HasStatusEffect("MortarRetaliationCounter") then
										local actions = { "ThrowGrenadeA", "ThrowGrenadeB", "ThrowGrenadeC", "ThrowGrenadeD" }
										for _, id in ipairs(actions) do
											local action = CombatActions[id]
											local weapons = action:GetAttackWeapons(unit)
											local enemyPos = ResolveGrenadeTargetPos(enemy, unit:GetPos(), weapons)
											local args = {target = enemyPos}
											local results = TE_SafeActionResults(action, unit, args, weapons)
											local explosionPos = (results and results.explosion_pos)
											local dropDist = (IsPoint(enemyPos) and IsPoint(explosionPos)) and DivCeil(enemyPos:Dist2D(explosionPos), const.SlabSizeX) or 99
											if enemy.enemy_visual_contact and ((enemyDist < 16) or (unit:HasStatusEffect("TacticalBOW") and (enemyDist <= 20))) and (weapons and (dropDist <= 1)) and not IsKindOfClasses(weapons, "FlareStick", "GlowStick", "SmokeGrenade") and not unit:IsPointBlankRange(enemy) and not enemy:HasStatusEffect("ThrowingRetaliationCounter") then
												StartCombatAction(action.id, unit, 0, args) -- Enemy Grenades/Explosives Attacks!
												unit:AddStatusEffect("ThrowingRetaliationCounter")
												enemy:AddStatusEffect("ThrowingRetaliationCounter")
												break
											end
										end
									end
								end
							end
						end
					end
				end
			end,
		}),
		PlaceObj('MsgActorReaction', {
			ActorParam = "unit",
			Event = "UnitAnyMovementStart",
			Handler = function (self, unit, target, toDoStance)
				local reaction_def = (self.msg_reactions or empty_table)[3]
				if self:VerifyReaction("UnitAnyMovementStart", reaction_def, unit, unit, target, toDoStance) then
					--TE Combat Static Sneaking [!MUST HAVE!] -- !!!Do NOT Change this one!!! (JA2 Core Logic)
				if g_Combat and unit:HasStatusEffect("TEActivation") then
					if unit:HasStatusEffect("Hidden") then
						unit:AddStatusEffect("Revealed")
						unit:RemoveStatusEffect("Hidden")
						unit:RemoveStatusEffect("GlobalCombatConcealed")
					end
					unit:AddStatusEffect("GlobalVisualContact")
					unit:RemoveStatusEffect("GlobalCoverProtection")
					return
				end
				end
			end,
			HandlerCode = function (self, unit, target, toDoStance)
				--TE Combat Static Sneaking [!MUST HAVE!] -- !!!Do NOT Change this one!!! (JA2 Core Logic)
				if g_Combat and unit:HasStatusEffect("TEActivation") then
					if unit:HasStatusEffect("Hidden") then
						unit:AddStatusEffect("Revealed")
						unit:RemoveStatusEffect("Hidden")
						unit:RemoveStatusEffect("GlobalCombatConcealed")
					end
					unit:AddStatusEffect("GlobalVisualContact")
					unit:RemoveStatusEffect("GlobalCoverProtection")
					return
				end
			end,
		}),
		PlaceObj('MsgActorReaction', {
			ActorParam = "unit",
			Event = "UnitMovementDone",
			Handler = function (self, unit, action_id, prev_pos)
				local reaction_def = (self.msg_reactions or empty_table)[4]
				if self:VerifyReaction("UnitMovementDone", reaction_def, unit, unit, action_id, prev_pos) then
					--TE Static Cover Protection [!MUST HAVE!] -- !!!Do NOT Change this one!!! (JA2 Core Logic)
				if g_Combat and unit:CanTakeCover() and unit:IsUsingCover() and unit:HasStatusEffect("TEActivation") then
					unit:AddStatusEffect("GlobalCoverProtection")
				else
					unit:RemoveStatusEffect("GlobalCoverProtection")
				end
				end
			end,
			HandlerCode = function (self, unit, action_id, prev_pos)
				--TE Static Cover Protection [!MUST HAVE!] -- !!!Do NOT Change this one!!! (JA2 Core Logic)
				if g_Combat and unit:CanTakeCover() and unit:IsUsingCover() and unit:HasStatusEffect("TEActivation") then
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
				local reaction_def = (self.msg_reactions or empty_table)[5]
				if self:VerifyReaction("UnitStanceChanged", reaction_def, unit, unit) then
					--TE Static Cover Protection [!MUST HAVE!] -- !!!Do NOT Change this one!!! (JA2 Core Logic)
				if g_Combat and unit:CanTakeCover() and unit:IsUsingCover() and unit:HasStatusEffect("TEActivation") then
					unit:AddStatusEffect("GlobalCoverProtection")
				else
					unit:RemoveStatusEffect("GlobalCoverProtection")
				end
				end
			end,
			HandlerCode = function (self, unit)
				--TE Static Cover Protection [!MUST HAVE!] -- !!!Do NOT Change this one!!! (JA2 Core Logic)
				if g_Combat and unit:CanTakeCover() and unit:IsUsingCover() and unit:HasStatusEffect("TEActivation") then
					unit:AddStatusEffect("GlobalCoverProtection")
				else
					unit:RemoveStatusEffect("GlobalCoverProtection")
				end
			end,
		}),
	},
	unit_reactions = {
		PlaceObj('UnitReaction', {
			Event = "OnCombatStarting",
			Handler = function (self, target, load_game)
				--JA3 Tactician Enhanced Activation [!MUST HAVE!] -- !!!Do NOT Change this one!!! (TE Core Logic)
				local allEnemies = GetAllEnemyUnits(target)
				for _, enemy in ipairs(allEnemies) do
					if not enemy:HasStatusEffect("TacticalEnemy") then
						enemy:AddStatusEffect("TacticalEnemy")
					end
					if enemy:HasStatusEffect("TEActivation") then
						enemy:RemoveStatusEffect("TEActivation")
					end
					if CurrentModOptions["Tactical_Hardcore"] == "<GameTerm('TE_HARD_BOILED')>" or CurrentModOptions["Tactical_Hardcore"] == "<GameTerm('TE_DEAD_ON_ARRIVAL')>" or CurrentModOptions["Hell_Gate"] == "<GameTerm('TE_NIGHTMARE_A')>" or CurrentModOptions["Hell_Gate"] == "<GameTerm('TE_NIGHTMARE_B')>" then
						if not enemy:HasStatusEffect("Surprised") and not enemy:HasStatusEffect("EnemyCQCReaction") and not enemy:GetActiveWeapons("HeavyWeapon") then
							enemy:AddStatusEffect("EnemyCQCReaction") -- Enemy CQC Reaction [!OPTIONAL!]
						end
					end
				end
				
				--"Livewire" CANNOT HackCheat if [Alerted]!
				if target:HasStatusEffect("InnerInfo") then
					if table.find(ModsLoaded, "id", "DDHP5J") then return end
					
					if not target:HasStatusEffect("InnerInfoRemake") then
						target:AddStatusEffect("InnerInfoRemake")
					end
					target:RemoveStatusEffect("InnerInfo")
				end
				
				-- "Mouse" CANNOT ReconCheat if [Alerted]!
				if target:HasStatusEffect("LightStep") then
					if not target:HasStatusEffect("LightStepRemake") then
						target:AddStatusEffect("LightStepRemake")
					end
					target:RemoveStatusEffect("LightStep")
				end
				
				--[Revised Tactical Gear II] "Overweight" debuff fixed!
				if target:HasStatusEffect("Overweight") then
					target:AddStatusEffect("Slowed")
					target:RemoveStatusEffect("FreeMove")
				end
				
				--TE Global Combat Sneaking Rules [!MUST HAVE!] -- !!!Do NOT Change this one!!! (JA2 Core Logic)
				if target:HasStatusEffect("Hidden") then
					target:AddStatusEffect("GlobalCombatConcealed")
				else
					target:RemoveStatusEffect("GlobalCombatConcealed")
				end
				if target.enemy_visual_contact then
					target:AddStatusEffect("GlobalVisualContact")
					target:RemoveStatusEffect("GlobalCombatConcealed")
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
			Event = "OnBeginTurn",
			Handler = function (self, target)
				--JA3 Tactician Enhanced Activation [!MUST HAVE!] -- !!!Do NOT Change this one!!! (TE Core Logic)
				local allEnemies = GetAllEnemyUnits(target)
				for _, enemy in ipairs(allEnemies) do
					if not enemy:HasStatusEffect("TacticalEnemy") then
						enemy:AddStatusEffect("TacticalEnemy")
					end
					if enemy:HasStatusEffect("TEActivation") then
						enemy:RemoveStatusEffect("TEActivation")
					end
					if CurrentModOptions["Tactical_Hardcore"] == "<GameTerm('TE_HARD_BOILED')>" or CurrentModOptions["Tactical_Hardcore"] == "<GameTerm('TE_DEAD_ON_ARRIVAL')>" or CurrentModOptions["Hell_Gate"] == "<GameTerm('TE_NIGHTMARE_A')>" or CurrentModOptions["Hell_Gate"] == "<GameTerm('TE_NIGHTMARE_B')>" then
						if not enemy:HasStatusEffect("Surprised") and not enemy:HasStatusEffect("EnemyCQCReaction") and not enemy:GetActiveWeapons("HeavyWeapon") then
							enemy:AddStatusEffect("EnemyCQCReaction") -- Enemy CQC Reaction [!OPTIONAL!]
						end
					end
				end
				
				--"Livewire" CANNOT HackCheat if [Alerted]!
				if target:HasStatusEffect("InnerInfo") then
					if table.find(ModsLoaded, "id", "DDHP5J") then return end
					
					if not target:HasStatusEffect("InnerInfoRemake") then
						target:AddStatusEffect("InnerInfoRemake")
					end
					target:RemoveStatusEffect("InnerInfo")
				end
				
				-- "Mouse" CANNOT ReconCheat if [Alerted]!
				if target:HasStatusEffect("LightStep") then
					if not target:HasStatusEffect("LightStepRemake") then
						target:AddStatusEffect("LightStepRemake")
					end
					target:RemoveStatusEffect("LightStep")
				end
				
				--[Revised Tactical Gear II] "Overweight" debuff fixed!
				if target:HasStatusEffect("Overweight") then
					target:AddStatusEffect("Slowed")
					target:RemoveStatusEffect("FreeMove")
				end
				
				--TE Global Combat Sneaking Rules [!MUST HAVE!] -- !!!Do NOT Change this one!!! (JA2 Core Logic)
				if target:HasStatusEffect("Hidden") then
					target:AddStatusEffect("GlobalCombatConcealed")
				else
					target:RemoveStatusEffect("GlobalCombatConcealed")
				end
				if target.enemy_visual_contact then
					target:AddStatusEffect("GlobalVisualContact")
					target:RemoveStatusEffect("GlobalCombatConcealed")
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
			Event = "OnEndTurn",
			Handler = function (self, target)
				--JA3 Tactician Enhanced Activation [!MUST HAVE!] -- !!!Do NOT Change this one!!! (TE Core Logic)
				local allEnemies = GetAllEnemyUnits(target)
				for _, enemy in ipairs(allEnemies) do
					if not enemy:HasStatusEffect("TacticalEnemy") then
						enemy:AddStatusEffect("TacticalEnemy")
					end
					if enemy:HasStatusEffect("TEActivation") then
						enemy:RemoveStatusEffect("TEActivation")
					end
					if CurrentModOptions["Tactical_Hardcore"] == "<GameTerm('TE_HARD_BOILED')>" or CurrentModOptions["Tactical_Hardcore"] == "<GameTerm('TE_DEAD_ON_ARRIVAL')>" or CurrentModOptions["Hell_Gate"] == "<GameTerm('TE_NIGHTMARE_A')>" or CurrentModOptions["Hell_Gate"] == "<GameTerm('TE_NIGHTMARE_B')>" then
						if not enemy:HasStatusEffect("Surprised") and not enemy:HasStatusEffect("EnemyCQCReaction") and not enemy:GetActiveWeapons("HeavyWeapon") then
							enemy:AddStatusEffect("EnemyCQCReaction") -- Enemy CQC Reaction [!OPTIONAL!]
						end
					end
				end
				
				--"Livewire" CANNOT HackCheat if [Alerted]!
				if target:HasStatusEffect("InnerInfo") then
					if table.find(ModsLoaded, "id", "DDHP5J") then return end
					
					if not target:HasStatusEffect("InnerInfoRemake") then
						target:AddStatusEffect("InnerInfoRemake")
					end
					target:RemoveStatusEffect("InnerInfo")
				end
				
				-- "Mouse" CANNOT ReconCheat if [Alerted]!
				if target:HasStatusEffect("LightStep") then
					if not target:HasStatusEffect("LightStepRemake") then
						target:AddStatusEffect("LightStepRemake")
					end
					target:RemoveStatusEffect("LightStep")
				end
				
				--[Revised Tactical Gear II] "Overweight" debuff fixed!
				if target:HasStatusEffect("Overweight") then
					target:AddStatusEffect("Slowed")
					target:RemoveStatusEffect("FreeMove")
				end
				
				--TE Global Combat Sneaking Rules [!MUST HAVE!] -- !!!Do NOT Change this one!!! (JA2 Core Logic)
				if target:HasStatusEffect("Hidden") then
					target:AddStatusEffect("GlobalCombatConcealed")
				else
					target:RemoveStatusEffect("GlobalCombatConcealed")
				end
				if target.enemy_visual_contact then
					target:AddStatusEffect("GlobalVisualContact")
					target:RemoveStatusEffect("GlobalCombatConcealed")
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
			Event = "OnCalcAPCost",
			Handler = function (self, target, current_ap, action, weapon, aim)
				--TE Global Minimum APCost [!MUST HAVE!] -- !!!Do NOT Change this one!!! (TE Core Logic)
				if IsKindOf(weapon, "Firearm") then
					if IsKindOfClasses(weapon, "Pistol", "Revolver") then
						return Max(2 * const.Scale.AP, current_ap)
					end
					if IsKindOfClasses(weapon, "SubmachineGun", "Shotgun", "AssaultRifle") then
						return Max(3 * const.Scale.AP, current_ap)
					end
					return Max(4 * const.Scale.AP, current_ap)
				end
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnCalcChanceToHit",
			Handler = function (self, target, attacker, action, attack_target, weapon1, weapon2, data)
				--TE Global Minimum Accuracy [!MUST HAVE!] -- !!!Do NOT Change this one!!! (TE Core Logic)
				if target == attacker and not attacker:HasStatusEffect("Spiritual") then
					data.min = self:ResolveValue("min_accuracy_mod")
				end
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnCalcFreeMove",
			Handler = function (self, target, data)
				--TE Global Maximum FreeMove [!MUST HAVE!] -- !!!Do NOT Change this one!!! (TE Core Logic)
				data.max = self:ResolveValue("max_freemove_mod")
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnUnitBandaged",
			Handler = function (self, target, healer, patient, hp_restored)
				--TE Medicine Consumables Matters! [!MUST HAVE!] -- !!!Do NOT Change this one!!! (TE Core Logic)
				local medic = healer
				local medicine = target:GetBandageMedicine()
				if medicine and medicine.Condition and target == medic then
					if medic.Medical >= 85 and medic.Wisdom >= 90 and medic:HasStatusEffect("Caretaker") then
						medicine.Condition = Max(0, (medicine.Condition - 15))
					elseif medic.Medical >= 60 and medic.Wisdom >= 70 and medic:HasStatusEffect("Savior") then
						medicine.Condition = Max(0, (medicine.Condition - 25))
					else
						medicine.Condition = Max(0, (medicine.Condition - 50))
					end
				end
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnCalcDamageAndEffects",
			Handler = function (self, target, attacker, attack_target, action, weapon, attack_args, hit, data)
				--TE Parry || HoldPosition! [!MUST HAVE!] -- !!!Do NOT Change this one!!! (TE Core Logic)
				if target == attacker and (attack_target ~= nil and attacker:IsOnEnemySide(attack_target)) and IsKindOf(attack_target, "Unit") and not (attack_args and attack_args.opportunity_attack_type) then
					if (action and action.ActionType) == "Melee Attack" and attack_target:HasStatusEffect("MartialArts") then
						hit.grazing = true -- [MartialArts] will trigger Grazing hit (Parry)!
					end
					if (action and action.ActionType) == "Ranged Attack" and (g_Overwatch[attack_target] or g_Pindown[attack_target]) and attack_target:HasStatusEffect("HoldPosition") then
						hit.critical = nil -- [HoldPosition] will invalidate Critical hit!
					end
				end
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnDamageDone",
			Handler = function (self, target, attack_target, dmg, hit_descr)
				--TE Trigger Enemy Off-Map Artillery Support [!OPTIONAL!]
				if target and (attack_target ~= nil and target:IsOnEnemySide(attack_target)) and IsKindOf(attack_target, "Unit") then
					local allEnemies = GetAllEnemyUnits(target)
					for _, enemy in ipairs(allEnemies) do
						local actions = { "GrenadeLauncherFire", "RocketLauncherFire", "Bombard" }
						for _, id in ipairs(actions) do
							local action = CombatActions[id]
							local weapon = target:GetActiveWeapons("Firearm")
							local weapons = action:GetAttackWeapons(target)
							local enemyDist = DivCeil(target:GetDist(attack_target), const.SlabSizeX)
							if (weapons and (enemyDist > 20)) and not hit_descr.weapon then
								if CurrentModOptions["Tactical_Hardcore"] == "<GameTerm('TE_DEAD_ON_ARRIVAL')>" or CurrentModOptions["Hell_Gate"] == "<GameTerm('TE_NIGHTMARE_A')>" or CurrentModOptions["Hell_Gate"] == "<GameTerm('TE_NIGHTMARE_B')>" then
									enemy:TE_AIArtilleryStrike(target) -- Anti-Launcher||Mortar Exploits!
									target:AddStatusEffect("SuppressionArtilleryCalled")
								end
							end
							-- Enemy Walkie-Talkie Full Alert (Anti-SneakyKillSpam Exploits) [!OPTIONAL!]
							if CurrentModOptions["Tactical_Hardcore"] == "<GameTerm('TE_HARD_BOILED')>" or CurrentModOptions["Tactical_Hardcore"] == "<GameTerm('TE_DEAD_ON_ARRIVAL')>" or CurrentModOptions["Hell_Gate"] == "<GameTerm('TE_NIGHTMARE_A')>" or CurrentModOptions["Hell_Gate"] == "<GameTerm('TE_NIGHTMARE_B')>" then
								if enemy:HasStatusEffect("EnemyFullAlert") or not enemy:IsAware() then
									if target:HasStatusEffect("FoxPerk") then
										PushUnitAlert("death", enemy) -- TriggerAlert (FoxPerk)!
									else
										TriggerUnitAlert("surprise", enemy) -- TriggerAlert!
									end
								end
							end
						end
					end
				end
				
				--TE Anti-Overwatch Exploits! [!MUST HAVE!] -- !!!Do NOT Change this one!!! (TE Core Logic)
				target:RemoveStatusEffect("DistractingRetaliationCounter")
				target:RemoveStatusEffect("ThrowingRetaliationCounter")
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnUnitKill",
			Handler = function (self, target, killedUnits)
				--TE B.O.W. Summon Rituals [!OPTIONAL!]
				if not g_Combat or target:HasStatusEffect("BOWRitualsCD") then return end
				
				for _, unit in ipairs(killedUnits) do
					if unit:HasStatusEffect("Surprised") or unit:HasStatusEffect("TutorialMinion") or unit:HasStatusEffect("ZombiePerk") or unit:HasStatusEffect("TacticalAmbusher") or unit:HasStatusEffect("TacticalBOW") then return end
						
					if unit ~= target and unit:IsOnEnemySide(target) and IsKindOf(unit, "Unit") then
						
						if CurrentModOptions["Hell_Gate"] == "<GameTerm('TE_NIGHTMARE_A')>" or CurrentModOptions["Hell_Gate"] == "<GameTerm('TE_NIGHTMARE_B')>" then
							target:TE_HellGate(target)
							target:AddStatusEffect("BOWRitualsCD")
						end
						if CurrentModOptions["DiceRoll_Event"] == "<GameTerm('TE_AMBUSHER')>" then
							if CurrentModOptions["Hell_Gate"] == "<GameTerm('TE_NIGHTMARE_A')>" or CurrentModOptions["Hell_Gate"] == "<GameTerm('TE_NIGHTMARE_B')>" then return end
						
							target:TE_DiceRoll(target)
							target:AddStatusEffect("BOWRitualsCD")
						end
					end
				end
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnUnitAttackReaction",
			Handler = function (self, target, attacker, attack_target, action, attack_args, results, can_retaliate)
				--TE Suppressive Fire Support! [!MUST HAVE!] -- !!!Do NOT Change this one!!! (TE Core Logic)
				local allEnemies = GetAllEnemyUnits(target)
				for _, enemy in ipairs(allEnemies) do
					if enemy:HasStatusEffect("Protected") or enemy:HasStatusEffect("Panicked") or enemy:HasStatusEffect("Unconscious") then return end
					
					if enemy ~= target and enemy ~= attacker and (enemy:IsAware() and not enemy:IsDead() and not enemy:IsDowned()) then
						local weapon = enemy:GetActiveWeapons()
						local weaponRange = weapon and weapon.WeaponRange or 0
						local enemyDist = DivCeil(enemy:GetDist(attacker), const.SlabSizeX)
						if not g_Overwatch[enemy] and not g_Pindown[enemy] then
							if attacker and attacker:IsOnEnemySide(enemy) and IsKindOf(attacker, "Unit") and attacker.enemy_visual_contact then
								if ((action and action.ActionType) == "Melee Attack" or (action and action.ActionType) == "Ranged Attack") and not (attack_args and attack_args.opportunity_attack_type) then
									if enemy ~= attack_target and enemy:HasStatusEffect("EnemyCQCReaction") and (weaponRange >= enemyDist) and ((enemyDist < 16) or (enemy:HasStatusEffect("TacticalBOW") and (enemyDist <= 20))) and not IsKindOf(weapon, "HeavyWeapon") then
										TE_AsyncRetaliate(enemy, attacker) -- Enemy CQC Reaction Retaliates [!OPTIONAL!]
									end
								end
							end
							if target == attacker and (attack_target ~= nil and attacker:IsOnEnemySide(attack_target)) and IsKindOf(attack_target, "Unit") then
								local action = enemy:GetDefaultAttackAction()
								local action1 = CombatActions['CancelShot']
								local action1a = CombatActions['CancelShotCone']
								local action2 = CombatActions['AutoFire']
								local action2a = CombatActions['MGBurstFire']
								local argz = {target = attacker}
								local resultz = action and action:GetActionResults(enemy, argz)
								if action and not (resultz and resultz.obstructed) then
									if (weaponRange >= enemyDist) or (IsKindOf(weapon, "AssaultRifle") and (enemyDist <= 45)) or (IsKindOf(weapon, "SniperRifle") and (enemyDist <= 70)) then
										if attacker.enemy_visual_contact and (g_Overwatch[attacker] or g_Pindown[attacker]) and not attacker:HasStatusEffect("HoldPosition") then
											if not enemy:HasStatusEffect("DistractingRetaliationCounter") and not attacker:HasStatusEffect("DistractingRetaliationCounter") then
												if IsKindOfClasses(weapon, "SniperRifle", "AssaultRifle", "SubmachineGun", "Pistol", "Revolver") then
													StartCombatAction(action1.id, enemy, 0, argz) -- Enemy Distracting Shot!
													enemy:AddStatusEffect("DistractingRetaliationCounter")
													attacker:AddStatusEffect("DistractingRetaliationCounter")
												elseif IsKindOf(weapon, "Shotgun") then
													StartCombatAction(action1a.id, enemy, 0, argz) -- Enemy Distracting Shot (Shotgun)!
													enemy:AddStatusEffect("DistractingRetaliationCounter")
													attacker:AddStatusEffect("DistractingRetaliationCounter")
												end
											end
										end
									end
									if (g_Overwatch[attacker] or g_Pindown[attacker]) and (weaponRange*2 >= enemyDist) and (enemyDist > 25) then
										if enemy ~= attack_target and not enemy:HasStatusEffect("SuppressingRetaliationCounter") and not attacker:HasStatusEffect("SuppressingRetaliationCounter") then
											if IsKindOfClasses(weapon, "SubmachineGun", "AssaultRifle") then
												StartCombatAction(action2.id, enemy, 0, argz) -- Enemy "Blind shots" Suppression (SMG & AR)!
												enemy:AddStatusEffect("SuppressingRetaliationCounter")
												attacker:AddStatusEffect("SuppressingRetaliationCounter")
											end
											if IsKindOf(weapon, "MachineGun") then
												StartCombatAction(action2a.id, enemy, 0, argz) -- Enemy "Blind shots" Suppression (LMG)!
												enemy:AddStatusEffect("SuppressingRetaliationCounter")
												attacker:AddStatusEffect("SuppressingRetaliationCounter")
											end
										end
									end
								end
								if enemy ~= attack_target and (not HasVisibilityTo(attacker, enemy) or (weaponRange < enemyDist)) and not enemy:HasStatusEffect("MortarRetaliationCounter") then
									local actions = { "ThrowGrenadeA", "ThrowGrenadeB", "ThrowGrenadeC", "ThrowGrenadeD" }
									for _, id in ipairs(actions) do
										local action = CombatActions[id]
										local weapons = action and action:GetAttackWeapons(enemy)
										local enemyPos = ResolveGrenadeTargetPos(attacker, enemy:GetPos(), weapons)
										local allyPos = ResolveGrenadeTargetPos(attack_target, enemy:GetPos(), weapons)
										local args1 = {target = enemyPos}
										local args2 = {target = allyPos}
										local results1 = TE_SafeActionResults(action, enemy, args1, weapons)
										local results2 = TE_SafeActionResults(action, enemy, args2, weapons)
										local explosionPos1 = (results1 and results1.explosion_pos)
										local explosionPos2 = (results2 and results2.explosion_pos)
										local dropDist1 = (weapons and IsPoint(enemyPos) and IsPoint(explosionPos1)) and DivCeil(enemyPos:Dist2D(explosionPos1), const.SlabSizeX) or 99
										local dropDist2 = (weapons and IsPoint(allyPos) and IsPoint(explosionPos2)) and DivCeil(allyPos:Dist2D(explosionPos2), const.SlabSizeX) or 99
										local tileSpace = DivRound(enemy:GetDist(attack_target), const.SlabSizeX)
										if ((attack_args and attack_args.opportunity_attack_type) or enemy:HasStatusEffect("EnemyCQCReaction")) and not enemy:HasStatusEffect("ThrowingRetaliationCounter") then
											if (weapons and (dropDist1 <= 1)) and ((enemyDist < 16) or (enemy:HasStatusEffect("TacticalBOW") and (enemyDist <= 20))) and not enemy:IsPointBlankRange(attacker) and not attacker:HasStatusEffect("ThrowingRetaliationCounter") then
												StartCombatAction(action.id, enemy, 0, args1) -- Enemy Grenades/Explosives Attacks!
												enemy:AddStatusEffect("ThrowingRetaliationCounter")
												attacker:AddStatusEffect("ThrowingRetaliationCounter")
												break
											end
										end
										if ((g_Overwatch[attacker] or g_Pindown[attacker]) or enemy:HasStatusEffect("EnemyCQCReaction")) and not enemy:HasStatusEffect("SmokeCoverCounter") then
											for _, hit in ipairs(results) do
												if not hit.grazing and not results.miss then
													if (weapons and (dropDist2 <= 1)) and (tileSpace <= 25) and IsKindOfClasses(weapons, "SmokeGrenade", "TearGasGrenade", "ToxicGasGrenade") and not attacker:HasStatusEffect("SmokeCoverCounter") then
														StartCombatAction(action.id, enemy, 0, args2) -- Enemy Smoke/Gas Covers!
														enemy:AddStatusEffect("SmokeCoverCounter")
														attacker:AddStatusEffect("SmokeCoverCounter")
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
				end
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
								if CurrentModOptions["Tactical_Hardcore"] == "<GameTerm('TE_DEAD_ON_ARRIVAL')>" or CurrentModOptions["Hell_Gate"] == "<GameTerm('TE_NIGHTMARE_A')>" or CurrentModOptions["Hell_Gate"] == "<GameTerm('TE_NIGHTMARE_B')>" then
									attacker:AddStatusEffect("SuppressionArtilleryCalled") -- Trigger Enemy Off-Map Artillery Support [!OPTIONAL!]
								end
								attack_target:AddStatusEffect("Suppressed")
							end
							if (weaponRange >= enemyDist) and HasVisibilityTo(attack_target, attacker) then
								if attack_target.stance == "Standing" and not (attack_args and attack_args.opportunity_attack_type) then
									TE_SafeCrouch(attack_target)
								end
								attack_target:AddStatusEffect("SuppressionShocked")
							end
						end
						if not (attack_args and attack_args.opportunity_attack_type) and ((enemyDist > 25) or IsKindOfClasses(results.weapon, "Grenade", "HeavyWeapon")) then
							if CurrentModOptions["Tactical_Hardcore"] == "<GameTerm('TE_DEAD_ON_ARRIVAL')>" or CurrentModOptions["Hell_Gate"] == "<GameTerm('TE_NIGHTMARE_A')>" or CurrentModOptions["Hell_Gate"] == "<GameTerm('TE_NIGHTMARE_B')>" then
								attacker:AddStatusEffect("SuppressionArtilleryCalled") -- Trigger Enemy Off-Map Artillery Support [!OPTIONAL!]
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
		PlaceObj('UnitReaction', {
			Event = "OnCalcOverwatchAttacks",
			Handler = function (self, target, value, action, args)
				--TE Binoculars Reconnaissance -- !!!Do NOT Change this one!!! (JA2 Core Logic)
				if (GameState.Night or GameState.Underground) and not target:HasNightVision() then return end
				
				local items = target:GetHandheldItems()
				local weapon = target:GetActiveWeapons("Firearm")
				for _, item in ipairs(items) do
					if g_Overwatch[target] and IsKindOf(item, "TE_Binoculars") and IsKindOfClasses(weapon, "AssaultRifle", "SniperRifle") then
						target:AddStatusEffect("GlobalReconnaissance")
					elseif not g_Overwatch[target] then
						target:RemoveStatusEffect("GlobalReconnaissance")
					end
				end
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnCheckIntelVisible",
			Handler = function (self, target)
				--TE TriggerAlert (Anti-RetreatSpam Exploits)! [!MUST HAVE!] -- !!!Do NOT Change this one!!! (JA2 Core Logic)
				local allEnemies = GetAllEnemyUnits(target)
				for _, enemy in ipairs(allEnemies) do
					if not g_Combat then
						if enemy:HasStatusEffect("TacticalEnemy") then
							if enemy:HasStatusEffect("Surprised") or enemy:HasStatusEffect("ZombiePerk") or enemy:HasStatusEffect("TacticalAmbusher") or enemy:HasStatusEffect("TacticalBOW") then return end
							
							TriggerUnitAlert("surprise", enemy) -- Trigger Sector-Alert!
						end
						if enemy:HasStatusEffect("TacticalAmbusher") or enemy:HasStatusEffect("TacticalBOW") then
							DoneObject(enemy) -- Ambusher & B.O.W. Self-Destruction!
						end
					end
				end
			end,
		}),
	},
	OnAdded = function (self, obj)
		obj:AddStatusEffect("GlobalSightRange") -- TE Global Visibility Overhaul! [!MUST HAVE!] -- !!!Do NOT Change this one!!! (TE Core Logic)
		obj:AddStatusEffectImmunity("TacticalEnemy", self.class)
		obj:AddStatusEffectImmunity("TacticalAmbusher", self.class)
		obj:AddStatusEffectImmunity("TacticalBOW", self.class)
		obj:AddStatusEffectImmunity("HighAlert", self.class)
		obj:AddStatusEffectImmunity("EnemyCQCReaction", self.class)
		obj:AddStatusEffectImmunity("EnemyBioInfection", self.class)
		obj:AddStatusEffectImmunity("TutorialMinion", self.class)
		obj:AddStatusEffectImmunity("OverwatchExpert", self.class)
		obj:AddStatusEffectImmunity("LightningReactionNPC", self.class)
		obj:AddStatusEffectImmunity("NaturalCamouflage", self.class)
		obj:AddStatusEffectImmunity("ZombiePerk", self.class)
		obj:AddStatusEffectImmunity("DieselPerk", self.class)
	end,
	OnRemoved = function (self, obj)
		obj:RemoveStatusEffectImmunity("TacticalEnemy", self.class)
		obj:RemoveStatusEffectImmunity("TacticalAmbusher", self.class)
		obj:RemoveStatusEffectImmunity("TacticalBOW", self.class)
		obj:RemoveStatusEffectImmunity("HighAlert", self.class)
		obj:RemoveStatusEffectImmunity("EnemyCQCReaction", self.class)
		obj:RemoveStatusEffectImmunity("EnemyBioInfection", self.class)
		obj:RemoveStatusEffectImmunity("TutorialMinion", self.class)
		obj:RemoveStatusEffectImmunity("OverwatchExpert", self.class)
		obj:RemoveStatusEffectImmunity("LightningReactionNPC", self.class)
		obj:RemoveStatusEffectImmunity("NaturalCamouflage", self.class)
		obj:RemoveStatusEffectImmunity("ZombiePerk", self.class)
		obj:RemoveStatusEffectImmunity("DieselPerk", self.class)
	end,
	Icon = "UI/Hud/Status effects/vengeance_target",
}

