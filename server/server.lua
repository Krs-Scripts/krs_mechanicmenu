local ox = exports.ox_inventory

local sponge = 'sponge'
local fixkit = 'fixkit'
local lockpick = 'lockpick'

RegisterNetEvent('krs_fixkit:removeItems', function(kit)
    local source = source

    local player = ox:GetItem(source, fixkit, false, true)

    if player >= 1 then
        ox:RemoveItem(source, fixkit, 1)
    end
end)

RegisterNetEvent('krs_sponge:removeItems', function(sponge)
    local source = source

    local player = ox:GetItem(source, sponge, false, true)

    if player >= 1 then
        ox:RemoveItem(source, sponge, 1)
    end
end)

RegisterNetEvent('krs_lockpick:removeItems', function(lockpick)
    local source = source

    local player = ox:GetItem(source, lockpick, false, true)

    if player >= 1 then
        ox:RemoveItem(source, lockpick, 1)
    end
end)

