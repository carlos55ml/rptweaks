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

    if Config.DisableVehicleRewards then 
        DisablePlayerVehicleRewards(GetPlayerName(-1))
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

        if Config.HideWeaponStats then
            HideHudComponentThisFrame(20)
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

-- the following values must satisfy the condtions (let x be the frequency) 
-- x ≥ 0.0
-- x must be a float type

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        SetPedDensityMultiplierThisFrame(Config.PedFrequency) -- https://runtime.fivem.net/doc/natives/#_0x95E3D6257B166CF2
        --[[ 
        Values:  
        → 0.0 = no peds on streets  
        → 1.0 = normal peds on streets   
        ]]
        SetScenarioPedDensityMultiplierThisFrame(Config.PedFrequency, Config.PedFrequency) -- https://runtime.fivem.net/doc/natives/#_0x7A556143A1C03898
        -------------------------------
        SetRandomVehicleDensityMultiplierThisFrame(Config.TrafficFrequency) -- https://runtime.fivem.net/doc/natives/#_0xB3B3359379FE77D3
        SetParkedVehicleDensityMultiplierThisFrame(Config.TrafficFrequency) -- https://runtime.fivem.net/doc/natives/#_0xEAE6DCC7EEE3DB1D
        SetVehicleDensityMultiplierThisFrame(Config.TrafficFrequency) -- https://runtime.fivem.net/doc/natives/#_0x245A6883D966D537
        --[[ 
        Use this native inside a looped function.
        Values:
        0.0 = no vehicles on streets
        1.0 = normal vehicles on streets
        0.0 ≤ x ≤ 1.0
        ]]
    end 
end)
