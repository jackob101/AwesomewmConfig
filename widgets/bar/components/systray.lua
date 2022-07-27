local wibox = require("wibox")

--- @class Systray : BaseWidget
Systray = {}
Systray.__index = Systray

--- @return Systray
function Systray.new(s)
    local newSystray = {}
    setmetatable(newSystray, Systray)

    newSystray.widget = wibox.widget({
        widget = wibox.widget.systray,
        screen = "primary",
    })

    return newSystray
end
