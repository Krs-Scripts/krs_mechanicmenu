local door, repair, wash, flip = false, false, false, false

local function getNearbyVehicle()
    local playerPed = cache.ped
    local coords = GetEntityCoords(playerPed)
    local vehicle = lib.getClosestVehicle(coords, 2.0, false)

    if DoesEntityExist(vehicle) then
        return vehicle
    else
        lib.notify({ title = 'Krs mechanic', description = 'No vehicles nearby', type = 'error' })
        return nil
    end
end

--- Unlock vehicle doors with lockpicking
function doorsLocked()
    local vehicle = getNearbyVehicle()
    if not vehicle then return end

    local lockpickCount = exports.ox_inventory:Search('count', 'lockpick')
    if lockpickCount < 1 then
        exports.krs_notify:Alert("NOTIFY", "Non hai il grimaldello.", 4000, 'error')
        return
    end

    TriggerServerEvent('krs_lockpick:removeItems', 1)
    local success = lib.skillCheck({'easy', 'easy', { areaSize = 60, speedMultiplier = 2 }, 'easy'}, {'e', 'e', 'e', 'e'})
    if success then
        lib.progressCircle({
            duration = 10000,
            label = 'Unlocking the vehicle',
            position = 'middle',
            useWhileDead = false,
            canCancel = true,
            disable = { move = true },
            anim = { dict = 'mini@repair', clip = 'fixing_a_ped' },
        })
        SetVehicleDoorsLocked(vehicle, 1)
        SetVehicleDoorsLockedForAllPlayers(vehicle, false)
        exports.krs_notify:Alert("NOTIFY", "Il veicolo è stato sbloccato.", 4000, 'success')
    else
        exports.krs_notify:Alert("NOTIFY", "Errore durante il minigioco.", 4000, 'error')
    end
end

--- Flip a vehicle
function flipVehicle()
    local vehicle = getNearbyVehicle()
    if not vehicle then return end

    lib.progressCircle({
        duration = 10000,
        label = 'Vehicle overturning',
        position = 'middle',
        useWhileDead = false,
        canCancel = true,
        disable = { move = true },
        anim = { dict = 'missfinale_c2ig_11', clip = 'pushcar_offcliff_m' },
    })
    SetVehicleOnGroundProperly(vehicle)
    exports.krs_notify:Alert("NOTIFY", "Il veicolo è stato ribaltato", 4000, 'success')
end

--- Repair a vehicle
function repairVehicle()
    local vehicle = getNearbyVehicle()
    if not vehicle then return end

    local kitCount = exports.ox_inventory:Search('count', 'fixkit')
    if kitCount < 1 then
        exports.krs_notify:Alert("NOTIFY", "Non hai il kit di riparazione.", 4000, 'error')
        return
    end

    TriggerServerEvent('krs_fixkit:removeItems', 1)
    TaskStartScenarioInPlace(cache.ped, 'PROP_HUMAN_BUM_BIN', 10000, true)
    lib.progressCircle({
        duration = 10000,
        label = 'Repairing the vehicle',
        position = 'middle',
        useWhileDead = false,
        canCancel = true,
        disable = { move = true },
    })
    SetVehicleFixed(vehicle)
    SetVehicleDeformationFixed(vehicle)
    SetVehicleUndriveable(vehicle, false)
    SetVehicleEngineOn(vehicle, true, true)
    ClearPedTasksImmediately(cache.ped)
    exports.krs_notify:Alert("NOTIFY", "Il veicolo è stato riparato", 4000, 'success')
end

--- Clean a vehicle
function cleanVehicle()
    local vehicle = getNearbyVehicle()
    if not vehicle then return end

    local spongeCount = exports.ox_inventory:Search('count', 'sponge')
    if spongeCount < 1 then
        exports.krs_notify:Alert("NOTIFY", "Non hai la spugna.", 4000, 'error')
        return
    end

    TriggerServerEvent('krs_sponge:removeItems', 1)
    lib.progressCircle({
        duration = 10000,
        label = 'Washing the vehicle',
        position = 'middle',
        useWhileDead = false,
        canCancel = true,
        disable = { move = true },
        anim = { dict = 'amb@world_human_maid_clean@', clip = 'base', flag = 1 },
        prop = {
            model = `prop_sponge_01`,
            pos = vector3(0.0, 0.0, -0.01),
            rot = vector3(90.0, 0.0, 0.0),
            bone = 28422
        },
    })
    SetVehicleDirtLevel(vehicle, 0)
    exports.krs_notify:Alert("NOTIFY", "Il veicolo è pulito", 4000, 'success')
end
