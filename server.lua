------------------------------------------------
--- Discord Vehicle Whitelist, Made by FAXES ---
------------------------------------------------

--- Config ---

roles = { -- Role(s) needed to bypass the Discord vehicle whitelist (be able to use the listed vehicles).
    "Role1",
    "Role2",
    "Role3",
}


--- Code ---

RegisterServerEvent("FaxDisVeh:CheckPermission")
AddEventHandler("FaxDisVeh:CheckPermission", function(_source)
    local src = source
    for k, v in ipairs(GetPlayerIdentifiers(src)) do
        if string.sub(v, 1, string.len("discord:")) == "discord:" then
            identifierDiscord = v
        end
    end

    if identifierDiscord then
        for i = 1, #roles do
            if exports.discord_perms:IsRolePresent(src, roles[i]) then
                TriggerClientEvent("FaxDisVeh:CheckPermission:Return", src, true, false) -- They have perms DEV: (perms pass, err pass)
            else
                TriggerClientEvent("FaxDisVeh:CheckPermission:Return", src, false, false)
            end
        end
    elseif identifierDiscord == nil then
        TriggerClientEvent("FaxDisVeh:CheckPermission:Return", src, false, true)
    end
end)