local wibox = require("wibox")
local beautiful = require("beautiful")
local icons = require("icons")

--- @class TimeBarWidget : BaseWidget
TimeBarWidget = {}
TimeBarWidget.__index = TimeBarWidget

--- @return TimeBarWidget
function TimeBarWidget.new()
    local newBarTimeWidget = {}
    setmetatable(newBarTimeWidget, TimeBarWidget)

    local clock = wibox.widget({
        widget = wibox.widget.textclock,
        format = "%H:%M",
        font = beautiful.bar_font,
    })

    newBarTimeWidget.widget = wibox.widget({
        icons.clock.widget(),
        clock,
        layout = wibox.layout.fixed.horizontal,
        spacing = beautiful.bar_icon_text_spacing,
    })

    return newBarTimeWidget
end