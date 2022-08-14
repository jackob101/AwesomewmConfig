--- @type Wibox
local wibox = require('wibox')

--- @type Awful
local awful = require('awful')

--- @type Beautiful
local beautiful = require('beautiful')

local notification_toggle = require("ui.notificationCenter")
-- Load widget classes into scope
-- load_all("ui.bar.components", {
--     "Volume",
--     "DateBarWidget",
--     "systray",
--     "taglist",
--     "tasklist",
--     "TilingStatus",
--     "TimeBarWidget",
--     "MacroBarIndicatorWidget"
-- })

local tilign_status = require(... .. ".components.TilingStatus")
local taglist = require(... .. ".components.taglist")

local tasklist = require(... .. ".components.tasklist")

local macro_indicator = require(... .. ".components.MacroBarIndicatorWidget")
local volume = require(... .. ".components.Volume")
local time = require(... .. ".components.TimeBarWidget")
local date = require(... .. ".components.DateBarWidget")
local systray = require((...) .. ".components.systray")
local notification_center_toggle = require("ui.notificationCenter")



----------------------------------------
-- What widgets are present on bar
----------------------------------------
local function add_widgets_with_space_before(widgets)
    local layout = wibox.widget({
        layout = Wibox.layout.fixed.horizontal,
    })

    local spacing = Wibox.widget({
        widget = Wibox.container.background,
        forced_width = Beautiful.bar.rightPanelChildSpacing,
    })

    for i, v in pairs(widgets) do
        if v then
            if i == 1 then
                layout:add(v)
            else
                layout:add(spacing)
                layout:add(v)
            end
        end
    end

    return layout
end

--- @param list_of_widgets BaseWidget[]
local function initWidgets(list_of_widgets, s, parent_widget)

    if parent_widget == nil then
        parent_widget = wibox.widget({
            layout = wibox.layout.fixed.horizontal,
            widget = wibox.container.background,
        })
    end

    for _, entry in ipairs(list_of_widgets) do
        if type(entry) == "function" then
            parent_widget:add(entry(s))
        else
            parent_widget:add(entry)
        end
    end

    return parent_widget
end

--- @param s Screen
local function create(s)

    local spacing = wibox.widget({
        widget = wibox.container.background,
        forced_width = beautiful.bar.rightPanelChildSpacing
    })

    -- Create the wibar
    local widget = Awful.wibar({
        position = "bottom",
        screen = s,
        height = Beautiful.bar.barHeight,
        bg = Beautiful.black .. Beautiful.bar_opacity,
    })


    -- Add widgets to the wibox
    widget:setup({
        layout = Wibox.layout.stack,
        {
            layout = Wibox.layout.align.horizontal,
            expand = "outside",
            widget = Wibox.container.background,
            {
                layout = Wibox.layout.align.horizontal,
                expand = "inside",
                {
                    widget = Wibox.container.margin,
                    margins = Beautiful.bar.leftPanelMargins,
                    layout = Wibox.layout.fixed.horizontal,
                    tilign_status(s),
                    taglist(s),
                },
                nil,
                {
                    widget = Wibox.container.margin,
                    margins = Beautiful.bar.rightPanelMargins,
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
            layout = Wibox.layout.align.horizontal,
            expand = "outside",
            nil,
            tasklist(s)
        }
    })

end

awful.screen.connect_for_each_screen(function(s)
    create(s)
end)
