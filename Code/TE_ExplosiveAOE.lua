--Defs Explosives AOE Effects
local function checkID(id)
    if not InventoryItemDefs[id] then
        return false
    end
    if not _G[id] then
        return false
    end
    return true
end

local function TE_ExplosiveAOE(id, centerEff, areaEff, hint)
    if checkID(id) == false then
        return
    end

    local defs = InventoryItemDefs[id]
    local load = _G[id]

    defs.CenterAppliedEffects   = centerEff
    defs.AreaAppliedEffects     = areaEff
    
    load.CenterAppliedEffects   = centerEff
    load.AreaAppliedEffects     = areaEff

    if hint then
        defs.AdditionalHint = hint
        load.AdditionalHint = hint
    end
end

local ceff_1 = {
    "CancelShot",
    "Bleeding",
    "Suppressed",
}
local aeff_1 = {
    "CancelShot",
    "Bleeding",
    "Suppressed",
}

local ceff_2 = {
    "CancelShot",
    "Suppressed",
}
local aeff_2 = {
    "CancelShot",
    "Suppressed",
}

local ceff_3 = {
    "CancelShot",
    "Slowed",
}
local aeff_3 = {
    "CancelShot",
}

local ceff_4 = {
    "Numbness",
}
local aeff_4 = {
    "Numbness",
}

local ceff_5 = {
    "Unconscious",
    "Bleeding",
}
local aeff_5 = {
    "CancelShot",
    "Bleeding",
    "Suppressed",
}

local hint_Frag         = T(30072476860901, "<bullet_point> Increased Thrown Range\n<bullet_point> Inflicts <em>Bleeding</em>\n<bullet_point> Inflicts <em>Suppressed</em>\n<bullet_point> Cancel <em>Overwatch</em> and <em>MGSetup</em>")
local hint_HE           = T(30072476860902, "<bullet_point> High Damage\n<bullet_point> Inflicts <em>Suppressed</em>\n<bullet_point> Cancel <em>Overwatch</em> and <em>MGSetup</em>")
local hint_Flashbang    = T(30072476860903, "<bullet_point> Decreased AP Cost\n<bullet_point> Center Area Inflicts <em>Slowed</em>\n<bullet_point> Cancel <em>Overwatch</em> and <em>MGSetup</em>")
local hint_Molotov      = T(30072476860904, "<bullet_point> Increased AP Cost\n<bullet_point> Inflicts <em>Burning</em>\n<bullet_point> Inflicts <em>Numbness</em>\n<bullet_point> Inflicts <em>Illuminated</em>")
local hint_Shell        = T(30072476860905, "<bullet_point> Very High Damage\n<bullet_point> Center Area Inflicts <em>Unconscious</em>\n<bullet_point> Inflicts <em>Bleeding</em>\n<bullet_point> Inflicts <em>Suppressed</em>\n<bullet_point> Cancel <em>Overwatch</em> and <em>MGSetup</em>")
local hint_Gas          = T(277464468866,   "<bullet_point> Inflicts <em>Choking</em>\n<bullet_point> Ranged attacks passing through gas become grazing hits\n<bullet_point> High mishap chance\n<bullet_point> Almost silent")
local hint_Smoke        = T(112062042147,   "<bullet_point> Ranged attacks passing through gas become <em>grazing</em> hits\n<bullet_point> No damage\n<bullet_point> Almost silent")
	
local function TE_ExplosiveAOE_Instant()
    --               id                           centerEff, areaEff,   hint
    TE_ExplosiveAOE("FragGrenade",                ceff_1,    aeff_1,    hint_Frag)
    TE_ExplosiveAOE("HE_Grenade",                 ceff_2,    aeff_2,    hint_HE)
    TE_ExplosiveAOE("Super_HE_Grenade",           ceff_5,    aeff_5,    hint_Shell)
    TE_ExplosiveAOE("ShapedCharge",               ceff_2,    aeff_2,    hint_HE)
    TE_ExplosiveAOE("ConcussiveGrenade",          ceff_3,    aeff_3,    hint_Flashbang)
    TE_ExplosiveAOE("Molotov",                    ceff_4,    aeff_4,    hint_Molotov)
end

local function TE_ExplosiveAOE_Trap()
    --               id                           centerEff, areaEff,   hint
    TE_ExplosiveAOE("BlackPowder",                ceff_1,    aeff_1,    nil)
    TE_ExplosiveAOE("C4",                         ceff_5,    aeff_5,    nil)
    TE_ExplosiveAOE("PETN",                       ceff_5,    aeff_5,    nil)
    TE_ExplosiveAOE("TNT",                        ceff_5,    aeff_5,    nil)
end

local function TE_ExplosiveAOE_Shell()
    --               id                           centerEff,  areaEff,   hint
    TE_ExplosiveAOE("_22mm_NATO_Frag",            ceff_2,     aeff_2,    hint_HE)
    TE_ExplosiveAOE("_22mm_NATO_Gas",             nil,        nil,       hint_Gas)
    TE_ExplosiveAOE("_22mm_NATO_Smoke",           nil,        nil,       hint_Smoke)
    TE_ExplosiveAOE("_22mm_WP_Frag",              ceff_2,     aeff_2,    hint_HE)
    TE_ExplosiveAOE("_22mm_WP_Gas",               nil,        nil,       hint_Gas)
    TE_ExplosiveAOE("_22mm_WP_Smoke",             nil,        nil,       hint_Smoke)
    TE_ExplosiveAOE("_40mmFragGrenade",           ceff_2,     aeff_2,    hint_HE)
    TE_ExplosiveAOE("_40mmFlashbangGrenade",      ceff_3,     aeff_3,    hint_Flashbang)
    TE_ExplosiveAOE("Warhead_Frag",               ceff_5,     aeff_5,    hint_Shell)
    TE_ExplosiveAOE("MortarShell_HE",             ceff_5,     aeff_5,    hint_Shell)
end

--Explosives AOE Effects Loaded
function OnMsg.ModsReloaded()
	TE_ExplosiveAOE_Instant()
	TE_ExplosiveAOE_Trap()
	TE_ExplosiveAOE_Shell()
end
function OnMsg.DataLoaded()
	TE_ExplosiveAOE_Instant()
	TE_ExplosiveAOE_Trap()
	TE_ExplosiveAOE_Shell()
end
function OnMsg.OptionsApply()
	TE_ExplosiveAOE_Instant()
	TE_ExplosiveAOE_Trap()
	TE_ExplosiveAOE_Shell()
end