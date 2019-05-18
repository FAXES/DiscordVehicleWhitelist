------------------------------------------------
--- Discord Vehicle Whitelist, Made by FAXES ---
------------------------------------------------

--- Config ---

blacklistedVehicles = {
    "POLICE",
    "POLICE2",
    "POLICE3",
}

--- Code ---
cHavePerms = false

AddEventHandler('playerSpawned', function()
    local src = source
    -- print("THIS?") -- DEBUGGING
    TriggerServerEvent("FaxDisVeh:CheckPermission", src)
end)

RegisterNetEvent("FaxDisVeh:CheckPermission:Return")
AddEventHandler("FaxDisVeh:CheckPermission:Return", function(havePerms, error)
    -- print("TRIGGERED") -- DEBUGGING
    if error then
        print("[FAX DISCORD VEHICLE WHITELIST ERROR] No Discord identifier was found! Permissions set to false")
    end

    if havePerms then
        cHavePerms = true
        -- print("true") -- DEBUGGING
    else
        cHavePerms = false
        -- print("false") -- DEBUGGING
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)

        if not cHavePerms then
            local ped = PlayerPedId()
            local veh = nil

            if IsPedInAnyVehicle(ped, false) then
                veh = GetVehiclePedIsUsing(ped)
            else
                veh = GetVehiclePedIsTryingToEnter(ped)
            end
            
            if veh and DoesEntityExist(veh) then
                local model = GetEntityModel(veh)

                for i = 1, #blacklistedVehicles do
                    local restrictedVehicleModel = GetHashKey(blacklistedVehicles[i])
                    if (model == restrictedVehicleModel) then
                        ShowInfo("~r~Restricted Vehicle Model.")
                        DeleteEntity(veh)
                        ClearPedTasksImmediately(ped)
                    end
                end
            end
        end
        -- local src = source
        -- TriggerServerEvent("FaxDisVeh:CheckPermission", src)
    end
end)

--- Functions ---
function ShowInfo(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentSubstringPlayerName(text)
	DrawNotification(false, false)
end
