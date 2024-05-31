VERSION ACTUELLE

-- v 1.0.0 : harryChampi
Ramasse 2 à 5 champignons dans certaines zones (1 indiquée par défaut en mode DEBUG)
	Ces champignons sont crus et s'ils sont consommés génèrent : 
		- des troubles de la vision
		- ralentissent le déplacement du joueur
	Si ces champignons crus sont cuits alors ils génèrent : 
		- restauration de l'endurance
		- ... ce que vous voulez ...

Pour cuire les champignons, l'item POELE est nécessaire dans l'inventaire (pas d'animation ni de crafting pour le moment)


VERSIONS A VENIR

-- v 1.1.0 : harryChampi
Les champignons ramassés sont aléatoires 
	- indiqués comme "Champignon inconnu" dans leur data LABEL
	
-- v 1.1.1 : harryChampi
Possibilité d'identifier les champignons grâce à un item LIVRE CHAMPIGNON

Les champignons inconnus qui sont déplacé (mode craft par expl) sur le LIVRE CHAMPIGNON sont alors : 
	- indiqués comme "Champignon xxxxxxxxx" dans leur data LABEL 
		xxxxxx pouvant être 
			"euphorisant" 	: gain d'endurance	  
			"stimulant"		: gain de vitesse
			"fortifiant"	: gain de force
			"réparateur"	: gain de vie
			"nourrisant"	: gain de nourriture
			"humide"		: gain d'eau







INSTALLATION / UTILISATION

-- A rajouter dans ox_inventory/web/images/
	Les 4 images dans le dossier /images

-- A rajouter dans ox_inventory/data/items.lua	
	
	['poele'] = {
		label = 'Poele',
		weight = 1000,
		stack = false,
		close = true,		
		client = {
			-- anim = { dict = 'missheistdockssetup1clipboard@idle_a', clip = 'idle_a', flag = 49 },
			-- prop = { model = `prop_rolled_sock_02`, pos = vec3(-0.14, -0.14, -0.08), rot = vec3(-50.0, -50.0, 0.0) },
			disable = { move = true, car = true, combat = true },
			usetime = 2500,
			image = 'poele.png',
		}			
	},	
	
	['marmitte'] = {
		label = 'Marmitte',
		weight = 1000,
		stack = false,
		close = true,		
		client = {
			disable = { move = true, car = true, combat = true },
			usetime = 2500,
			image = 'marmitte.png',
		}			
	},	

	
	['champicru'] = {
		label = 'Champignons Cru',
		weight = 500,
		stack = true,
		close = true,		
		client = {
			disable = { move = true, car = true, combat = true },
			usetime = 2500,
			image = 'champicru.png',
		}			
	},

	
	['champicuit'] = {
		label = 'Champignons Cuit',
		weight = 250,
		stack = false,
		close = true,		
		client = {
			disable = { move = true, car = true, combat = true },
			usetime = 2500,
			image = 'champicuit.png',
		}			
	},
