function onStartup()
    if Config.NoAutoHealthRegen then
        SetPlayerHealthRechargeLimit(PlayerId(), 0)
    end

    if Config.Trains then
        SwitchTrainTrack(0, true)  -- enable trains 
        SwitchTrainTrack(3, true)   
        SetRandomTrains(1)
    end


    if Config.NoGangsAttack then
        -- no agresive gangs
        SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_HILLBILLY"), GetHashKey('PLAYER'))
        SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_BALLAS"), GetHashKey('PLAYER'))
        SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_MEXICAN"), GetHashKey('PLAYER'))
        SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_FAMILY"), GetHashKey('PLAYER'))
        SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_MARABUNTE"), GetHashKey('PLAYER'))
        SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_SALVA"), GetHashKey('PLAYER'))
        SetRelationshipBetweenGroups(1, GetHashKey("GANG_1"), GetHashKey('PLAYER'))
        SetRelationshipBetweenGroups(1, GetHashKey("GANG_2"), GetHashKey('PLAYER'))
        SetRelationshipBetweenGroups(1, GetHashKey("GANG_9"), GetHashKey('PLAYER'))
        SetRelationshipBetweenGroups(1, GetHashKey("GANG_10"), GetHashKey('PLAYER'))
        SetRelationshipBetweenGroups(1, GetHashKey("FIREMAN"), GetHashKey('PLAYER'))
        SetRelationshipBetweenGroups(1, GetHashKey("MEDIC"), GetHashKey('PLAYER'))
        SetRelationshipBetweenGroups(1, GetHashKey("COP"), GetHashKey('PLAYER'))
    end

    if Config.NoHeadshots then 
        SetPedSuffersCriticalHits(GetPlayerPed(-1), false)
    end
end

AddEventHandler("playerSpawned", function()
    Citizen.Wait(3000)
    onStartup()
    PopulateNow()
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1)
        if Config.NoAutoHealthRegen then
            SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0) -- disable auto health regen
        end

        if Config.NoRandomNPCCops then
            SetCreateRandomCops(0) -- disable random cops and effects
            CancelCurrentPoliceReport()
            DistantCopCarSirens(false)
        end

        if Config.SameHealthForMaleAndFemalesPeds then
            if GetEntityMaxHealth(GetPlayerPed(-1)) ~= 200 then -- set female peds to same health as male.
                SetEntityMaxHealth(GetPlayerPed(-1), 200)
                SetEntityHealth(GetPlayerPed(-1), 200)
            end
        end

        if Config.DisableVehicleRewards then
            while true do
                Citizen.Wait(50)
                local id = PlayerId()
                
                DisablePlayerVehicleRewards(id)
                
                RemoveAllPickupsOfType(‘PICKUP_WEAPON_CARBINERIFLE’)
                RemoveAllPickupsOfType(‘PICKUP_WEAPON_PISTOL’)
                RemoveAllPickupsOfType(‘PICKUP_WEAPON_PUMPSHOTGUN’)
                RemoveAllPickupsOfType(‘PICKUP_WEAPON_COMBATPDW’)
                RemoveAllPickupsOfType(‘PICKUP_WEAPON_COMBATPISTOL’)
            end
        end

        SetPedDensityMultiplierThisFrame(Config.PedFrequency)
        SetScenarioPedDensityMultiplierThisFrame(Config.PedFrequency, Config.PedFrequency)
        -------------------------------
        SetRandomVehicleDensityMultiplierThisFrame(Config.TrafficFrequency)
        SetParkedVehicleDensityMultiplierThisFrame(Config.TrafficFrequency)
        SetVehicleDensityMultiplierThisFrame(Config.TrafficFrequency)

        if Config.HideHUD.WeaponStats then
            HideHudComponentThisFrame(20)
        end
        if Config.HideHUD.Reticle then
            HideHudComponentThisFrame(14)
        end
        if Config.HideHUD.CarName then
            HideHudComponentThisFrame(6)
            HideHudComponentThisFrame(8)
        end
        if Config.HideHUD.StreetName then
            HideHudComponentThisFrame(7)
            HideHudComponentThisFrame(9)
        end
    end
end)

Citizen.CreateThread(function()
    if Config.Populate then
        while true do 
            Citizen.Wait(20 * 1000)
            PopulateNow()
        end
    end
end)

Citizen.CreateThread(function()
    if Config.NoPlaneTurbulence then
        while true do
            Citizen.Wait(30 * 1000)
            local plane = GetVehiclePedIsIn(PlayerPedId(), false)
            if IsThisModelAPlane(GetEntityModel(plane)) then
                -- Goodbye turbulence!
                SetPlaneTurbulenceMultiplier(plane, 0.0)
            end
        end
    end
end)

Citizen.CreateThread(function()
    Wait(50)
    if Config.ShowPlayerID then
        while true do
            miid(Config.PlayerID.LocationX, Config.PlayerID.LocationY, Config.PlayerID.Width,Config.PlayerID.Height,Config.PlayerID.Scale, "~g~ID:~w~  ".. GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))) .. '', 255, 255, 255, 255)
            Citizen.Wait(1)
        end
    end
end)

function miid(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(8)
    SetTextProportional(0)
    SetTextScale(scale, scale)
	SetTextColour( 0,0,0, 255 )
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
	SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end