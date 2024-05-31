-------------------------------------------------------
-- DECLARATIONS ET INITIALISATIONS
-------------------------------------------------------
local ESX = GetResourceState('es_extended') == 'started' and exports.es_extended:getSharedObject()

RegisterNetEvent('harryChampi:server:Inventory', function(item, action, quantity)
local src = source	
	--print("item " .. item .. " action " .. action .. " quantity " .. quantity)
	
	if action =="add" then
		exports.ox_inventory:AddItem(src, item, quantity)
	elseif action == "del" then 
		exports.ox_inventory:RemoveItem(src, item, quantity)
	-- elseif action == "qte" then
		-- local itemCount = exports.ox_inventory:GetItemCount(src, item)
		-- print (itemCount .. " de " .. item)
	else
		print ("Erreur DEV - paramètre [" .. action .. "] invalide")
	end
end)