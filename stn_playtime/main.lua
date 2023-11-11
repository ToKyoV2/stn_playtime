local casoveLimit = 3600 -- čas v sekundách, např. 3600 sekund = 1 hodina


function kontrolaCasu(identifier)
    local odehranyCas = nactiOdehranyCasZDatabaze(identifier)
    
    return odehranyCas >= casoveLimit
end


function nactiOdehranyCasZDatabaze(identifier)
    local result = exports.oxmysql:scalarSync("SELECT played_time FROM stn_playtime WHERE identifier = '" .. identifier .. "'")

    return result or 0
end


function zapisOdehranyCasDoDatabaze(identifier, cas)
    exports.oxmysql:executeSync("UPDATE stn_playtime SET played_time = " .. cas .. " WHERE identifier = '" .. identifier .. "'")
end


RegisterCommand("stnulozcas", function(source, args, rawCommand)
    if source == 0 then 
        print("Aktualizuji čas všech hráčů na serveru.")

        local players = GetPlayers()
        for _, player in ipairs(players) do
            local identifier = GetPlayerIdentifier(player)
            local odehranyCas = nactiOdehranyCasZDatabaze(identifier)
            zapisOdehranyCasDoDatabaze(identifier, odehranyCas + casoveLimit)
        end
    else
        print("Tento příkaz může být spuštěn pouze z konzole serveru.")
    end
end, true)
