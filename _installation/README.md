VERSION ACTUELLE

-- v 1.0.0 : harryChampi
Ramasse 2 � 5 champignons dans certaines zones (1 indiqu�e par d�faut en mode DEBUG)
	Ces champignons sont crus et s'ils sont consomm�s g�n�rent : 
		- des troubles de la vision
		- ralentissent le d�placement du joueur
	Si ces champignons crus sont cuits alors ils g�n�rent : 
		- restauration de l'endurance
		- ... ce que vous voulez ...

Pour cuire les champignons, l'item POELE est n�cessaire dans l'inventaire (pas d'animation ni de crafting pour le moment)


VERSIONS A VENIR

-- v 1.1.0 : harryChampi
Les champignons ramass�s sont al�atoires 
	- indiqu�s comme "Champignon inconnu" dans leur data LABEL
	
-- v 1.1.1 : harryChampi
Possibilit� d'identifier les champignons gr�ce � un item LIVRE CHAMPIGNON

Les champignons inconnus qui sont d�plac� (mode craft par expl) sur le LIVRE CHAMPIGNON sont alors : 
	- indiqu�s comme "Champignon xxxxxxxxx" dans leur data LABEL 
		xxxxxx pouvant �tre 
			"euphorisant" 	: gain d'endurance	  
			"stimulant"		: gain de vitesse
			"fortifiant"	: gain de force
			"r�parateur"	: gain de vie
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
