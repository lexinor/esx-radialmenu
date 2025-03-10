local trunkBusy = {}

RegisterNetEvent('esx-radialmenu:trunk:server:Door', function(open, plate, door)
    TriggerClientEvent('esx-radialmenu:trunk:client:Door', -1, plate, door, open)
end)

RegisterNetEvent('esx-trunk:server:setTrunkBusy', function(plate, busy)
    trunkBusy[plate] = busy
end)

RegisterNetEvent('esx-trunk:server:KidnapTrunk', function(targetId, closestVehicle)
    TriggerClientEvent('esx-trunk:client:KidnapGetIn', targetId, closestVehicle)
end)

ESX.RegisterServerCallback('esx-trunk:server:getTrunkBusy', function(src, cb, plate)
    if trunkBusy[plate] then cb(true) return end
    cb(false)
end)

ESX.RegisterCommand({"getintrunk"}, 'user', function(xPlayer, args, showError)
    TriggerClientEvent('esx-trunk:client:GetIn', xPlayer.source)
end, false, {help = Translation("getintrunk_command_desc")})

ESX.RegisterCommand({"putintrunk"}, 'user', function(xPlayer, args, showError)
    TriggerClientEvent('esx-trunk:server:KidnapTrunk', xPlayer.source)
end, false, {help = Translation("putintrunk_command_desc")})