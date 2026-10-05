--JA3 Tactician Enhanced & C-UAE Compability Logic Loaded
function OnMsg.ModsReloaded()
	local TE_cuaeSettings = {
		ReplaceWeapons = true,
		AddWeaponComponents = true,
		ReplaceArmor = true,
		ExtraHandgun = true,
		ExtraGrenadesCount = 5,
		AlwaysAddArmor = true,
		DisallowSilencers = true,
		ApplyChangesInSateliteView = true,
		AlternativeWeaponTypeTables = {
			Handgun = {{"Shotgun",40}, {"SMG",60}, {"AssaultRifle",100}},
			Shotgun = {{"Shotgun",100}},
			SMG = {{"AssaultRifle",15}},
			AssaultRifle = {{"MachineGun",15}, {"Sniper",25}},
		}
	}
	local cuaeImmunityTable = {
		'Machete',
		'Machete_Balanced',
		'Machete_Sharpened',
		'Machete_Crafted',
	}
	CUAEForceSettings(TE_cuaeSettings)
	CUAEAddImmunityTable(cuaeImmunityTable)
end
function OnMsg.DataLoaded()
	local TE_cuaeSettings = {
		ReplaceWeapons = true,
		AddWeaponComponents = true,
		ReplaceArmor = true,
		ExtraHandgun = true,
		ExtraGrenadesCount = 5,
		AlwaysAddArmor = true,
		DisallowSilencers = true,
		ApplyChangesInSateliteView = true,
		AlternativeWeaponTypeTables = {
			Handgun = {{"Shotgun",40}, {"SMG",60}, {"AssaultRifle",100}},
			Shotgun = {{"Shotgun",100}},
			SMG = {{"AssaultRifle",15}},
			AssaultRifle = {{"MachineGun",15}, {"Sniper",25}},
		}
	}
	local cuaeImmunityTable = {
		'Machete',
		'Machete_Balanced',
		'Machete_Sharpened',
		'Machete_Crafted',
	}
	CUAEForceSettings(TE_cuaeSettings)
	CUAEAddImmunityTable(cuaeImmunityTable)
end
function OnMsg.OptionsApply()
	local TE_cuaeSettings = {
		ReplaceWeapons = true,
		AddWeaponComponents = true,
		ReplaceArmor = true,
		ExtraHandgun = true,
		ExtraGrenadesCount = 5,
		AlwaysAddArmor = true,
		DisallowSilencers = true,
		ApplyChangesInSateliteView = true,
		AlternativeWeaponTypeTables = {
			Handgun = {{"Shotgun",40}, {"SMG",60}, {"AssaultRifle",100}},
			Shotgun = {{"Shotgun",100}},
			SMG = {{"AssaultRifle",15}},
			AssaultRifle = {{"MachineGun",15}, {"Sniper",25}},
		}
	}
	local cuaeImmunityTable = {
		'Machete',
		'Machete_Balanced',
		'Machete_Sharpened',
		'Machete_Crafted',
	}
	CUAEForceSettings(TE_cuaeSettings)
	CUAEAddImmunityTable(cuaeImmunityTable)
end