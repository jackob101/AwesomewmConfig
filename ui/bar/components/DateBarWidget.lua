--- @type Wibox
local wibox = require("wibox")

--- @type Beautiful
local beautiful = require 'beautiful'

--- @type Helpers
local helpers = require('helpers')


--- @type Widgets
local widgets = require("widgets")


local calendar = wibox.widget({
    widget = wibox.widget.textclock,
    format = "%a %b %d",
    font = beautiful.bar.font,
})

calendar.markup = helpers.ui.colorize_text(calendar.text, beautiful.foreground)
calendar:connect_signal("widget::redraw_needed", function()
    calendar.markup = helpers.ui.colorize_text(calendar.text, beautiful.foreground)
end)

local widget = wibox.widget({
    widgets.text({
        font = beautiful.icons_font,
        size = beautiful.bar_icons_size,
        text = ""
    }),
    calendar,
    layout = wibox.layout.fixed.horizontal,
    spacing = beautiful.bar_icon_text_spacing,
})

local function create()
    return widget
end


return create