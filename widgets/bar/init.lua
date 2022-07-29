local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local theme = Beautiful.bar

-- Load widget classes into scope
load_all("widgets.bar.components", {
    "volume",
    "central_panel_toggle",
    "date",
    "systray",
    "taglist",
    "tasklist",
    "tiling_status",
    "time"
})

----------------------------------------
-- What widgets are present on bar
----------------------------------------

--- @class StatusBar : BaseWidget
StatusBar = {}
StatusBar.__index = StatusBar

local left_widgets = {
    TilingStatusWidget,
    TagListWidget,
}

local middle_widgets = {
    TaskListWidget,
}

local right_widgets = {
    VolumeBarWidget,
    TimeBarWidget,
    DateBarWidget,
    Systray,
    CentralPanelToggle,
}

----------------------------------------
-- Wibar configuration
----------------------------------------


----------------------------------------
-- helper function to initialize widgets
----------------------------------------

--- @param list_of_widgets BaseWidget[]
local function init_widgets(list_of_widgets, s, parent_widget)

    if parent_widget == nil then
        parent_widget = wibox.widget({
            layout = wibox.layout.fixed.horizontal,
            widget = wibox.container.background,
        })
    end

    for _, entry in ipairs(list_of_widgets) do
        parent_widget:add(entry.new(s).widget)
    end

    return parent_widget
end

----------------------------------------
-- Initialize the bar
----------------------------------------
--- @type Screen
--- @return StatusBar
function StatusBar.new(s)
    --- @type StatusBar
    local newStatusBar = {}
    setmetatable(newStatusBar, StatusBar)

    local right_parent_widget = wibox.widget({
        layout = wibox.layout.fixed.horizontal,
        spacing = theme.rightPanelChildSpacing
    })

    local left = {
        widget = wibox.container.margin,
        margins = theme.leftPanelMargins,
        layout = wibox.layout.fixed.horizontal,
        init_widgets(left_widgets, s),
    }

    local middle = init_widgets(middle_widgets, s)

    local right = {
        widget = wibox.container.margin,
        margins = theme.rightPanelMargins,
        init_widgets(right_widgets, s, right_parent_widget),
    }

    -- Create the wibar
    newStatusBar.widget = awful.wibar({
        position = "bottom",
        screen = s,
        height = theme.barHeight,
        bg = beautiful.black .. beautiful.bar_opacity,
    })


    -- Add widgets to the wibox
    newStatusBar.widget:setup({
        layout = wibox.layout.stack,
        {
            layout = wibox.layout.align.horizontal,
            expand = "outside",
            widget = wibox.container.background,
            {
                layout = wibox.layout.align.horizontal,
                expand = "inside",
                left,
                nil,
                right,
            },
        },
        {
            layout = wibox.layout.align.horizontal,
            expand = "outside",
            nil,
            middle,
        }
    })

    return newStatusBar
end
