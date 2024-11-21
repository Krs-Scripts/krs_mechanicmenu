

exports.ox_target:addGlobalVehicle({
	
    {
        icon = Krs.iconFixkit,  
        label = Krs.labelFixkit,
        groups = Krs.jobname,
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
        canInteract = function(entity)
            return not IsEntityDead(entity)
        end,
        onSelect = function(data)
            cleanVehicle()
        end
    },
})
