-- ========== TE GunFightRework Remastered Begin ========== [Stock Data Overhaul (SDO)]

--TE AttackAPCost
function Unit:GetAttackAPCost(action, weapon, action_ap_cost, aim, delta)
	if not weapon then 
		return 0
	end
	
	local min, max = self:GetBaseAimLevelRange(action, weapon)
	aim = Clamp(aim or 0, min, max) - min -- only charge for aiming above min level
	delta = delta or 0
	
    -- # Modification begin
    local aimCost
    local has, _ = weapon:HasComponent("CombatMod_NoExtraAimCost")
	--ThermalScope ignore RainHeavy condition
    if has then
        aimCost = const.Scale.AP
    else
        aimCost = const.Scale.AP
        if GameState.RainHeavy then
            aimCost = MulDivRound(aimCost, 100 + const.EnvEffects.RainAimingMultiplier, 100)
        end
    end
    -- # Modification end
	
	local ap = action_ap_cost or weapon.AttackAP or weapon.ShootAP or 0
	ap = ap + delta 
	ap = self:CallReactions_Modify("OnCalcAPCost", ap, action, weapon, aim)

	if IsKindOf(weapon, "HeavyWeapon") then
	elseif IsKindOf(weapon, "Firearm") or IsKindOf(weapon, "Grenade") or IsKindOf(weapon, "MeleeWeapon") then
		ap = ap + aim * aimCost
	else
		ap = -1
	end
	
	-- legal cheat: during heavy rain last possible aim costs 1 AP regardless of the penalty
	local remainingAP = (self:GetUIActionPoints() / 1000) * 1000
	if GameState.RainHeavy and ap > remainingAP and aim > 0 then 
		local diff = abs(remainingAP - ap)
		if diff < aimCost and diff >= const.Scale.AP then
			ap = remainingAP
			aimCost = 1000
		end
	end
	
	return ap, aimCost
end

--TE RangeAccuracy
function GetRangeAccuracy(props_cont, distance, unit, action)
	local effective_range_acc = 100
	local point_blank_acc = 100
	local weapon_range
	if unit and action then
		weapon_range = action:GetMaxAimRange(unit, props_cont)
	end
	weapon_range = weapon_range or props_cont.WeaponRange or props_cont:GetProperty("WeaponRange")
	
	-- # Modification begin
	if CurrentModOptions["Gunfight_Rework"] then
		local eff_range = weapon_range / 2
		local dist = distance / const.SlabSizeX
		local factor = 175
		local k0 = 0
		local k1 = 25
		local k2 = 5 -- 2^2=25
		
		if eff_range >= dist then
			return effective_range_acc
		else
			local modify_0, modify_1, modify_2
			local x = dist - eff_range
			
			modify_0 = k0
			modify_1 = MulDivRound(k1, x, eff_range)
			modify_2 = MulDivRound(k2, x, eff_range) * MulDivRound(k2, x, eff_range)
			
			local modify = MulDivRound(modify_0 + modify_1 + modify_2, factor, 100)
			return (effective_range_acc - modify)
		end
	else
		local eff_range = (IsKindOfClasses(props_cont, "Shotgun", "SubmachineGun", "Pistol", "Revolver") and weapon_range / 2) or (IsKindOfClasses(props_cont, "AssaultRifle", "SniperRifle", "MachineGun") and weapon_range)
		local dist = distance / const.SlabSizeX
		local factor = 125
		local k0 = 0
		local k1 = 25
		local k2 = 5 -- 2^2=25
		
		if eff_range >= dist then
			return effective_range_acc
		else
			local modify_0, modify_1, modify_2
			local x = dist - eff_range
			
			modify_0 = k0
			modify_1 = MulDivRound(k1, x, eff_range)
			modify_2 = MulDivRound(k2, x, eff_range) * MulDivRound(k2, x, eff_range)
			
			local modify = MulDivRound(modify_0 + modify_1 + modify_2, factor, 100)
			return (effective_range_acc - modify)
		end
	end
	-- # Modification end
end

--TE Grenade MaxAimRange
function Grenade:GetMaxAimRange(unit)
	local str = IsKindOf(unit, "Unit") and unit.Strength or 100
	local range = MulDivRound(self.BaseRange, Max(0, 100 - str), 100) + MulDivRound(self.ThrowMaxRange, Min(100, str), 100)
	return Min(16, range)
end

--TE GetAutofireShots
function FirearmBase:GetAutofireShots(action)
	if type(action) == "string" then
		action = CombatActions[action]
	end
	local shots = action:ResolveValue("num_shots") or 1
	local shotsBoost = GetComponentEffectValue(self, "ExtraBurstShots", action.id)
	if shotsBoost then
		shots = shots + shotsBoost
	end 
	
    -- # Modification begin
    if IsKindOf(self, "AssaultRifle") then
        if action.id == "AutoFire" then
            shots = 10
        end
    end

    if IsKindOf(self, "SubmachineGun") then
        if action.id == "BurstFire" then
            shots = shots + 2
        end
        if action.id == "AutoFire" then
            shots = 10
        end
    end

    if IsKindOf(self, "M41Shotgun") then
        if action.id == "BuckshotBurst" then
            shots = 2
        end
    end
	
    if IsKindOfClasses(self, "Pistol", "Revolver") and not IsKindOf(self, "Glock18") and not IsKindOf(self, "MoW_Pistol_G17") and not IsKindOf(self, "MoW_Pistol_APS") then
        if action.id == "BurstFire" then
            shots = 2
        end
    end
	
    if IsKindOf(self, "Glock18") or IsKindOf(self, "MoW_Pistol_G17") or IsKindOf(self, "MoW_Pistol_APS") then
        if action.id == "BurstFire" then
            shots = shots + 1
        end
        if action.id == "AutoFire" then
            shots = 10
        end
    end
    -- # Modification end
	
	return shots
end

--TE Prop_DamageAndStatusEffects
function BaseWeapon:PrecalcDamageAndStatusEffects(attacker, target, attack_pos, damage, hit, effect, attack_args, record_breakdown, action, prediction)
	if IsKindOf(target, "Unit") then
		local effects = EffectsTable(effect)
		local ignoreGrazing = IsFullyAimedAttack(attack_args) and self:HasComponent("IgnoreGrazingHitsWhenFullyAimed")
--		local ignore_cover = (hit.aoe or hit.melee_attack or ignoreGrazing) and 100 or self.IgnoreCoverReduction
		local ignore_cover = (hit.aoe or hit.melee_attack) and 100 or self.IgnoreCoverReduction -- hit.grazing_reason = "cover" will invalid ThermalScope!
		
		-- grazing hits
		local chance = 0
		local base_chance = 0
		-- cover effect based on attack_pos
		if target:IsAware() and not target:HasStatusEffect("Exposed") and (not ignore_cover or ignore_cover <= 0) then
			local cover, any, coverage = target:GetCoverPercentage(attack_pos)
			base_chance = 50 -- const.Combat.GrazingChanceInCover = 50
			if target:HasStatusEffect("Protected") or target:HasStatusEffect("LightningReaction") or target:HasStatusEffect("LightningReactionNPC") or target:HasStatusEffect("TacticalBOW") then
				base_chance = 100 -- Protected || LightningReaction || B.O.W. in cover always hit.grazing = true!
			else
				base_chance = Min(75, MulDivRound(target.Agility - attacker.Dexterity, 250, 100)) -- [Agility - Dexterity] difference cover grazing_reason
			end
			chance = InterpolateCoverEffect(coverage, base_chance, 0)
			hit.grazing_reason = "cover"
		end

		if not ignoreGrazing and not hit.aoe then
			if target:IsConcealedFrom(attack_pos or attacker) then
				chance = chance + 33 -- const.EnvEffects.FogGrazeChance = 33
				hit.grazing_reason = "fog"
			end
			if target:IsObscuredFrom(attack_pos or attacker) then
				chance = chance + 33 -- const.EnvEffects.DustStormGrazeChance = 33
				hit.grazing_reason = "duststorm"
			end
		end		
		
		if not prediction then
			local grazing_roll = target:Random(100)
			if grazing_roll < chance then
				hit.grazing = true
			else
				hit.grazing_reason = false
			end
		elseif chance ~= 0 then
			hit.grazing = true
		end
		-- grazing hits (from cover and gas) cant crit
		if hit.grazing then
			hit.critical = nil
		end
		-- [SingularPurpose] "SniperRifle" IsFullyAimedAttack always ignore_armor!
		local ignore_armor = hit.aoe or IsKindOf(self, "MeleeWeapon") or (attacker and attacker.team.player_enemy and (attacker:IsPointBlankRange(target) or IsKindOfClasses(self, "SniperRifle", "SubmachineGun", "Shotgun", "Pistol", "Revolver"))) or (IsFullyAimedAttack(attack_args) and attacker:HasStatusEffect("SingularPurpose") and IsKindOf(self, "SniperRifle")) or attacker:HasStatusEffect("TestEffects")
		-- Order/method of damage buff calculations might need a revision. The are quite a few now and they seem to be added arbitrary.
		if not hit.stray or hit.aoe then
			local data = {
				breakdown = record_breakdown or {},
				effects = {},
				base_damage = damage,
				damage_add = 0,
				damage_percent = 100,
				ignore_armor = false,
				ignore_body_part_damage = {},
				action_id = action and action.id,	
				weapon = self,
				prediction = prediction,
				critical = hit.critical,
				critical_damage = const.Weapons.CriticalDamage,
			}
			local mod_attack_args = attack_args or {}
			local mod_hit_data = hit or {}
			local action_id = action and action.id
			Msg("GatherDamageModifications", attacker, target, action_id, self, mod_attack_args, mod_hit_data, data) -- only called for non-stray hits (no misses)
			if IsKindOf(attacker, "Unit") then
				attacker:CallReactions("OnCalcDamageAndEffects", attacker, target, action, self, mod_attack_args, mod_hit_data, data)
			end
			if IsKindOf(target, "Unit") then
				target:CallReactions("OnCalcDamageAndEffects", attacker, target, action, self, mod_attack_args, mod_hit_data, data)
			end
			damage = Max(0, MulDivRound(data.base_damage + data.damage_add, data.damage_percent, 100))
			if data.critical then
				damage = Max(0, MulDivRound(damage, 100 + data.critical_damage, 100))
			end
			hit.critical = data.critical
			for _, effect in ipairs(data.effects) do
				EffectTableAdd(effects, effect)
			end
			ignore_armor = ignore_armor or data.ignore_armor
							
			local part_def = hit.spot_group and Presets.TargetBodyPart.Default[hit.spot_group]
			if part_def then
				if not data.ignore_body_part_damage[part_def.id] then
					damage = MulDivRound(damage, 100 + part_def.damage_mod, 100)
					if record_breakdown then record_breakdown[#record_breakdown + 1] = { name = part_def.display_name, value = part_def.damage_mod } end
				end
				EffectTableAdd(effects, part_def.applied_effect)
			end
			
		else
			damage = MulDivRound(damage, 50, 100)
		end
	
		hit.damage = damage
		target:ApplyHitDamageReduction(hit, self, hit.spot_group or g_DefaultShotBodyPart, nil, ignore_armor, record_breakdown)
		if hit.grazing then
			hit.effects = {}
			hit.damage = Max(1, MulDivRound(hit.damage, const.Combat.GrazingHitDamage, 100))
		else
			hit.effects = effects
		end
	else
		--apply dmg mod for non units
		local obj_dmg_mod = (not hit.ignore_obj_damage_mod and self:HasMember("ObjDamageMod")) and self.ObjDamageMod or 100
		if obj_dmg_mod ~= 100 then
			damage = MulDivRound(damage, obj_dmg_mod, 100)
			if record_breakdown then record_breakdown[#record_breakdown + 1] = { name = T{360767699237, "<em><DisplayName></em> damage modifier to objects", self}, value = obj_dmg_mod } end
		end
		if HasPerk(attacker, "CollateralDamage") and IsKindOfClasses(self, "HeavyWeapon", "MachineGun") then
			local collateralDamage = CharacterEffectDefs.CollateralDamage
			local damageBonus = collateralDamage:ResolveValue("objectDamageMod")
			damage = MulDivRound(damage, 100 + damageBonus, 100)
			if record_breakdown then record_breakdown[#record_breakdown + 1] = { name = collateralDamage.DisplayName, value = damageBonus } end
		end
		--apply armor for non units
		local pen_class = self:HasMember("PenetrationClass") and self.PenetrationClass or #PenetrationClassIds
		local armor_class = target and target.armor_class or 1
		if pen_class >= armor_class then
			hit.damage = damage or 0
			hit.armor_prevented = 0
		else
			hit.damage = 0
			hit.armor_prevented = damage or 0
		end
		if record_breakdown then 
			if hit.damage > 0 then
				record_breakdown[#record_breakdown + 1] = { name = T(478438763504, "Armor (Pierced)") }
			else
				record_breakdown[#record_breakdown + 1] = { name = T(360312988514, "Armor"), value = -hit.armor_prevented }
			end
		end
	end
end

--TE Prop_HitChance
local function TE_AutoFire()
    -- Param
    --
    local max_dist = 15
	local base_penalty = -15
	local auto_max_penalty = -60
	local burst_max_penalty = -40
	local mg_burst_max_penalty = -60
	local mg_burst_max_held_penalty = -75
	local mg_burst_cumbersome_penalty = -25
	--
	local defs
	local para
	--
	defs = Presets.ChanceToHitModifier.Default["Autofire"]
	para = table.find_value(defs.Parameters, 'Name', 'max_dist')
	para.Value = max_dist
	para = table.find_value(defs.Parameters, 'Name', 'base_penalty')
	para.Value = base_penalty
	para = table.find_value(defs.Parameters, 'Name', 'auto_max_penalty')
	para.Value = auto_max_penalty
	para = table.find_value(defs.Parameters, 'Name', 'burst_max_penalty')
	para.Value = burst_max_penalty
	para = table.find_value(defs.Parameters, 'Name', 'mg_burst_max_penalty')
	para.Value = mg_burst_max_penalty
	para = table.find_value(defs.Parameters, 'Name', 'mg_burst_max_held_penalty')
	para.Value = mg_burst_max_held_penalty
	para = table.find_value(defs.Parameters, 'Name', 'mg_burst_cumbersome_penalty')
	para.Value = mg_burst_cumbersome_penalty
	defs:PostLoad()

    -- Function
	local maxAutoPenalty = -100
	local strength_scale = 80
	local strength_min = 70
	local grip_bonus = 30
    Presets.ChanceToHitModifier.Default["Autofire"].CalcValue = function (self, attacker, target, body_part_def, action, weapon1, weapon2, lof, aim, opportunity_attack, attacker_pos, target_pos)
		if not attacker or not target then 
			return false, 0
		end
		
		local param
		local metaText = {}
		
		local extra = 0
		if action.id == "BurstFire" then
			param = "burst_max_penalty"
		elseif action.id == "BuckshotBurst" then
			param = "burst_max_penalty"
		elseif action.id == "AutoFire" then
			param = "auto_max_penalty"
		elseif action.id == "MGBurstFire" then
			if (attacker and attacker.team.player_enemy) or ((g_Overwatch[attacker] and g_Overwatch[attacker].permanent) or attacker:HasStatusEffect("GrizzlyPerk")) then
				if attacker:HasStatusEffect("GrizzlyPerk") then
					metaText[#metaText + 1] = GrizzlyPerk.DisplayName
				end
				param = "mg_burst_max_penalty"
			else
				param = "mg_burst_max_held_penalty"
				if weapon1 and weapon1:IsCumbersome() then
					extra = self:ResolveValue("mg_burst_cumbersome_penalty")
				end
			end
		elseif action.id == "GrizzlyPerk" then
			param = "mg_burst_max_penalty"
			metaText[#metaText + 1] = GrizzlyPerk.DisplayName
		else
			return false, 0
		end
		
		local penalty = self:ResolveValue("base_penalty")
		local pb_dist = const.Weapons.PointBlankRange * const.SlabSizeX
		local dist = attacker_pos:Dist(target_pos)
		
		if dist > pb_dist then
			-- scale in the distance after point-blank range to max penalty
			local max_dist = self:ResolveValue("max_dist") * const.SlabSizeX		
			local max_penalty = self:ResolveValue(param) + extra
			
			dist = Min(dist, max_dist) - pb_dist
			max_dist = max_dist - pb_dist
			penalty = penalty + Min(-1, MulDivRound(dist, max_penalty - penalty, max_dist))
		end
		
        -- # Modification begin
		local compDef
        _, compDef = GetComponentEffectValue(weapon1, "CombatMod_ReduceAutoPenalty")
        if compDef then
            penalty = penalty - self:ResolveValue("base_penalty")
            metaText[#metaText + 1] = compDef.DisplayName
        end

		local isDeployed = false
		if action.id == "MGBurstFire" or action.id == "GrizzlyPerk" then
			if (g_Overwatch[attacker] and g_Overwatch[attacker].permanent) or attacker:HasStatusEffect("GrizzlyPerk") then
				isDeployed = true
			end
		end

		if isDeployed == false then
			_, compDef = GetComponentEffectValue(weapon1, "CombatMod_IncreaseAutoPenalty")
			if compDef then
				penalty = penalty + self:ResolveValue("base_penalty")
				metaText[#metaText + 1] = compDef.DisplayName
			end

			if weapon1.Caliber == "9mm" or weapon1.Caliber == "9x18" or weapon1.Caliber == "9x39" or weapon1.Caliber == "22LR" or weapon1.Caliber == "30-60" or weapon1.Caliber == "32ACP" or weapon1.Caliber == "32HRMAG" or weapon1.Caliber == "357MAG" or weapon1.Caliber == "38SP" or weapon1.Caliber == "380ACP" or weapon1.Caliber == "40SW" or weapon1.Caliber == "44AMP" or weapon1.Caliber == "44CAL" or weapon1.Caliber == "44MAG" or weapon1.Caliber == "45ACP" or weapon1.Caliber == "4_6x30" or weapon1.Caliber == "4_7x33" or weapon1.Caliber == "7_62x25" or weapon1.Caliber == "7_65x21" or weapon1.Caliber == "50AE" or weapon1.Caliber == "PistolAmmo" or weapon1.Caliber == "ExoticAmmo" then
				if (attacker and attacker.team.player_enemy) or attacker:HasStatusEffect("TakeAim") then
					penalty = MulDivRound(penalty, 115, 100) -- 15%
					metaText[#metaText + 1] = T(30072476860009, "Perk: Recoil Management")
				else
					penalty = MulDivRound(penalty, 125, 100) -- 25%
				end
				metaText[#metaText + 1] = T(30072476860000, "Caliber Penalty")
			end
			if weapon1.Caliber == "12gauge" then
				if (attacker and attacker.team.player_enemy) or attacker:HasStatusEffect("TakeAim") then
					penalty = MulDivRound(penalty, 125, 100) -- 25%
					metaText[#metaText + 1] = T(30072476860009, "Perk: Recoil Management")
				else
					penalty = MulDivRound(penalty, 150, 100) -- 50%
				end
				metaText[#metaText + 1] = T(30072476860000, "Caliber Penalty")
			end
			if weapon1.Caliber == "556" or weapon1.Caliber == "5_45x39" or weapon1.Caliber == "5_7x28" or weapon1.Caliber == "58CHN" or weapon1.Caliber == "6_5Creedmoor" or weapon1.Caliber == "6_5Grendel" or weapon1.Caliber == "300Blackout" or weapon1.Caliber == "NATOIntmAmmo" then
				if (attacker and attacker.team.player_enemy) or attacker:HasStatusEffect("TakeAim") then
					penalty = MulDivRound(penalty, 150, 100) -- 50%
					metaText[#metaText + 1] = T(30072476860009, "Perk: Recoil Management")
				else
					penalty = MulDivRound(penalty, 175, 100) -- 75%
				end
				metaText[#metaText + 1] = T(30072476860000, "Caliber Penalty")
			end
			if weapon1.Caliber == "762WP" or weapon1.Caliber == "WPammo" then
				if (attacker and attacker.team.player_enemy) or attacker:HasStatusEffect("TakeAim") then
					penalty = MulDivRound(penalty, 175, 100) -- 75%
					metaText[#metaText + 1] = T(30072476860009, "Perk: Recoil Management")
				else
					penalty = MulDivRound(penalty, 200, 100) -- 100%
				end
				metaText[#metaText + 1] = T(30072476860000, "Caliber Penalty")
			end
			if weapon1.Caliber == "762NATO" or weapon1.Caliber == "7_5x54" or weapon1.Caliber == "7_62x54R" or weapon1.Caliber == "7_92x33" or weapon1.Caliber == "7_92x57" or weapon1.Caliber == "280" or weapon1.Caliber == "303" or weapon1.Caliber == "300WinMag" or weapon1.Caliber == "308Win" or weapon1.Caliber == "338_Lapua_Magnum" or weapon1.Caliber == "408_ChayTac" or weapon1.Caliber == "86CHN" or weapon1.Caliber == "NATORifleAmmo" then
				if (attacker and attacker.team.player_enemy) or attacker:HasStatusEffect("TakeAim") then
					penalty = MulDivRound(penalty, 200, 100) -- 100%
					metaText[#metaText + 1] = T(30072476860009, "Perk: Recoil Management")
				else
					penalty = MulDivRound(penalty, 225, 100) -- 125%
				end
				metaText[#metaText + 1] = T(30072476860000, "Caliber Penalty")
			end
			if weapon1.Caliber == "50BMG" or weapon1.Caliber == "20x82" then
				if (attacker and attacker.team.player_enemy) or attacker:HasStatusEffect("TakeAim") then
					penalty = MulDivRound(penalty, 225, 100) -- 125%
					metaText[#metaText + 1] = T(30072476860009, "Perk: Recoil Management")
				else
					penalty = MulDivRound(penalty, 250, 100) -- 150%
				end
				metaText[#metaText + 1] = T(30072476860000, "Caliber Penalty")
			end
		end

		local strength = attacker.Strength
		_, compDef = GetComponentEffectValue(weapon1, "CombatMod_AutoStrength")
		if compDef then
			strength = strength + grip_bonus
			metaText[#metaText + 1] = compDef.DisplayName
		end
		penalty = penalty + MulDivRound(Max(0, strength - strength_min), strength_scale, 100)
		if penalty >= 0 then
			return false, 0
		end

		penalty = Max(penalty, maxAutoPenalty)
		
		if action.id == "BurstFire" then
			return true, penalty, T(913932180355, "Burst Fire"), #metaText ~= 0 and metaText
		end
		if action.id == "BuckshotBurst" then
			return true, penalty, T(913932180355, "Burst Fire"), #metaText ~= 0 and metaText
		end
		-- # Modification end
		
		return true, penalty, false, #metaText ~= 0 and metaText
	end
end

--TE Prop_AutoFireSuppression
local function TE_AutoFireSuppression()
    Presets.CombatAction.WeaponAttacks["AutoFire"].GetActionResults = function (self, unit, args)
		local args = table.copy(args)
		args.applied_status = { "Suppressed", "SuppressionShocked", "SuppressionChangeStance" }
		args.weapon = args.weapon or self:GetAttackWeapons(unit, args)
		args.num_shots = args.num_shots or args.weapon and args.weapon:GetAutofireShots(self)
		args.multishot = true
		args.damage_bonus = self:ResolveValue("dmg_penalty")
		local attack_args = unit:PrepareAttackArgs(self.id, args)
		local results = attack_args.weapon:GetAttackResults(self, attack_args)
		local target = attack_args.target
		if not results.obstructed and not attack_args.stuck and IsKindOf(target, "Unit") and IsValidTarget(target) then
			local target_dist = unit:GetDist(target)
			local weapon = attack_args.weapon
			if target_dist <= weapon.WeaponRange * const.SlabSizeX * 2 then
				results.extra_packets = results.extra_packets or {}
				table.insert(results.extra_packets, {target = target, effects = { "Suppressed", "SuppressionShocked", "SuppressionChangeStance" }})
			end
		end
		return results, attack_args
	end
end

--TE Prop_MGFireSuppression
local function TE_MGFireSuppression()
    Presets.CombatAction.WeaponAttacks["MGBurstFire"].GetActionResults = function (self, unit, args)
		local args = table.copy(args)
		args.applied_status = { "Suppressed", "SuppressionShocked", "SuppressionChangeStance" }
		args.weapon = args.weapon or self:GetAttackWeapons(unit, args)
		args.num_shots = args.num_shots or args.weapon and args.weapon:GetAutofireShots(self)
		args.multishot = true
		args.damage_bonus = self:ResolveValue("dmg_penalty")
		local attack_args = unit:PrepareAttackArgs(self.id, args)
		local results = attack_args.weapon:GetAttackResults(self, attack_args)
		local target = attack_args.target
		if not results.obstructed and not attack_args.stuck and IsKindOf(target, "Unit") and IsValidTarget(target) then
			local target_dist = unit:GetDist(target)
			local weapon = attack_args.weapon
			if target_dist <= weapon.WeaponRange * const.SlabSizeX * 2 then
				results.extra_packets = results.extra_packets or {}
				table.insert(results.extra_packets, {target = target, effects = { "Suppressed", "SuppressionShocked", "SuppressionChangeStance" }})
			end
		end
		return results, attack_args
	end
end

--TE Prop_OverwatchAttack GetAimParams
local function TE_OverwatchAimParams()
    Presets.CombatAction.Default["Overwatch"].GetAimParams = function (self, unit, weapon)
		local params = weapon:GetAreaAttackParams(self.id, unit)
		params.cone_angle = weapon.OverwatchAngle
		params.min_range = self:GetMinAimRange(unit, weapon)
		params.max_range = self:GetMaxAimRange(unit, weapon)
		if unit and unit.team.player_team or unit:IsLocalPlayerControlled() or unit:IsMerc() or IsMerc(unit) then
			local items = unit:GetHandheldItems()
			for _, item in ipairs(items) do
				if IsKindOf(item, "TE_Binoculars") and (unit:GetActiveWeapons("AssaultRifle") or unit:GetActiveWeapons("SniperRifle")) then
					params.cone_angle = 15 * 60
				end
			end
		end
		if unit and unit.team.player_enemy and not unit:GetActiveWeapons("Shotgun") then
			if (CurrentModOptions["Tactical_Hardcore"] == "<GameTerm('TE_DEAD_ON_ARRIVAL')>" or CurrentModOptions["Hell_Gate"] == "<GameTerm('TE_NIGHTMARE_A')>" or CurrentModOptions["Hell_Gate"] == "<GameTerm('TE_NIGHTMARE_B')>") and (unit:GetActiveWeapons("SniperRifle") or unit:HasStatusEffect("TacticalBOW")) then
				params.cone_angle = 120 * 60
			else
				params.cone_angle = 60 * 60
			end
		end
		assert(params.max_range >= params.min_range)
		return params
	end
end

--TE Prop_OverwatchAttack GetMaxAimRange
local function TE_OverwatchMaxAimRange()
    Presets.CombatAction.Default["Overwatch"].GetMaxAimRange = function (self, unit, weapon)
		local range = not CurrentModOptions["Gunfight_Rework"] and IsKindOfClasses(weapon, "SniperRifle", "AssaultRifle", "MachineGun") and weapon.WeaponRange * 2 or weapon:GetOverwatchConeParam("MaxRange")
		local sight = unit:GetSightRadius() / const.SlabSizeX
		return Min(range, sight)
	end
end

--TE Prop_OverwatchAttack GetAPCost
local function TE_OverwatchAttackAP()
    Presets.CombatAction.Default["Overwatch"].GetAPCost = function (self, unit, args)
		if args and args.action_cost_only then
			return self.ActionPoints + 2 * const.Scale.AP
		end
		local weapon = self:GetAttackWeapons(unit, args)
		if not weapon or (weapon.PreparedAttackType ~= "Overwatch" and weapon.PreparedAttackType ~= "Both")then return -1 end
		local attack = unit:GetDefaultAttackAction("ranged", "ungrouped")
		local atk_cost = attack:GetAPCost(unit, args) + self.ActionPoints + 2 * const.Scale.AP
		return Max(unit:GetUIActionPoints(), atk_cost), atk_cost
	end
end

--TE Prop_ShotgunBuckshotBurst GetAPCost
local function TE_BuckshotBurstAP()
    Presets.CombatAction.WeaponAttacks["BuckshotBurst"].GetAPCost = function (self, unit, args)
		if self.CostBasedOnWeapon then
			local weapon = self:GetAttackWeapons(unit, args)	
			return weapon and (unit:GetAttackAPCost(self, weapon, nil, args and args.aim or 0) + self.ActionPointDelta) or -1
		end
		return self.ActionPoints
	end
end

--TE Prop_GrenadeLauncherFire GetAPCost
local function TE_GrenadeLauncherFireAP()
    Presets.CombatAction.WeaponAttacks["GrenadeLauncherFire"].GetAPCost = function (self, unit, args)
		return 9000
	end
end

--TE Prop_RocketLauncherFire GetAPCost
local function TE_RocketLauncherFireAP()
    Presets.CombatAction.WeaponAttacks["RocketLauncherFire"].GetAPCost = function (self, unit, args)
		return 9000
	end
end

--TE Bombard shots
local function TE_BombardShots()
	-- Param
    --
	local ap_per_shot = 2 -- Default 3
	--
	local defs
	local para
	--
	defs = Presets.CombatAction.WeaponAttacks["Bombard"]
	para = table.find_value(defs.Parameters, 'Name', 'ap_per_shot')
	para.Value = ap_per_shot
	defs:PostLoad()
end

--TE Aim Overhaul
local function TE_Aim()
    -- Function
	--
	local maxAimBonus = 25
    Presets.ChanceToHitModifier.Default["Aim"].CalcValue = function (self, attacker, target, body_part_def, action, weapon1, weapon2, lof, aim, opportunity_attack, attacker_pos, target_pos)
		local num = aim
		local min_bonus = self:ResolveValue("MinBonus")
		local min_dex = self:ResolveValue("MinDex")
		local dex_scale = self:ResolveValue("DexScale")
		local dex = attacker.Dexterity
		
		if IsKindOfClasses(weapon1, "FirearmProperties", "MeleeWeaponProperties") then
			min_bonus = weapon1.AimAccuracy
		end
		
		local modifyVal, compDef
		local metaText = {}
		
		-- Light Stock
		modifyVal, compDef = GetComponentEffectValue(weapon1, "ReduceAimAccuracy", "cth_penalty")
		if modifyVal then
			min_bonus = Max(1, MulDivRound(min_bonus, 100 - modifyVal, 100))
			metaText[#metaText + 1] = compDef.DisplayName
		end
		
		local bonus = num * min_bonus + MulDivRound(Max(0, dex - min_dex) * num, dex_scale, 100)
		
		-- Target Camo
		if IsKindOf(target, "Unit") then
			local armor = target:GetItemInSlot("Torso", "Armor")
			if (armor and armor.Camouflage) or target:HasStatusEffect("Infiltrator") or target:HasStatusEffect("NaturalCamouflage") then
				bonus = MulDivRound(bonus, 75, 100) -- CamoAimPenalty = -25
				metaText[#metaText + 1] = T(396692757033, "Camouflaged - aiming is less effective")
			end
		end
		
		-- Forward Grip
		modifyVal, compDef = GetComponentEffectValue(weapon1, "FirstAimBonusModifier", "first_aim_bonus")
		if modifyVal then
			bonus = bonus + MulDivRound(min_bonus, modifyVal, 100)
			metaText[#metaText + 1] = compDef.DisplayName
		end
		
		-- Heavy Stock
		if IsFullyAimedAttack(num) then
			modifyVal, compDef = GetComponentEffectValue(weapon1, "BonusAccuracyWhenFullyAimed", "bonus_cth")
			if modifyVal then
				bonus = bonus + modifyVal
				metaText[#metaText + 1] = compDef.DisplayName
			end
		end
		
		-- Improved Sight
		modifyVal, compDef = GetComponentEffectValue(weapon1, "AccuracyBonusWhenAimed", "bonus_cth")
		if modifyVal then
			bonus = bonus + modifyVal
			metaText[#metaText + 1] = compDef.DisplayName
		end
		
        -- # Modification begin
		-- Thermal Scope
		_, compDef = GetComponentEffectValue(weapon1, "CombatMod_AimAccuracyLimit")
		if compDef then
			if (bonus > maxAimBonus) then
				bonus = maxAimBonus
				metaText[#metaText + 1] = compDef.DisplayName
			end
		end
        -- # Modification end
		
		return num > 0, bonus,  T{762331260877, "Aiming (x<aim_mod>)", aim_mod = num}, #metaText ~= 0 and metaText
	end
end

--TE StanceCover
local function TE_StanceCover()
    -- Param
    --
    local Cover = -45 -- Default -20
	local ExposedCover = -5 -- Default -5
	local CrouchPenalty = -5 -- Default -5
	local PronePenalty = -15 -- Default -10
	--
	local defs
	local para
	--
	defs = Presets.ChanceToHitModifier.Default["RangeAttackTargetStanceCover"]
	para = table.find_value(defs.Parameters, 'Name', 'Cover')
	para.Value = Cover
	para = table.find_value(defs.Parameters, 'Name', 'ExposedCover')
	para.Value = ExposedCover
	para = table.find_value(defs.Parameters, 'Name', 'CrouchPenalty')
	para.Value = CrouchPenalty
	para = table.find_value(defs.Parameters, 'Name', 'PronePenalty')
	para.Value = PronePenalty
	defs:PostLoad()
end

--TE RangeAttackTargetStanceCover penalty
local function TE_TargetStanceCover()
	-- Function
	--
	Presets.ChanceToHitModifier.Default["RangeAttackTargetStanceCover"].CalcValue = function (self, attacker, target, body_part_def, action, weapon1, weapon2, lof, aim, opportunity_attack, attacker_pos, target_pos)
		if opportunity_attack or not IsKindOf(weapon1, "Firearm") or not IsKindOf(target, "Unit") then 
			return false, 0 
		end
		local target_stance = target:GetHitStance()
		if target_stance == "Prone" then
			local value = self:ResolveValue("PronePenalty") 
			return true, value, T(904752344471, "Target Prone")
		end
		
		local cover, any, coverage
		if weapon1 then
			local ignoreCth = weapon1:HasComponent("IgnoreCoverCtHWhenFullyAimed") and IsFullyAimedAttack(aim) and not target:HasStatusEffect("Hotblood") and not target:HasStatusEffect("TacticalBOW") -- Hotblood || B.O.W. will invalid IgnoreCoverCtHWhenFullyAimed!
			if not ignoreCth and (opportunity_attack or target:IsAware()) and not target:HasStatusEffect("Exposed") then
				cover, any, coverage = target:GetCoverPercentage(attacker_pos, target_pos)
			end
		end
		
		-- force exposed when aiming/shooting
		local melee_attack = action and action.ActionType == "Melee Attack"
		cover = not target.aim_action_id and not melee_attack and cover
		
		if cover then
			local name = false
			local exposed_value = self:ResolveValue("ExposedCover")
			local full_value = self:ResolveValue("Cover")
			
			if CheckSightCondition(attacker, target, const.usObscured) then
				exposed_value = exposed_value + const.EnvEffects.DustStormCoverCTHPenalty
				full_value = full_value + const.EnvEffects.DustStormCoverCTHPenalty
				name = T(548829641491, "Behind Cover (Dust Storm)")
			end
			
			local value = InterpolateCoverEffect(coverage, full_value, exposed_value)
			local metaText = false
		
			if value < exposed_value then
				return true, value, name, metaText, "Cover"
			end
		end
		if target_stance == "Crouch" then
			local value = self:ResolveValue("CrouchPenalty")
			return true, value, T(309253003316, "Target Crouched")
		end
		return false, 0
	end
end

--TE TargetedShot void
local function TE_TargetedShot()
	-- Param
    --
	local pistol_effect = 100 -- Default 66
	--
	local defs
	local para
	--
	defs = Presets.ChanceToHitModifier.Default["TargetedShot"]
	para = table.find_value(defs.Parameters, 'Name', 'pistol_effect')
	para.Value = pistol_effect
	defs:PostLoad()
end

--TE PointBlank bonus
local function TE_PointBlank()
	-- Param
    --
	local bonus = 50 -- Default 15
	--
	local defs
	local para
	--
	defs = Presets.ChanceToHitModifier.Default["PointBlank"]
	para = table.find_value(defs.Parameters, 'Name', 'bonus')
	para.Value = bonus
	defs:PostLoad()
end

--TE BipodProne bonus
local function TE_BipodProne()
	-- Param
    --
	local bonus_cth = 25 -- Default 20
	--
	local defs
	local para
	--
	defs = Presets.WeaponComponentEffect.ChanceToHit["AccuracyBonusProne"]
	para = table.find_value(defs.Parameters, 'Name', 'bonus_cth')
	para.Value = bonus_cth
	defs:PostLoad()
end

--TE BipodHeld penalty
local function TE_BipodHeld()
	-- Function
	--
	local para_bipodPenalty = -15
	Presets.ChanceToHitModifier.Default["Bipod"].CalcValue = function (self, attacker, target, body_part_def, action, weapon1, weapon2, lof, aim, opportunity_attack, attacker_pos, target_pos)
		
		-- # Modification begin
		if attacker.stance ~= "Prone" or not weapon1 then
			if IsFullyAimedAttack(aim) then
				return false, 0
			else
				local _, compDef = GetComponentEffectValue(weapon1, "CombatMod_BipodPenalty")
				if compDef then
					local value = para_bipodPenalty
					return not not value, value
				end
			end
			return false, 0
		end
		-- # Modification end

		local value = GetComponentEffectValue(weapon1, "AccuracyBonusProne", "bonus_cth")
		return not not value, value
	end
end

--TE SeenBySpotter penalty
local function TE_SeenBySpotter()
	-- Param
    --
	local SpotterPenalty = -25 -- Default -20
	local BlindFirePenalty = -75 -- Default -20
	--
	local defs
	local para
	--
	defs = Presets.ChanceToHitModifier.Default["SeenBySpotter"]
	para = table.find_value(defs.Parameters, 'Name', 'SpotterPenalty')
	para.Value = SpotterPenalty
	para = table.find_value(defs.Parameters, 'Name', 'BlindFirePenalty')
	para.Value = BlindFirePenalty
	defs:PostLoad()
end

--TE Defs_BodyPart & Lethal Headshot!
local function checkID(id)
    if not Presets.TargetBodyPart.Default[id] then
        return false
    end
    return true
end

local function TE_BodyPart(id, dmgMod, hitMod, effect, text)
    if checkID(id) == false then
        return
    end
    
    local part = Presets.TargetBodyPart.Default[id]

    part.damage_mod       = dmgMod
    part.tohit_mod        = hitMod
    part.applied_effect   = effect
    
    if text then
        part.description  = text
    end
end

local text_Head     = T(30072476861001, "Head attack: significantly lower hit chance and massive damage; inflicts <em>Blinded</em>")
local text_Neck     = T(30072476861002, "Neck attack: significantly lower hit chance and massive damage; inflicts <em>Bleeding</em>")
local text_Torso    = nil
local text_Groin    = T(30072476861003, "Groin attack: lower hit chance and increased damage")
local text_Legs     = nil
local text_Arms     = nil

local function TE_Body()
    --          BodyPart     dmgMod,  hitMod,  effect,        text
    TE_BodyPart("Head",      150,     -50,     "Blinded",     text_Head)
    TE_BodyPart("Neck",      150,     -50,     "Bleeding",    text_Neck)
    TE_BodyPart("Torso",       0,       0,     nil,           text_Torso)
    TE_BodyPart("Groin",      50,     -25,     nil,           text_Groin)
    TE_BodyPart("Legs",      -50,     -25,     "Slowed",      text_Legs)
    TE_BodyPart("Arms",      -50,     -25,     "Inaccurate",  text_Arms)
end

--TE levelDiff void
local function TE_Level()
	-- Param
    --
	local levelDiff = 100 -- Default 2
	--
	local defs
	local para
	--
	defs = Presets.ChanceToHitModifier.Default["TrainingAdvantage"]
	para = table.find_value(defs.Parameters, 'Name', 'levelDiff')
	para.Value = levelDiff
	defs:PostLoad()
	--
	defs = Presets.ChanceToHitModifier.Default["TrainingDisadvantage"]
	para = table.find_value(defs.Parameters, 'Name', 'levelDiff')
	para.Value = levelDiff
	defs:PostLoad()
end

--TE Bandage Medicine
local function TE_BandageMedicine()
	-- Param
    --
    local selfheal = 90 -- Default 70
	local base_heal = 40 -- Default 20
	local medical_max_heal = 60 -- Default 30
	local ReviveConditionLoss = 80 -- Default 10
	local MaxConditionHPRestore = 125 -- Default 120
	--
	local defs
	local para
	--
	defs = Presets.CombatAction.Consumables["Bandage"]
	para = table.find_value(defs.Parameters, 'Name', 'selfheal')
	para.Value = selfheal
	para = table.find_value(defs.Parameters, 'Name', 'base_heal')
	para.Value = base_heal
	para = table.find_value(defs.Parameters, 'Name', 'medical_max_heal')
	para.Value = medical_max_heal
	para = table.find_value(defs.Parameters, 'Name', 'ReviveConditionLoss')
	para.Value = ReviveConditionLoss
	para = table.find_value(defs.Parameters, 'Name', 'MaxConditionHPRestore')
	para.Value = MaxConditionHPRestore
	defs:PostLoad()
end

-- ========== TE GunFightRework Remastered End ==========


-- ========== TE ObjMaterial Solid Cover Begin ==========

function OnMsg.DataLoaded()
-- ========== GENERATED BY ObjMaterial Editor DO NOT EDIT MANUALLY! ==========

PlaceObj('ObjMaterial', {
	SortKey = 4,
	armor_class = 5,
	destruction_propagation_strength = 10,
	id = "Brick_Inv",
	invulnerable = true,
	max_hp = 1500,
	noise_on_hit = 2,
})

PlaceObj('ObjMaterial', {
	SortKey = 4,
	armor_class = 5,
	breakdown_defense = 0,
	destruction_propagation_strength = 10,
	id = "Brick",
	max_hp = 1500,
	noise_on_break = 15,
	noise_on_hit = 2,
})

PlaceObj('ObjMaterial', {
	SortKey = 4,
	armor_class = 5,
	breakdown_defense = 0,
	destruction_propagation_strength = 10,
	id = "Brick_Solid",
	max_hp = 1500,
	noise_on_break = 15,
	noise_on_hit = 2,
})

PlaceObj('ObjMaterial', {
	SortKey = 11,
	armor_class = 5,
	breakdown_defense = 0,
	destruction_propagation_strength = 10,
	id = "ClayBrick",
	max_hp = 1500,
})

PlaceObj('ObjMaterial', {
	SortKey = 6,
	armor_class = 5,
	destruction_propagation_strength = 10,
	id = "Metal_Inv_Imp",
	impenetrable = true,
	invulnerable = true,
	max_hp = 2500,
})

PlaceObj('ObjMaterial', {
	SortKey = 6,
	armor_class = 5,
	destruction_propagation_strength = 10,
	id = "Metal_Inv_Penetrable",
	invulnerable = true,
	max_hp = 2500,
})

PlaceObj('ObjMaterial', {
	SortKey = 6,
	armor_class = 5,
	breakdown_defense = 0,
	destruction_propagation_strength = 10,
	id = "Metal_Solid",
	max_hp = 2500,
})

PlaceObj('ObjMaterial', {
	SortKey = 6,
	armor_class = 5,
	breakdown_defense = 0,
	destruction_propagation_strength = 10,
	id = "Metal_Solid_Hard",
	max_hp = 2500,
})

PlaceObj('ObjMaterial', {
	SortKey = 3,
	armor_class = 3,
	breakdown_defense = 0,
	destruction_propagation_strength = 10,
	id = "Tin",
	max_hp = 500,
})

PlaceObj('ObjMaterial', {
	SortKey = 6,
	armor_class = 3,
	breakdown_defense = 0,
	destruction_propagation_strength = 10,
	id = "Wood",
	max_hp = 1000,
})

PlaceObj('ObjMaterial', {
	SortKey = 5,
	armor_class = 4,
	breakdown_defense = 0,
	destruction_propagation_strength = 10,
	id = "Planks",
	max_hp = 1200,
})

PlaceObj('ObjMaterial', {
	Comment = "INV",
	armor_class = 5,
	destruction_propagation_strength = 10,
	id = "Trees",
	invulnerable = true,
	max_hp = 2500,
})

PlaceObj('ObjMaterial', {
	SortKey = 7,
	armor_class = 5,
	destruction_propagation_strength = 10,
	id = "Logs",
	impenetrable = true,
	invulnerable = true,
	max_hp = 2500,
})

PlaceObj('ObjMaterial', {
	SortKey = 8,
	armor_class = 5,
	destruction_propagation_strength = 10,
	id = "Concrete",
	impenetrable = true,
	invulnerable = true,
	max_hp = 2500,
})

PlaceObj('ObjMaterial', {
	SortKey = 8,
	armor_class = 5,
	breakdown_defense = 0,
	destruction_propagation_strength = 10,
	id = "ConcreteThin",
	max_hp = 1500,
})

PlaceObj('ObjMaterial', {
	Comment = "INV",
	SortKey = 10,
	armor_class = 5,
	destruction_propagation_strength = 10,
	id = "Stone",
	impenetrable = true,
	invulnerable = true,
	max_hp = 2500,
})

PlaceObj('ObjMaterial', {
	Comment = "INV IMP",
	SortKey = 9,
	armor_class = 5,
	destruction_propagation_strength = 10,
	id = "Sandbag",
	impenetrable = true,
	invulnerable = true,
	max_hp = 2500,
})
end

-- ========== TE ObjMaterial Solid Cover End ==========


-- ========== GunFightRework ConstEdit Begin ==========

local function TE_GunFight_Logic()
	const.RequiredPerksForGold = 2 -- Default = 3
	const.XPQuestReward_Large = 2000 -- Default = 1000
	const.XPQuestReward_Medium = 1000 -- Default = 500
	const.XPQuestReward_Small = 600 -- Default = 300
	const.XPQuestReward_Minor = 300 -- Default = 150
	const.Weapons.UpgradeScrapParts = 4 -- Default = 2
	const.Combat.MGFreeInterruptAttacks = 2 -- Default = 1
	const.Combat.MaxGrit = 45 -- Default = 30
	const.Combat.GrazingChanceInCover = 50 -- Default = 40
	const.Combat.AwareSightRange = 70 -- Default = 24
	const.Combat.SightModMaxValue = 140 -- Default = 120
	const.Combat.SightModMinValue = 18 -- Default = 40
	const.Combat.CamoSightPenalty = 15 -- Default = 25
	const.Combat.CamoAimPenalty = 25 -- Default = 50
	const.Combat.GloryKillChance = 15 -- Default = 10
	const.Combat.HealAmountBase = 50 -- Default = 20
	const.Combat.SightModHiddenProne = 25 -- Default = 20 (Comment = "sight penalty (as % of base value) for seeing hidden units in prone stance")
	const.Combat.SightModStealthStatDiff = 0 -- Default = 50 (Comment = "what percentage of the stat difference (other.Dexterity - self.Dexterity) is applied as a sight modifier to units trying to see a Hidden unit")
	const.EnvEffects.SightHeightDiffMod = -5 -- Default = -15 (Comment = "sight penalty (as % of base value) for seeing units on higher ground")
	const.EnvEffects.BrushSightMod = -45 -- Default = -15
	const.EnvEffects.DarknessSightMod = -90 -- Default = -10
	const.EnvEffects.DarknessDetectionRate = -60 -- Default = -30
	const.EnvEffects.DarknessCTHPenalty = -40 -- Default = -20
	const.EnvEffects.DustStormCoverCTHPenalty = -15 -- Default = -5
	const.EnvEffects.DustStormGrazeChance = 33 -- Default = 25
	const.EnvEffects.DustStormMoveCostMod = 40 -- Default = 30
	const.EnvEffects.DustStormSightMod = -25 -- Default = -10
	const.EnvEffects.FireStormSightMod = -25 -- Default = -10
	const.EnvEffects.FogGrazeChance = 33 -- Default = 25
	const.EnvEffects.FogSightMod = -75 -- Default = -30
	const.EnvEffects.RainAimingMultiplier = 150 -- Default = 100
	const.EnvEffects.RainNoiseMod = -25 -- Default = -50
end

--TE Real Lethal Weapons
local function TE_Real_Lethal()
	const.Weapons.ShotgunCollateralDamage = 100 -- Default = 50
    const.Weapons.CriticalDamage = 75 --  Default = 50
    const.Combat.ArmorDegradePercent = 75 -- Default = 50
    const.Combat.AimCritBonus = 2 -- Default = 0
	const.Combat.AutofireAttribBonus = 50 -- Default = 0
	const.Combat.BuckshotAttribBonus = 100 -- Default = 50
	const.Combat.MeleeAttackProneMod = 100 -- Default = 20
	const.Combat.HeadshotStealthKillChanceMod = 15 -- Default = 10
	const.Combat.GrazingHitDamage = 15 -- Default = 33
end

--TE AutoPenalty void
local function TE_AutoPenalty()
    -- Param
	--
	local defs
	local para
	--
	defs = CombatActions.BurstFire
	para = table.find_value(defs.Parameters, 'Name', 'dmg_penalty')
	para.Value = 0
	defs:PostLoad()
    --
    defs = CombatActions.AutoFire
	para = table.find_value(defs.Parameters, 'Name', 'dmg_penalty')
	para.Value = 0
	defs:PostLoad()
        --
    defs = CombatActions.MGBurstFire
	para = table.find_value(defs.Parameters, 'Name', 'dmg_penalty')
	para.Value = 0
	defs:PostLoad()
end

-- ========== GunFightRework ConstEdit End ==========


--Tactician Enhanced GunFightRework Loaded
function OnMsg.ModsReloaded()
	-- Stock Data Overhaul
	if CurrentModOptions["Gunfight_Rework"] then
		TE_GunFight_Logic()
	end
	-- Real Lethal Weapons
	if CurrentModOptions["Real_Lethal"] then
		TE_Real_Lethal()
    	TE_AutoPenalty()
	end
	-- GunFightRework Fundamental Logic
	TE_Aim()
	TE_AutoFire()
	TE_BipodHeld()
	TE_BipodProne()
	TE_StanceCover()
	TE_TargetStanceCover()
	TE_TargetedShot()
	TE_PointBlank()
	TE_SeenBySpotter()
    TE_Body()
	TE_Level()
	TE_BandageMedicine()
	TE_AutoFireSuppression()
	TE_MGFireSuppression()
	TE_OverwatchAimParams()
	TE_OverwatchMaxAimRange()
	TE_OverwatchAttackAP()
	TE_BuckshotBurstAP()
	TE_GrenadeLauncherFireAP()
	TE_RocketLauncherFireAP()
	TE_BombardShots()
end
function OnMsg.DataLoaded()
	-- Stock Data Overhaul
	if CurrentModOptions["Gunfight_Rework"] then
		TE_GunFight_Logic()
	end
	-- Real Lethal Weapons
	if CurrentModOptions["Real_Lethal"] then
		TE_Real_Lethal()
    	TE_AutoPenalty()
	end
	-- GunFightRework Fundamental Logic
	TE_Aim()
	TE_AutoFire()
	TE_BipodHeld()
	TE_BipodProne()
	TE_StanceCover()
	TE_TargetStanceCover()
	TE_TargetedShot()
	TE_PointBlank()
	TE_SeenBySpotter()
    TE_Body()
	TE_Level()
	TE_BandageMedicine()
	TE_AutoFireSuppression()
	TE_MGFireSuppression()
	TE_OverwatchAimParams()
	TE_OverwatchMaxAimRange()
	TE_OverwatchAttackAP()
	TE_BuckshotBurstAP()
	TE_GrenadeLauncherFireAP()
	TE_RocketLauncherFireAP()
	TE_BombardShots()
end
function OnMsg.OptionsApply()
	-- Stock Data Overhaul
	if CurrentModOptions["Gunfight_Rework"] then
		TE_GunFight_Logic()
	end
	-- Real Lethal Weapons
	if CurrentModOptions["Real_Lethal"] then
		TE_Real_Lethal()
    	TE_AutoPenalty()
	end
	-- GunFightRework Fundamental Logic
	TE_Aim()
	TE_AutoFire()
	TE_BipodHeld()
	TE_BipodProne()
	TE_StanceCover()
	TE_TargetStanceCover()
	TE_TargetedShot()
	TE_PointBlank()
	TE_SeenBySpotter()
    TE_Body()
	TE_Level()
	TE_BandageMedicine()
	TE_AutoFireSuppression()
	TE_MGFireSuppression()
	TE_OverwatchAimParams()
	TE_OverwatchMaxAimRange()
	TE_OverwatchAttackAP()
	TE_BuckshotBurstAP()
	TE_GrenadeLauncherFireAP()
	TE_RocketLauncherFireAP()
	TE_BombardShots()
end