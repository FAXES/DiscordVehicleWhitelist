------------------------------------------------
--- Discord Vehicle Whitelist, Made by FAXES ---
------------- Modified by Clink123 -------------
------------------------------------------------

--- Config ---

local RoleVehicleDictionary = {
    ['736824407598694432'] = {"charger", "crownvic", "tahoe13", "tahoe"},
	['736415956091404362'] = {"czr1", "c8", "1980BroncoLifted", "2008F350", "2010Ram3500", "2010Silverado1500", "2015GMCYukonDenali", "KenworthT440", "Ram3500Flatbed", "stormtr", "flatbedm2", "cxt1", "yacht2", "gruppe1", "gruppe2", "gruppe3"},
    ['738995097911427113'] = {"8q400","a220","a319","tu154m","saab2000","md80","lcf","lcfloader","l1011","il76","il62m","ha420","fokker100","emb190","emb175","emb145","emb120","emb100","e190e2","dc30f","dc10","beluga","bac","b727c","b727","avashut","an225","atr72","a380","a350","a343","a340","a333","a321neo","a320","788","779x","773er","757","748f","748","747sp","747","739","707","208"},
}

--- Code ---

RegisterServerEvent("FaxDisVeh:CheckPermission")
AddEventHandler("FaxDisVeh:CheckPermission", function(model)
    local src = source
    local passAuth = false
	local delete = false

    for k, v in ipairs(GetPlayerIdentifiers(src)) do
        if string.sub(v, 1, string.len("discord:")) == "discord:" then
            identifierDiscord = v
        end
    end

    if identifierDiscord then
        usersRoles = exports.discord_perms:GetRoles(src)
        local function has_value(table, val)
            if table then
                for index, value in ipairs(table) do
                    if value == val then
                        return true
                    end
                end
            end
            return false
        end
		local function has_valueVeh(table, val)
            if table then
                for index, value in ipairs(table) do
                    if GetHashKey(value) == val then
                        return true
                    end
                end
            end
            return false
        end
        for role, vehicles in pairs(RoleVehicleDictionary) do 
            if not has_value(usersRoles, role) then
				if has_valueVeh(vehicles, model) then
					delete = true;
				end
            end
            if next(RoleVehicleDictionary, role) == nil then
                if delete == true then
                    TriggerClientEvent("FaxDisVeh:CheckPermission:Return", src, false, false)
                else
                    TriggerClientEvent("FaxDisVeh:CheckPermission:Return", src, true, false)
                end
            end
        end
    else
        TriggerClientEvent("FaxDisVeh:CheckPermission:Return", src, false, true)
    end
end)