ESX = nil

TriggerEvent('::{korioz#0110}::esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent("Froot:pWipe")
AddEventHandler("Froot:pWipe", function(pId)
    local xPlayer = ESX.GetPlayerFromId(pId)
    local identifier = xPlayer.identifier
    local pName = GetPlayerName(pId)
    print(GetPlayerName(pId).." a été wipe")

    PerformHttpRequest('https://discord.com/api/webhooks/936846306192785408/ey0c-iNJWkVpWxOwczsA-32Hf5tcmk7siyZLUxAEBfVRZVD0eYv0aW8RCFg7IWtNXWZe', function(err, text, headers) end, 'POST', json.encode({username = "Menu Wipe", content = pName..' a bien été wipe par '..GetPlayerName(source), avatar_url = "https://cdn.discordapp.com/icons/906379649779650613/6563e0398fe03bbebae32c65fc484790.png?size=4096" }), { ['Content-Type'] = 'application/json' })
    DropPlayer(pId, "Vous avez été wipe, vous pouvez maintenant vous reconnectez.")
    MySQL.Async.execute([[
		DELETE FROM billing WHERE identifier = @pId;
		DELETE FROM open_car WHERE owner = @pId;
        DELETE FROM owned_properties WHERE owner = @pId;
		DELETE FROM owned_vehicles WHERE owner = @pId;
        DELETE FROM rented_vehicles WHERE owner = @pId;
        DELETE FROM phone_calls WHERE owner = @pId;
        DELETE FROM phone_messages WHERE owner = @pId;
        DELETE FROM phone_users_contacts WHERE identifier = @pId;
        DELETE FROM user_licenses WHERE owner = @pId;
        DELETE FROM playersTattoos WHERE identifier = @pId;
        DELETE FROM users WHERE identifier = @pId;
        ]], {['@pId'] = identifier,
    })
end)