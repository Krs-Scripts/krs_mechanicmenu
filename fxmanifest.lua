fx_version "cerulean"
use_fxv2_oal "yes"
lua54 "yes"
game "gta5"
version "1.0.0"
description "A simple interactmechanic system"
name 'krs_interactmechanic'
author "karos7804"

shared_scripts {
	'@es_extended/imports.lua',
	'@ox_lib/init.lua',
	'config.lua'
}

server_scripts {
	'server/*.lua'
}

client_scripts {
	'client/*.lua'
}

dependency {
    'ox_lib',
    'ox_target',
    'ox_inventory',
}
