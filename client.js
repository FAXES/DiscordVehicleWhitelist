////////////////////////////////////////////////
/// Discord Vehicle Whitelist, Made by FAXES ///
////////////////////////////////////////////////

let restricted = [];

Delay = (ms) => new Promise(res => setTimeout(res, ms));

onNet("DiscordVehicleWhitelist:SendEm", cars => {
    cars.forEach(e => {
        restricted.push({c: e.split(":")[1], d: e.split(":")[0]});
    });
});

setTick(async () => {
    await Delay(400);
    let ped = GetPlayerPed(PlayerId())
    let veh = GetVehiclePedIsIn(ped);
    if(veh && DoesEntityExist(veh)) {
        let model = GetEntityModel(veh);
        let driver = GetPedInVehicleSeat(veh, -1);
        if(driver == ped) {
            const found = restricted.find(e => e.c == model);
            if(found) {
                if(found.d) {
                    DeleteEntity(veh);
                } else {
                    TaskLeaveVehicle(ped, veh, 16);
                }
            }
        }
    }
});