--======================================== Tactician Enhanced Sector DiceRoll Event Begin ========================================

--DiceRoll Squad
local TE_DiceRollSquad = {
	Legion = {
		"LegionButcher_Stronger",
		"LegionButcher_Stronger_Elite",
		"LegionGoon_Stronger",
		"LegionGoon_Stronger_Elite",
		"LegionGrenadier_Stronger",
		"LegionGrenadier_Stronger_Elite",
		"LegionGunner_Stronger",
		"LegionHyena",
		"LegionHyenaHandler_Stronger",
		"LegionManiac_Stronger",
		"LegionManiac_Stronger_Elite",
		"LegionRaidLeader_Stronger",
		"LegionRaidLeader_Stronger_Elite",
		"LegionRaider_Stronger",
		"LegionRaider_Stronger_Elite",
		"LegionRocketeer_Stronger",
		"LegionScout_Stronger",
		"LegionScout_Stronger_Elite",
		"LegionSniper_Stronger",
		"LegionSniper_Stronger_Elite",
	},
	Thug = {
		"ThugBoss_Stronger",
		"ThugBoss_Stronger_Elite",
		"ThugCutter_Stronger",
		"ThugCutter_Stronger_Elite",
		"ThugEnforcer_Stronger",
		"ThugEnforcer_Stronger_Elite",
		"ThugGoon_Stronger",
		"ThugGoon_Stronger_Elite",
		"ThugGrenadier_Stronger",
		"ThugGrenadier_Stronger_Elite",
		"ThugGunner_Stronger",
		"ThugGunner_Stronger_Elite",
		"ThugSniper_Stronger",
		"ThugSniper_Stronger_Elite",
	},
	Army = {
		"ArmyCommander_Elite",
		"ArmyDemo_Elite",
		"ArmyHeavy",
		"ArmyRPG",
		"ArmyScout",
		"ArmySniper_Elite",
		"ArmySoldier",
		"ArmyStormer",
	},
	Adonis = {
		"AdonisAssault_Elite",
		"AdonisDedicatedGunner_Elite",
		"AdonisDemolitions_Elite",
		"AdonisFlanker_Elite",
		"AdonisHeavy",
		"AdonisSniper_Elite",
		"AdonisSquadLeader_Elite",
		"AdonisStormer_Elite",
	},
}

--DiceRoll Notification
PlaceObj('TacticalNotification', {
	SortKey = -9000,
	combatLog = true,
	combatLogType = "important",
	id = "ReinforcementCalling",
	style = "yellow",
	text = T(3042581131200001, 'Enemy signaller is calling for reinforcements!'),
	duration = 5000,
})

PlaceObj('TacticalNotification', {
	SortKey = -9000,
	combatLog = true,
	combatLogType = "important",
	id = "ReinforcementArriving",
	style = "red",
	text = T(3042581131200002, 'Enemy reinforcements have arrived on the battlefield!'),
	duration = 5000,
})

PlaceObj('TacticalNotification', {
	SortKey = -9000,
	combatLog = true,
	combatLogType = "important",
	id = "AmbusherRaiding",
	style = "red",
	text = T(3042581131200003, 'Enemy ambusher is raiding on the battlefield!'),
	duration = 5000,
})


--TE DiceRoll Reinforcement
OnMsg.TurnStart = function()
	if CurrentModOptions["Hell_Gate"] == "<GameTerm('TE_NIGHTMARE_A')>" or CurrentModOptions["Hell_Gate"] == "<GameTerm('TE_NIGHTMARE_B')>" then return end
	
	if CurrentModOptions["DiceRoll_Event"] == "<GameTerm('TE_REINFORCEMENT')>" then
		for _, unit in ipairs(g_Units) do
			if not g_Combat or GameState.Underground or unit:HasStatusEffect("TutorialMinion") then return end
			
			if unit.team.player_team and (g_Teams[g_CurrentTeam].side == 'player1' or g_Teams[g_CurrentTeam].side == 'player2') then
				local enemies = GetAllEnemyUnits(unit)
				for _, enemy in ipairs(enemies) do
					if (g_Combat.current_turn == 1 or g_Combat.current_turn == 8 or g_Combat.current_turn == 16) and ((enemy.Affiliation == "Legion" or enemy.Affiliation == "Thug" or enemy.Affiliation == "Army" or enemy.Affiliation == "Adonis") and not enemy:HasStatusEffect("TutorialMinion")) then
						ShowTacticalNotification("ReinforcementCalling")
					end
				end
			elseif unit.team.player_enemy and (g_Teams[g_CurrentTeam].side == 'enemy1' or g_Teams[g_CurrentTeam].side == 'enemy2') then
				local enemies = GetAllEnemyUnits(unit)
				if g_Combat.current_turn == 1 or g_Combat.current_turn == 8 or g_Combat.current_turn == 16 then
					local nameList = { 'Legion', 'Thug', 'Army', 'Adonis' }
					local typeName = nameList[#nameList]
					if unit.Affiliation == "Legion" then
						typeName = nameList[1]
					elseif unit.Affiliation == "Thug" then
						typeName = nameList[2]
					elseif unit.Affiliation == "Army" then
						typeName = nameList[3]
					elseif unit.Affiliation == "Adonis" then
						typeName = nameList[4]
					else
						return
					end
					-- generate enemy reinforcement
					local squadType = TE_DiceRollSquad[typeName]
					local enemyCount = Min(16, #enemies*4)
					local closestExitZone = GetClosestExitZoneInteractable(unit)
					local positions = closestExitZone:GetRandomPositions(enemyCount)
					for i = 1, #positions do
						local unitClass = squadType[InteractionRandRange(1, #squadType)]
						local sessionId = GenerateUniqueUnitDataId(gv_CurrentSectorId, unitClass)
						local unit = SpawnUnit(unitClass, sessionId, positions[i])
						unit:SetSide('enemy1')
						unit:AddStatusEffect('ReinforcementProtection')
						TriggerUnitAlert("surprise", unit)
					end
					ShowTacticalNotification('ReinforcementArriving')
					return
				end
			end
		end
	end
end

--Ambusher startPos
function TE_AmbusherPosClose(nearUnit, distTile, toFace)
	nearUnit = nearUnit or GetTerrainCursorXY(UIL.GetScreenSize() / 2)
	distTile = distTile or 1

	local dirFlag = toFace and 1 or -1
	local dist = const.SlabSizeX * distTile * 20
	
	local startPos, direction
	if IsKindOf(nearUnit, "Unit") then
		startPos = GetClosestExitZoneInteractable(nearUnit)
		direction = Rotate(point(const.SlabSizeX, 0), nearUnit:GetAngle())
	else
		startPos = nearUnit
		direction = Rotate(point(const.SlabSizeX, 0), AsyncRand(60 * 360))
	end
	
	local pt = startPos + SetLen(direction, dist) * dirFlag
	local freePoint = DbgFindFreePassPositions(pt, 1, 100, xxhash(pt))
	while not next(freePoint) do
		freePoint = DbgFindFreePassPositions(pt, 1, 100, xxhash(pt))
	end
	
	return freePoint[1]
end

--Ambusher Raid!
function Unit:TE_AmbusherRaid(ambush, pos)
	if (not pos or not (IsPoint(pos) or IsValidPos(pos))) or (not ambush or ambush <= 0) then return end
	
	local positions = {}
	for i = 1, ambush do
		local spawnPos = TE_AmbusherPosClose(pos, 2, false)
		table.insert(positions, spawnPos)
	end
	
	for i = 1, #positions do
		CreateGameTimeThread(function()
			local allEnemies = GetAllEnemyUnits(self)
			for _, enemy in ipairs(allEnemies) do
				local nameList = { 'Legion', 'Thug', 'Army', 'Adonis' }
				local typeName = nameList[#nameList]
				if enemy.Affiliation == "Legion" then
					typeName = nameList[1]
				elseif enemy.Affiliation == "Thug" then
					typeName = nameList[2]
				elseif enemy.Affiliation == "Army" then
					typeName = nameList[3]
				elseif enemy.Affiliation == "Adonis" then
					typeName = nameList[4]
				else
					return
				end
				local squadType = TE_DiceRollSquad[typeName]
				local unitClass = squadType[InteractionRandRange(1, #squadType)]
				local ambushSessionId = GenerateUniqueUnitDataId(gv_CurrentSectorId, unitClass)
				local ambushUnit = SpawnUnit(unitClass, ambushSessionId, positions[i])
				local zone = SmokeZone:new{smoke_dx = 0.8, smoke_dy = 0.8, remaining_time = 10000, gas_type = 'smoke'}
				ambushUnit.already_spawned_on_map = true
				ambushUnit:SetSide('enemy1')
				ambushUnit:AddStatusEffect('AmbusherProtection')
				PushUnitAlert("surprise", ambushUnit)
				ShowTacticalNotification('AmbusherRaiding')
				zone:SetPos(positions[i])
				zone:PropagateSmoke()
				Sleep(1000)
				return
			end
		end)
	end
end

--Sector DiceRoll
function Unit:TE_DiceRoll(target)
	if not g_Combat or GameState.Underground or self:HasStatusEffect("BOWRitualsCD") then return end
	
	local pos = target:GetPos()
	local ambush = 1
	self:TE_AmbusherRaid(ambush, pos)
end

--======================================== Tactician Enhanced Sector DiceRoll Event End ========================================