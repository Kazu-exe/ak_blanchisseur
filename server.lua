ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('akira:blanchiment')
AddEventHandler('akira:blanchiment', function(argent)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local taxe = 0.50 -- Changer la taxe %  

	argent = ESX.Math.Round(tonumber(argent))
	pourcentage = argent * taxe
	Total = ESX.Math.Round(tonumber(pourcentage))

	if argent > 0 and xPlayer.getAccount('black_money').money >= argent then
		xPlayer.removeAccountMoney('black_money', argent)
		TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, 'Taylor', 'Blanchiment', 'Az attend bouge pas j\'arrive !', 'CHAR_ARTHUR', 8)
		Citizen.Wait(10000)
		
		TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, 'Taylor', 'Blanchiment', 'Tien ton argent ' .. ESX.Math.GroupDigits(Total) .. '$', 'CHAR_ARTHUR', 8)
		xPlayer.addMoney(Total)
	else
		TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, 'Taylor', 'Blanchiment', '~r~Ta pas assez trou du cul', 'CHAR_ARTHUR', 8)
	end	
end)
