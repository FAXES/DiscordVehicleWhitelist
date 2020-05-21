------------------------------------------------
--- Discord Vehicle Whitelist, Made by FAXES ---
------------------------------------------------

--- Config ---

-- List of vehicle classes: https://runtime.fivem.net/doc/natives/?_0x29439776AAA00A62
blacklistedVehicles = {
    "POLICE",   -- This blacklists a vehicle model.
    19,         -- This restricts the millitary vehicle class.
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
        print("^1No Discord identifier was found! ^rPermissions set to false. See this link for a debugging process - docs.faxes.zone/docs/debugging-discord")
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
                        if type(blacklistedVehicles[i]) == "number" then
                            if GetVehicleClass(veh) == blacklistedVehicles[i] then
                                ShowInfo("~r~Restricted vehicle model.")
                                DeleteEntity(veh)
                                ClearPedTasksImmediately(ped)
                            end
                        elseif type(blacklistedVehicles[i]) == "string" then
                            local restrictedVehicleModel = GetHashKey(blacklistedVehicles[i])
                            if (model == restrictedVehicleModel) then
                                ShowInfo("~r~Restricted vehicle model.")
                                DeleteEntity(veh)
                                ClearPedTasksImmediately(ped)
                            end
                        end
                    end
                end
            end
        end
    end
end)

--- Functions ---
function ShowInfo(text)
	BeginTextCommandThefeedPost("STRING")
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandThefeedPostTicker(false, false)
end
function DeleteE(entity)
	Citizen.InvokeNative(0xAE3CBE5BF394C9C9, Citizen.PointerValueIntInitialized(entity))
end
