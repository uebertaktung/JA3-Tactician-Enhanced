TE_Utils = {}
opt_TE_droprate = nil

function TE_Utils.UpdateOptions()
	opt_TE_droprate = CurrentModOptions["Tactical_Hardcore"] == "<GameTerm('TE_HARD_BOILED')>" or CurrentModOptions["Tactical_Hardcore"] == "<GameTerm('TE_DEAD_ON_ARRIVAL')>" or CurrentModOptions["Hell_Gate"] == "<GameTerm('TE_NIGHTMARE_A')>" or CurrentModOptions["Hell_Gate"] == "<GameTerm('TE_NIGHTMARE_B')>"
end

function TE_Utils.TE_GetTeamUnitsBySide(includedSides, excludedSides)
	includedSides = includedSides or { "neutral", "player1", "player2", "enemy1", "enemy2", "enemyNeutral", "ally" }
	excludedSides = excludedSides or {}
	
	local teams =  table.ifilter(g_Teams, function(i, t)
		return table.find(includedSides, t.side) and not table.find(excludedSides, t.side)
	end)
	
	local units = {}
	for _, team in ipairs(teams) do
		for _, u in ipairs(team.units) do
			if not u:IsDead() and u.species == "Human" then
				table.insert(units, u)
			end
		end	
	end
	
	return units
end

OnMsg.ModsReloaded = TE_Utils.UpdateOptions
OnMsg.DataLoaded = TE_Utils.UpdateOptions
OnMsg.OptionsApply = TE_Utils.UpdateOptions