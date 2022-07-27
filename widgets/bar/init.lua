local awful = require("awful")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local wibox = require("wibox")


----------------------------------------
-- What widgets are present on bar
----------------------------------------

local left_widgets = {
    TilingStatusWidget,
    TaglistWidget,
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

local config = {}
config.bar_height = beautiful.bar_height
config.right_panel_margins = (config.bar_height - (config.bar_height * 0.5)) / 2
config.right_panel_child_spacing = dpi(15)
config.left_panel_margins = (config.bar_height - (config.bar_height * 1)) / 2

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
awful.screen.connect_for_each_screen(function(s)


    local right_parent_widget = wibox.widget({
        layout = wibox.layout.fixed.horizontal,
        spacing = config.right_panel_child_spacing
    })


    local left = {
        widget = wibox.container.margin,
        margins = config.left_panel_margins,
        layout = wibox.layout.fixed.horizontal,
        init_widgets(left_widgets, s),
    }
    local middle = init_widgets(middle_widgets, s)
    local right = {
        widget = wibox.container.margin,
        margins = config.right_panel_margins,
        init_widgets(right_widgets, s, right_parent_widget),
    }

    -- Create the wibar
    s.mywibox = awful.wibar({
        position = "bottom",
        screen = s,
        height = beautiful.bar_height,
        bg = beautiful.black .. beautiful.bar_opacity,
    })


    -- Add widgets to the wibox
    s.mywibox:setup({
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
end)
