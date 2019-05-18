------------------------------------------------
--- Discord Vehicle Whitelist, Made by FAXES ---
------------------------------------------------

--- Config ---

roleNeeded = "ROLE_NAME_HERE" -- Role needed to bypass the Discord vehicle whitelist (be able to use the listed vehicles).


--- Code ---

RegisterServerEvent("FaxDisVeh:CheckPermission")
AddEventHandler("FaxDisVeh:CheckPermission", function(_source)
    local src = source
    -- print("SERVER TRIG") -- DEBUGGING
    for k, v in ipairs(GetPlayerIdentifiers(src)) do
        if string.sub(v, 1, string.len("discord:")) == "discord:" then
            identifierDiscord = v
        end
    end

    if identifierDiscord then
        if exports.discord_perms:IsRolePresent(src, roleNeeded) then
            TriggerClientEvent("FaxDisVeh:CheckPermission:Return", src, true, false) -- They have perms DEV: (perms pass, err pass)
        else
            TriggerClientEvent("FaxDisVeh:CheckPermission:Return", src, false, false)
        end
    elseif identifierDiscord == nil then
        TriggerClientEvent("FaxDisVeh:CheckPermission:Return", src, false, true)
    end
end)