local ox = exports.ox_inventory
local door = false
local repair = false
local wash = false
local flip = false
local impound = false

function impoundVehicle()
    local playerPed = cache.ped or PlayerPedId()
    local vehicle = ESX.Game.GetVehicleInDirection()
    local coords = cache.coords or GetEntityCoords(playerPed)

    if DoesEntityExist(vehicle) then
        impound = true
        TaskStartScenarioInPlace(playerPed, "CODE_HUMAN_MEDIC_TEND_TO_DEAD")
        lib.progressCircle({
            duration = 10000,
            label = 'Impounding the vehicle',
            position = 'middle',
            useWhileDead = false,
            canCancel = true,
            disable = {
                move = true,
            },
        })
        DeleteEntity(vehicle)
        ClearPedTasks(playerPed)
        lib.notify({
            id = 'some_identifier',
            title = 'Krs Mechanic Menu',
            description = 'The vehicle was seized',
            position = 'top',
            style = {
                backgroundColor = '#141517',
                color = '#C1C2C5',
                ['.description'] = {
                    color = '#909296'
                }
            },
            icon = 'fa-solid fa-toolbox', 
            iconColor = '#F8F9FA'
        })
        impound = false
    else
        lib.notify({
            id = 'some_identifier',
            title = 'Krs Mechanic Error',
            description = 'No vehicles nearby',
            position = 'top',
            style = {
                backgroundColor = '#141517',
                color = '#C1C2C5',
                ['.description'] = {
                    color = '#909296'
                }
            },
            icon = 'fa-solid fa-toolbox', 
            iconColor = '#F8F9FA'
        })
    end
end

function doorsLocked()
    local playerPed = cache.ped or PlayerPedId()
    local vehicle = ESX.Game.GetVehicleInDirection()
    local coords = cache.coords or GetEntityCoords(playerPed)

    local lockpick = ox:Search('count', 'lockpick') 
    if lockpick < 1 then
        lib.notify({
            id = 'some_identifier',
            title = 'Krs Mechanic Error',
            description = 'You don\'t have the lockpick.',
            position = 'top',
            style = {
                backgroundColor = '#141517',
                color = '#C1C2C5',
                ['.description'] = {
                    color = '#909296'
                }
            },
            icon = 'fa-solid fa-screwdriver', 
            iconColor = '#F8F9FA'
        })
        return
    end
    TriggerServerEvent('krs_lockpick:removeItems', lockpick)
    local success = lib.skillCheck({'easy', 'easy', { areaSize = 60, speedMultiplier = 2 }, 'easy'}, {'e', 'e', 'e', 'e'})
    if success then
        if DoesEntityExist(vehicle) then
            door = true
            lib.progressCircle({
                duration = 10000,
                label = 'Unlocking the vehicle',
                position = 'middle',
                useWhileDead = false,
                canCancel = true,
                disable = {
                    move = true,
                },
                anim = {
                    dict = 'mini@repair',
                    clip = 'fixing_a_ped'
                },
            })
            SetVehicleDoorsLocked(vehicle, 1)
            SetVehicleDoorsLockedForAllPlayers(vehicle, false)
            lib.notify({
                id = 'some_identifier',
                title = 'Krs Mechanic Menu',
                description = 'The vehicle was unlocked',
                position = 'top',
                style = {
                    backgroundColor = '#141517',
                    color = '#C1C2C5',
                    ['.description'] = {
                        color = '#909296'
                    }
                },
                icon = 'fa-solid fa-toolbox', 
                iconColor = '#F8F9FA'
            })
            door = false
        else
            lib.notify({
                id = 'some_identifier',
                title = 'Krs Mechanic Error',
                description = 'No vehicles nearby',
                position = 'top',
                style = {
                    backgroundColor = '#141517',
                    color = '#C1C2C5',
                    ['.description'] = {
                        color = '#909296'
                    }
                },
                icon = 'fa-solid fa-toolbox', 
                iconColor = '#F8F9FA'
            })
        end
    else
        lib.notify({
            id = 'some_identifier',
            title = 'Krs Mechanic Error',
            description = 'Error during the skill minigame',
            position = 'top',
            style = {
                backgroundColor = '#141517',
                color = '#C1C2C5',
                ['.description'] = {
                    color = '#909296'
                }
            },
            icon = 'fa-solid fa-toolbox', 
            iconColor = '#F8F9FA'
        })
    end
end


function flipVehicle()
    local playerPed = cache.ped or PlayerPedId()
    local vehicle = ESX.Game.GetVehicleInDirection()
    local coords = cache.coords or GetEntityCoords(playerPed)

    if DoesEntityExist(vehicle) then
        flip = true
        lib.progressCircle({
            duration = 10000,
            label = 'Vehicle overturning',
            position = 'middle',
            useWhileDead = false,
            canCancel = true,
            disable = {
                move = true,
            },
            anim = {
                dict = 'missfinale_c2ig_11',
                clip = 'pushcar_offcliff_m',
            },
        })
        local coords = GetEntityRotation(vehicle, 2)
        SetEntityRotation(vehicle, coords[1], 0, coords[3], 2, true)
        SetVehicleOnGroundProperly(vehicle)
        lib.notify({
            id = 'some_identifier',
            title = 'Krs Mechanic Menu',
            description = 'The vehicle was overturned',
            position = 'top',
            style = {
                backgroundColor = '#141517',
                color = '#C1C2C5',
                ['.description'] = {
                    color = '#909296'
                }
            },
            icon = 'fa-solid fa-toolbox', 
            iconColor = '#F8F9FA'
        })
        flip = false
    else
        lib.notify({
            id = 'some_identifier',
            title = 'Krs Mechanic Error',
            description = 'No vehicles nearby',
            position = 'top',
            style = {
                backgroundColor = '#141517',
                color = '#C1C2C5',
                ['.description'] = {
                    color = '#909296'
                }
            },
            icon = 'fa-solid fa-toolbox', 
            iconColor = '#F8F9FA'
        })
    end
end

function repairVehicle()
    local playerPed = cache.ped or PlayerPedId()
    local vehicle = ESX.Game.GetVehicleInDirection()
    local coords = cache.coords or GetEntityCoords(playerPed)

    local kit = ox:Search('count', 'fixkit') 
    if kit < 1 then
        lib.notify({
            id = 'some_identifier',
            title = 'Krs Mechanic Error',
            description = 'You don\'t have the repair kit.',
            position = 'top',
            style = {
                backgroundColor = '#141517',
                color = '#C1C2C5',
                ['.description'] = {
                    color = '#909296'
                }
            },
            icon = 'fa-solid fa-toolbox', 
            iconColor = '#F8F9FA'
        })
        return
    end

    TriggerServerEvent('krs_fixkit:removeItems', kit)

    if DoesEntityExist(vehicle) then
        repair = true
        TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 10000, true)
        lib.progressCircle({
            duration = 10000,
            label = 'Repairing the vehicle',
            position = 'middle',
            useWhileDead = false,
            canCancel = true,
            disable = {
                move = true,
            },
        })
        SetVehicleFixed(vehicle)
        SetVehicleDeformationFixed(vehicle)
        SetVehicleUndriveable(vehicle, false)
        SetVehicleEngineOn(vehicle, true, true)
        ClearPedTasksImmediately(playerPed)
        lib.notify({
            id = 'some_identifier',
            title = 'Krs Mechanic Menu',
            description = 'The vehicle has been repaired',
            position = 'top',
            style = {
                backgroundColor = '#141517',
                color = '#C1C2C5',
                ['.description'] = {
                    color = '#909296'
                }
            },
            icon = 'fa-solid fa-toolbox', 
            iconColor = '#F8F9FA'
        })
        repair = false
    else
        lib.notify({
            id = 'some_identifier',
            title = 'Krs Mechanic Error',
            description = 'No vehicles nearby',
            position = 'top',
            style = {
                backgroundColor = '#141517',
                color = '#C1C2C5',
                ['.description'] = {
                    color = '#909296'
                }
            },
            icon = 'fa-solid fa-toolbox', 
            iconColor = '#F8F9FA'
        })
    end
end


function cleanVehicle()
    local playerPed = cache.ped or PlayerPedId()
    local vehicle = ESX.Game.GetVehicleInDirection()
    local coords = cache.coords or GetEntityCoords(playerPed)

    local sponge = ox:Search('count', 'sponge') 
    if sponge < 1 then
        lib.notify({
            id = 'some_identifier',
            title = 'Krs Mechanic Error',
            description = 'You don\'t have the sponge.',
            position = 'top',
            style = {
                backgroundColor = '#141517',
                color = '#C1C2C5',
                ['.description'] = {
                    color = '#909296'
                }
            },
            icon = 'fa-solid fa-soap', 
            iconColor = '#F8F9FA'
        })
        return
    end

    TriggerServerEvent('krs_sponge:removeItems', sponge)

    if DoesEntityExist(vehicle) then
        wash = true
        lib.progressCircle({
            duration = 10000,
            label = 'Washing the vehicle',
            position = 'middle',
            useWhileDead = false,
            canCancel = true,
            disable = {
                move = true,
            },
            anim = {
                dict = 'amb@world_human_maid_clean@',
                clip = 'base',
                flag = 1
            },
            prop = {
                model = `prop_sponge_01`,
                pos = vector3(0.0, 0.0, -0.01),
                rot = vector3(90.0, 0.0, 0.0),
                bone = 28422
            },
        })
        SetVehicleDirtLevel(vehicle, 0)
        lib.notify({
            id = 'some_identifier',
            title = 'Krs Mechanic Menu',
            description = 'The vehicle is clean',
            position = 'top',
            style = {
                backgroundColor = '#141517',
                color = '#C1C2C5',
                ['.description'] = {
                    color = '#909296'
                }
            },
            icon = 'fa-solid fa-toolbox', 
            iconColor = '#F8F9FA'
        })
        wash = false
    else
        lib.notify({
            id = 'some_identifier',
            title = 'Krs Mechanic Error',
            description = 'No vehicles nearby',
            position = 'top',
            style = {
                backgroundColor = '#141517',
                color = '#C1C2C5',
                ['.description'] = {
                    color = '#909296'
                }
            },
            icon = 'fa-solid fa-toolbox', 
            iconColor = '#F8F9FA'
        })
    end
end