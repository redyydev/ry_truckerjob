local working = false
local truck_details = {truck = '',trailer = '',plate = '', info = 0}
local Blips = {}

local delivery_truck = false

RegisterNetEvent('ry_truckerjob:start_job')
AddEventHandler('ry_truckerjob:start_job', function()
	start_job()
end)

function start_job()
	local elements = {}

	table.insert(elements, {label = Config.Menus['start'].label, value = 'start'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'startjob',
		{
			title    =  Config.Menus['start'].name,
			align    = 'center-left',
			elements = elements
		},
		function (data,menu)
			if data.current.value == 'start' then
				truck_menu()
			end
			menu.close()
		end)
end

function truck_menu()

	local elements = {}

	for i=1, #Config.Menus['trucks'].options, 1 do
		table.insert(elements, {label = GetLabelText(GetDisplayNameFromVehicleModel(Config.Menus['trucks'].options[i])), value = Config.Menus['trucks'].options[i]})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'truckselect',
		{
			title    = Config.Menus['trucks'].name,
			align    = 'center-left',
			elements = elements
		},
		function (data,menu)
			truck_details.truck = data.current.value
			trailer_menu()

			menu.close()
		end)
end

function trailer_menu()

	local elements = {}

	for k,v in pairs(Config.Menus['trailers'].options) do 
		table.insert(elements, {label = v.name, value = k})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'trailerselect',
		{
			title    = Config.Menus['trailers'].name,
			align    = 'center-left',
			elements = elements
		},
		function (data,menu)
			truck_details.trailer = data.current.value
			Citizen.Wait(10)
			confirm()
			menu.close()
		end)
end

function confirm()

	local elements = {}

	table.insert(elements, {label = Config.Menus['confirm'].yes.label, value = 'confirm'})
	table.insert(elements, {label = Config.Menus['confirm'].no.label, value = 'cancel'})

	ESX.UI.Menu.CloseAll()

	
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'cancelselect',
		{
			title    = Config.Menus['confirm'].name,
			align    = 'center-left',
			elements = elements
		},
		function (data,menu)
			
			if data.current.value == 'confirm' then
				start_travel()
				TriggerEvent('ry_truckerjob:updatworking', true)
				working = true
			end

			if data.current.value == 'cancel' then
				truck_details.truck = ''
				truck_details.trailer = ''
				ESX.UI.Menu.CloseAll()
			end

			menu.close()
		end)
end

function start_travel()
	ESX.Game.SpawnVehicle(truck_details.truck, Config.SpawnPointTrucker, 270.0, function(vehicle)
			platenum = math.random(10000, 99999)
			truck_details.plate = "WAL" .. platenum
			truck_details.info = vehicle

			SetVehicleNumberPlateText(vehicle, "WAL" .. platenum)

			if Config.TeleportPlayerToTruck then
				TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)  
			end

			Citizen.Wait(1)

			ESX.Game.SpawnVehicle(truck_details.trailer, Config.SpawnPointTrucker, 270.0, function(trailer)
				AttachVehicleToTrailer(vehicle, trailer, 1.1)
				for k,v in pairs(Config.Menus['trailers'].options) do 
					if truck_details.trailer == k then
						TriggerEvent('ry_truckerjob:' .. v.route, v.route)
					end
				end
			end)
	end)
end

function start_route(route)
	if route == 'route1' then
		TriggerEvent('ry_truckerjob:start_route', 'route1')
	elseif route == 'route2' then
		TriggerEvent('ry_truckerjob:start_route', 'route2')
	elseif route == 'route3' then
		TriggerEvent('ry_truckerjob:start_route', 'route3')
	elseif route == 'route4' then
		TriggerEvent('ry_truckerjob:start_route', 'route4')
	end
end

function Activate_Blips(x,y ,z)
	if Blips['delivery'] ~= nil then
		RemoveBlip(Blips['delivery'])
		Blips['delivery'] = nil
	end

	Blips['delivery'] = AddBlipForCoord(x,y,z)
	SetBlipRoute(Blips['delivery'], true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Delivery Spot')
	EndTextCommandSetBlipName(Blips['delivery'])
end

function DrawText3Ds(x, y, z, text)
	local px, py, pz = table.unpack(GetEntityCoords(PlayerPedId()))

	local distance = GetDistanceBetweenCoords(x, y, z, px, py, pz, false)

	if distance <= 6 then
		SetTextScale(0.35, 0.35)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextEntry("STRING")
		SetTextCentre(true)
		AddTextComponentString(text)
		SetDrawOrigin(x,y,z, 0)
		DrawText(0.0, 0.0)
		local factor = (string.len(text)) / 370
		DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
		ClearDrawOrigin()
	end
end

function progress(duration,label,DisableMouse)
	TriggerEvent("ry_progbar:client:progress", {
		name = "delivering",
		duration = Config.Duration,
		label = Config.Label,
		useWhileDead = false,
		canCancel = false,
		controlDisables = {
			disableMovement = false,
			disableCarMovement = true,
			disableMouse =  Config.DisableMouse,
			disableCombat =  false,
		}
	})
end

RegisterNetEvent('ry_truckerjob:delivery')
AddEventHandler('ry_truckerjob:delivery', function(x,y,z)
	RemoveBlip(Blips['delivery'])
	Blips['delivery'] = nil

	progress()
	Citizen.Wait(Config.Duration)
	TriggerServerEvent('ry_truckerjob:pay', Config.MoneyPerDelivery)
	TriggerEvent('ry_updateblip', x,y,z)
	ESX.ShowNotification(Config.ReceiveMoney)
end)

RegisterNetEvent('ry_truckerjob:last_delivery')
AddEventHandler('ry_truckerjob:last_delivery', function(k)
	RemoveBlip(Blips['delivery'])
	Blips['delivery'] = nil
	progress()
	Citizen.Wait(Config.Duration)
	local vehicle_life = GetVehicleEngineHealth(GetVehiclePedIsIn(GetPlayerPed(-1), false))
	if Config.ActivateDamage then
		if vehicle_life >= 650 then
			TriggerServerEvent('ry_truckerjob:pay', Config.DeliveryFinalMoney)
			ESX.ShowNotification(Config.ReceiveFinalMoney)
		else
			local reward = Config.DeliveryFinalMoney
			if vehicle_life < 649 and vehicle_life >= 450 then
				ESX.ShowNotification(Config.ALittleBroken)
				local math = math.ceil(reward / 2.5)
				local final_reward = math
				TriggerServerEvent('ry_truckerjob:pay', final_reward)
				ESX.ShowNotification('You have won ' .. final_reward .. '$ for final delivery.')
			end
			if vehicle_life < 449 and vehicle_life >= 100 then
				local math = math.ceil(reward / 5)
				ESX.ShowNotification(Config.Broken)
				local final_reward = math
				TriggerServerEvent('ry_truckerjob:pay', final_reward)
				ESX.ShowNotification('You have won ' .. final_reward .. '$ for final delivery.')
			end 
		end
	else
		TriggerServerEvent('ry_truckerjob:pay', Config.DeliveryFinalMoney)
		ESX.ShowNotification(Config.ReceiveFinalMoney)
	end

	if Config.DeleteTruckWhenFinish then
		ESX.Game.DeleteVehicle(truck_details.info)
	end
	TriggerEvent('ry_truckerjob:state', false, k)

	if Config.AddDeliveryTruck then
		ESX.ShowNotification(Config.DeliveryTruckNotification)
		Activate_Blips(Config.CoordDeliveryTruck.x, Config.CoordDeliveryTruck.y, Config.CoordDeliveryTruck.z)
		TriggerEvent('ry_truckerjob:updatworking', true)
		delivery_truck = true
	end
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1)
		if delivery_truck then
	
			local coord = GetEntityCoords(PlayerPedId())
			local ped = GetPlayerPed(-1)

			local dist = #(coord - Config.CoordDeliveryTruck)
			local isATruck = false
			for i=1, #Config.Menus['trucks'].options, 1 do
				if IsVehicleModel(GetVehiclePedIsUsing(ped), Config.Menus['trucks'].options[i]) then
					isATruck = true
					break
				end
			end

			if dist < 5 and isATruck then
				DrawText3Ds (Config.CoordDeliveryTruck.x,  Config.CoordDeliveryTruck.y,  Config.CoordDeliveryTruck.z+0.5, Config.MarkerDeliveryTruck)
				if IsControlJustReleased(0, 38) then
					ESX.Game.DeleteVehicle(truck_details.info)
					ESX.ShowNotification(Config.VehicleDelivered)
					TriggerEvent('ry_truckerjob:statelast', false)
					TriggerEvent('ry_truckerjob:updatworking', false)
					TriggerEvent('ry_truckerjob:clearblips')
				end
			end
	
		end
	end
end)

RegisterNetEvent('ry_truckerjob:clearblips')
AddEventHandler('ry_truckerjob:clearblips', function()
	RemoveBlip(Blips['delivery'])
	Blips['delivery'] = nil
end)

RegisterNetEvent('ry_truckerjob:updatworking2')
AddEventHandler('ry_truckerjob:updatworking2', function(option)
    working = option
	ESX.Game.DeleteVehicle(truck_details.info)
	TriggerEvent('ry_truckerjob:updatworking', option)
end)

RegisterNetEvent('ry_truckerjob:route1')
AddEventHandler('ry_truckerjob:route1', function(route)
    start_route(route)
end)

RegisterNetEvent('ry_truckerjob:route2')
AddEventHandler('ry_truckerjob:route2', function(route)
	start_route(route)
end)

RegisterNetEvent('ry_truckerjob:route3')
AddEventHandler('ry_truckerjob:route3', function(route)
	start_route(route)
end)

RegisterNetEvent('ry_truckerjob:route4')
AddEventHandler('ry_truckerjob:route4', function(route)
	start_route(route)
end)
