local oxT = exports.ox_target
local PlayerData = {}

AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

RegisterCommand('testJob', function()
    print(PlayerData.job.name)
end)

oxT:addGlobalVehicle({
	
    {
        icon = Krs.iconFixkit,  
        label = Krs.labelFixkit,
        groups = Krs.jobname,
        distance = 3,
        canInteract = function(entity)
            return not IsEntityDead(entity)
        end,
        onSelect = function(data)
            repairVehicle()
        end
    },
    {
        icon = Krs.iconFlipVehicle, 
        label = Krs.labelFlipVehicle,
        groups = Krs.jobname,
        distance = 3,
        canInteract = function(entity)
            return not IsEntityDead(entity)
        end,
        onSelect = function(data)
            flipVehicle()
        end
    },
    {
        icon = Krs.iconLockPick, 
        label = Krs.labelLockPick,
        groups = Krs.jobname,
        distance = 3,
        canInteract = function(entity)
            return not IsEntityDead(entity)
        end,
        onSelect = function(data)
            doorsLocked()
        end
    },
    {
        icon = Krs.iconSponge, 
        label = Krs.labelSponge,
        groups = Krs.jobname,
        distance = 3,
        canInteract = function(entity)
            return not IsEntityDead(entity)
        end,
        onSelect = function(data)
            cleanVehicle()
        end
    },
    {
        icon = Krs.iconImpound, 
        label = Krs.labelImpound,
        groups = Krs.jobname,
        distance = 3,
        canInteract = function(entity)
            return not IsEntityDead(entity)
        end,
        onSelect = function(data)
            impoundVehicle()
        end
    },
})