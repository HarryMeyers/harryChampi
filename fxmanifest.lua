fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Harry MEYERS - Discord : harrymeyers'
description 'Les champis c la vie'
version '1.0.0'


shared_scripts {
	'config/*.lua',
    '@ox_lib/init.lua'
}

client_scripts {
	'client/*.lua',
}

server_script {
	'server/*.lua',
}

dependencies {
    'ox_inventory',
    'ox_lib',
}

