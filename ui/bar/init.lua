--- @type Wibox
local wibox = require('wibox')

local notification_toggle = require("ui.notificationCenter")
-- Load widget classes into scope
load_all("ui.bar.components", {
    "Volume",
    "NotificationBoxToggle",
    "DateBarWidget",
    "systray",
    "taglist",
    "tasklist",
    "TilingStatus",
    "TimeBarWidget",
    "MacroBarIndicatorWidget"
})

----------------------------------------
-- What widgets are present on bar
----------------------------------------

--- @class StatusBar : BaseWidget
StatusBar = {}
StatusBar.__index = StatusBar

--- @param widget  Widget
local function withSpacing(widget)

    if not widget then
       return 
    end

    local spacing = Wibox.widget({
        widget = Wibox.container.background,
        forced_width = Beautiful.bar.rightPanelChildSpacing,
    })


    return {
        layout = wibox.layout.fixed.horizontal,
        spacing,
        widget
    }
end

--- @type Screen
--- @return StatusBar
function StatusBar.new(s)
    --- @type StatusBar
    local newInstance = {}
    setmetatable(newInstance, StatusBar)

    local left_widgets = {
        TilingStatusWidget.new(s),
        TagListWidget.new(s),
    }

    local middle_widgets = {
        TaskListWidget.new(s),
    }

    local right_widgets = {
        MacroBarIndicator.new(),
        VolumeBarWidget.new(),
        TimeBarWidget.new(),
        DateBarWidget.new(),
        Systray.new(s),
        notification_toggle()
    }



    -- Create the wibar
    newInstance.widget = Awful.wibar({
        position = "bottom",
        screen = s,
        height = Beautiful.bar.barHeight,
        bg = Beautiful.black .. Beautiful.bar_opacity,
    })
local systray = Systray.new(s)
    -- Add widgets to the wibox
    newInstance.widget:setup({
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
                    StatusBar._initWidgets(left_widgets, s),
                },
                nil,
                {
                    widget = Wibox.container.margin,
                    margins = Beautiful.bar.rightPanelMargins,
                    {
                        layout = Wibox.layout.fixed.horizontal,
                        -- statusbar._initrightwidgets(right_widgets, s),
                        MacroBarIndicator.new(),
                        withSpacing(VolumeBarWidget.new().widget),
                        withSpacing(TimeBarWidget.new().widget),
                        withSpacing(DateBarWidget.new().widget),
                        withSpacing(systray and systray.widget),
                        withSpacing(notification_toggle())
                    },
                    -- StatusBar._initRightWidgets(right_widgets, s)
                },
            },
        },
        {
            layout = Wibox.layout.align.horizontal,
            expand = "outside",
            nil,
            StatusBar._initWidgets(middle_widgets, s),
        }
    })

    return newInstance
end

function StatusBar._initRightWidgets(listOfWidgets, s)
    local container = Wibox.widget({
        layout = Wibox.layout.fixed.horizontal,
    })

    local spacing = Wibox.widget({
        widget = Wibox.container.background,
        forced_width = Beautiful.bar.rightPanelChildSpacing,
    })

    for _, v in pairs(listOfWidgets) do
        if v and v.widget then
            container:add(spacing)
            container:add(v.widget)
        end
    end

    return container
end

--- @param list_of_widgets BaseWidget[]
function StatusBar._initWidgets(list_of_widgets, s, parent_widget)

    if parent_widget == nil then
        parent_widget = Wibox.widget({
            layout = Wibox.layout.fixed.horizontal,
            widget = Wibox.container.background,
        })
    end

    for _, entry in ipairs(list_of_widgets) do
        parent_widget:add(entry.widget)
    end

    return parent_widget
end
