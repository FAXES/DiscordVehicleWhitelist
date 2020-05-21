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
    local passAuth = false

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
        for index, valueReq in ipairs(whitelistRoles) do 
            if has_value(usersRoles, valueReq) then
                passAuth = true
            end
            if next(whitelistRoles,index) == nil then
                if passAuth == true then
                    TriggerClientEvent("FaxDisVeh:CheckPermission:Return", src, true, false)
                else
                    TriggerClientEvent("FaxDisVeh:CheckPermission:Return", src, false, false)
                end
            end
        end
    else
        TriggerClientEvent("FaxDisVeh:CheckPermission:Return", src, false, true)
    end
end)