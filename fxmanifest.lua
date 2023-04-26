fx_version 'cerulean'
game 'gta5'

name "Prototipo de API ChatGPT-3.5 Turbo"
author "MikyDev"
version "1.0.0"
lua54 'yes'


shared_scripts {'@ox_lib/init.lua', '@es_extended/imports.lua'}

client_scripts {
	'config.lua',
	'client.lua'
}

server_scripts {
	'config.lua',
	'server.lua'
}

