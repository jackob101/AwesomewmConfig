--- @type Wibox
local wibox = require("wibox")

--- @type Beautiful
local beautiful = require 'beautiful'



local calendar = wibox.widget({
    widget = wibox.widget.textclock,
    format = "%a %b %d",
    font = beautiful.bar.font,
})

local widget = wibox.widget({
    IconsHandler.icons.calendar.widget(),
    calendar,
    layout = wibox.layout.fixed.horizontal,
    spacing = beautiful.bar.barIconTextSpacing,
})

local function create()
    return widget
end


return create