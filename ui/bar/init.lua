--- @type Wibox
local wibox = require('wibox')

--- @type Awful
local awful = require('awful')

--- @type Beautiful
local beautiful = require('beautiful')


local tilign_status = require(... .. ".components.TilingStatus")
local taglist = require(... .. ".components.taglist")

local tasklist = require(... .. ".components.tasklist")

local macro_indicator = require(... .. ".components.MacroBarIndicatorWidget")
local volume = require(... .. ".components.Volume")
local time = require(... .. ".components.TimeBarWidget")
local date = require(... .. ".components.DateBarWidget")
local systray = require((...) .. ".components.systray")
local notification_center_toggle = require("ui.notificationCenter")



--- @param s Screen
local function create(s)

    local spacing = wibox.widget({
        widget = wibox.container.background,
        forced_width = beautiful.bar.rightPanelChildSpacing
    })

    -- Create the wibar
    local widget = awful.wibar({
        position = "bottom",
        screen = s,
        height = beautiful.bar.barHeight,
        bg = beautiful.black .. beautiful.bar_opacity,
    })


    -- Add widgets to the wibox
    widget:setup({
        layout = wibox.layout.stack,
        {
            layout = wibox.layout.align.horizontal,
            expand = "outside",
            widget = wibox.container.background,
            {
                layout = wibox.layout.align.horizontal,
                expand = "inside",
                {
                    widget = wibox.container.margin,
                    margins = beautiful.bar.leftPanelMargins,
                    layout = wibox.layout.fixed.horizontal,
                    tilign_status(s),
                    taglist(s),
                },
                nil,
                {
                    widget = wibox.container.margin,
                    margins = beautiful.bar.rightPanelMargins,
                    {
                        layout = wibox.layout.fixed.horizontal,
                        macro_indicator(s),
                        spacing,
                        volume(s),
                        spacing,
                        time(s),
                        spacing,
                        date(s),
                        spacing,
                        systray(s),
                        spacing,
                        notification_center_toggle(s)
                    },
                },
            },
        },
        {
            layout = wibox.layout.align.horizontal,
            expand = "outside",
            nil,
            tasklist(s)
        }
    })

end

awful.screen.connect_for_each_screen(function(s)
    create(s)
end)
