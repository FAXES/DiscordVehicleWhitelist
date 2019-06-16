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
    TriggerServerEvent("FaxDisVeh:CheckPermission", src)
end)

RegisterNetEvent("FaxDisVeh:CheckPermission:Return")
AddEventHandler("FaxDisVeh:CheckPermission:Return", function(havePerms, error)
    if error then
        print("[FAX DISCORD VEHICLE WHITELIST ERROR] No Discord identifier was found! Permissions set to false")
    end

    if havePerms then
        cHavePerms = true
    else
        cHavePerms = false
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(400)

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
                local driver = GetPedInVehicleSeat(veh, -1)
		        if driver == ped then
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
function DeleteE(entity)
	Citizen.InvokeNative(0xAE3CBE5BF394C9C9, Citizen.PointerValueIntInitialized(entity))
end
