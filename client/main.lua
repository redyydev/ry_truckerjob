--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- SCRIPT BY REDYY#0449
-- www.fiverr.com/redyypt
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

ESX = nil
PlayerData = nil

-- DON'T CHANGE --
local setjob = false
local InMarker = false
local working = false

local CurrentAction  = nil

local Blips_job = {}

local Route1_active = false
local Route2_active = false
local Route3_active = false
local Route4_active = false

local Route1 = {}
local Route2 = {}
local Route3 = {}
local Route4 = {}
-- DON'T CHANGE --

Citizen.CreateThread(function()
    Wait(100)
	while ESX == nil do TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) Citizen.Wait(0) end
    while ESX.GetPlayerData().job == nil do Wait(0) end
    ESX.PlayerData = ESX.GetPlayerData()
    PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

-- Normal Markers
Citizen.CreateThread(function()
    Wait(1000)
    while PlayerData == nil do Wait(10) end
    while true do 
        Citizen.Wait(1)
        local coord = GetEntityCoords(PlayerPedId())
        local markers = Config.Markers
        local job = PlayerData.job.name
        for k,v in pairs(markers) do 
            local dist = #(coord - v.coord)
            if dist < 3 and job == 'trucker' then
                if working then
                    DrawText3Ds(v.coord.x, v.coord.y, v.coord.z+0.5, '[ ~r~G ~w~] ' .. v.cancel)
                    if IsControlJustReleased(0, 183) then
                        Citizen.Wait(1)
                        for k,v in pairs(Config.Routes['route1']['locations']) do 
                            Route1 = {}
                            TriggerEvent('ry_truckerjob:state', false, k)
                            TriggerEvent('ry_truckerjob:clearblips')
                            TriggerEvent('ry_truckerjob:updatworking2', false)
                        end
                        for k,v in pairs(Config.Routes['route2']['locations']) do 
                            Route2 = {}                         
                            TriggerEvent('ry_truckerjob:state', false, k)
                            TriggerEvent('ry_truckerjob:clearblips')
                            TriggerEvent('ry_truckerjob:updatworking2', false)
                        end
                        for k4,v in pairs(Config.Routes['route3']['locations']) do 
                            Route = {}                          
                            TriggerEvent('ry_truckerjob:state', false, k)
                            TriggerEvent('ry_truckerjob:clearblips')
                            TriggerEvent('ry_truckerjob:updatworking2', false)
                        end
                        for k,v in pairs(Config.Routes['route4']['locations']) do 
                            Route4 = {}                          
                            TriggerEvent('ry_truckerjob:state', false, k)
                            TriggerEvent('ry_truckerjob:clearblips')
                            TriggerEvent('ry_truckerjob:updatworking2', false)
                        end
                        ESX.UI.Menu.CloseAll()
                    end
                else
                    DrawText3Ds(v.coord.x, v.coord.y, v.coord.z+0.5, '[ ~g~E ~w~] ' .. v.name)
                    if IsControlJustReleased(0, 38) then
                        for k2,v in pairs(Config.Routes['route1']['locations']) do 
                            if Route1_active then
                                Route1 = {}                          
                                TriggerEvent('ry_truckerjob:state', false, k2)
                            end
                        end
                        for k2,v in pairs(Config.Routes['route2']['locations']) do 
                            if Route2_active then
                                Route2 = {}                          
                                TriggerEvent('ry_truckerjob:state', false, k2)
                            end
                        end
                        for k2,v in pairs(Config.Routes['route3']['locations']) do 
                            if Route3_active then
                                Route3 = {}                           
                                TriggerEvent('ry_truckerjob:state', false, k2)
                            end
                        end
                        for k2,v in pairs(Config.Routes['route4']['locations']) do 
                            if Route4_active then
                                Route4 = {}                          
                                TriggerEvent('ry_truckerjob:state', false, k2)
                            end
                        end
                        TriggerEvent(v.event)
                    elseif IsControlJustReleased(0, 202) then
                        ESX.UI.Menu.CloseAll()
                    end
                end
                DrawMarker(v.marker.type, v.coord.x, v.coord.y, v.coord.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.marker.size.x, v.marker.size.y, v.marker.size.z, v.marker.color.r, v.marker.color.g, v.marker.color.b, 100, false, true, 2, true, false, false, false)
                InMarker = true
            end
            if dist > 4 and InMarker then
                InMarker = false
                ESX.UI.Menu.CloseAll()
            end
        end
    end
end)

-- Routes
Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1)
        local coord = GetEntityCoords(PlayerPedId())
        local ped = GetPlayerPed(-1)
        local isATruck = false
        for i=1, #Config.Menus['trucks'].options, 1 do
            if IsVehicleModel(GetVehiclePedIsUsing(ped), Config.Menus['trucks'].options[i]) then
                isATruck = true
                break
            end
        end
        if working then
            for k,v in pairs(Config.Routes['route1']['locations']) do 
                local dist = #(coord - v.coord)
                if Route1_active then
                    DrawMarker(v.marker.type, v.coord.x, v.coord.y, v.coord.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.marker.size.x, v.marker.size.y, v.marker.size.z, v.marker.color.r, v.marker.color.g, v.marker.color.b, 100, false, true, 2, true, false, false, false)
                    if dist < 5 then
                        if not Route1[k].delivered and Route1[k].active and isATruck then
                            DrawText3Ds(v.coord.x, v.coord.y, v.coord.z+0.5, v.marker.text)
                            InMarker = true
                            CurrentAction = 'Route1[' .. k .. ']'
                            TriggerEvent('ry_truckerjob:hasEnteredMarker', k, v.event, 'route1')
                        else
                            if Route1[k].delivered then
                                DrawText3Ds(v.coord.x, v.coord.y, v.coord.z+0.5, v.marker.text_delivered)
                            end
                            CurrentAction = nil
                            InMarker = false
                        end                         
                    end
                end
            end

            for k2,v in pairs(Config.Routes['route2']['locations']) do 
                local dist = #(coord - v.coord)
                if Route2_active then
                    DrawMarker(v.marker.type, v.coord.x, v.coord.y, v.coord.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.marker.size.x, v.marker.size.y, v.marker.size.z, v.marker.color.r, v.marker.color.g, v.marker.color.b, 100, false, true, 2, true, false, false, false)
                    if dist < 5 then
                        if not Route2[k2].delivered and Route2[k2].active and isATruck then
                            DrawText3Ds(v.coord.x, v.coord.y, v.coord.z+0.5, v.marker.text)
                            InMarker = true
                            CurrentAction = 'Route2[' .. k2 .. ']'
                            TriggerEvent('ry_truckerjob:hasEnteredMarker', k2, v.event, 'route2')
                        else
                                if Route2[k2].delivered then
                                    DrawText3Ds(v.coord.x, v.coord.y, v.coord.z+0.5, v.marker.text_delivered)
                                end
                            CurrentAction = nil
                            InMarker = false
                        end                         
                    end
                end
            end

            for k3,v in pairs(Config.Routes['route3']['locations']) do 
                local dist = #(coord - v.coord)
                if Route3_active then
                    DrawMarker(v.marker.type, v.coord.x, v.coord.y, v.coord.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.marker.size.x, v.marker.size.y, v.marker.size.z, v.marker.color.r, v.marker.color.g, v.marker.color.b, 100, false, true, 2, true, false, false, false)
                    if dist < 5 then
                        if not Route3[k3].delivered and Route3[k3].active and isATruck then
                            DrawText3Ds(v.coord.x, v.coord.y, v.coord.z+0.5, v.marker.text)
                            InMarker = true
                            CurrentAction = 'Route3[' .. k3 .. ']'
                            TriggerEvent('ry_truckerjob:hasEnteredMarker', k3, v.event, 'route3')
                        else
                                if Route3[k3].delivered then
                                    DrawText3Ds(v.coord.x, v.coord.y, v.coord.z+0.5, v.marker.text_delivered)
                                end
                            CurrentAction = nil
                            InMarker = false
                        end                         
                    end
                end
            end

            for k4,v in pairs(Config.Routes['route4']['locations']) do 
                local dist = #(coord - v.coord)
                if Route4_active then
                    DrawMarker(v.marker.type, v.coord.x, v.coord.y, v.coord.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.marker.size.x, v.marker.size.y, v.marker.size.z, v.marker.color.r, v.marker.color.g, v.marker.color.b, 100, false, true, 2, true, false, false, false)
                    if dist < 5 then
                        if not Route4[k4].delivered and Route4[k4].active and isATruck then
                            DrawText3Ds(v.coord.x, v.coord.y, v.coord.z+0.5, v.marker.text)
                            InMarker = true
                            CurrentAction = 'Route4[' .. k4 .. ']'
                            TriggerEvent('ry_truckerjob:hasEnteredMarker', k4, v.event, 'route4')
                        else
                                if Route4[k4].delivered then
                                    DrawText3Ds(v.coord.x, v.coord.y, v.coord.z+0.5, v.marker.text_delivered)
                                end
                            CurrentAction = nil
                            InMarker = false
                        end                         
                    end
                end
            end
        end
    end
end)
--  

RegisterNetEvent('ry_truckerjob:hasEnteredMarker')
AddEventHandler('ry_truckerjob:hasEnteredMarker', function(zone,event,v)
    if CurrentAction == 'Route1[' .. zone .. ']' or 'Route2[' .. zone .. ']' or 'Route3[' .. zone .. ']' or 'Route4[' .. zone .. ']' then
        if IsControlJustReleased(0, 38) and InMarker then
            local num = zone+1
            if zone == 1 then
                Route1[1].active = false
                Route1[2].active = true
                Route2[1].active = false
                Route2[2].active = true
                Route3[1].active = false
                Route3[2].active = true
                Route4[1].active = false
                Route4[2].active = true

                if v == 'route1' then
                TriggerEvent(event, Route1[num].coord.x, Route1[num].coord.y, Route1[num].coord.z, k)
                elseif v == 'route2' then
                TriggerEvent(event, Route2[num].coord.x, Route2[num].coord.y, Route2[num].coord.z, k)
                elseif v == 'route3' then
                TriggerEvent(event, Route3[num].coord.x, Route3[num].coord.y, Route3[num].coord.z, k)
                elseif v == 'route4' then
                TriggerEvent(event, Route4[num].coord.x, Route4[num].coord.y, Route4[num].coord.z, k)
                end

                Citizen.Wait(Config.Duration)
                Route1[1].delivered = true
                Route2[1].delivered = true
                Route3[1].delivered = true
                Route4[1].delivered = true
            elseif zone == 2 then
                Route1[2].active = false
                Route1[3].active = true
                Route2[2].active = false
                Route2[3].active = true
                Route3[2].active = false
                Route3[3].active = true
                Route4[2].active = false
                Route4[3].active = true
                if v == 'route1' then
                    TriggerEvent(event, Route1[num].coord.x, Route1[num].coord.y, Route1[num].coord.z, k)
                    elseif v == 'route2' then
                    TriggerEvent(event, Route2[num].coord.x, Route2[num].coord.y, Route2[num].coord.z, k)
                    elseif v == 'route3' then
                    TriggerEvent(event, Route3[num].coord.x, Route3[num].coord.y, Route3[num].coord.z, k)
                    elseif v == 'route4' then
                    TriggerEvent(event, Route4[num].coord.x, Route4[num].coord.y, Route4[num].coord.z, k)
                end                
                Citizen.Wait(Config.Duration)
                Route1[2].delivered = true
                Route2[2].delivered = true
                Route3[2].delivered = true
                Route4[2].delivered = true
            elseif zone == 3 then
                Route1[3].active = false
                Route1[4].active = true
                Route2[3].active = false
                Route2[4].active = true
                Route3[3].active = false
                Route3[4].active = true
                Route4[3].active = false
                Route4[4].active = true
                if v == 'route1' then
                    TriggerEvent(event, Route1[num].coord.x, Route1[num].coord.y, Route1[num].coord.z, k)
                    elseif v == 'route2' then
                    TriggerEvent(event, Route2[num].coord.x, Route2[num].coord.y, Route2[num].coord.z, k)
                    elseif v == 'route3' then
                    TriggerEvent(event, Route3[num].coord.x, Route3[num].coord.y, Route3[num].coord.z, k)
                    elseif v == 'route4' then
                    TriggerEvent(event, Route4[num].coord.x, Route4[num].coord.y, Route4[num].coord.z, k)
                end                
                Citizen.Wait(Config.Duration)
                Route1[3].delivered = true
                Route2[3].delivered = true
                Route3[3].delivered = true
                Route4[3].delivered = true
            elseif zone == 4 then
                Route1[4].active = false
                Route2[4].active = false
                Route3[4].active = false
                Route4[4].active = false
                TriggerEvent(event, k)
                Route1[4].delivered = true
                Route2[4].delivered = true
                Route3[4].delivered = true
                Route4[4].delivered = true
            end            
        end
    end
end)

RegisterNetEvent('ry_truckerjob:start_route')
AddEventHandler('ry_truckerjob:start_route', function(route)
        for k2,locations in pairs(Config.Routes['route1']) do
            if locations then
                for k,v in ipairs(locations) do
                    table.insert(Route1, v)
                end
            end
        end
        for k2,locations in pairs(Config.Routes['route2']) do
            if locations then
                for k,v in ipairs(locations) do
                    table.insert(Route2, v)
                end
            end
        end
        for k2,locations in pairs(Config.Routes['route3']) do
            if locations then
                for k,v in ipairs(locations) do
                    table.insert(Route3, v)
                end
            end
        end
        for k2,locations in pairs(Config.Routes['route4']) do
            if locations then
                for k,v in ipairs(locations) do
                    table.insert(Route4, v)
                end
            end
        end

        Citizen.Wait(10)
        if route == 'route1' then
            Route1_active = true
            Route1[1].active = true
            Route1[1].delivered = false
            Route1[2].delivered = false
            Route1[3].delivered = false
            Route1[4].delivered = false
        elseif route == 'route2' then
            Route2_active = true
            Route2[1].active = true
            Route2[1].delivered = false
            Route2[2].delivered = false
            Route2[3].delivered = false
            Route2[4].delivered = false
        elseif route == 'route3' then
            Route3_active = true
            Route3[1].active = true
            Route3[1].delivered = false
            Route3[2].delivered = false
            Route3[3].delivered = false
            Route3[4].delivered = false
        elseif route == 'route4' then
            Route4_active = true
            Route4[1].active = true
            Route4[1].delivered = false
            Route4[2].delivered = false
            Route4[3].delivered = false
            Route4[4].delivered = false
        end

        if Route1_active then
            TriggerEvent('ry_updateblip', Route1[1].coord.x, Route1[1].coord.y, Route1[1].coord.z)
        elseif Route2_active then
            TriggerEvent('ry_updateblip', Route2[1].coord.x, Route2[1].coord.y, Route2[1].coord.z)
        elseif Route3_active then
            TriggerEvent('ry_updateblip', Route3[1].coord.x, Route3[1].coord.y, Route3[1].coord.z)
        elseif Route4_active then
            TriggerEvent('ry_updateblip', Route4[1].coord.x, Route4[1].coord.y, Route4[1].coord.z)
        end
end)


RegisterNetEvent('ry_truckerjob:state')
AddEventHandler('ry_truckerjob:state', function(option, k)
        working = option
        Route1_active = option
        Route1 = {}
        Route2_active = option
        Route2 = {}
        Route3_active = option
        Route3 = {}
        Route4_active = option
        Route4 = {}
end)


RegisterNetEvent('ry_truckerjob:statelast')
AddEventHandler('ry_truckerjob:statelast', function(option)
    for k,v in pairs(Config.Routes['route1']['locations']) do 
        Route1_active = option
        Route1 = {}
    end
    for k,v in pairs(Config.Routes['route2']['locations']) do 
        Route2_active = option
        Route2 = {}
    end
    for k,v in pairs(Config.Routes['route3']['locations']) do 
        Route3_active = option
        Route3 = {}
    end
    for k,v in pairs(Config.Routes['route4']['locations']) do 
        Route4_active = option
        Route4 = {}
    end
end)

RegisterNetEvent('ry_truckerjob:updatworking')
AddEventHandler('ry_truckerjob:updatworking', function(option)
    working = option
end)

RegisterNetEvent('ry_updateblip')
AddEventHandler('ry_updateblip', function(x,y,z)
    Activate_Blips(x,y,z)

end)

Citizen.CreateThread(function()
    Wait(1000)
    while PlayerData == nil do Wait(10) end
    if PlayerData.job.name == 'trucker' then
        for k,v in pairs(Config.Markers) do
            if Blips_job[k] ~= nil then
                RemoveBlip(Blips[k])
                Blips[k] = nil
            end
                Blips_job[k] = AddBlipForCoord(v.coord.x, v.coord.y, v.coord.z)
                SetBlipSprite (Blips_job[k], v.blip.Sprite)
                SetBlipDisplay(Blips_job[k], 4)
                SetBlipScale  (Blips_job[k], v.blip.Scale)
                SetBlipColour (Blips_job[k], v.blip.Colour)
                SetBlipAsShortRange(Blips_job[k], true)
                    
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(v.blip.Name)
                EndTextCommandSetBlipName(Blips_job[k])
        end
    end
end)