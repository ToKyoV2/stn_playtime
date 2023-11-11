fx_version 'cerulean'
game 'gta5'

lua54 'yes'

description 'stn_playtime'

shared_script '@ox_lib/init.lua'

client_script 'client.lua'

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'main.lua'
}