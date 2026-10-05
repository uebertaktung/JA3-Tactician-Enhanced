--TE Global Darkness Level (Visual Effect)
local DarknessLightmodel = {}
function TE_Darkness_Level()
    if rawequal(CurrentLightmodel, Undefined()) or rawequal(CurrentLightmodel, false) then return end
    DarknessLightmodel = CurrentLightmodel[1]
    local TE_Lightmodel = DarknessLightmodel
	local choice = CurrentModOptions["Darkness_Level"]
    if choice == '125%' then
        if IsKindOf(TE_Lightmodel, 'Lightmodel') then
            if TE_Lightmodel.night then
                if GameState.Underground then
                    TE_Lightmodel.sun_intensity = 25
                    TE_Lightmodel.sun_angular_radius = 100
                    TE_Lightmodel.shadow = 0
                    TE_Lightmodel.exposure = 0
                else
                    TE_Lightmodel.ae_disable = true
                    TE_Lightmodel.sun_intensity = 20
                    TE_Lightmodel.sun_angular_radius = 120
                    TE_Lightmodel.shadow = 0
                    TE_Lightmodel.exposure = 0
                    TE_Lightmodel.ps_exposure = 0
                    TE_Lightmodel.vignette_tint_color = 1342177280
                    TE_Lightmodel.vignette_tint_feather = 1.0
                    TE_Lightmodel.vignette_tint_start = 1.0
                    TE_Lightmodel.vignette_darken_feather = 1.0
                    TE_Lightmodel.vignette_darken_start = 0.5
                    TE_Lightmodel.vignette_darken_opacity = 0.7
                    TE_Lightmodel.vignette_circularity = 0.0
                end
                SetLightmodel(1, TE_Lightmodel, 0)
            end
        end
    elseif choice == '150%' then
        if IsKindOf(TE_Lightmodel, 'Lightmodel') then
            if TE_Lightmodel.night then
                if GameState.Underground then
                    TE_Lightmodel.sun_intensity = 20
                    TE_Lightmodel.sun_angular_radius = 50
                    TE_Lightmodel.shadow = 700
                    TE_Lightmodel.exposure = -80
                else
                    TE_Lightmodel.ae_disable = true
                    TE_Lightmodel.sun_intensity = 10
                    TE_Lightmodel.sun_angular_radius = 50
                    TE_Lightmodel.shadow = 700
                    TE_Lightmodel.exposure = -70
                    TE_Lightmodel.ps_exposure = 250
                    TE_Lightmodel.vignette_tint_color = 1342177280
                    TE_Lightmodel.vignette_tint_feather = 1.0
                    TE_Lightmodel.vignette_tint_start = 1.0
                    TE_Lightmodel.vignette_darken_feather = 1.0
                    TE_Lightmodel.vignette_darken_start = 0.5
                    TE_Lightmodel.vignette_darken_opacity = 0.7
                    TE_Lightmodel.vignette_circularity = 0.0
                end
                SetLightmodel(1, TE_Lightmodel, 0)
            end
        end
    elseif choice == '200%' then
        if IsKindOf(TE_Lightmodel, 'Lightmodel') then
            if TE_Lightmodel.night then
                if GameState.Underground then
                    TE_Lightmodel.sun_intensity = 0
                    TE_Lightmodel.sun_angular_radius = 25
                    TE_Lightmodel.shadow = 700
                    TE_Lightmodel.exposure = -100
                else
                    TE_Lightmodel.ae_disable = true
                    TE_Lightmodel.sun_intensity = 0
                    TE_Lightmodel.sun_angular_radius = 10
                    TE_Lightmodel.shadow = 1000
                    TE_Lightmodel.exposure = -100
                    TE_Lightmodel.ps_exposure = 250
                    TE_Lightmodel.vignette_tint_color = 1342177280
                    TE_Lightmodel.vignette_tint_feather = 1.0
                    TE_Lightmodel.vignette_tint_start = 1.0
                    TE_Lightmodel.vignette_darken_feather = 1.0
                    TE_Lightmodel.vignette_darken_start = 0.5
                    TE_Lightmodel.vignette_darken_opacity = 0.9
                    TE_Lightmodel.vignette_circularity = 0.0
                end
                SetLightmodel(1, TE_Lightmodel, 0)
            end
        end
    end
end

--Tactician Enhanced Darkness_Level Loaded
function OnMsg.PostNewMapLoaded()
	if CurrentModOptions["Darkness_Level"] == '100%' then return end
	
    DarknessLightmodel = CurrentLightmodel[1]
	TE_Darkness_Level()
end
function OnMsg.ModsReloaded()
	if CurrentModOptions["Darkness_Level"] == '100%' then return end
	
    DarknessLightmodel = CurrentLightmodel[1]
	TE_Darkness_Level()
end
function OnMsg.DataLoaded()
	if CurrentModOptions["Darkness_Level"] == '100%' then return end
	
    DarknessLightmodel = CurrentLightmodel[1]
	TE_Darkness_Level()
end
function OnMsg.OptionsApply()
	if CurrentModOptions["Darkness_Level"] == '100%' then return end
	
    DarknessLightmodel = CurrentLightmodel[1]
	TE_Darkness_Level()
end