////////////////////////////////////////////////
/// Discord Vehicle Whitelist, Made by FAXES ///
////////////////////////////////////////////////

const config = {
    vehicles: [
        {car: "POLICE", delete: true},
        {car: "POLICE2", delete: false, role: ""},
        {car: "POLICE3"}
    ]
}

if(GetResourceState("DiscordWhitelist") == "stopped" || GetResourceState("DiscordWhitelist") == "missing" || GetResourceState("DiscordWhitelist") == "uninitialized" ) {console.log(`^1 You must have DiscordWhitelist installed.^7`)}

on('playerConnecting', async (name, setKickReason, deferrals) => {
    let src = global.source;
    let arr = [];
    const userRoles = await exports.DiscordWhitelist.getRoles(src);

    await Promise.all(config.vehicles.map(async (e) => {
        if(e.role) {
            if(!userRoles.includes(e.role)) {
                arr.push(`${e.delete}:${e.car}`);
            }
        } else {
            arr.push(`${e.delete}:${e.car}`);
        }
    }));

    emitNet("DiscordVehicleWhitelist:SendEm", src, arr);
});