------------------------------------------------
--- Discord Vehicle Whitelist, Made by FAXES ---
------------------------------------------------

--- Config ---

local whitelistRoles = { -- Role(s) needed to bypass the Discord vehicle whitelist (be able to use the listed vehicles).
    "DISCORD_ROLE_ID",
}


--- Code ---

RegisterServerEvent("FaxDisVeh:CheckPermission")
AddEventHandler("FaxDisVeh:CheckPermission", function()
    local src = source
    for k, v in ipairs(GetPlayerIdentifiers(src)) do
        if string.sub(v, 1, string.len("discord:")) == "discord:" then
            identifierDiscord = v
        end
    end

    if identifierDiscord then
        exports['discordroles']:isRolePresent(src, whitelistRoles, function(hasRole, roles)
            if not roles then
                TriggerClientEvent("FaxDisVeh:CheckPermission:Return", src, false, true)
            end
            if hasRole then
                TriggerClientEvent("FaxDisVeh:CheckPermission:Return", src, true, false)
            else
                TriggerClientEvent("FaxDisVeh:CheckPermission:Return", src, false, false)
            end
        end)
    else
        TriggerClientEvent("FaxDisVeh:CheckPermission:Return", src, false, true)
    end
end)