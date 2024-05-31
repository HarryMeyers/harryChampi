-------------------------------------------------------
-- DECLARATIONS ET INITIALISATIONS
-------------------------------------------------------
local ESX = GetResourceState('es_extended') == 'started' and exports.es_extended:getSharedObject()

local champiMessage = ""

local EffetChampis = 0

-------------------------------------------------------
-- FUNCTIONS 
-------------------------------------------------------
-- Pour gérer les problèmes de vision
local function startTimecycle(timecycleName, maxTimecycleStrenght)
    maxTimecycleStrenght = maxTimecycleStrenght or 1.0

    local time = 10000 -- Time to reach max strenght
    local interval = 100 -- Strenght increases each interval

    local streghtToAddEachInterval = maxTimecycleStrenght / (time/interval)

    local timecycleStrength = 0.0

    SetTimecycleModifier(timecycleName)
    
    while time >= 0 do
        SetTimecycleModifierStrength(timecycleStrength)
        Citizen.Wait(interval)
        time = time - interval

        timecycleStrength = timecycleStrength + streghtToAddEachInterval
    end
end

-------------------------------------------------------
-- EVENTS
-------------------------------------------------------
-- Event qui est appelé depuis les boxZones pour effectuer le ramassage de champis
RegisterNetEvent('harryChampi:client:trouvezMesChampis', function()
    local playerPed = PlayerPedId()
	local qteChampi = math.random(2,5)
	TriggerServerEvent('harryChampi:server:Inventory', 'champicru', 'add', qteChampi)
    champiMessage = "Vous avez trouvé " .. qteChampi .. " champignons"		
	-- Message pour le joueur (tu mets ton script message à la place bien évidemment)
	--exports['MJ_Notify']:Alert("Interraction", champiMessage, config.champiZones.timeMessage, "Announce")
	ESX.ShowNotification(champiMessage)
end)


-- Commande qui sera appelée pour gérer la consommation des champis
RegisterCommand("mangezMesChampis", function(source, args)
    local type = args[1]
	local playerPed = PlayerPedId()
	
	if type == "cru" then
	
		-- Si au moins 1 champignon cru alors
			-- remove le champi cru, 
			-- applique un flou sur la vision
			-- ralenti le déplacement
			-- pendant xx secondes (voir config)
			-- avec un message d'info au joueur comme quoi il a été malade
		if exports.ox_inventory:Search('count', 'champicru') > 0 then 
			TriggerServerEvent('harryChampi:server:Inventory', 'champicru', 'del', '1')
			
			if EffetChampis == 0 then			
				champiMessage = "Manger ce champignon cru t\'as rendu malade"				
				
				EffetChampis = Config.timeChampiCru
				local timer = 0
				
				-- Règlages pour les effets négatifs sur le déplacement
				local animSet = "move_m@drunk@moderatedrunk"
				local transitionSpeed = 5.0
				RequestAnimSet(animSet)
				while not HasAnimSetLoaded(animSet) do
					Citizen.Wait(0)
				end
				
				-- Règlages pour les effets négatifs sur la vision
				local currentTimecycle = GetTimecycleModifierIndex()
				local timecycleName = "drug_wobbly"
				local timecycleStrenght = 1.0
		        startTimecycle(timecycleName, timecycleStrenght)
								
				while timer <= EffetChampis do
					-- Effet négatif du déplacement
					SetPedMovementClipset(playerPed, animSet, transitionSpeed)
					-- Effet négatif sur la vision
					if(GetTimecycleModifierIndex() == -1 or GetTimecycleModifierIndex() == currentTimecycle) then
						SetTimecycleModifier(timecycleName)
						SetTimecycleModifierStrength(timecycleStrenght)
					end							
					Citizen.Wait(1000)
					timer = timer + 1000
				end
				-- Enlève les effets négatifs
				ResetPedMovementClipset(playerPed, transitionSpeed)
				ClearTimecycleModifier()
				EffetChampis = 0
			else
				EffetChampis = EffetChampis + Config.timeChampiCru
			end
			
        else
            champiMessage = "Pas de champignon cru sur toi"
        end			
			
    elseif type == "cuit" then
	
		-- Si au moins 1 champignon cuit alors
			-- remove le champi cuit, 
			-- applique une restauration de l'endurance,
			-- accélère le déplacement de 30%
			-- pendant xx secondes (voir config)
			-- avec un message d'info au joueur comme quoi il a été dopé par le super champignon, go Mario !
		if exports.ox_inventory:Search('count', 'champicuit') > 0 then 
			TriggerServerEvent('harryChampi:server:Inventory', 'champicuit', 'del', '1')
			
			-- Mettre effet positifs ici
            ResetPlayerStamina(playerPed) -- Restauration de l'endurance
			
            champiMessage = "Manger ce champignon cuit t'\as donné des ailes"
        else
            champiMessage = "Pas de champignon cuit sur toi"
        end
    else
		if args[1] == null then args[1] = "Nul" end
        champiMessage = "Erreur DEV - paramètre [" .. args[1] .. "] invalide"
    end
	
	-- Message pour le joueur (tu mets ton script message à la place bien évidemment)
	--exports['MJ_Notify']:Alert("Interraction", champiMessage, config.champiZones.timeMessage, "Announce")
	ESX.ShowNotification(champiMessage)
end, false)


-- Commande qui sera appelée pour faire cuire les champignons
RegisterCommand("cuireChampis", function(source)

	-- Si au moins 1 champignon cru alors
		-- Si au moins 1 poele alors
			-- remove le champi cru, 
			-- ajoute le champi cuit,
			-- avec un message d'info au joueur comme quoi la cuisson est ok
    if exports.ox_inventory:Search('count', 'champicru') > 0 then 
		if exports.ox_inventory:Search('count', 'poele') > 0 then 
			TriggerServerEvent('harryChampi:server:Inventory', 'champicru', 'del', '1')
			TriggerServerEvent('harryChampi:server:Inventory', 'champicuit', 'add', '1')
			champiMessage = "Cuisson du champignon réussie"
		else
			champiMessage = "Il te manque des accessoires pour faire cuire tes champignons"
		end
	else
		champiMessage = "Pas de champignon cru sur toi"
    end
	-- Message pour le joueur (tu mets ton script message à la place bien évidemment)
	--exports['MJ_Notify']:Alert("Interraction", champiMessage, config.champiZones.timeMessage, "Announce")
	ESX.ShowNotification(champiMessage)
end, false)


-------------------------------------------------------
-- OX TARGET
-------------------------------------------------------
-- BoxZone pour ramassage des champignons
exports.ox_target:addBoxZone({
    coords = vector3(1413.70, -2606.01, 47.93),
    size = vector3(5.0, 5.0, 2.0),
    rotation = 0.0,
    debug = true,
    options = {
        {
            name = 'harryChampi:client:trouvezMesChampis',
            label = "Zone à champignons 1",
            event = 'harryChampi:client:trouvezMesChampis',
            distance = 3.0,
        },
    },
})




