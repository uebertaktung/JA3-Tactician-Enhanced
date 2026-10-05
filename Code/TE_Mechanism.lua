-- ========== Activate JA3 Tactician Enhanced DO NOT EDIT MANUALLY! ========== -- These are [Tactician Enhanced] CORE Function and DO NOT EDIT MANUALLY! [!MUST HAVE!] -- !!!Do NOT Change this one!!! (TE & JA2 Core Logic)
OnMsg.ExplorationStart = function()
	for _, unit in ipairs(g_Units) do
		if unit.team.player_team or unit:IsLocalPlayerControlled() or unit:IsMerc() or IsMerc(unit) then
			local enemies = GetAllEnemyUnits(unit)
			for _, enemy in ipairs(enemies) do
				if not g_Combat then
					if enemy:HasStatusEffect("TacticalAmbusher") or enemy:HasStatusEffect("TacticalBOW") then
						DoneObject(enemy) -- Ambusher & B.O.W. Self-Destruction (Avoid invaliad DiceRoll or Hell Gate position)! -- !!!Do NOT Change this one!!! (TE Core Logic)
					end
					if not enemy:IsDead() then
						if CurrentModOptions["Tactical_Hardcore"] == "<GameTerm('TE_HARD_BOILED')>" or CurrentModOptions["Tactical_Hardcore"] == "<GameTerm('TE_DEAD_ON_ARRIVAL')>" or CurrentModOptions["Hell_Gate"] == "<GameTerm('TE_NIGHTMARE_A')>" or CurrentModOptions["Hell_Gate"] == "<GameTerm('TE_NIGHTMARE_B')>" then
							unit:AddStatusEffect("EnemyFullAlert") -- Sector Enemies Full Alert (Anti-SneakyKill Exploits) [OPTIONAL]
							enemy:AddStatusEffect("EnemyFullAlert") -- Sector Enemies Full Alert (Anti-SneakyKill Exploits) [OPTIONAL]
						end
						if enemy:GetActiveWeapons("SniperRifle") or enemy:GetActiveWeapons("MeleeWeapon") then
							enemy:AddStatusEffect("NaturalCamouflage") -- Sector Snipers & Brutes Gain Camouflage! -- !!!Do NOT Change this one!!! (TE Core Logic)
						end
						unit:SetActionCommand("Hide") -- player_team always [Sneaking] at ExplorationStart on enemies presence! -- !!!Do NOT Change this one!!! (TE Core Logic)
					end
				end
			end
			if CurrentModOptions["Tactical_Tutorial"] then
				unit:AddStatusEffect("TacticalTutorial") -- Tactician Enhanced Tutorial Info for Illustrative Purposes [OPTIONAL]
			end
			unit:AddStatusEffect("TEActivation") -- Tactician Enhanced Activation [!MUST HAVE!] -- !!!Do NOT Change this one!!! (TE Core Logic)
			unit:RemoveStatusEffect("HighAlert")
			unit:RemoveStatusEffect("TacticalEnemy")
			unit:RemoveStatusEffect("TacticalAmbusher")
			unit:RemoveStatusEffect("TacticalBOW")
			unit:RemoveStatusEffect("EnemyCQCReaction")
			unit:RemoveStatusEffect("EnemyBioInfection")
			unit:RemoveStatusEffect("TutorialMinion")
			unit:RemoveStatusEffect("OverwatchExpert")
			unit:RemoveStatusEffect("LightningReactionNPC")
			unit:RemoveStatusEffect("NaturalCamouflage")
			unit:RemoveStatusEffect("ZombiePerk")
			unit:RemoveStatusEffect("DieselPerk")
		end
	end
end
OnMsg.CombatStart = function()
	for _, unit in ipairs(g_Units) do
		if not unit.team.player_enemy or unit:IsLocalPlayerControlled() or unit:IsMerc() or IsMerc(unit) then
			unit:AddStatusEffect("TEActivation") -- Tactician Enhanced Activation [!MUST HAVE!] -- !!!Do NOT Change this one!!! (TE Core Logic)
			unit:RemoveStatusEffect("HighAlert")
			unit:RemoveStatusEffect("TacticalEnemy")
			unit:RemoveStatusEffect("TacticalAmbusher")
			unit:RemoveStatusEffect("TacticalBOW")
			unit:RemoveStatusEffect("EnemyFullAlert")
			unit:RemoveStatusEffect("EnemyCQCReaction")
			unit:RemoveStatusEffect("EnemyBioInfection")
			unit:RemoveStatusEffect("TutorialMinion")
			unit:RemoveStatusEffect("OverwatchExpert")
			unit:RemoveStatusEffect("LightningReactionNPC")
			unit:RemoveStatusEffect("NaturalCamouflage")
			unit:RemoveStatusEffect("ZombiePerk")
			unit:RemoveStatusEffect("DieselPerk")
		else
			if CurrentModOptions["Tactical_Hardcore"] == "<GameTerm('TE_DEAD_ON_ARRIVAL')>" or CurrentModOptions["Hell_Gate"] == "<GameTerm('TE_NIGHTMARE_A')>" or CurrentModOptions["Hell_Gate"] == "<GameTerm('TE_NIGHTMARE_B')>" then --TE Enemy Stats-Specialization [OPTIONAL]
				if unit.Agility < 90 then
					unit.Agility = 90
				end
				if unit.Dexterity < 90 then
					unit.Dexterity = 90
				end
				if unit.Strength < 90 then
					unit.Strength = 90
				end
				if unit.Leadership < 90 then
					unit.Leadership = 90
				end
				if unit.Marksmanship < 90 then
					unit.Marksmanship = 90
				end
				if unit.Mechanical < 90 then
					unit.Mechanical = 90
				end
				if unit.Explosives < 90 then
					unit.Explosives = 90
				end
				if unit.Medical < 90 then
					unit.Medical = 90
				end
				if unit.Wisdom < 90 then
					unit.Wisdom = 90
				end
			end
			if IsKindOf(unit, "Unit") and not unit:HasStatusEffect("TutorialMinion") and unit.species == "Human" then -- Tactician Enhanced Activation [!MUST HAVE!] -- !!!Do NOT Change this one!!! (TE Core Logic)
				if not unit:HasStatusEffect("TacticalEnemy") then
					unit:AddStatusEffect("TacticalEnemy")
				end
				if unit:HasStatusEffect("EnemyFullAlert") then
					unit:RemoveStatusEffect("EnemyFullAlert")
				end
				if unit:HasStatusEffect("TEActivation") then
					unit:RemoveStatusEffect("TEActivation")
				end
				if not unit:HasStatusEffect("FreeMove") then
					unit:AddStatusEffect("FreeMove")
				end
				if unit:HasStatusEffect("MinFreeMove") then
					unit:RemoveStatusEffect("MinFreeMove")
				end
				if unit:HasStatusEffect("Shatterhand") then
					unit:RemoveStatusEffect("Shatterhand")
				end
				if unit:HasStatusEffect("Hotblood") then
					unit:RemoveStatusEffect("Hotblood")
				end
				if CurrentModOptions["Tactical_Hardcore"] == "<GameTerm('TE_HARD_BOILED')>" or CurrentModOptions["Tactical_Hardcore"] == "<GameTerm('TE_DEAD_ON_ARRIVAL')>" or CurrentModOptions["Hell_Gate"] == "<GameTerm('TE_NIGHTMARE_A')>" or CurrentModOptions["Hell_Gate"] == "<GameTerm('TE_NIGHTMARE_B')>" then
					local weapon = unit:GetActiveWeapons()
					if not unit:HasStatusEffect("Surprised") and not unit:HasStatusEffect("EnemyCQCReaction") and not IsKindOf(weapon, "HeavyWeapon") then
						unit:AddStatusEffect("EnemyCQCReaction")
					end
					 --TE Enemy Perks-Specialization [OPTIONAL]
					if not unit:HasStatusEffect("BeefedUp") then
						unit:AddStatusEffect("BeefedUp")
					end
					if (unit.Agility >= 85 or unit.Dexterity >= 85 or unit.Marksmanship >= 85) or (unit.Health >= 85 or unit.Strength >= 85) then
						if not unit:HasStatusEffect("NightOps") then
							unit:AddStatusEffect("NightOps")
						end
						if not unit:HasStatusEffect("Throwing") then
							unit:AddStatusEffect("Throwing")
						end
					end
					if unit.using_cumbersome then
						if not unit:HasStatusEffect("KillingWind") then
							unit:AddStatusEffect("KillingWind")
						end
						if not unit:HasStatusEffect("Ironclad") then
							unit:AddStatusEffect("Ironclad")
						end
					end
					if IsKindOf(weapon, "MeleeWeapon") then
						if not unit:HasStatusEffect("DangerClose") then
							unit:AddStatusEffect("DangerClose")
						end
						if not unit:HasStatusEffect("NaturalCamouflage") then
							unit:AddStatusEffect("NaturalCamouflage")
						end
						if not unit:HasStatusEffect("MartialArts") then
							unit:AddStatusEffect("MartialArts")
						end
						if not unit:HasStatusEffect("MeleeTraining") then
							unit:AddStatusEffect("MeleeTraining")
						end
						if not unit:HasStatusEffect("OptimalPerformance") then
							unit:AddStatusEffect("OptimalPerformance")
						end
						if not unit:HasStatusEffect("BreachAndClear") then
							unit:AddStatusEffect("BreachAndClear")
						end
						if not unit:HasStatusEffect("Berserker") then
							unit:AddStatusEffect("Berserker")
						end
						if not unit:HasStatusEffect("TrueGrit") then
							unit:AddStatusEffect("TrueGrit")
						end
						if not unit:HasStatusEffect("Infiltrator") then
							unit:AddStatusEffect("Infiltrator")
						end
						if not unit:HasStatusEffect("HardBlow") then
							unit:AddStatusEffect("HardBlow")
						end
						if not unit:HasStatusEffect("BloodScent") and (unit.Strength >= 90 or unit.Agility >= 90) then
							unit:AddStatusEffect("BloodScent")
						end
						if not unit:HasStatusEffect("LineBreaker") and (unit.Strength >= 90 or unit.Agility >= 90) then
							unit:AddStatusEffect("LineBreaker")
						end
						if unit:HasStatusEffect("HeavyWeaponsTraining") then
							unit:RemoveStatusEffect("HeavyWeaponsTraining")
						end
						if unit:HasStatusEffect("AutoWeapons") then
							unit:RemoveStatusEffect("AutoWeapons")
						end
						if unit:HasStatusEffect("CQCTraining") then
							unit:RemoveStatusEffect("CQCTraining")
						end
						if unit:HasStatusEffect("Killzone") then
							unit:RemoveStatusEffect("Killzone")
						end
					end
					if IsKindOf(weapon, "Shotgun") then
						if not unit:HasStatusEffect("DangerClose") then
							unit:AddStatusEffect("DangerClose")
						end
						if not unit:HasStatusEffect("CQCTraining") then
							unit:AddStatusEffect("CQCTraining")
						end
						if not unit:HasStatusEffect("BreachAndClear") then
							unit:AddStatusEffect("BreachAndClear")
						end
						if not unit:HasStatusEffect("Berserker") then
							unit:AddStatusEffect("Berserker")
						end
						if not unit:HasStatusEffect("TrueGrit") then
							unit:AddStatusEffect("TrueGrit")
						end
						if not unit:HasStatusEffect("InstantAutopsy") then
							unit:AddStatusEffect("InstantAutopsy")
						end
						if not unit:HasStatusEffect("LineBreaker") and (unit.Strength >= 90 or unit.Agility >= 90) then
							unit:AddStatusEffect("LineBreaker")
						end
						if unit:HasStatusEffect("HeavyWeaponsTraining") then
							unit:RemoveStatusEffect("HeavyWeaponsTraining")
						end
						if unit:HasStatusEffect("AutoWeapons") then
							unit:RemoveStatusEffect("AutoWeapons")
						end
						if unit:HasStatusEffect("MartialArts") then
							unit:RemoveStatusEffect("MartialArts")
						end
						if unit:HasStatusEffect("Killzone") then
							unit:RemoveStatusEffect("Killzone")
						end
					end
					if IsKindOf(weapon, "SubmachineGun") then
						if not unit:HasStatusEffect("TagTeam") then
							unit:AddStatusEffect("TagTeam")
						end
						if not unit:HasStatusEffect("AutoWeapons") then
							unit:AddStatusEffect("AutoWeapons")
						end
						if not unit:HasStatusEffect("CQCTraining") then
							unit:AddStatusEffect("CQCTraining")
						end
						if not unit:HasStatusEffect("Flanker") then
							unit:AddStatusEffect("Flanker")
						end
						if not unit:HasStatusEffect("Untraceable") then
							unit:AddStatusEffect("Untraceable")
						end
						if not unit:HasStatusEffect("Infiltrator") then
							unit:AddStatusEffect("Infiltrator")
						end
						if not unit:HasStatusEffect("Killzone") and (unit.Dexterity >= 90 or unit.Agility >= 90) then
							unit:AddStatusEffect("Killzone")
						end
						if unit:HasStatusEffect("HeavyWeaponsTraining") then
							unit:RemoveStatusEffect("HeavyWeaponsTraining")
						end
						if unit:HasStatusEffect("MartialArts") then
							unit:RemoveStatusEffect("MartialArts")
						end
						if unit:HasStatusEffect("LineBreaker") then
							unit:RemoveStatusEffect("LineBreaker")
						end
					end
					if IsKindOf(weapon, "AssaultRifle") then
						if not unit:HasStatusEffect("SecondStoryMan") then
							unit:AddStatusEffect("SecondStoryMan")
						end
						if not unit:HasStatusEffect("AutoWeapons") then
							unit:AddStatusEffect("AutoWeapons")
						end
						if not unit:HasStatusEffect("CQCTraining") then
							unit:AddStatusEffect("CQCTraining")
						end
						if not unit:HasStatusEffect("HitTheDeck") then
							unit:AddStatusEffect("HitTheDeck")
						end
						if not unit:HasStatusEffect("TakeAim") then
							unit:AddStatusEffect("TakeAim")
						end
						if not unit:HasStatusEffect("DeathFromAbove") then
							unit:AddStatusEffect("DeathFromAbove")
						end
						if not unit:HasStatusEffect("Counterfire") then
							unit:AddStatusEffect("Counterfire")
						end
						if not unit:HasStatusEffect("BattleFocus") and (unit.Health >= 80 or unit.Strength >= 80) then
							unit:AddStatusEffect("BattleFocus")
						end
						if unit:HasStatusEffect("HeavyWeaponsTraining") then
							unit:RemoveStatusEffect("HeavyWeaponsTraining")
						end
						if unit:HasStatusEffect("CollateralDamage") then
							unit:RemoveStatusEffect("CollateralDamage")
						end
						if unit:HasStatusEffect("InstantAutopsy") then
							unit:RemoveStatusEffect("InstantAutopsy")
						end
						if unit:HasStatusEffect("LineBreaker") then
							unit:RemoveStatusEffect("LineBreaker")
						end
						if unit:HasStatusEffect("Killzone") then
							unit:RemoveStatusEffect("Killzone")
						end
					end
					if IsKindOfClasses(weapon, "MachineGun", "HeavyWeapon") then
						if not unit:HasStatusEffect("KillingWind") then
							unit:AddStatusEffect("KillingWind")
						end
						if not unit:HasStatusEffect("HeavyWeaponsTraining") then
							unit:AddStatusEffect("HeavyWeaponsTraining")
						end
						if not unit:HasStatusEffect("CQCTraining") then
							unit:AddStatusEffect("CQCTraining")
						end
						if not unit:HasStatusEffect("HitTheDeck") then
							unit:AddStatusEffect("HitTheDeck")
						end
						if not unit:HasStatusEffect("TakeAim") then
							unit:AddStatusEffect("TakeAim")
						end
						if not unit:HasStatusEffect("Ironclad") then
							unit:AddStatusEffect("Ironclad")
						end
						if not unit:HasStatusEffect("StressManagement") then
							unit:AddStatusEffect("StressManagement")
						end
						if not unit:HasStatusEffect("HoldPosition") and (unit.Health >= 80 or unit.Strength >= 80) then
							unit:AddStatusEffect("HoldPosition")
						end
						if not unit:HasStatusEffect("CollateralDamage") and (unit.Strength >= 80 or unit.Agility >= 80) then
							unit:AddStatusEffect("CollateralDamage")
						end
						if unit:HasStatusEffect("AutoWeapons") then
							unit:RemoveStatusEffect("AutoWeapons")
						end
						if unit:HasStatusEffect("Instagib") then
							unit:RemoveStatusEffect("Instagib")
						end
					end
					if IsKindOf(weapon, "SniperRifle") then
						if not unit:HasStatusEffect("HawksEye") then
							unit:AddStatusEffect("HawksEye")
						end
						if not unit:HasStatusEffect("NaturalCamouflage") then
							unit:AddStatusEffect("NaturalCamouflage")
						end
						if not unit:HasStatusEffect("CQCTraining") then
							unit:AddStatusEffect("CQCTraining")
						end
						if not unit:HasStatusEffect("Hobbler") then
							unit:AddStatusEffect("Hobbler")
						end
						if not unit:HasStatusEffect("Deadeye") then
							unit:AddStatusEffect("Deadeye")
						end
						if not unit:HasStatusEffect("DeathFromAbove") then
							unit:AddStatusEffect("DeathFromAbove")
						end
						if not unit:HasStatusEffect("Infiltrator") then
							unit:AddStatusEffect("Infiltrator")
						end
						if not unit:HasStatusEffect("Instagib") and unit.Dexterity >= 90 then
							unit:AddStatusEffect("Instagib")
						end
						if unit:HasStatusEffect("HeavyWeaponsTraining") then
							unit:RemoveStatusEffect("HeavyWeaponsTraining")
						end
						if unit:HasStatusEffect("AutoWeapons") then
							unit:RemoveStatusEffect("AutoWeapons")
						end
						if unit:HasStatusEffect("CollateralDamage") then
							unit:RemoveStatusEffect("CollateralDamage")
						end
					end
				end
				if CurrentModOptions["Hell_Gate"] == "<GameTerm('TE_NIGHTMARE_A')>" or CurrentModOptions["Hell_Gate"] == "<GameTerm('TE_NIGHTMARE_B')>" then --TE Enemy Bio-Infection [OPTIONAL]
					if not unit:HasStatusEffect("Surprised") and not unit:HasStatusEffect("EnemyBioInfection") then
						unit:AddStatusEffect("EnemyBioInfection")
					end
				end
			end
		end
	end
end
OnMsg.TurnStart = function()
	for _, unit in ipairs(g_Units) do
		if unit.team.player_team and (g_Teams[g_CurrentTeam].side == 'player1' or g_Teams[g_CurrentTeam].side == 'player2') then
			unit:AddStatusEffect("TEActivation") -- Tactician Enhanced Activation [!MUST HAVE!] -- !!!Do NOT Change this one!!! (TE Core Logic)
			unit:RemoveStatusEffect("HighAlert")
			unit:RemoveStatusEffect("TacticalEnemy")
			unit:RemoveStatusEffect("TacticalAmbusher")
			unit:RemoveStatusEffect("TacticalBOW")
			unit:RemoveStatusEffect("EnemyFullAlert")
			unit:RemoveStatusEffect("EnemyCQCReaction")
			unit:RemoveStatusEffect("EnemyBioInfection")
			unit:RemoveStatusEffect("TutorialMinion")
			unit:RemoveStatusEffect("OverwatchExpert")
			unit:RemoveStatusEffect("LightningReactionNPC")
			unit:RemoveStatusEffect("NaturalCamouflage")
			unit:RemoveStatusEffect("ZombiePerk")
			unit:RemoveStatusEffect("DieselPerk")
		end
		if unit.team.player_enemy and (g_Teams[g_CurrentTeam].side == 'enemy1' or g_Teams[g_CurrentTeam].side == 'enemy2') then
			if CurrentModOptions["Tactical_Hardcore"] == "<GameTerm('TE_DEAD_ON_ARRIVAL')>" or CurrentModOptions["Hell_Gate"] == "<GameTerm('TE_NIGHTMARE_A')>" or CurrentModOptions["Hell_Gate"] == "<GameTerm('TE_NIGHTMARE_B')>" then --TE Enemy Stats-Specialization [!OPTIONAL!]
				if unit.Agility < 90 then
					unit.Agility = 90
				end
				if unit.Dexterity < 90 then
					unit.Dexterity = 90
				end
				if unit.Strength < 90 then
					unit.Strength = 90
				end
				if unit.Leadership < 90 then
					unit.Leadership = 90
				end
				if unit.Marksmanship < 90 then
					unit.Marksmanship = 90
				end
				if unit.Mechanical < 90 then
					unit.Mechanical = 90
				end
				if unit.Explosives < 90 then
					unit.Explosives = 90
				end
				if unit.Medical < 90 then
					unit.Medical = 90
				end
				if unit.Wisdom < 90 then
					unit.Wisdom = 90
				end
			end
			if IsKindOf(unit, "Unit") and not unit:HasStatusEffect("TutorialMinion") and unit.species == "Human" then -- Tactician Enhanced Activation [!MUST HAVE!] -- !!!Do NOT Change this one!!! (TE Core Logic)
				if not unit:HasStatusEffect("TacticalEnemy") then
					unit:AddStatusEffect("TacticalEnemy")
				end
				if unit:HasStatusEffect("EnemyFullAlert") then
					unit:RemoveStatusEffect("EnemyFullAlert")
				end
				if unit:HasStatusEffect("TEActivation") then
					unit:RemoveStatusEffect("TEActivation")
				end
				if not unit:HasStatusEffect("FreeMove") then
					unit:AddStatusEffect("FreeMove")
				end
				if unit:HasStatusEffect("MinFreeMove") then
					unit:RemoveStatusEffect("MinFreeMove")
				end
				if unit:HasStatusEffect("Shatterhand") then
					unit:RemoveStatusEffect("Shatterhand")
				end
				if unit:HasStatusEffect("Hotblood") then
					unit:RemoveStatusEffect("Hotblood")
				end
				if CurrentModOptions["Tactical_Hardcore"] == "<GameTerm('TE_HARD_BOILED')>" or CurrentModOptions["Tactical_Hardcore"] == "<GameTerm('TE_DEAD_ON_ARRIVAL')>" or CurrentModOptions["Hell_Gate"] == "<GameTerm('TE_NIGHTMARE_A')>" or CurrentModOptions["Hell_Gate"] == "<GameTerm('TE_NIGHTMARE_B')>" then
					local weapon = unit:GetActiveWeapons()
					if not unit:HasStatusEffect("Surprised") and not unit:HasStatusEffect("EnemyCQCReaction") and not IsKindOf(weapon, "HeavyWeapon") then
						unit:AddStatusEffect("EnemyCQCReaction")
					end
					 --TE Enemy Perks-Specialization [OPTIONAL]
					if not unit:HasStatusEffect("BeefedUp") then
						unit:AddStatusEffect("BeefedUp")
					end
					if (unit.Agility >= 85 or unit.Dexterity >= 85 or unit.Marksmanship >= 85) or (unit.Health >= 85 or unit.Strength >= 85) then
						if not unit:HasStatusEffect("NightOps") then
							unit:AddStatusEffect("NightOps")
						end
						if not unit:HasStatusEffect("Throwing") then
							unit:AddStatusEffect("Throwing")
						end
					end
					if unit.using_cumbersome then
						if not unit:HasStatusEffect("KillingWind") then
							unit:AddStatusEffect("KillingWind")
						end
						if not unit:HasStatusEffect("Ironclad") then
							unit:AddStatusEffect("Ironclad")
						end
					end
					if IsKindOf(weapon, "MeleeWeapon") then
						if not unit:HasStatusEffect("DangerClose") then
							unit:AddStatusEffect("DangerClose")
						end
						if not unit:HasStatusEffect("NaturalCamouflage") then
							unit:AddStatusEffect("NaturalCamouflage")
						end
						if not unit:HasStatusEffect("MartialArts") then
							unit:AddStatusEffect("MartialArts")
						end
						if not unit:HasStatusEffect("MeleeTraining") then
							unit:AddStatusEffect("MeleeTraining")
						end
						if not unit:HasStatusEffect("OptimalPerformance") then
							unit:AddStatusEffect("OptimalPerformance")
						end
						if not unit:HasStatusEffect("BreachAndClear") then
							unit:AddStatusEffect("BreachAndClear")
						end
						if not unit:HasStatusEffect("Berserker") then
							unit:AddStatusEffect("Berserker")
						end
						if not unit:HasStatusEffect("TrueGrit") then
							unit:AddStatusEffect("TrueGrit")
						end
						if not unit:HasStatusEffect("Infiltrator") then
							unit:AddStatusEffect("Infiltrator")
						end
						if not unit:HasStatusEffect("HardBlow") then
							unit:AddStatusEffect("HardBlow")
						end
						if not unit:HasStatusEffect("BloodScent") and (unit.Strength >= 90 or unit.Agility >= 90) then
							unit:AddStatusEffect("BloodScent")
						end
						if not unit:HasStatusEffect("LineBreaker") and (unit.Strength >= 90 or unit.Agility >= 90) then
							unit:AddStatusEffect("LineBreaker")
						end
						if unit:HasStatusEffect("HeavyWeaponsTraining") then
							unit:RemoveStatusEffect("HeavyWeaponsTraining")
						end
						if unit:HasStatusEffect("AutoWeapons") then
							unit:RemoveStatusEffect("AutoWeapons")
						end
						if unit:HasStatusEffect("CQCTraining") then
							unit:RemoveStatusEffect("CQCTraining")
						end
						if unit:HasStatusEffect("Killzone") then
							unit:RemoveStatusEffect("Killzone")
						end
					end
					if IsKindOf(weapon, "Shotgun") then
						if not unit:HasStatusEffect("DangerClose") then
							unit:AddStatusEffect("DangerClose")
						end
						if not unit:HasStatusEffect("CQCTraining") then
							unit:AddStatusEffect("CQCTraining")
						end
						if not unit:HasStatusEffect("BreachAndClear") then
							unit:AddStatusEffect("BreachAndClear")
						end
						if not unit:HasStatusEffect("Berserker") then
							unit:AddStatusEffect("Berserker")
						end
						if not unit:HasStatusEffect("TrueGrit") then
							unit:AddStatusEffect("TrueGrit")
						end
						if not unit:HasStatusEffect("InstantAutopsy") then
							unit:AddStatusEffect("InstantAutopsy")
						end
						if not unit:HasStatusEffect("LineBreaker") and (unit.Strength >= 90 or unit.Agility >= 90) then
							unit:AddStatusEffect("LineBreaker")
						end
						if unit:HasStatusEffect("HeavyWeaponsTraining") then
							unit:RemoveStatusEffect("HeavyWeaponsTraining")
						end
						if unit:HasStatusEffect("AutoWeapons") then
							unit:RemoveStatusEffect("AutoWeapons")
						end
						if unit:HasStatusEffect("MartialArts") then
							unit:RemoveStatusEffect("MartialArts")
						end
						if unit:HasStatusEffect("Killzone") then
							unit:RemoveStatusEffect("Killzone")
						end
					end
					if IsKindOf(weapon, "SubmachineGun") then
						if not unit:HasStatusEffect("TagTeam") then
							unit:AddStatusEffect("TagTeam")
						end
						if not unit:HasStatusEffect("AutoWeapons") then
							unit:AddStatusEffect("AutoWeapons")
						end
						if not unit:HasStatusEffect("CQCTraining") then
							unit:AddStatusEffect("CQCTraining")
						end
						if not unit:HasStatusEffect("Flanker") then
							unit:AddStatusEffect("Flanker")
						end
						if not unit:HasStatusEffect("Untraceable") then
							unit:AddStatusEffect("Untraceable")
						end
						if not unit:HasStatusEffect("Infiltrator") then
							unit:AddStatusEffect("Infiltrator")
						end
						if not unit:HasStatusEffect("Killzone") and (unit.Dexterity >= 90 or unit.Agility >= 90) then
							unit:AddStatusEffect("Killzone")
						end
						if unit:HasStatusEffect("HeavyWeaponsTraining") then
							unit:RemoveStatusEffect("HeavyWeaponsTraining")
						end
						if unit:HasStatusEffect("MartialArts") then
							unit:RemoveStatusEffect("MartialArts")
						end
						if unit:HasStatusEffect("LineBreaker") then
							unit:RemoveStatusEffect("LineBreaker")
						end
					end
					if IsKindOf(weapon, "AssaultRifle") then
						if not unit:HasStatusEffect("SecondStoryMan") then
							unit:AddStatusEffect("SecondStoryMan")
						end
						if not unit:HasStatusEffect("AutoWeapons") then
							unit:AddStatusEffect("AutoWeapons")
						end
						if not unit:HasStatusEffect("CQCTraining") then
							unit:AddStatusEffect("CQCTraining")
						end
						if not unit:HasStatusEffect("HitTheDeck") then
							unit:AddStatusEffect("HitTheDeck")
						end
						if not unit:HasStatusEffect("TakeAim") then
							unit:AddStatusEffect("TakeAim")
						end
						if not unit:HasStatusEffect("DeathFromAbove") then
							unit:AddStatusEffect("DeathFromAbove")
						end
						if not unit:HasStatusEffect("Counterfire") then
							unit:AddStatusEffect("Counterfire")
						end
						if not unit:HasStatusEffect("BattleFocus") and (unit.Health >= 80 or unit.Strength >= 80) then
							unit:AddStatusEffect("BattleFocus")
						end
						if unit:HasStatusEffect("HeavyWeaponsTraining") then
							unit:RemoveStatusEffect("HeavyWeaponsTraining")
						end
						if unit:HasStatusEffect("CollateralDamage") then
							unit:RemoveStatusEffect("CollateralDamage")
						end
						if unit:HasStatusEffect("InstantAutopsy") then
							unit:RemoveStatusEffect("InstantAutopsy")
						end
						if unit:HasStatusEffect("LineBreaker") then
							unit:RemoveStatusEffect("LineBreaker")
						end
						if unit:HasStatusEffect("Killzone") then
							unit:RemoveStatusEffect("Killzone")
						end
					end
					if IsKindOfClasses(weapon, "MachineGun", "HeavyWeapon") then
						if not unit:HasStatusEffect("KillingWind") then
							unit:AddStatusEffect("KillingWind")
						end
						if not unit:HasStatusEffect("HeavyWeaponsTraining") then
							unit:AddStatusEffect("HeavyWeaponsTraining")
						end
						if not unit:HasStatusEffect("CQCTraining") then
							unit:AddStatusEffect("CQCTraining")
						end
						if not unit:HasStatusEffect("HitTheDeck") then
							unit:AddStatusEffect("HitTheDeck")
						end
						if not unit:HasStatusEffect("TakeAim") then
							unit:AddStatusEffect("TakeAim")
						end
						if not unit:HasStatusEffect("Ironclad") then
							unit:AddStatusEffect("Ironclad")
						end
						if not unit:HasStatusEffect("StressManagement") then
							unit:AddStatusEffect("StressManagement")
						end
						if not unit:HasStatusEffect("HoldPosition") and (unit.Health >= 80 or unit.Strength >= 80) then
							unit:AddStatusEffect("HoldPosition")
						end
						if not unit:HasStatusEffect("CollateralDamage") and (unit.Strength >= 80 or unit.Agility >= 80) then
							unit:AddStatusEffect("CollateralDamage")
						end
						if unit:HasStatusEffect("AutoWeapons") then
							unit:RemoveStatusEffect("AutoWeapons")
						end
						if unit:HasStatusEffect("Instagib") then
							unit:RemoveStatusEffect("Instagib")
						end
					end
					if IsKindOf(weapon, "SniperRifle") then
						if not unit:HasStatusEffect("HawksEye") then
							unit:AddStatusEffect("HawksEye")
						end
						if not unit:HasStatusEffect("NaturalCamouflage") then
							unit:AddStatusEffect("NaturalCamouflage")
						end
						if not unit:HasStatusEffect("CQCTraining") then
							unit:AddStatusEffect("CQCTraining")
						end
						if not unit:HasStatusEffect("Hobbler") then
							unit:AddStatusEffect("Hobbler")
						end
						if not unit:HasStatusEffect("Deadeye") then
							unit:AddStatusEffect("Deadeye")
						end
						if not unit:HasStatusEffect("DeathFromAbove") then
							unit:AddStatusEffect("DeathFromAbove")
						end
						if not unit:HasStatusEffect("Infiltrator") then
							unit:AddStatusEffect("Infiltrator")
						end
						if not unit:HasStatusEffect("Instagib") and unit.Dexterity >= 90 then
							unit:AddStatusEffect("Instagib")
						end
						if unit:HasStatusEffect("HeavyWeaponsTraining") then
							unit:RemoveStatusEffect("HeavyWeaponsTraining")
						end
						if unit:HasStatusEffect("AutoWeapons") then
							unit:RemoveStatusEffect("AutoWeapons")
						end
						if unit:HasStatusEffect("CollateralDamage") then
							unit:RemoveStatusEffect("CollateralDamage")
						end
					end
				end
				if CurrentModOptions["Hell_Gate"] == "<GameTerm('TE_NIGHTMARE_A')>" or CurrentModOptions["Hell_Gate"] == "<GameTerm('TE_NIGHTMARE_B')>" then --TE Enemy Bio-Infection [OPTIONAL]
					if not unit:HasStatusEffect("Surprised") and not unit:HasStatusEffect("EnemyBioInfection") then
						unit:AddStatusEffect("EnemyBioInfection")
					end
				end
			end
		end
	end
end

--"Prone" stance CanTakeCover!
function Unit:CanTakeCover()
--	return self.species == "Human" and self.stance ~= "Prone" and (GetHighestCover(self.return_pos or self) or 0) > 0
	return self.species == "Human" and (GetHighestCover(self.return_pos or self) or 0) > 0
end
function Unit:TakeCover()
	if not self:CanTakeCover() then
		return
	end
	self:InterruptPreparedAttack()
	self:AddStatusEffect("Protected")
	UpdateTakeCoverAction()
--	self:DoChangeStance("Crouch")
	
	if self.stance == "Standing" then
		self:DoChangeStance("Crouch")
	end

	ObjModified(self)
end


-- ========== TE Overwatch || OpportunityAttack || Reconnaissance || SightRadius Overhaul Begin ==========

if FirstLoad then
	owInArea = 1
	owHasLine = 2
	owNoAllyHit = 4
	owInSight = 8
end

local OverwatchSpotTargetPreferOrder = { Torso = 1, Groin = 2, Head = 4, Arms = 5, Legs = 6 }

--TE NEW Global Reconnaissance Mechanism! [!MUST HAVE!] -- !!!Do NOT Change this one!!! (TE + JA2 Core Logic)
function Unit:OverwatchCheck(target, target_dummies, conditions, sync)
	if #target_dummies == 0 or (target:HasStatusEffect("Hidden") and target:HasStatusEffect("GlobalCombatConcealed") and target:HasStatusEffect("GlobalCamouflage")) then return end
	local overwatch = g_Overwatch[self]
	if not overwatch or overwatch.num_attacks <= 0 then --or overwatch.triggered_by[target.handle] then
		return
	end
		
	--local action = CombatActions[overwatch.action_id]
	local action = self:GetDefaultAttackAction("ranged", "ungrouped")
	local aim_type = action.AimType
	local is_aoe = aim_type == "cone" or aim_type == "aoe" or aim_type == "parabola aoe" or aim_type == "line aoe"
	local weapon1, weapon2 = action:GetAttackWeapons(self)
	local base_sight = self:HasStatusEffect("ManningEmplacement") and 60 or false -- const.Combat.AwareSightRange = 60
	local sight = self:GetSightRadius(target, base_sight)
	local attack_args = {
		obj = self,
		--action_id = overwatch.action_id,
		action_id = action.id,
		step_pos = overwatch.pos,
		occupied_pos = self:GetOccupiedPos(),
		stance = overwatch.stance,
		range = overwatch.dist,
		angle = overwatch.angle,
		cone_angle = overwatch.cone_angle,
		can_use_covers = false,
		group_spots = false, -- dual shot should find out which spot should be target
		require_los = true,
		prediction = true,
	}
	local wdata1, wdata2
	if weapon1 then
		attack_args.weapon = weapon1
		wdata1 = GetLoFData(self, target_dummies, attack_args) or false
	end
	if weapon2 then
		attack_args.weapon = weapon2
		wdata2 = GetLoFData(self, target_dummies, attack_args) or false
	end

	local trigger_idx, trigger_best_target_idx
	for i, target_dummy in ipairs(target_dummies) do
		local lof1 = wdata1 and wdata1[i]
		local lof2 = wdata2 and wdata2[i]

		conditions[i] = conditions[i] or 0

		local in_area = lof1 and lof1.lof or lof2 and lof2.lof
		if in_area then
			conditions[i] = bor(conditions[i], owInArea)
		end

		-- do sight check manually here instead of in LOF check to discern between "in larger cone, out of sight" and "out of cone" cases
		local dist = self:GetDist(IsValid(target_dummy) and target_dummy or target_dummy.pos or target_dummy.obj)
		
		if in_area then
			conditions[i] = bor(conditions[i], owHasLine)
			
			--TE Binoculars Reconnaissance & [Flashlight] Illumination
			local items = self:GetHandheldItems()
			local weapon = self:GetActiveWeapons("Firearm")
			local flashLight = weapon:HasComponent("IgnoreInTheDark") -- [Flashlight]
			local enemyDist = DivCeil(self:GetDist(target), const.SlabSizeX)
			if not self.team.player_enemy then
				for _, item in ipairs(items) do
					if IsKindOf(item, "TE_Binoculars") and IsKindOfClasses(weapon, "AssaultRifle", "SniperRifle") then
						if not GameState.Night and not GameState.Underground then
							if GameState.Fog or GameState.DustStorm or GameState.FireStorm then
								target:AddStatusEffect("ReconnaissanceSpottedGood")
							else
								target:AddStatusEffect("ReconnaissanceSpottedExcellent")
							end
							target:AddStatusEffect("GlobalEnemySpotted")
						elseif (GameState.Night or GameState.Underground) and self:HasNightVision() then
							if GameState.Fog or GameState.DustStorm or GameState.FireStorm then
								target:AddStatusEffect("ReconnaissanceSpottedBad")
							else
								target:AddStatusEffect("ReconnaissanceSpottedNVG")
							end
							target:AddStatusEffect("GlobalEnemySpotted")
						end
						--CombatLog("short", T{353305209140, "<LogName> was revealed by enemy overwatch", target})
					end
				end
			else
				target:AddStatusEffect("GlobalVisualContact")
			end
			if flashLight and (enemyDist <= 20) then
				target:AddStatusEffect("IlluminationSpotted")
			end
			if g_Combat and HasPerk(self, "Spotter") then
				target:AddStatusEffect("Marked")
			end
		end
		
		if in_area and (dist <= sight) then
			conditions[i] = bor(conditions[i], owInSight)
			local best_idx, best_value
			if not is_aoe then
				local spot_lof1 = lof1 and lof1.lof or empty_table
				local spot_lof2 = lof2 and lof2.lof or empty_table
				for k = 1, Max(#spot_lof1, #spot_lof2) do
					local hit_data1 = spot_lof1[k] or empty_table
					local hit_data2 = spot_lof2[k] or empty_table
					if (hit_data1.ally_hits_count or 0) == 0 and (hit_data2.ally_hits_count or 0) == 0 then
						local value = OverwatchSpotTargetPreferOrder[hit_data1.target_spot_group] or 100
						if not best_idx or value < best_value or value == best_value and (not sync or self:Random(100) < 50) then
							best_idx, best_value = k, value
						end
					else
						best_idx, best_value = nil, nil
						break
					end
				end
			end
			if is_aoe or best_idx then
				conditions[i] = bor(conditions[i], owNoAllyHit)
				if not trigger_idx then
					trigger_idx = i
					trigger_best_target_idx = best_idx
				end
			end
		end
	end
	if trigger_idx then
		local lof = wdata1 and wdata1[trigger_idx] or wdata2 and wdata2[trigger_idx]
		local target_lof = trigger_best_target_idx and lof.lof[trigger_best_target_idx]
		for k, v in pairs(lof) do
			attack_args[k] = v
		end
		if target_lof then
			attack_args.best_ally_hits_count = 0
			--attack_args.lof_pos1 = target_lof.lof_pos1
			--attack_args.lof_pos2 = target_lof.lof_pos2
			--attack_args.target_pos = target_lof.target_pos
			attack_args.target_spot = target_lof.target_spot
			attack_args.target_spot_group = target_lof.target_spot_group
		end
		return trigger_idx, attack_args
	end
end
function Unit:OnOverwatchPlaced()
	local overwatch = g_Overwatch[self]
	if not overwatch then return end
	
	local step_pos = overwatch.pos
	local distance = overwatch.dist
	local stance = overwatch.stance
	local cone_angle = overwatch.cone_angle
	local target_angle = overwatch.angle
	
	local enemies = table.ifilter(GetAllEnemyUnits(self), function(_, enemy) return enemy:GetDist(step_pos) <= distance end)
	if #enemies > 0 then
		local maxvalue, los_values = CheckLOS(enemies, step_pos, distance, stance, cone_angle, target_angle, false)


		-- reveal & mark enemies in the area
		for i, los in ipairs(los_values) do
			if los then
				local items = self:GetHandheldItems()
				local weapon = self:GetActiveWeapons("Firearm")
				local flashLight = weapon:HasComponent("IgnoreInTheDark")
				local enemyDist = DivCeil(self:GetDist(enemies[i]), const.SlabSizeX)
				if not g_Combat and not self.team.player_enemy then
					for _, item in ipairs(items) do
						if IsKindOf(item, "TE_Binoculars") and IsKindOfClasses(weapon, "AssaultRifle", "SniperRifle") then
							if not GameState.Night and not GameState.Underground then
								if GameState.Fog or GameState.DustStorm or GameState.FireStorm then
									enemies[i]:AddStatusEffect("ReconnaissanceSpottedGood")
								else
									enemies[i]:AddStatusEffect("ReconnaissanceSpottedExcellent")
								end
								enemies[i]:AddStatusEffect("GlobalEnemySpotted")
							elseif (GameState.Night or GameState.Underground) and self:HasNightVision() then
								if GameState.Fog or GameState.DustStorm or GameState.FireStorm then
									enemies[i]:AddStatusEffect("ReconnaissanceSpottedBad")
								else
									enemies[i]:AddStatusEffect("ReconnaissanceSpottedNVG")
								end
								enemies[i]:AddStatusEffect("GlobalEnemySpotted")
							end
							CombatLog("short", T{353305209140, "<LogName> was revealed by enemy overwatch", enemies[i]})
						end
					end
					if enemies[i]:HasStatusEffect("Hidden") then
						CombatLog("short", T{353305209140, "<LogName> was revealed by enemy overwatch", enemies[i]})
						enemies[i]:RemoveStatusEffect("Hidden")
					end
				end
				if g_Combat and HasPerk(self, "Spotter") then
					enemies[i]:AddStatusEffect("Marked")
				end
				if flashLight and (enemyDist <= 20) then
					enemies[i]:AddStatusEffect("IlluminationSpotted")
				end
			end
		end
	end
end

--TE OpportunityAttack will fire at the best BodyPart of [target_spot_group]!
function Unit:ProvokeOpportunityAttack_Overwatch(obj, attack_args, target_dummy)
	local overwatch = g_Overwatch[obj]
	if not overwatch then return end
	--TE Reconnaissance Overwatch
	local items = obj:GetHandheldItems()
	local weapon = obj:GetActiveWeapons("Firearm")
	for _, item in ipairs(items) do
		if overwatch and IsKindOf(item, "TE_Binoculars") and IsKindOfClasses(weapon, "AssaultRifle", "SniperRifle") then
			return -- Reconnaissance Overwatch will NOT interrupt enemies!
		end
	end
	--local action = CombatActions[overwatch.action_id]
	overwatch.triggered_by[self.handle] = true
	if not self.team.player_enemy then
		self:AddStatusEffect("GlobalEnemySpotted")
	end
	CombatLog("short", T{353305209140, "<LogName> was revealed by enemy overwatch", self})
	self:RemoveStatusEffect("Hidden")
	self:InterruptBegin()

	local reason = T(484641340197, "Overwatch")
	obj:SetAttackReason(reason, true)

	local cmd_thread = CurrentThread() == self.command_thread
	if cmd_thread then
		self:PushDestructor(function(self)
			obj:FinishOpportunityAttack_Overwatch()
		end)
	end
	attack_args.aim = overwatch.aim
	attack_args.origin_action_id = overwatch.origin_action_id
	assert(attack_args.target == self)
	attack_args.target_dummy = target_dummy
	attack_args.opportunity_attack = true
	attack_args.opportunity_attack_type = "Overwatch"
	if overwatch.cone_angle > 180*60 then
		attack_args.circular_overwatch = true
	end
	local lof_data
	local best_value
	for _, data in ipairs(attack_args.lof) do
		if data.ally_hits_count == 0 and data.enemy_hits_count > 0 then
	        local value = OverwatchSpotTargetPreferOrder[data.target_spot_group] or 100
		    if not best_value or best_value > value then
			    lof_data = data
                best_value = value -- Overwatch the best target_spot_group automatically
			end
		end
	end
	lof_data = lof_data or attack_args.lof[1]
	table.clear(attack_args.lof)
	attack_args.lof[1] = lof_data
	attack_args.target_spot_group = lof_data.target_spot_group

	local status
	local num_attacks = (HasPerk(obj, "Killzone") or obj:HasStatusEffect("TacticalEnemy")) and 2 or 1

	for i = 1, num_attacks do
		local weapon = obj:GetActiveWeapons("Firearm")
		local default_action = obj:GetDefaultAttackAction("ranged", "ungrouped", nil, true, "ignore", {skip_ap_check = true})
		if not weapon or not default_action or not obj:CanAttack(self, weapon, default_action, 0, nil, "skip_ap_check") then
			break
		end
		overwatch.action_id = default_action.id
		if IsValidTarget(self) then
			if IsKindOf(obj.prepared_attack_obj, "AOEActionVisuals") then
				obj.prepared_attack_obj:SetState("activate", self:GetPos())
			end
			obj:SetCommand("OpportunityAttack", default_action.id, attack_args, status)
			if attack_args.circular_overwatch and obj.combat_behavior == "OverwatchAction" then
				local shot_vector = self:GetPos() - obj:GetPos()
				local target_pos = (obj:GetPos() + SetLen(shot_vector, overwatch.dist)):SetZ(overwatch.target_pos:z())
				local args = obj.combat_behavior_params[3]
				if args then 
					args.target = target_pos 
				end
 			end
			while not obj:IsIdleCommand() do
				WaitMsg("Idle", 100)
			end
		end
	end

	if cmd_thread then
		self:PopDestructor()
	end
	obj:FinishOpportunityAttack_Overwatch()
end
function Unit:ProvokeOpportunityAttack_Pindown(obj, descr)
	--No need to reset them as it is assumed AIExecutionController:Done to run later on.
	self:InterruptBegin()
	LockCameraMovement("pindown")
	AdjustCombatCamera("set")
	descr = descr or g_Pindown[obj]
	obj:SetAttackReason(T(579571403585, "Pin Down"), true)

	local cmd_thread = CurrentThread() == self.command_thread
	if cmd_thread then
		self:PushDestructor(function(self)
			obj:FinishOpportunityAttack_Pindown()
		end)
	end
	
	local num_attacks = (HasPerk(obj, "Killzone") or obj:HasStatusEffect("TacticalEnemy")) and 2 or 1
	
	for i = 1, num_attacks do
		local weapon = obj:GetActiveWeapons("Firearm")
		local default_action = obj:GetDefaultAttackAction()
		if not weapon or not default_action or not obj:CanAttack(self, weapon, default_action, 0, nil, "skip_ap_check") then
			break
		end
		if IsValidTarget(self) then
			obj:SetCommand("PinDownAttack", self, descr.action_id, descr.target_spot_group, descr.aim)
			while not obj:IsIdleCommand() do
				WaitMsg("Idle", 100)
			end
		end
	end

	-- hit makes target go Pain/Die and breaks the execution of the cleanup code below
	while not obj:IsIdleCommand() do
		WaitMsg("Idle")
	end
	if cmd_thread then
		self:PopDestructor()
	end
	obj:FinishOpportunityAttack_Pindown()
end
function Unit:Retaliate(attacker, attack_reason, fnGetAttackAndWeapon)
	if not IsKindOf(attacker, "Unit") or attacker.team ~= g_Teams[g_CurrentTeam] or attacker == self then
		return false
	end
	if self:IsDead() or self:IsDowned() or not self:IsAware() or self:HasPreparedAttack() then
		return false
	end
	
	local retaliated = false
	
	local num_attacks = (HasPerk(self, "Killzone") or self:HasStatusEffect("TacticalEnemy")) and 2 or 1
	for i = 1, num_attacks do
		local action, weapon
		if fnGetAttackAndWeapon then
			action, weapon = fnGetAttackAndWeapon(self)
		else
			weapon = self:GetActiveWeapons("Firearm")
			if IsKindOf(weapon, "HeavyWeapon") then
				weapon = nil
			else				
				action = self:GetDefaultAttackAction()
			end
		end
		if not weapon or not action or not self:CanAttack(attacker, weapon, action, 0, nil, "skip_ap_check") then
			break
		end
		
		local lof_data = GetLoFData(self, { attacker }, { action_id = action.id })
		if lof_data[1].los == 0 then
			break
		end
		
	    local lof_target_spot_group = false
	    local best_value
	    for _, data in ipairs(lof_data[1].lof) do
		    if data.ally_hits_count == 0 and data.enemy_hits_count > 0 then
	            local value = OverwatchSpotTargetPreferOrder[data.target_spot_group] or 100
		        if not best_value or best_value > value then
			        lof_target_spot_group = data.target_spot_group
                    best_value = value -- Retaliate the best target_spot_group automatically
			    end
		    end
	    end
	
		if i == 1 then			
			self:SetAttackReason(attack_reason, true)
			attacker:InterruptBegin()
		end
		if IsValidTarget(attacker) then
			retaliated = true
			self:QueueCommand("RetaliationAttack", attacker, lof_target_spot_group, action)
			while not self:IsIdleCommand() do
				WaitMsg("Idle")
			end
		end
	end
	
	ClearAITurnContours()
	g_Interrupt = true
	
	self:SetAttackReason()
	return retaliated
end

--Setup GetOverwatchConeParam WeaponRange
function Firearm:GetOverwatchConeParam(param)
	if param == "Angle" then
		return self.OverwatchAngle
	elseif param == "MinRange" then
		if not CurrentModOptions["Overwatch_Cone"] or self.Entity == "Weapon_M2Browning" then
			if CurrentModOptions["Gunfight_Rework"] then
				return self.WeaponRange or MulDivRound(self.WeaponRange, 75, 100)
			else
				if IsKindOfClasses(self, "SniperRifle", "AssaultRifle", "MachineGun") then
            		return self.WeaponRange * 2 or MulDivRound(self.WeaponRange * 2, 75, 100)
				else
            		return self.WeaponRange or MulDivRound(self.WeaponRange, 75, 100)
				end
			end
		end
		return 2
	elseif param == "MaxRange" then
		if CurrentModOptions["Gunfight_Rework"] then
			return self.WeaponRange or MulDivRound(self.WeaponRange, 75, 100)
		else
			if IsKindOfClasses(self, "SniperRifle", "AssaultRifle", "MachineGun") then
            	return self.WeaponRange * 2 or MulDivRound(self.WeaponRange * 2, 75, 100)
			else
				return self.WeaponRange or MulDivRound(self.WeaponRange, 75, 100)
			end
		end
	end
	assert(false, string.format("unknown Overwatch parameter '%s'", param))
end

--TE GetAreaAttackParams Overwatch cone_angle
local TE_GetAreaAttackParams = Firearm.GetAreaAttackParams

function Firearm:GetAreaAttackParams(action_id, attacker, target_pos, step_pos, stance)
	local params = TE_GetAreaAttackParams(self, action_id, attacker, target_pos, step_pos, stance)
	
	if attacker then
		params.step_pos = step_pos or attacker:IsValidPos() and (GetPassSlab(attacker) or attacker:GetPos())
		params.stance = stance or attacker.stance
	end
	if action_id == "Buckshot" or action_id == "DoubleBarrel" or action_id == "BuckshotBurst" or action_id == "CancelShotCone" then
		self:FillConeAttackAoeParams(params, attacker)
	elseif action_id == "EyesOnTheBack" then
		local effect = attacker:GetStatusEffect("EyesOnTheBack")
		params.cone_angle = effect and (effect:ResolveValue("cone_angle")*60)
		params.min_range = not CurrentModOptions["Overwatch_Cone"] and Min(20, self:GetOverwatchConeParam("MaxRange")) or 2
		params.max_range = Min(20, self:GetOverwatchConeParam("MaxRange"))
	elseif action_id == "Overwatch" or action_id == "MGRotate" or action_id == "MGSetup" then
		if self.emplacement_weapon then
			params.min_distance_2d = const.EmplacementWeaponMinDistance2D
		end
		params.cone_angle = self.OverwatchAngle
		params.min_range = self:GetOverwatchConeParam("MinRange")
		params.max_range = self:GetOverwatchConeParam("MaxRange")
	elseif action_id == "BulletHell" or action_id == "DanceForMe" then
		params.cone_angle = self.OverwatchAngle
		params.min_range = not CurrentModOptions["Overwatch_Cone"] and Min(20, self:GetOverwatchConeParam("MaxRange")) or 2
		params.max_range = Min(20, self:GetOverwatchConeParam("MaxRange"))
	elseif action_id == "FireFlare" then
		params.min_range = self.ammo and self.ammo.AreaOfEffect or 0
		params.max_range = self.ammo and self.ammo.AreaOfEffect or 0
	end
	if attacker and attacker.team.player_enemy and not attacker:GetActiveWeapons("Shotgun") then
		if (CurrentModOptions["Tactical_Hardcore"] == "<GameTerm('TE_DEAD_ON_ARRIVAL')>" or CurrentModOptions["Hell_Gate"] == "<GameTerm('TE_NIGHTMARE_A')>" or CurrentModOptions["Hell_Gate"] == "<GameTerm('TE_NIGHTMARE_B')>") and (attacker:GetActiveWeapons("SniperRifle") or attacker:HasStatusEffect("TacticalBOW")) then
			params.cone_angle = 120 * 60 -- Deadly Enemy Sniper
		else
			params.cone_angle = 60 * 60 -- Enemy Recon Spotter
		end
	end
	
	return params
end

--TE Overwatch Visual Update
function Unit:UpdateOverwatchVisual(overwatch)
	overwatch = overwatch or g_Overwatch[self]
	if not overwatch then return end
	
	if (overwatch.permanent and overwatch.num_attacks <= 0) or not self.visible or (self.team.player_enemy and not self.enemy_visual_contact) or ((CurrentModOptions["Tactical_Hardcore"] == "<GameTerm('TE_DEAD_ON_ARRIVAL')>" or CurrentModOptions["Hell_Gate"] == "<GameTerm('TE_NIGHTMARE_A')>" or CurrentModOptions["Hell_Gate"] == "<GameTerm('TE_NIGHTMARE_B')>") and (self.team.player_enemy and (self:GetActiveWeapons("SniperRifle") or self:HasStatusEffect("TacticalBOW")))) then
		if IsValid(self.prepared_attack_obj) then
			DoneObject(self.prepared_attack_obj)
		end		
		self.prepared_attack_obj = nil
		return
	end

	local lightStepHideOW = HasPerk(SelectedObj, "LightStep") and IsValidTarget(SelectedObj) and self:IsOnEnemySide(SelectedObj) and GetInGameInterfaceMode() == "IModeCombatMovement"
	if lightStepHideOW or self:HasStatusEffect("TestEffects") then
		if IsValid(self.prepared_attack_obj) then
			DoneObject(self.prepared_attack_obj)
		end
		self.prepared_attack_obj = nil
	else	
		if overwatch.origin_action_id == "EyesOnTheBack" then
			local step_positions, step_objs = GetStepPositionsInArea(overwatch.pos, overwatch.dist)
			local filtered_positions = table.ifilter(step_positions, function(idx, pt) return not IsOnFadedSlab(pt) end)
			overwatch.pos = SnapToPassSlab(overwatch.pos) or overwatch.pos:SetTerrainZ()
			local visual_pos = overwatch.pos:IsValidZ() and overwatch.pos or overwatch.pos:SetTerrainZ()

			local maxvalue, los_values = CheckLOS(step_positions, overwatch.pos, -1, overwatch.stance, -1, false, false)
			if not self.prepared_attack_obj then
				local data = {
					explosion_pos = visual_pos,
					stance = overwatch.stance,
					range = overwatch.dist,
					step_positions = step_positions,
					step_objs = step_objs,
					los_values = los_values or empty_table,
				}
				self.prepared_attack_obj = MortarAOEVisuals:new({
					material_prefix = "EyesOnTheBack",
					mode = (self.team.control == "UI" or self.team.player_ally) and "Ally" or "Enemy"}, nil, data)
			end
		else
			if IsValid(self.prepared_attack_obj) and not IsKindOf(self.prepared_attack_obj, "OverwatchVisuals") then				
				DoneObject(self.prepared_attack_obj)
				self.prepared_attack_obj = false
			end
			if not self.prepared_attack_obj then
				self.prepared_attack_obj = OverwatchVisuals:new({mode = (self.team.control == "UI" or self.team.player_ally) and "Ally" or "Enemy"})
			end
			self.prepared_attack_obj:UpdateFromOverwatch(overwatch)
		end
	end
end

--!!!Enemies Should NOT RevealTo(target) if NOT self.enemy_visual_contact during CombatActions!!! (JA2 Logic) [!MUST HAVE!]
MapVar("g_AttackRevealQueue", false)

function Unit:AttackReveal(action, attack_args, results)
	local attacker = self
	local target = attack_args.target
	local killed = results.killed_units or empty_table
	if not g_Combat then
		g_AttackRevealQueue = {self}
	end
	if IsKindOf(target, "Unit") and not target:IsDead() and not table.find(killed, target) then
		if g_Combat and not attacker.team.player_enemy then
			self:RevealTo(target)
--		else
--			g_AttackRevealQueue[#g_AttackRevealQueue + 1] = target
		end
	end
	for _, hit in ipairs(results) do
		local unit = IsKindOf(hit.obj, "Unit") and not hit.obj:IsIncapacitated() and hit.obj
		if unit and unit.team ~= self.team and not unit:IsDead() and not table.find(killed, unit) then
			if g_Combat and not attacker.team.player_enemy  then
				self:RevealTo(unit)
--			else
--				g_AttackRevealQueue[#g_AttackRevealQueue + 1] = unit
			end
		end
	end
end

--!!!Play weapon SoundFX even if not attacker.visible!!! (JA2 Logic) [!MUST HAVE!]
function Firearm:FireBullet(attacker, shot, threads, results, attack_args)
	local fx_action = attack_args.fx_action or "WeaponFire"
	NetUpdateHash("FireBullet", attacker)
	local visual_obj = self:GetVisualObj()
	assert(visual_obj and visual_obj:IsValidPos())
	
	if fx_action ~= "" and attack_args.single_fx then
		results.fx_played = results.fx_played or {}
		if results.fx_played[fx_action] then
			fx_action = ""
		else
			results.fx_played[fx_action] = true
		end
	end

	local action_dir = shot.target_pos - shot.attack_pos
	if action_dir:Len() > 0 then
		action_dir = SetLen(action_dir, 4096)
	else
		action_dir = RotateRadius(4096, attacker:GetAngle())
	end

	if fx_action ~= "" then --this will still play weapon SoundFX even if not attacker.visible
--	if fx_action ~= "" and attacker.visible then
		--local fx_target = self:HasComponent("SilentShots") and "Silencer" or "Basic"
		local fx_target = (not CurrentModOptions["SilencerFX_Disabler"] and visual_obj.parts.Muzzle) or visual_obj.parts.Barrel or visual_obj
		PlayFX(fx_action, "start", visual_obj, fx_target, shot.attack_pos, action_dir)
		-- shell eject fx
		if shot.ammo_type then
			PlayFX("ShellEject", "start", visual_obj, shot.ammo_type)
		end
	end
	BirdsFlappingAway(visual_obj:GetVisualPos())
	table.insert(threads, CreateGameTimeThread(self.ProjectileFly, self, attacker, shot.attack_pos, shot.stuck_pos, action_dir, const.Combat.BulletVelocity, shot.hits, attack_args.target, attack_args))
end
function Firearm:FireSpread(results, attack_args)
	local attacker = attack_args.obj
	local visual_obj = self:GetVisualObj()
	
	local fx_action = attack_args.aoe_fx_action or ""
	if fx_action ~= "" and attack_args.single_fx then
		results.fx_played = results.fx_played or {}
		if results.fx_played[fx_action] then
			fx_action = ""
		else
			results.fx_played[fx_action] = true
		end
	end

	if fx_action ~= "" then --this will still play weapon SoundFX even if not attacker.visible
--	if fx_action ~= "" and IsKindOf(attacker, "Unit") and attacker.visible then
		local lof_idx = table.find(attack_args.lof, "target_spot_group", attack_args.target_spot_group or "Torso")
		local lof_data = attack_args.lof[lof_idx or 1]
		local action_dir = SetLen(lof_data.lof_pos2 - lof_data.lof_pos1, 4096)
		local spot_pos = lof_data.attack_pos
		--local fx_target = self:HasComponent("SilentShots") and "Silencer" or "Basic"
		local fx_target = (not CurrentModOptions["SilencerFX_Disabler"] and visual_obj.parts.Muzzle) or visual_obj.parts.Barrel or visual_obj
		PlayFX(attack_args.aoe_fx_action, "start", visual_obj, fx_target, spot_pos, action_dir)
		-- shell eject fx
		if results.ammo_type then
			PlayFX("ShellEject", "start", visual_obj, results.ammo_type)
		end
	end
	for _, hit in ipairs(results.area_hits) do
		if hit.pos then
			local surf_fx_type = GetObjMaterial(hit.pos, hit.obj)
			local fx_target = surf_fx_type or hit.obj
			if hit.pos:Dist(results.attack_pos) > 0 then
				local dir = SetLen(hit.pos - results.attack_pos, guim)
				if (hit.impact_force or 0) >= const.BulletImpactBig then
					PlayFX("BulletImpactBig", "start", false, fx_target, hit.pos, dir)
				else
					PlayFX("BulletImpactSmall", "start", false, fx_target, hit.pos, dir)
				end
			end
		end
		if not hit.cosmetic then
			self:ApplyHitResults(hit.obj, attacker, hit)
		end
	end
	for _, hit in ipairs(results.cosmetic_hits) do
		if hit.pos then
			local surf_fx_type = GetObjMaterial(hit.pos, hit.obj)
			local fx_target = surf_fx_type or hit.obj
			if hit.pos:Dist(results.attack_pos) > 0 then
				local dir = SetLen(hit.pos - results.attack_pos, guim)
				if (hit.impact_force or 0) >= const.BulletImpactBig then
					PlayFX("BulletImpactBig", "start", false, fx_target, hit.pos, dir)
				else
					PlayFX("BulletImpactSmall", "start", false, fx_target, hit.pos, dir)
				end
			end
		end
	end
end

--TE Toxic & Tear GasTick (JA2 Logic) [!MUST HAVE!]
function EnvEffectToxicGasTick(unit, voxels, combat_moment)
	local inside, protected, attacker
	if next(g_SmokeObjs) ~= nil then
		if not voxels then
			voxels = unit:GetVisualVoxels()
		end
		local smoke
		for _, voxel in ipairs(voxels) do
			local smoke_obj = g_SmokeObjs[voxel]
			if smoke_obj and smoke_obj:GetGasType() == "toxicgas" then
				smoke = smoke_obj
				inside = true
				break
			end
		end
		if inside then
			local mask = unit:GetItemInSlot("Head", "GasMaskBase")
			protected = mask and mask.Condition > 0
			for _, zone in ipairs(smoke.zones) do
				if zone.owner then
					attacker = zone.owner
					break
				end
			end
		end
	end
	
	if inside and protected and attacker then
		-- awareness reactions (there will be no damage/negative effects)
		PushUnitAlert("attack", attacker, unit)
	end
	
	inside = inside and not protected
	
	local effect = unit:GetStatusEffect("Choking")
	if effect then
		if unit.team.player_enemy then return end -- Enemy GasMaskBase protected
		
		local start_time = effect:ResolveValue("choking_start_time")
		if (combat_moment == "end turn") or (not g_Combat and not g_StartingCombat and GameTime() >= start_time + 5000) then			
			local damage = Choking:ResolveValue("damage")
			unit:TakeDirectDamage(damage, T{698692719911, "<damage> (Choking)", damage = damage})
			EnvEffectReaction("toxicgas", attacker, unit, damage)
			if g_Combat or g_StartingCombat then
				start_time = GameTime()
			else
				start_time = start_time + 5000
			end
			if inside then
				effect:SetParameter("choking_start_time", start_time)
			else
				unit:RemoveStatusEffect("Choking")
			end
			local tiredness = RollSkillCheck(unit, "Health") and 1 or 2
			unit:ChangeTired(tiredness)
		end
	elseif inside then
		unit:AddStatusEffect("Choking")
		EnvEffectReaction("toxicgas", attacker, unit, 0)
	end	
end
function EnvEffectTearGasTick(unit, voxels, combat_moment)
	local inside, protected, attacker
	if next(g_SmokeObjs) ~= nil then
		if not voxels then
			voxels = unit:GetVisualVoxels()
		end
		local smoke
		for _, voxel in ipairs(voxels) do
			local smoke_obj = g_SmokeObjs[voxel]
			if smoke_obj and smoke_obj:GetGasType() == "teargas" then
				smoke = smoke_obj
				inside = true
				break
			end
		end
		if inside then
			local mask = unit:GetItemInSlot("Head", "GasMaskBase")
			protected = mask and mask.Condition > 0
			for _, zone in ipairs(smoke.zones) do
				if zone.owner then
					attacker = zone.owner
					break
				end
			end
		end
	end
	
	if inside and protected and attacker then
		-- awareness reactions (there will be no damage/negative effects)
		PushUnitAlert("attack", attacker, unit)
	end
	inside = inside and not protected
	
	local effect = unit:GetStatusEffect("Blinded")
	if effect then
		if unit.team.player_enemy then return end -- Enemy GasMaskBase protected
		
		local start_time = effect:ResolveValue("blinded_start_time")
		if (combat_moment == "end turn") or (not g_Combat and not g_StartingCombat and GameTime() >= start_time + 5000) then
			-- choking damage/end will happen on end turn in combat		
			if g_Combat or g_StartingCombat then
				start_time = GameTime()
			else
				start_time = start_time + 5000
			end
			if inside then
				effect:SetParameter("blinded_start_time", start_time)
			else
				unit:RemoveStatusEffect("Blinded")
			end
		elseif combat_moment == "start turn" and inside then
			if not RollSkillCheck(unit, "Health") then
				unit:AddStatusEffect("Panicked")
			end
		end
	elseif inside then
		unit:AddStatusEffect("Blinded")
		EnvEffectReaction("teargas", attacker, unit, 0)
	end	
end

--TE Tracers & Burning Illumination (JA2 Logic) [!MUST HAVE!]
function IsIlluminated(target, voxels, sync, step_pos)
	--if step_pos is present, use it for all pos checks and use the target for all unit checks
	if not IsValid(target) or not target:IsValidPos() then return end
	if not GameState.Night and not GameState.Underground then
		return true
	end
	local env_factors = GetVoxelStealthParams(step_pos or target)
	--if sync then NetUpdateHash("IsIlluminated", target, target:GetPos(), env_factors, table.unpack(voxels)) end
	if env_factors ~= 0 and band(env_factors, const.vsFlagIlluminated) ~= 0 then
		return true
	end
	-- If the weapon ignores dark it also generates light (in theory)
	if IsKindOf(target, "Unit") then
		if not target.team.player_enemy then
			local _, __, weapons = target:GetActiveWeapons()
			for i, w in ipairs(weapons) do
				if w:HasComponent("IgnoreInTheDark") then
					return true
				end
			end
		end
		-- Tracers & Burning also generate light (in reality)!
		if target:HasStatusEffect("Burning") or target:HasStatusEffect("IlluminationSpotted") then
			return true
		end
	end

	if next(g_DistToFire) == nil then
		return
	end

	if not voxels then
		if IsKindOf(target, "Unit") then
			voxels = step_pos and target:GetVisualVoxels(step_pos) or target:GetVisualVoxels()
		else
			local x, y, z = WorldToVoxel(target)
			voxels = {point_pack(x, y, z)}
		end
	end
	return AreVoxelsInFireRange(voxels)
end

--!!!TE SightRadius Overhaul!!! [!MUST HAVE!] -- !!!Do NOT Change this one!!! (TE Core Logic)
local TE_GetSightRadius = Unit.GetSightRadius

function Unit:GetSightRadius(other, base_sight, step_pos)
	-- base sight radius, based on awareness (in-combat only) and illumination
	local sightAmount, hidden, night_time = TE_GetSightRadius(self, other, base_sight, step_pos)
	local modifier = 100
	local other_is_unit = other and IsKindOf(other, "Unit") or false
	local hidden = other_is_unit and (other:HasStatusEffect("Hidden") or other:HasStatusEffect("NaturalCamouflage"))
	local sight = base_sight or (self:IsAware() and 70) or (not self:IsAware() and const.Combat.UnawareSightRange) -- sight IsAware = 70 & Unaware = UnawareSightRange -- !!!Do NOT Change this one!!! (Core Logic)
	local night_time = GameState.Night or GameState.Underground
	if night_time and other and IsIlluminated(other, nil, nil, step_pos) then
		night_time = false
	end

	local force_min_sight = self:CallReactions_Or("OnCheckForceMinSight", self, other, step_pos, night_time)
	force_min_sight = force_min_sight or (IsKindOf(other, "Unit") and other:CallReactions_Or("OnCheckForceMinSight", self, other, step_pos, night_time))
	if force_min_sight then
		return MulDivRound(sight, 8, 100) * const.SlabSizeX, hidden, night_time -- force_min_sight SightModMinValue = 8 -- !!!Do NOT Change this one!!! (Core Logic)
	end
	modifier = self:CallReactions_Modify("OnCalcSightModifier", modifier, self, other, step_pos, night_time)
	if IsKindOf(other, "Unit") then
		modifier = other:CallReactions_Modify("OnCalcSightModifier", modifier, self, other, step_pos, night_time)
	end
	
	if other_is_unit and not other:IsDead() and not other:IsDowned() then
		if hidden then
			-- add (clamped) Perks difference as modifier -- !!!Do NOT Change this one!!! (Core Logic)
			local steath_mod = 0
			if other:IsUsingCover() or other.stance == "Prone" or (other.stance == "Crouch" and (other:HasStatusEffect("Untraceable") or other:HasStatusEffect("Stealthy"))) or other:HasStatusEffect("FleetingShadow") or other:HasStatusEffect("NaturalCamouflage") then
				steath_mod = steath_mod + 25 -- IsUsingCover + 25 hidden steath_mod || Prone + 25 hidden steath_mod || Crouch + 25 Untraceable or Stealthy steath_mod || Standing + 25 FleetingShadow or NaturalCamouflage steath_mod -- !!!Do NOT Change this one!!! (Core Logic)
			end
			modifier = modifier - steath_mod
		end
		-- add (clamped) Camouflage difference as modifier -- !!!Do NOT Change this one!!! (Core Logic)
		local armor = other:GetItemInSlot("Torso", "Armor")
		if (armor and armor.Camouflage) or other:HasStatusEffect("Infiltrator") or other:HasStatusEffect("NaturalCamouflage") then
			modifier = modifier - 15 -- Camouflage or Infiltrator = -15 -- !!!Do NOT Change this one!!! (Core Logic)
			other:AddStatusEffect("GlobalCamouflage")
		else
			other:RemoveStatusEffect("GlobalCamouflage")
		end
		if other:HasStatusEffect("GlobalVisualContact") then
			modifier = modifier + 200 -- visual_contact = 200 -- !!!Do NOT Change this one!!! (Core Logic)
		end
	end

	-- environmental factors
	if other then
		local env_factors = GetVoxelStealthParams(step_pos or other) or 0
		if band(env_factors, const.vsFlagTallGrass) ~= 0 then
			modifier = modifier -45 -- BrushSightMod = -45 -- !!!Do NOT Change this one!!! (Core Logic)
		end
	end
	if night_time and other then
		local darknessMod = -90 -- night_time base sight radius darknessMod = -90 -- !!!Do NOT Change this one!!! (Core Logic)
		if self:HasNightVision() or self.team.player_enemy or self:HasStatusEffect("TestEffects") then
			local penaltyReduce = 12 -- night_time base sight radius night_vision penaltyReduce = 12 -- !!!Do NOT Change this one!!! (Core Logic)
			darknessMod = MulDivRound(darknessMod, penaltyReduce, 100)
		end
		modifier = modifier + darknessMod
	end
	if GameState.Fog then
		modifier = modifier - 75 -- FogSightMod = -75 -- !!!Do NOT Change this one!!! (Core Logic)
	end
	if GameState.DustStorm then
		modifier = modifier - 25 -- DustStorm = -25 -- !!!Do NOT Change this one!!! (Core Logic)
	end
	if GameState.FireStorm then
		modifier = modifier - 25 -- FireStorm = -25 -- !!!Do NOT Change this one!!! (Core Logic)
	end
	if other_is_unit then	-- height difference check
		local ox, oy, oz
		if step_pos then
			ox, oy, oz = PosToGridCoords(step_pos:xyz())
		else
			ox, oy, oz = other:GetGridCoords()
		end
		local x, y, z = self:GetGridCoords()
		if oz >= z + const.EnvEffects.SightHeightDiffThreshold then
			modifier = modifier - 5 -- SightHeightDiffMod = -5 -- !!!Do NOT Change this one!!! (Core Logic)
		elseif g_Exploration and oz + const.EnvEffects.SightHeightDiffThreshold < z  then
			modifier = modifier + 10 -- g_Exploration SightHeightDiffMod = 10 -- !!!Do NOT Change this one!!! (Core Logic)
		end
	end
	
	modifier = Clamp(modifier, 18, 140) -- base SightModMinValue = 18 & SightModMaxValue = 140 -- !!!Do NOT Change this one!!! (Core Logic)
	
	local sightAmount = MulDivRound(sight, modifier, 100) * const.SlabSizeX
	
	-- Prevent going in and out of sus state due to Pos/VisualPos differences.
	if self.command == "IdleSuspicious" then
		sightAmount = sightAmount + const.SlabSizeX / 4
	end
	
	return sightAmount, hidden, night_time
end
function GetMaxSightRadius()
	return MulDivRound(70, const.SlabSizeX * 140, 100) -- const.Combat.AwareSightRange = 70 || const.Combat.SightModMaxValue = 140
end

-- ========== TE Overwatch || OpportunityAttack || Reconnaissance || SightRadius Overhaul End ==========


-- ========== TE Global GameTerm & ConstEdit Begin ==========

--TE Global New GameTerm Added
function TE_NewGameTerm()

	-- ========== GENERATED BY GameTerm Editor DO NOT EDIT MANUALLY! ==========

	PlaceObj('GameTerm', {
		Description = T(3042581133111000, --[[GameTerm Default OFF Description]] "OFF"),
		Name = T(3042581133110000, --[[GameTerm Default OFF Name]] "OFF"),
		id = "TE_OFF",
	})
	
	PlaceObj('GameTerm', {
		Description = T(3042581133111001, --[[GameTerm Default SECTOR REINFORCEMENT Description]] "SECTOR REINFORCEMENT"),
		Name = T(3042581133110001, --[[GameTerm Default SECTOR REINFORCEMENT Name]] "SECTOR REINFORCEMENT"),
		id = "TE_REINFORCEMENT",
	})
	
	PlaceObj('GameTerm', {
		Description = T(3042581133111002, --[[GameTerm Default SECTOR AMBUSHER Description]] "SECTOR AMBUSHER"),
		Name = T(3042581133110002, --[[GameTerm Default SECTOR AMBUSHER Name]] "SECTOR AMBUSHER"),
		id = "TE_AMBUSHER",
	})
	
	PlaceObj('GameTerm', {
		Description = T(3042581133111003, --[[GameTerm Default HARD BOILED Description]] "HARD BOILED"),
		Name = T(3042581133110003, --[[GameTerm Default HARD BOILED Name]] "HARD BOILED"),
		id = "TE_HARD_BOILED",
	})
	
	PlaceObj('GameTerm', {
		Description = T(3042581133111004, --[[GameTerm Default DEAD ON ARRIVAL Description]] "DEAD ON ARRIVAL"),
		Name = T(3042581133110004, --[[GameTerm Default DEAD ON ARRIVAL Name]] "DEAD ON ARRIVAL"),
		id = "TE_DEAD_ON_ARRIVAL",
	})
	
	PlaceObj('GameTerm', {
		Description = T(3042581133111005, --[[GameTerm Default THE NIGHTMARE A Description]] "THE NIGHTMARE A"),
		Name = T(3042581133110005, --[[GameTerm Default THE NIGHTMARE A Name]] "THE NIGHTMARE A"),
		id = "TE_NIGHTMARE_A",
	})
	
	PlaceObj('GameTerm', {
		Description = T(3042581133111006, --[[GameTerm Default THE NIGHTMARE B Description]] "THE NIGHTMARE B"),
		Name = T(3042581133110006, --[[GameTerm Default THE NIGHTMARE B Name]] "THE NIGHTMARE B"),
		id = "TE_NIGHTMARE_B",
	})
	
	PlaceObj('GameTerm', {
		Description = T(3042581133111007, --[[GameTerm Default Reconnaissance Description]] "Detect all enemies in <GameTerm('Overwatch')> covered area <em>Instantly</em> during the <em>Exploration</em> mode or at the <em>NEXT</em> turn during <em>Combat</em>. Will NOT fire any <GameTerm('Interrupt')> attack while in <GameTerm('Overwatch')>."),
		Name = T(3042581133110007, --[[GameTerm Default Reconnaissance Name]] "Reconnaissance"),
		id = "TE_Reconnaissance",
	})
	
	PlaceObj('GameTerm', {
		Description = T(3042581133111008, --[[GameTerm Default Concealed Description]] "You are harder to spot while in <em>Cover</em> or on <em>Prone</em> stance <em>Statically</em>. <em>Reveals</em> yourself once you start ANY <em>Movement</em>."),
		Name = T(3042581133110008, --[[GameTerm Default Concealed Name]] "Concealed"),
		id = "TE_Concealed",
	})
	
end
OnMsg.ModsReloaded = TE_NewGameTerm
OnMsg.DataLoaded = TE_NewGameTerm
OnMsg.OptionsApply = TE_NewGameTerm

--TE Global AI Const.Adjustment
local function TE_AI_Logic()
    const.AIDecisionThreshold = 100 -- Default = 80 -- targets/locations up to 100 percent of max scored target/location can be selected!
    const.AIPointBlankTargetMod = 100 -- Default = 50 -- targets in point-blank range get +100% score!
    --const.AIFallbackWeight_OpenDoor = 100 -- Default = 100
    --const.AIFallbackWeight_ClosedDoor = 40 -- Default = 40
    --const.AIFallbackWeight_Window = 70 -- Default = 70
    --const.AIAvoidFireWeigth = -200 -- Default = -200
    --const.AIAvoidGasWeigth = -200 -- Default = -200
    --const.AIAvoidBombardEdge = 100 -- Default = 100 -- % of score retained at the border of the zone
    --const.AIAvoidBombardCenter = 30 -- Default = 30 -- % of score retained at the center of the zone
    --const.AIFriendlyFire_MaxRange = 10 * const.SlabSizeX -- Default = 10 -- max range to ally for it to be considered in danger
    --const.AIFriendlyFire_LOFWidth = 100*guic -- Default = 100 -- max distance from an ally to the line between position and target considered in danger
    --const.AIFriendlyFire_LOFConeNear = 100*guic -- Default = 100 -- same as above for cone attacks (near side of the cone, positioned at attacker)
    --const.AIFriendlyFire_LOFConeFar = 300*guic -- Default = 300 -- same as above for cone attacks (far side of the cone, positioned at AIFriendlyFire_MaxRange)
    --const.AIFriendlyFire_ScoreMod = 50 -- Default = 50	-- % of damage score evaluation remanining when an ally is in danger
    const.AIShootAboveCTH = 15 -- Default = 0 -- Min 15% CTH required for AI firing shots!
    const.Combat.FastForwardGameSpeed = 175 -- Default = 200 -- Prevent Combat AI stuck_pos!
end

--TE Global Explosion Resistance ("ProneStance")
local function TE_Explosion_Resistance()
	local choice = CurrentModOptions["Explosion_Resistance"]
	if choice == '0%' then
        const.Combat.ExplosionProneDamageMod = 0
	elseif choice == '15%' then
        const.Combat.ExplosionProneDamageMod = -15
	elseif choice == '30%' then
        const.Combat.ExplosionProneDamageMod = -30
	elseif choice == '40%' then
        const.Combat.ExplosionProneDamageMod = -40
	elseif choice == '50%' then
        const.Combat.ExplosionProneDamageMod = -50
	elseif choice == '60%' then
        const.Combat.ExplosionProneDamageMod = -60
	elseif choice == '70%' then
        const.Combat.ExplosionProneDamageMod = -70
	end
end

--TE Global UnawareSightRange
local function TE_Unaware_Sight()
	local choice = CurrentModOptions["Unaware_Sight"]
	if choice == '70%' then
        const.Combat.UnawareSightRange = 8
	elseif choice == '80%' then
        const.Combat.UnawareSightRange = 10
	elseif choice == '100%' then
        const.Combat.UnawareSightRange = 12
	elseif choice == '125%' then
        const.Combat.UnawareSightRange = 15
	elseif choice == '150%' then
        const.Combat.UnawareSightRange = 18
	elseif choice == '180%' then
        const.Combat.UnawareSightRange = 20
	end
end

--TE Global Projectile Velocity (Only Visual Effect)
local function TE_Projectile_Velocity()
	local choice = CurrentModOptions["Projectile_Velocity"]
	if choice == '50%' then
        const.Combat.BulletVelocity = 20000
        const.Combat.RocketVelocity = 10000
	elseif choice == '100%' then
        const.Combat.BulletVelocity = 40000
        const.Combat.RocketVelocity = 20000
	elseif choice == '150%' then
        const.Combat.BulletVelocity = 60000
        const.Combat.RocketVelocity = 30000
	elseif choice == '200%' then
        const.Combat.BulletVelocity = 80000
        const.Combat.RocketVelocity = 40000
	elseif choice == '250%' then
        const.Combat.BulletVelocity = 100000
        const.Combat.RocketVelocity = 50000
	elseif choice == '300%' then
        const.Combat.BulletVelocity = 120000
        const.Combat.RocketVelocity = 60000
	end
end

--TE Global AutoResolveEnemyPower
local function TE_Auto_Resolve()
	local choice = CurrentModOptions["Auto_Resolve"]
	if choice == '50%' then
        const.AutoResolve.BaseEnemyPower = 50
	elseif choice == '100%' then
        const.AutoResolve.BaseEnemyPower = 100
	elseif choice == '150%' then
        const.AutoResolve.BaseEnemyPower = 150
	elseif choice == '200%' then
        const.AutoResolve.BaseEnemyPower = 200
	elseif choice == '250%' then
        const.AutoResolve.BaseEnemyPower = 250
	elseif choice == '300%' then
        const.AutoResolve.BaseEnemyPower = 300
	elseif choice == '350%' then
        const.AutoResolve.BaseEnemyPower = 350
	elseif choice == '400%' then
        const.AutoResolve.BaseEnemyPower = 400
	elseif CurrentModOptions["Hell_Gate"] == "<GameTerm('TE_NIGHTMARE_A')>" or CurrentModOptions["Hell_Gate"] == "<GameTerm('TE_NIGHTMARE_B')>" then
        const.AutoResolve.BaseEnemyPower = 1500
	end
end

-- ========== TE Global ConstEdit End ==========


-- ========== TE Global MiscEdit Begin ==========

--TE Success disarmCheck ONLY out of combat!
function Trap:AttemptDisarm(unit, stat)
	if IsSetpiecePlaying() then return end
	stat = stat or "Explosives"
	
	local statPreset = table.find_value(UnitPropertiesStats:GetProperties(), "id", stat)
	local statT = statPreset and statPreset.name or Untranslated("Unknown Stat")
	local disarmCheck = unit[stat]
	
	if HasPerk(unit, "MrFixit") then
		disarmCheck = disarmCheck + CharacterEffectDefs.MrFixit:ResolveValue("mrfixit_bonus")
	end
	
	if unit:HasStatusEffect("TestEffects") then
		disarmCheck = disarmCheck + 1000
	end
	
	local trapName = self:GetTrapDisplayName()
	local success = (disarmCheck > DifficultyToNumber(self.disarmDifficulty) + self.additionalDifficulty) or CheatEnabled("SkillCheck")
	if not g_Combat then
		if success then
			local msg = self:GetDisarmCombatLogMessage()
			local msgCtx = SubContext(unit, {TrapName = trapName, stat = statT})
			CombatLog("important", T{msg, msgCtx})
			CreateFloatingText(self:GetVisualPos(), T{386434780847, "<em><stat></em> success", TrapName = trapName, stat = statT}, "BanterFloatingText")
		
			--Get parts for successful disarm
			local partsCount = 1 + unit:Random(2)
			AddItemToSquadBag(unit.Squad, "Parts", partsCount)
			CreateFloatingText(unit:GetVisualPos(), T{178669996888, "Salvaged <Amount> parts", Amount = partsCount})
		
			self.disarmed = true
			self.done = true
			ObjModified("combat_bar_traps")
			PlayFX("TrapDisarmed", "start", self)
		else
			CreateFloatingText(self:GetVisualPos(), T{338382091310, "<em><stat></em> failure!", TrapName = trapName, stat = statT}, "BanterFloatingText")
			self:TriggerTrap(unit)
		end
	elseif g_Combat then
		CreateFloatingText(self:GetVisualPos(), T{338382091310, "<em><stat></em> failure!", TrapName = trapName, stat = statT}, "BanterFloatingText")
		self:TriggerTrap(unit)
	end
	Msg("TrapDisarm", self, unit, success, stat)
	
	return success and "success" or "fail"
end

--TE Ironman Mode ON
function OnMsg.CanSaveGameQuery(query, request)
	if g_Combat then
		local currentTeam = g_Teams[g_CurrentTeam]
		if currentTeam and currentTeam.side ~= "player1" then
			query.current_team_side = currentTeam.side or "not player1"
		end
		if g_AIExecutionController then
			query.ai_turn = true
		end
		if (IsGameRuleActive("Ironman") or CurrentModOptions["Hell_Gate"] == "<GameTerm('TE_NIGHTMARE_A')>" or CurrentModOptions["Hell_Gate"] == "<GameTerm('TE_NIGHTMARE_B')>") and (not request or request.autosave_id ~= "combatStart") then
			query.ironman = true --!!!Ironman should be also ON NIGHTMARE MODE!!! [!OPTIONAL!]
		end
		for _, unit in ipairs(g_Units) do
			if not unit:IsIdleCommand() then
				query.unit_actions = true
			end
		end
	end
end

--TE EnemySquad Size Multiplier
local TE_EnemySquadSize = rawget(_G, "TE_EnemySquadSize") or {}

function TE_SetEnemySquadSizeMultiplier()
	for _, v in pairs(EnemySquadDefs) do
		for _, u in ipairs(v.Units) do
			local skip = false
			for _, w in ipairs(u.weightedList) do
				local ud = UnitDataDefs[w.unitType]
				-- skip some "unique" type units
				if ud.ImportantNPC == true
					or ud.role == "Commander"
					or ud.group == "MercenariesNew"
					or ud.group == "MercenariesOld"
					or ud.militia == true then
					skip = true
				end
			end
			
			if skip == false then
				-- save the default values
				local saved = TE_EnemySquadSize[u]
				if saved == nil then
					saved = { ["UnitCountMin"] = u.UnitCountMin, ["UnitCountMax"] = u.UnitCountMax }
					TE_EnemySquadSize[u] = saved
				end

				u.UnitCountMin = MulDivRound(saved.UnitCountMin, 150, 100)
				u.UnitCountMax = MulDivRound(saved.UnitCountMax, 150, 100)
			end
		end
	end
end
OnMsg.ModsReloaded = TE_SetEnemySquadSizeMultiplier
OnMsg.DataLoaded = TE_SetEnemySquadSizeMultiplier

--TE DropLimit Factor
function TE_DropLoot(unit)
	local factor = 1

	if opt_TE_droprate then
		factor = 1
	end

	local baseDropRate = {
		['Firearm'] = Min(10, factor * const.BaseDropChance.Firearm),
		['Grenade'] = 0,
		['HeavyWeapon'] = 0,
		['Ordnance'] = 0,
--		['Ammo'] = Min(100, factor * const.BaseDropChance.Ammo),
--		['Armor'] = Min(100, factor * const.BaseDropChance.Armor),
--		['ConditionAndRepair'] = Min(100, factor * const.BaseDropChance.ConditionAndRepair),
--		['Medicine'] = Min(100, factor * const.BaseDropChance.Medicine),
--		['MeleeWeapon'] = Min(100, factor * const.BaseDropChance.MeleeWeapon),
--		['QuickSlotItem'] = Min(100, factor * const.BaseDropChance.QuickSlotItem),
--		['ResourceItem'] = Min(100, factor * const.BaseDropChance.ResourceItem),
--		['ToolItem'] = Min(100, factor * const.BaseDropChance.ToolItem),
--		['Valuables'] = Min(100, factor * const.BaseDropChance.Valuables),
	}

	unit:ForEachItem(
		function(item, slot_name)
		    -- skip the following numerous loops for the performance experience if drop rates are not touched by the mod
			for k, v in pairs(baseDropRate) do
				if IsKindOf(item, k) then
					if IsKindOf(item, "UnarmedWeapon") or IsKindOf(item, "Infected_HardenedSkin") or IsKindOf(item, "HyenaWeapon") or IsKindOf(item, "CrocodileWeapon") or IsKindOf(item, "CrocodileHide") then 
						item.drop_chance = 0
						break
					end

					local chance
					if factor > 1 then 
						chance = 10
					else
						chance = v
					end
					item.drop_chance = chance
					break
				end
			end
		end
	)
end
function TE_SetNonPlayerUnits()
	-- reset drop rates of non-player units
	for _, unit in pairs(TE_Utils.TE_GetTeamUnitsBySide({"neutral","enemy1","enemy2","enemyNeutral","ally",})) do
		if not (unit.team.side == 'player1' or IsMerc(unit)) then
			TE_DropLoot(unit)
		end
	end
end
function TE_SetNonPlayerUnitsApply()
	if not g_Combat or g_Combat.current_turn == 1 or g_Combat.current_turn == 2 then
		TE_SetNonPlayerUnits()
	end
end
OnMsg.DoneEnterSector = TE_SetNonPlayerUnitsApply

--No StealthVignette
function OnMsg.ClassesBuilt()
    StealthVignetteDialog.Image = "Mod/JA3_TacticianEnhanced/Images/NO_Vignette.png"
end

--No GasMaskShow
function OnMsg.OnUpdateItemsVisuals(unit)
	unit:UnequipGasMask()
end

--No LockCameraMovement
function AdjustCombatCamera(state, instant, target, floor, sleepTime, noFitCheck) return end
function LockCameraMovement(reason) return end
function StartCinematicCombatCamera(attacker, target) return end
function CombatCam_ShowAttack(attacker, target) return end
function CombatCam_ShowAttackNew(attacker, target, willBeinterrupted, results, freezeCamPos, changeFloorOnly) return end

--No movedToShowAttacker(enemies)!
function Unit:PrepareToAttack(attack_args, attack_results)
	if not self.visible and not self.team.player_enemy then
		local targetIsUnit = attack_args.target and IsKindOf(attack_args.target, "Unit") and attack_args.target
		if targetIsUnit and targetIsUnit.visible then
			local floor = GetStepFloor(targetIsUnit)
			SnapCameraToObj(targetIsUnit, "force", floor)
		else
			return
		end
	end
	local showMiddle
	local dontMoveCamera, ccAttacker = StopCinematicCombatCamera()
	local updateLastUnitShoot = false
	if dontMoveCamera then updateLastUnitShoot = ccAttacker end
	local targetPos = not IsPoint(attack_args.target) and attack_args.target:GetVisualPos() or attack_args.target
	local notInGivenCommand = self.command ~= "OverwatchAction" and self.command ~= "MGSetup" and self.command ~= "MGTarget"
	local attackerPos = self:GetVisualPos()
	local isRetaliation = attack_args.opportunity_attack_type and attack_args.opportunity_attack_type == "Retaliation"
	local isAIControlled = not ActionCameraPlaying and not self:IsMerc() and g_AIExecutionController and 
		(not self.opportunity_attack or #g_CombatCamAttackStack == 0) and not self.team.player_enemy
	local mercPlayingAsAI = self:IsMerc() and g_AIExecutionController and g_AIExecutionController.units_playing and g_AIExecutionController.units_playing[self]
	local isAIControlledMerc = not ActionCameraPlaying and (isRetaliation or attack_args.gruntyPerk or mercPlayingAsAI)
	local cameraPosChanged

	--Show attacker
	local movedToShowAttacker
	if isAIControlled or isAIControlledMerc then
		--handle camera
		if g_LastUnitToShoot ~= self and not dontMoveCamera then
			local midPoint = (attackerPos + targetPos) / 2
			local floor = GetStepFloor(self)
			local target_floor = GetStepFloor(attack_args.target)
			showMiddle = floor == target_floor and notInGivenCommand and DoPointsFitScreen({ attackerPos, targetPos }, midPoint, 10)
			local posToShow = showMiddle and midPoint or attackerPos
			local cameraIsNear = DoPointsFitScreen({posToShow}, nil, const.Camera.BufferSizeNoCameraMov)
			if cameraIsNear and showMiddle then
				cameraIsNear = DoPointsFitScreen({ attackerPos, targetPos }, nil, 10)
			end
			
			if not cameraIsNear then
				movedToShowAttacker = true
				SnapCameraToObj(posToShow, "force", GetStepFloor(showMiddle and targetPos or attackerPos))
				if not self:CanQuickPlayInCombat() then Sleep(1000) end
			elseif not IsVisibleFromCamera(self) or GetStepFloor(self) > cameraTac.GetFloor() then
				--no movement of camera should still take into account the floor
				cameraTac.SetFloor(GetStepFloor(self), hr.CameraTacInterpolatedMovementTime * 10, hr.CameraTacInterpolatedVerticalMovementTime * 10)
			end
			updateLastUnitShoot = self
		end
	elseif not ActionCameraPlaying and self.opportunity_attack and not isRetaliation and not self.team.player_enemy then
		movedToShowAttacker = not DoPointsFitScreen({ targetPos }, nil, const.Camera.BufferSizeNoCameraMov)
		CombatCam_ShowAttackNew(self, attack_args.target, nil, attack_results, dontMoveCamera)
	end
	
	--handle badges
	if not g_AITurnContours[self.handle] and (isAIControlled or isAIControlledMerc or (self.opportunity_attack and not isRetaliation)) then
		local enemy = self.team.side == "enemy1" or self.team.side == "enemy2" or self.team.side == "neutralEnemy"
		g_AITurnContours[self.handle] = SpawnUnitContour(self, enemy and "CombatEnemy" or "CombatAlly")
		ShowBadgeOfAttacker(self, true)
	end

	self:AimTarget(attack_args, attack_results, true)

	--delay after aim
	if not self:CanQuickPlayInCombat() and movedToShowAttacker and (g_AIExecutionController or isRetaliation or attack_args.gruntyPerk or self.opportunity_attack) then
		local delay
		local consecutiveDelay = not dontMoveCamera and g_LastUnitToShoot == self

		if dontMoveCamera then
			delay = const.Combat.ShootDelayAfterAimCinematic
		elseif consecutiveDelay then
			delay = const.Combat.ConsecutiveShootDelayAfterAim
		else
			delay = const.Combat.ShootDelayAfterAim
		end
		Sleep(delay)
	end

	self:SetTargetDummy(nil, nil, attack_args.anim, 0, attack_args.stance)

	--Show target
	if not showMiddle then cameraPosChanged = not DoPointsFitScreen({targetPos}, nil, const.Camera.BufferSizeNoCameraMov) end
	if isAIControlled and notInGivenCommand and g_LastUnitToShoot ~= self or isAIControlledMerc then
		local interrupts = self:CheckProvokeOpportunityAttacks(attack_args.action_id and CombatActions[attack_args.action_id], "attack interrupt", {self.target_dummy or self})
		local targetNotVisible = showMiddle and IsKindOf(attack_args.target, "Unit") and not IsVisibleFromCamera(attack_args.target)
		CombatCam_ShowAttackNew(self, attack_args.target, interrupts, attack_results, dontMoveCamera or showMiddle, targetNotVisible)
	elseif self:IsMerc() and not ActionCameraPlaying and not g_AIExecutionController then
		--edge case where merc/player shoots but he is in overwatch so the overwatch will be shown first and then his attack
		local interrupts = self:CheckProvokeOpportunityAttacks(attack_args.action_id and CombatActions[attack_args.action_id], "attack interrupt", {self.target_dummy or self})
		if interrupts then
			CombatCam_ShowAttackNew(self, attack_args.target, interrupts, attack_results)
		else
			local cameraIsNear = DoPointsFitScreen({targetPos}, nil, const.Camera.BufferSizeNoCameraMov)
			if attack_results.explosion and (not attack_args.action_id or attack_args.action_id ~= "Bombard") and not cameraIsNear then
				SnapCameraToObj(targetPos, nil, GetStepFloor(targetPos), 500)
				Sleep(500)
			end
		end
	end

	--delay before shooting
	if not self:CanQuickPlayInCombat() then
		if g_AIExecutionController or isRetaliation or self.opportunity_attack then
			local delay
			local consecutiveDelay = not dontMoveCamera and g_LastUnitToShoot == self
			
			if dontMoveCamera then
				delay = const.Combat.ShootDelayCinematic
			elseif not cameraPosChanged then
				delay = const.Combat.ShootDelayTargetOnScreen
			elseif consecutiveDelay then
				delay = const.Combat.ConsecutiveShootDelay
			else
				delay = const.Combat.ShootDelay
			end
			Sleep(delay)
		elseif self.command ~= "PrepareBombard" and self.command ~= "OverwatchAction" then
			if cameraPosChanged then
				Sleep(const.Combat.ShootDelayNonAI)
			else
				Sleep(const.Combat.ShootDelayTargetOnScreen)
			end
		end
	end
	if updateLastUnitShoot then
		g_LastUnitToShoot = updateLastUnitShoot
	end
end

--Tactical CameraZoom
local function TE_CameraZoom()
    hr.CameraTacMaxZoom = 400
    hr.CameraTacMinZoom = 20
    hr.CameraTacZoomStep = 20
end

--Always Show KillCamera
function SetActionCameraNoFallbackSync(attacker, target, disable_float, interpolation_time, no_rotate, preset_filter, dontActiveAC)
	-- Randomly decide whether to trigger the action camera (e.g. 100% chance)
	local should_activate_camera = AsyncRand(100) <= 100 -- 100% probability
	if not should_activate_camera then
		return false
	end

	local new_pos, new_lookat, preset, fallback = CalcActionCamera(attacker, target, nil, nil, no_rotate)
	if fallback then return false end
	if preset_filter and table.find(preset_filter, preset.id) then return false end
	
	assert(preset)
	if not preset then return end
	
	if not dontActiveAC then
		LocalACWillStartPlaying = (LocalACWillStartPlaying or 0) + 1
	end
	NetSyncEvents.SetActionCameraDirect(not dontActiveAC and netUniqueId, attacker, target, new_pos, new_lookat, preset and preset.id, disable_float, interpolation_time or ac_interpolation_time, true)
	
	return true
end

--Always Success ModifyWeaponDlg
local TE_GetModificationDifficultyParams = ModifyWeaponDlg.GetModificationDifficultyParams

function ModifyWeaponDlg:GetModificationDifficultyParams(componentToChangePreset)
	local playerMechSkill, bestMechSkillUnit, difficulty, allowed = TE_GetModificationDifficultyParams(self, componentToChangePreset)
	return playerMechSkill, bestMechSkillUnit, -100, allowed
end

--TE Real Forgiving Mode (P.O.W.)!
function Unit:Die(skip_anim)
	local attacker = self.on_die_attacker
	local hit_descr = self.on_die_hit_descr or {}
	local target_spot_group = hit_descr.spot_group
	local headshot = target_spot_group == "Head"
	local attack_action_id = attacker and CombatActions_LastStartedAction and CombatActions_LastStartedAction.unit == attacker and CombatActions_LastStartedAction.action_id
	local zoom_in = (self:IsLocalPlayerControlled() or headshot or attack_action_id == "KnifeThrow") and attacker and CurrentActionCamera and CurrentActionCamera[1] ~= self and CurrentActionCamera[2] == self and not self.villain
	local results = {}

	self:AlignOnDeath("don't snap in voxel")
	self:RoamDropFlare()

	if not skip_anim then
		if zoom_in then
			ZoomActionCamera()
		end

		-- Action camera should wait for this to be over before closing.
		if CurrentActionCamera then
			CurrentActionCamera.wait_signal = true
		end
	end
	
	if self.reincarnate then
		self:PlayDying()
		self:ReviveOnHealth()
		self:SetBehavior()
		self:SetCombatBehavior()
		self:SetCommand("Idle")
		return
	elseif self.immortal or (CurrentModOptions["Merc_Immortal"] and (self:IsMerc() or IsMerc(self))) then -- TE PlayerMercs Never KIA!
		self:ReviveOnHealth()
		self:SetSide("neutral")
		self:AddStatusEffect("BleedingOut")
		self:AddStatusEffect("Unconscious")
		return
	end
	
	self.throw_died_message = "all"
	self.HitPoints = 0 -- needs to be before RemoveAllStatusEffects so that Wounded can detect the death and leave any blood stains on
	self:RemoveAllStatusEffects("death")
	if self.villain then
		local attackerMerc = attacker and IsMerc(attacker)
		
		if self.DefeatBehavior == "Defeated" then
			self:SetBehavior("VillainDefeat")
			self:SetCombatBehavior("VillainDefeat")
			self.villain_defeated = true
			self:SetCommand("VillainDefeat")
		elseif self.DefeatBehavior == "Dead" then
			if attackerMerc and SideIsEnemy(self.team.side, attacker.team.side) then
				PlayVoiceResponse(self, "DramaticDeath")
			end
			Msg("VillainDefeated", self, attacker)
			self.villain_defeated = true
		end
	end
	self.HitPoints = 0 -- in case statuses do some shenanigans I guess
	self.time_of_death = Game.CampaignTime
	self.pending_aware_state = nil
	self.killed_stance = self.stance

	Msg("UnitDieStart", self, attacker)
	Msg("UnitDiedOnSector", self, gv_CurrentSectorId)
	self.throw_died_message = "pre-sync"
	
	self:InterruptPreparedAttack()
	self:EndInterruptableMovement()
	CombatActionInterruped(self)
	for _, unit in ipairs(g_Units) do
		if unit:GetBandageTarget() == self then
			unit:SetCommand("EndCombatBandage")
		end
	end	
	local stealth_kill = hit_descr.stealth_kill
	if not attacker then
		CombatLog("debug", T{Untranslated("  <em><name></em> was <em>killed</em>"), name = self:GetLogName()})
	end

	results.glory_kill = not self.immortal and not hit_descr.grazing and self:Random(100) < const.Combat.GloryKillChance
	
	local death_explosion = hit_descr.death_explosion
	if self:GetItemInSlot("Inventory", "Valuables") or self:GetItemInSlot("Inventory", "QuestItem") then
		death_explosion = false
		hit_descr.death_explosion = false
	end

	if death_explosion then
		PlayFX("DeathExplosion", "start", self, target_spot_group)
	elseif results.glory_kill and IsKindOf(hit_descr.weapon, "Firearm") and not self.immortal and headshot and self.species == "Human" and self.parts.Head then
		self:SetHeadshot(true)
		PlayFX("Death", "start", self, "Headshot")
	else
		PlayFX("Death", "start", self, target_spot_group)
	end
	
	if IsMerc(self) then
		PlayFX("MercDeath", "start", self)
	end

	self:SetPos(self:GetVisualPos())
	self:SetHierarchyGameFlags(const.gofOnRoof) --hide with roofs and walls if too close to one
	self:ClearPath()
	self:ClearEnumFlags(const.efResting)
	self:SetTargetDummy(false)
	SetCombatActionState(self, nil)
	-- Remember the anim prefix when the unit died as it will drop its items
	self.die_anim_prefix = self:GetWeaponAnimPrefix()

	local container
	if not self.immortal then
		if death_explosion then
			container = GetDropContainer(self)
			container:SetVisible(false)
		end
		self:DropLoot(container)
		if container and not container:HasItem() then
			DoneObject(container)
			container = false
		end
	end
	self:SyncWithSession("map")
	self.throw_died_message = "after-start"

	if self.villain and self.DefeatBehavior == "Dead" then
		MoraleModifierEvent("LieutenantDefeated", self)
	else
		MoraleModifierEvent("UnitDied", self)
		if attacker and self.team.side ~= "neutral" and self.team.side ~= "player1" and self.team.side ~= "player2" and results.glory_kill then
			MoraleModifierEvent("SpectacularKill", attacker)
		end
	end

	-- alerts: noise (non-stealth only) and killed (always)
	local alerted, suspicious = PushUnitAlert("death", self)
	if not stealth_kill then
		local noise_alerted, noise_suspicious = PushUnitAlert("noise", self, const.Combat.DeathNoiseRange, Presets.NoiseTypes.Default.Pain.display_name)
		alerted, suspicious = alerted + noise_alerted, suspicious + noise_suspicious
	end
	if g_Combat and IsKindOf(attacker, "Unit") and not g_Combat:ShouldEndCombat() then
		if stealth_kill and alerted == 0 then
			PlayVoiceResponse(attacker, "OpponentKilledStealth")
		end
	end

	-- skip end combat check if the death made someone suspicious or alert
	-- note: a stealth kill attack wouldn't alert/raise suspicion in other units except through the "death" trigger
	local end_combat_check = g_Combat and suspicious + alerted == 0 and not g_AIExecutionController

	self:PushDestructor(function(self)
		self:RemovePreparedAttackVisuals()
		Msg("ActionCameraWaitSignalEnd")
		if container then
			container:SetVisible(true)
		end
	end)
	self:PushDestructor(function(self)
		assert(not self.command and not self:IsValid(), "Die command should not be interrupted (new command: " .. tostring(self.command) .. ").")
	end)
	-- wait a bit for possible destruction around or below the unit (bullets and explosions might destroy stuff after the unit)
	if not skip_anim then
		Sleep(100)
		self:StopPain()
	end
	self:PlayDying(skip_anim, end_combat_check)
	self:PopDestructor()
	self:PopAndCallDestructor()

	ObjModified(self)
	Msg("UnitDied", self, attacker, results)
	self.throw_died_message = false
	
	if IsValid(self) then
		self:BeginInterruptableMovement()
		self:SetCommand("Dead")
	end
end

-- ========== GENERATED BY LootDef Editor (Ctrl-L) DO NOT EDIT MANUALLY! ==========

--TE FlagHill_Beach(I1) NewLoot!
function OnMsg.DataLoaded()
	PlaceObj('LootDef', {
		Comment = "ernie container",
		group = "Ernie",
		id = "FlagHill_Beach_Gun",
		loot = "all",
		PlaceObj('LootEntryInventoryItem', {
			item = "_762NATO_Basic",
			stack_max = 10,
			stack_min = 10,
		}),
		PlaceObj('LootEntryInventoryItem', {
			item = "Parts",
			stack_max = 10,
			stack_min = 10,
		}),
		PlaceObj('LootEntryInventoryItem', {
			item = "TE_Binoculars",
			stack_max = 1,
			stack_min = 1,
		}),
		PlaceObj('LootEntryUpgradedWeapon', {
			Condition = 90,
			RandomizeCondition = true,
			weapon = "Gewehr98",
		}),
	})
end

-- ========== GENERATED BY InventoryItemCompositeDef Editor (Ctrl-Alt-Y) DO NOT EDIT MANUALLY! ==========

--TE DiamondBriefcase Valuables+!
UndefineClass('DiamondBriefcase')
DefineClass.DiamondBriefcase = {
	__parents = { "Valuables" },
	__generated_by_class = "InventoryItemCompositeDef",


	object_class = "Valuables",
	Repairable = false,
	Icon = "UI/Icons/Items/diamond_briefcase",
	DisplayName = T(157264750485, --[[InventoryItemCompositeDef DiamondBriefcase DisplayName]] "Diamond Shipment"),
	DisplayNamePlural = T(116084819674, --[[InventoryItemCompositeDef DiamondBriefcase DisplayNamePlural]] "Diamond Shipments"),
	Description = T(894669501328, --[[InventoryItemCompositeDef DiamondBriefcase Description]] "A shipment of diamonds recovered from the enemy."),
	AdditionalHint = T(952083748618, --[[InventoryItemCompositeDef DiamondBriefcase AdditionalHint]] "<bullet_point> <GameColorD>Can be cashed in for Money</GameColorD>"),
	Valuable = 1,
	Cost = 36000, -- Default = 12000
	RestockWeight = 0,
}

-- ========== TE Global MiscEdit End ==========


--Tactician Enhanced Mechanism Loaded
function OnMsg.ModsReloaded()
	if not TE_DataReady() then return end
	TE_AI_Logic()
	TE_Explosion_Resistance()
	TE_Projectile_Velocity()
	TE_Unaware_Sight()
	TE_Auto_Resolve()
	TE_CameraZoom()
    if SoundPresets and SoundPresets["ui_overwatch-activate"] and SoundPresets["ui_overwatch-deactivate"] then SoundPresets["ui_overwatch-activate"].volume = 0 end
    if SoundPresets and SoundPresets["ui_overwatch-activate"] and SoundPresets["ui_overwatch-deactivate"] then SoundPresets["ui_overwatch-deactivate"].volume = 0 end
    if SoundPresets and SoundPresets["ui_overwatch-activate"] and SoundPresets["ui_overwatch-deactivate"] then LoadSoundBank(SoundPresets["ui_overwatch-activate"]) end
    if SoundPresets and SoundPresets["ui_overwatch-activate"] and SoundPresets["ui_overwatch-deactivate"] then LoadSoundBank(SoundPresets["ui_overwatch-deactivate"]) end
end
function OnMsg.DataLoaded()
	if not TE_DataReady() then return end
	TE_AI_Logic()
	TE_Explosion_Resistance()
	TE_Projectile_Velocity()
	TE_Unaware_Sight()
	TE_Auto_Resolve()
	TE_CameraZoom()
    if SoundPresets and SoundPresets["ui_overwatch-activate"] and SoundPresets["ui_overwatch-deactivate"] then SoundPresets["ui_overwatch-activate"].volume = 0 end
    if SoundPresets and SoundPresets["ui_overwatch-activate"] and SoundPresets["ui_overwatch-deactivate"] then SoundPresets["ui_overwatch-deactivate"].volume = 0 end
    if SoundPresets and SoundPresets["ui_overwatch-activate"] and SoundPresets["ui_overwatch-deactivate"] then LoadSoundBank(SoundPresets["ui_overwatch-activate"]) end
    if SoundPresets and SoundPresets["ui_overwatch-activate"] and SoundPresets["ui_overwatch-deactivate"] then LoadSoundBank(SoundPresets["ui_overwatch-deactivate"]) end
end
function OnMsg.OptionsApply()
	if not TE_DataReady() then return end
	TE_AI_Logic()
	TE_Explosion_Resistance()
	TE_Projectile_Velocity()
	TE_Unaware_Sight()
	TE_Auto_Resolve()
	TE_CameraZoom()
    if SoundPresets and SoundPresets["ui_overwatch-activate"] and SoundPresets["ui_overwatch-deactivate"] then SoundPresets["ui_overwatch-activate"].volume = 0 end
    if SoundPresets and SoundPresets["ui_overwatch-activate"] and SoundPresets["ui_overwatch-deactivate"] then SoundPresets["ui_overwatch-deactivate"].volume = 0 end
    if SoundPresets and SoundPresets["ui_overwatch-activate"] and SoundPresets["ui_overwatch-deactivate"] then LoadSoundBank(SoundPresets["ui_overwatch-activate"]) end
    if SoundPresets and SoundPresets["ui_overwatch-activate"] and SoundPresets["ui_overwatch-deactivate"] then LoadSoundBank(SoundPresets["ui_overwatch-deactivate"]) end
end

-- ========== TE Patch Helpers (log-error fixes) ==========
function TE_ToPos(o)
	if o == nil then return nil end
	if IsPoint(o) then return o end
	if IsValid(o) then return o:GetPos() end
	return nil
end
function TE_ScatterPos(closest, fallback_obj, radius)
	local base = TE_ToPos(closest) or TE_ToPos(fallback_obj) or point(0, 0, 0)
	local ang = InteractionRand(360*60)
	local off = Rotate(point(InteractionRand(radius), 0, 0), ang)
	if not IsPoint(off) then off = point(0, 0, 0) end
	return base + off
end
function TE_SafeActionResults(action, unit, args, weapons)
	if not action or not weapons or not IsPoint(args.target) then return nil end
	local ok, res = pcall(action.GetActionResults, action, unit, args)
	if ok then return res end
	return nil
end
-- DoChangeStance sleeps, which is illegal inside a reaction (called through pcall): run it in its own thread
function TE_SafeCrouch(unit)
	if not IsValid(unit) then return end
	CreateGameTimeThread(function()
		if IsValid(unit) and not unit:IsDead() and unit.stance == "Standing" then
			unit:DoChangeStance("Crouch")
		end
	end)
end
-- GetComponentEffectValue(weapon, id) with no param key calls ResolveValue(nil) and errors for marker effects (CombatMod_*)
function TE_GetCompEffect(weapon, effect_id, key)
	if key ~= nil then return GetComponentEffectValue(weapon, effect_id, key) end
	if type(weapon) ~= "table" or type(weapon.components) ~= "table" then return nil end
	for _, comp_id in pairs(weapon.components) do
		local def = WeaponComponents[comp_id]
		if def and def.ModificationEffects and table.find(def.ModificationEffects, effect_id) then
			return true, def
		end
	end
	return nil
end
function TE_SetParamCache(comp, name, value)
	if not comp then return end
	g_PresetParamCache = g_PresetParamCache or {}
	g_PresetParamCache[comp] = g_PresetParamCache[comp] or {}
	g_PresetParamCache[comp][name] = value
end
-- true once all preset/def tables the TE load-time code touches exist
function TE_DataReady()
	return UnitDataDefs ~= nil and InventoryItemDefs ~= nil and WeaponComponents ~= nil
		and Presets ~= nil and Presets.ChanceToHitModifier ~= nil and Presets.ChanceToHitModifier.Default ~= nil
end
-- the game's gas code (Grenade.lua) and TE call this global; if it is missing in this build, fall back to a no-op
if EnvEffectReaction == nil then
	function EnvEffectReaction() end
end
-- ========== TE Patch Helpers End ==========
