ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('ry_truckerjob:pay')
AddEventHandler('ry_truckerjob:pay', function(amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer ~= nil then
		xPlayer.addMoney(tonumber(amount))
	end
end)