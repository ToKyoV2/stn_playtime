local zbyleCasoveLimit = 0



function zobrazCasNaObrazovce(cas)
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName("Zbývá čas: " .. cas .. " sekund")
    EndTextCommandDisplayText(0.5, 0.9)
end


RegisterNetEvent("blokujStrelbu")
AddEventHandler("blokujStrelbu", function()
    local playerId = PlayerId()


    DisablePlayerFiring(playerId, true)
end)


RegisterNetEvent("blokujMlaceni")
AddEventHandler("blokujMlaceni", function()
    local playerId = PlayerId()


    DisableControlAction(0, 140, true) 
end)


RegisterNetEvent("aktualizujCas")
AddEventHandler("aktualizujCas", function(cas)
    zbyleCasoveLimit = cas
end)


RegisterNetEvent("povolVse")
AddEventHandler("povolVse", function()
    local playerId = PlayerId()


    DisablePlayerFiring(playerId, false)


    DisableControlAction(0, 140, false)


    zbyleCasoveLimit = 0
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000) 

        if zbyleCasoveLimit > 0 then
            zobrazCasNaObrazovce(zbyleCasoveLimit)
            zbyleCasoveLimit = zbyleCasoveLimit - 1
        end
    end
end)
