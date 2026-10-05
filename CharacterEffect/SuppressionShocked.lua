UndefineClass('SuppressionShocked')
DefineClass.SuppressionShocked = {
	__parents = { "StatusEffect" },
	__generated_by_class = "ModItemCharacterEffectCompositeDef",


	comment = "Tactical Suppression Fire (PINNED DOWN || COWERING)",
	object_class = "StatusEffect",
	unit_reactions = {
		PlaceObj('UnitReaction', {
			Event = "OnCheckForceMinSight",
			Handler = function (self, target, observer, other, step_pos, darkness)
				--TE COWERING [!MUST HAVE!] -- !!!Do NOT Change this one!!! (TE Core Logic)
				local effect = target:GetStatusEffect("SuppressionShocked") or target:GetStatusEffect("Wounded")
				if target == observer and effect.stacks >= 5 then
					return true -- sight range limited
				end
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnCalcMaxAimActions",
			Handler = function (self, target, value, attacker, attack_target, action, weapon)
				--TE PINNED DOWN [!MUST HAVE!] -- !!!Do NOT Change this one!!! (TE Core Logic)
				local effect = target:GetStatusEffect("SuppressionShocked") or target:GetStatusEffect("Wounded")
				if target == attacker and effect.stacks >= 3 then
					return value - 10 -- aim level limited
				end
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnCalcChanceToHit",
			Handler = function (self, target, attacker, action, attack_target, weapon1, weapon2, data)
				--TE SHOCK [!MUST HAVE!] -- !!!Do NOT Change this one!!! (TE Core Logic)
				local effect = target:GetStatusEffect("SuppressionShocked") or target:GetStatusEffect("Wounded")
				local cth_effect = self:ResolveValue("cth_effect")
				if target == attacker then
					ApplyCthModifier_Add(self, data, cth_effect * effect.stacks) -- cth effect limited
				end
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnCalcStartTurnAP",
			Handler = function (self, target, value)
				--TE Tactical Suppression Fire [!MUST HAVE!] -- !!!Do NOT Change this one!!! (TE Core Logic)
				local effect = target:GetStatusEffect("SuppressionShocked") or target:GetStatusEffect("Wounded")
				local ap_loss = self:ResolveValue("ap_loss")
				return value + (ap_loss * const.Scale.AP * effect.stacks) -- max ap limited
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnStatusEffectAdded",
			Handler = function (self, target, id, stacks)
				--TE Tactical Suppression Fire [!MUST HAVE!] -- !!!Do NOT Change this one!!! (TE Core Logic)
				local effect = target:GetStatusEffect("SuppressionShocked")
				if CharacterEffectDefs.SuppressionShocked then
					if not target:IsAware() or target:IsDead() or target:IsDowned() or target:HasStatusEffect("Suppressed") or target:HasStatusEffect("Protected") or target:HasStatusEffect("Panicked") or target:HasStatusEffect("Unconscious") or target:HasStatusEffect("ZombiePerk") or target:HasStatusEffect("TacticalBOW") then return end
					
					if target.stance ~= "Prone" and effect.stacks >= 3 then
						target:TakeSuppressionFire()
					end
				end
			end,
		}),
	},
	DisplayName = T(706990335817, --[[ModItemCharacterEffectCompositeDef SuppressionShocked DisplayName]] "Shocked"),
	Description = T(120295435136, --[[ModItemCharacterEffectCompositeDef SuppressionShocked Description]] "Penalty of <em><ap_loss></em> <em>Maximum AP</em> and <em><percent(cth_effect)></em> <em>Accuracy</em> is applied to each <em>Shocked</em> and <GameTerm('Wounded')> level.\n<color EmStyle>3</color> stacks: cannot perform <GameTerm('Aims')> (PINNED DOWN).\n<color EmStyle>5</color> stacks: force <em>Minimum Sight</em> (COWERING)."),
	AddEffectText = T(593449125116, --[[ModItemCharacterEffectCompositeDef SuppressionShocked AddEffectText]] "<color EmStyle><DisplayName></color> is <em>Shocked</em>!"),
	OnAdded = function (self, obj)
		--TE Tactical Suppression Fire [!MUST HAVE!] -- !!!Do NOT Change this one!!! (TE Core Logic)
		if IsKindOf(obj, "Unit") then --check to prevent effects that call this onremove and the obj is UnitData
			local effect = obj:GetStatusEffect("SuppressionShocked") or obj:GetStatusEffect("Wounded")
			local ap_loss = -self:ResolveValue("ap_loss")
			obj:ConsumeAP(ap_loss * const.Scale.AP * effect.stacks) -- max ap limited
		end
	end,
	lifetime = "Until End of Turn",
	Icon = "Mod/JA3_TacticianEnhanced/Images/suppressive_shocked.png",
	max_stacks = 5,
	RemoveOnEndCombat = true,
	Shown = true,
	HasFloatingText = true,
}

