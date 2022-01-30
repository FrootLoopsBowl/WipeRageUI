local wipeMenu = RageUI.CreateMenu("Wipe", "Wipe Menu")
wipeMenu.Closed = function()
    isOpen = false
    RageUI.Visible(wipeMenu, false)
end

function OpenWipeMenu()
    if isOpen then
        isOpen = false
        RageUI.Visible(wipeMenu, false)
    else
        isOpen = true
        RageUI.Visible(wipeMenu, true)
        Citizen.CreateThread(function()
            while isOpen do
                Wait(1)
                RageUI.IsVisible(wipeMenu, function()
                    for k, v in pairs(GetActivePlayers()) do
                        RageUI.Button(GetPlayerName(v), description, {}, true, {
                            onSelected = function()
                                local confirmwipe = KeyBoardInput("Etes vous sur de wipe ce joueur", "oui/non", 7, false)
                                if confirmwipe == "oui" then
                                    Notifications("Vous avez bien wipe ce joueur")
                                    TriggerServerEvent("Froot:pWipe", GetPlayerServerId(v))
                                else
                                    Notifications("Vous avez annulé le wipe")
                                end
                            end
                        })
                    end
                end)
            end
        end)
    end
end

RegisterCommand("wipeMenu", function()
    OpenWipeMenu()
end, false)