--- @type Beautiful
local beautiful = require('beautiful')

--- @type Wibox
local wibox = require("wibox")

--- @type Widgets
local widgets = require("widgets")

--- @type Helpers
local helpers = require("helpers")

local clock = wibox.widget({
    widget = wibox.widget.textclock,
    format = "%H:%M",
    font = beautiful.font_name .. beautiful.bar_font_size
})

clock.markup = helpers.ui.colorize_text(clock.text, beautiful.foreground)
clock:connect_signal("widget::redraw_needed", function()
    clock.markup = helpers.ui.colorize_text(clock.text, beautiful.foreground)
end)


local widget = wibox.widget({
    widgets.text({
        text = "",
        size = beautiful.bar_icons_size,
        font = beautiful.icons_font
    }),
    clock,
    layout = wibox.layout.fixed.horizontal,
    spacing = beautiful.bar_icon_text_spacing,
})

return function()
    return widget
end
