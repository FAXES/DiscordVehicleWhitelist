------------------------------------------------
--- Discord Vehicle Whitelist, Made by FAXES ---
------------- Modified by Clink123 -------------
------------------------------------------------

--- Code ---

local lastVeh = nil

RegisterNetEvent("FaxDisVeh:CheckPermission:Return")
AddEventHandler("FaxDisVeh:CheckPermission:Return", function(havePerms, error)
    if error then
        print("^1No Discord identifier was found! ^rPermissions set to false. See this link for a debugging process - docs.faxes.zone/docs/debugging-discord")
    end
    if havePerms then
    else
		local ped = PlayerPedId()
		local veh = nil
		if IsPedInAnyVehicle(ped, false) then
			veh = GetVehiclePedIsUsing(ped)
		else
			veh = GetVehiclePedIsTryingToEnter(ped)
		end
		if veh and DoesEntityExist(veh) then
			ShowInfo("~r~Restricted vehicle model.")
			DeleteEntity(veh)
			ClearPedTasksImmediately(ped)
		end
    end
end)

Citizen.CreateThread(function()
    while true do			
		Citizen.Wait(500)
		local src = source
		local ped = PlayerPedId()
		local veh = nil
		if IsPedInAnyVehicle(ped, false) then
			veh = GetVehiclePedIsUsing(ped)
			if veh and DoesEntityExist(veh) then
				local model = GetEntityModel(veh)
				local driver = GetPedInVehicleSeat(veh, -1)
				if driver == ped then
					if (lastVeh ~= veh) then
						TriggerServerEvent("FaxDisVeh:CheckPermission", model)
						lastVeh = veh
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
