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

        if Config.NoRandomDispatch then
            SetCreateRandomCops(0) -- disable random cops and effects
            CancelCurrentPoliceReport()
            DistantCopCarSirens(false)
            for i = 1, 16 do
                EnableDispatchService(i, false)
            end
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

        if Config.KeepEngineOn then
            local playerPed = GetPlayerPed(-1)
            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
            local isRunning = GetIsVehicleEngineRunning(vehicle)
            if IsPedInAnyVehicle(playerPed, false) and IsControlPressed(2, 75) and not IsEntityDead(playerPed) and isRunning == true then
                    SetVehicleEngineOn(vehicle, true, true, false)
                    TaskLeaveVehicle(playerPed, vehicle, 0)
                    Citizen.Wait(150)
                end
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
            Citizen.Wait(1)
            miid(Config.PlayerID.LocationX, Config.PlayerID.LocationY, Config.PlayerID.Width,Config.PlayerID.Height,Config.PlayerID.Scale, "~g~ID:~w~  ".. GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))) .. '', 255, 255, 255, 255)
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

local sh = GetEntityHealth(ply)
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
        if Config.RagdollWhenShot then 
            local ply = GetPlayerPed(-1)
                if HasEntityBeenDamagedByAnyPed(ply) then
                        dam = sh - GetEntityHealth(ply)
                        if (dam > 0) and (GetPedArmour(ply) <= 25) then
                            if (dam >= 0) and (dam <= 5) then
                                --print("hurt1")
                                hurtMedium(ply, dam)
                            elseif (dam >= 6) and (dam <= 10) then
                                --print("hurt2")
                                hurtMediumBad(ply, dam)
                            elseif (dam >= 11) and (dam <= 16) then
                                --print("hurt3")  
                                hurtPainful(ply, dam)
                            elseif dam >= 17 then
                                --print("hurt4")
                                hurtPainful(ply, dam)
                            end
                        end
                        
                        sh = GetEntityHealth(ply)
                end
                ClearEntityLastDamageEntity(ply)
        end
	 end
end)



function hurtMedium(ped, r)
    if IsEntityDead(ped) then return false end
    SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
    --print(r)
end
function hurtMediumBad(ped, r)
    if IsEntityDead(ped) then return false end
    SetPedToRagdoll(GetPlayerPed(-1), 1200, 1200, 0, 0, 0, 0)
    --Citizen.SetTimeout( 4000, function() SetPedIsDrunk(ped, true) end)
    --Citizen.SetTimeout( 30000, function() SetPedIsDrunk(ped, false) end)
    --print(r)
end
function hurtBad(ped, r)
    if IsEntityDead(ped) then return false end
    SetPedToRagdoll(GetPlayerPed(-1), 1500, 1500, 0, 0, 0, 0)
    --Citizen.SetTimeout( 5000, function() SetPedIsDrunk(ped, true) end)
    --Citizen.SetTimeout( 120000, function() SetPedIsDrunk(ped, false) end)
    --print(r)
end
function hurtPainful(ped, r)
    if IsEntityDead(ped) then return false end
    SetPedToRagdoll(GetPlayerPed(-1), 2000, 2000, 0, 0, 0, 0)
    --Citizen.SetTimeout( 15000, function() SetPedIsDrunk(ped, true) end)
    --Citizen.SetTimeout( 120000, function() SetPedIsDrunk(ped, false) end)
    --print(r)
end