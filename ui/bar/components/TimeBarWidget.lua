--- @type Beautiful
local beautiful = require('beautiful')

--- @type Wibox
local wibox = require("wibox")



local clock = wibox.widget({
    widget = wibox.widget.textclock,
    format = "%H:%M",
    font = beautiful.bar_font,
})

local widget = wibox.widget({
    IconsHandler.icons.clock.widget("#FFFFFF"),
    clock,
    layout = wibox.layout.fixed.horizontal,
    spacing = beautiful.bar_icon_text_spacing,
})

return function()
    return widget
end
