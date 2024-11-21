local sponge = 'sponge'
local fixkit = 'fixkit'
local lockpick = 'lockpick'

RegisterNetEvent('krs_fixkit:removeItems', function(kit)
    local source = source

    local player = exports.ox_inventory:GetItem(source, fixkit, false, true)

    if player >= 1 then
        exports.ox_inventory:RemoveItem(source, fixkit, 1)
    end
end)

RegisterNetEvent('krs_sponge:removeItems', function(sponge)
    local source = source

    local player = exports.ox_inventory:GetItem(source, sponge, false, true)

    if player >= 1 then
        exports.ox_inventory:RemoveItem(source, sponge, 1)
    end
end)

RegisterNetEvent('krs_lockpick:removeItems', function(lockpick)
    local source = source

    local player = exports.ox_inventory:GetItem(source, lockpick, false, true)

    if player >= 1 then
        exports.ox_inventory:RemoveItem(source, lockpick, 1)
    end
end)
