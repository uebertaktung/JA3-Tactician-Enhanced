--======================================== Tactician Enhanced Hell Gate Event Begin ========================================

--Hell Gate Notification
PlaceObj('TacticalNotification', {
	SortKey = -9000,
	combatLog = true,
	combatLogType = "important",
	id = "HellGateRituals",
	style = "red",
	text = T(3042581131200004, 'B.O.W. has being summoned at the Hell Gate!'),
	duration = 5000,
})


--Hell Gate startPos
function TE_BOWPosClose(nearUnit, distTile, toFace)
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

--Generate B.O.W. Upon Enemy Death
function OnMsg.UnitDied(unit)
	if not g_Combat or (unit:HasStatusEffect("Unaware") or unit:HasStatusEffect("Surprised") or unit:HasStatusEffect("ZombiePerk") or unit:HasStatusEffect("TacticalBOW") or unit:HasStatusEffect("TutorialMinion")) or unit.species ~= "Human" then return end
	
	if CurrentModOptions["Hell_Gate"] == "<GameTerm('TE_NIGHTMARE_A')>" or CurrentModOptions["Hell_Gate"] == "<GameTerm('TE_NIGHTMARE_B')>" then
		if unit.team.player_team or unit:IsLocalPlayerControlled() or unit:IsMerc() or IsMerc(unit) then return end
		
		if unit.team.player_enemy and InteractionRandRange(1,100) <= 50 then
			local unitClass = (unit.Affiliation == "Legion" and table.rand({'InfectedSoldier'})) or ((unit.Affiliation == "Thug" or unit.Affiliation == "Army" or unit.Affiliation == "Adonis") and table.rand({'InfectedLicker'}))
			local infectedSessionId = GenerateUniqueUnitDataId(gv_CurrentSectorId, unitClass)
			local infectedUnit = SpawnUnit(unitClass, infectedSessionId, unit:GetPos())
			local zone = SmokeZone:new{smoke_dx = 0.8, smoke_dy = 0.8, remaining_time = 10000, gas_type = 'toxicgas'}
			infectedUnit:SetSide('enemy1')
			PushUnitAlert("surprise", infectedUnit)
			zone:SetPos(unit:GetPos())
			zone:PropagateSmoke()
			return
		end
	end
end

--B.O.W. Summoned at the Hell Gate!
function Unit:TE_BOWSummoned(bow, pos)
	if (not pos or not (IsPoint(pos) or IsValidPos(pos))) or (not bow or bow <= 0) then return end
	
	local positions = {}
	for i = 1, bow do
		local spawnPos = TE_BOWPosClose(pos, 2, false)
		table.insert(positions, spawnPos)
	end
	
	for i = 1, #positions do
		CreateGameTimeThread(function()
			local unitClass = (CurrentModOptions["Hell_Gate"] == "<GameTerm('TE_NIGHTMARE_A')>" and table.rand({ 'InfectedHyena', 'InfectedCrocodile' })) or (CurrentModOptions["Hell_Gate"] == "<GameTerm('TE_NIGHTMARE_B')>" and table.rand({ 'BOWSuperMK1', 'BOWSuperMK2' }))
			local bowSessionId = GenerateUniqueUnitDataId(gv_CurrentSectorId, unitClass)
			local bowUnit = SpawnUnit(unitClass, bowSessionId, positions[i])
			local zone = SmokeZone:new{smoke_dx = 0.8, smoke_dy = 0.8, remaining_time = 10000, gas_type = 'toxicgas'}
			bowUnit.already_spawned_on_map = true
			bowUnit:SetSide('enemy1')
			bowUnit:AddStatusEffect('BOWSummoned')
			PushUnitAlert("surprise", bowUnit)
			ShowTacticalNotification('HellGateRituals')
			zone:SetPos(positions[i])
			zone:PropagateSmoke()
			Sleep(1000)
		end)
		Sleep(500)
	end
end

--Hell Gate Summoning Rituals
function Unit:TE_HellGate(target)
	if not g_Combat or GameState.Underground or (self:HasStatusEffect("Surprised") or self:HasStatusEffect("TutorialMinion") or self:HasStatusEffect("ZombiePerk") or self:HasStatusEffect("TacticalBOW") or self:HasStatusEffect("BOWRitualsCD") or target:HasStatusEffect("BOWRitualsCD")) then return end
	
	local pos = target:GetPos()
	local bow = 1
	self:TE_BOWSummoned(bow, pos)
end

--======================================== Tactician Enhanced Hell Gate Event End ========================================