local icons = require("icons")

--- @class DNDUpdatable : BaseWidget
--- @field update fun(newStatus: boolean)

--- @class DoNotDisturbService : Initializable
--- @field isDNDOn boolean
--- @field toUpdate DNDUpdatable[]
DoNotDisturbService = {
    isDNDOn = false,
	toUpdate = {}
}
DoNotDisturbService.__index = DoNotDisturbService

--- @return DoNotDisturbService
function DoNotDisturbService.init()
    if DoNotDisturbService.isInitialized then
        return
    end
    DoNotDisturbService.isInitialized = true
end

--- @param widget DNDUpdatable
function DoNotDisturbService.connect(widget)
	table.insert(DoNotDisturbService.toUpdate, widget)
end

function DoNotDisturbService.update()
	for _, v in  ipairs(DoNotDisturbService.toUpdate) do
		v.update(DoNotDisturbService.isDNDOn)
	end
end

function DoNotDisturbService.toggle()

    if not DoNotDisturbService.isDNDOn then
        Naughty.notification({
            title = "Do not disturb",
            message = "Do not disturb has been turned on",
            icon = icons.bell_slash,
            force_display = true
        })
    else
        Naughty.notification({
            title = "Do not disturb",
            message = "Do not disturb has been turned off",
            icon = icons.bell,
            force_display = true
        })
    end

    DoNotDisturbService.isDNDOn = not DoNotDisturbService.isDNDOn

	DoNotDisturbService.update()
end
