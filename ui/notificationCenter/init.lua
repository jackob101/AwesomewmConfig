--- @type Gears
local gears = require('gears')

local notification_toggle = require((...) .. ".widget")

--- @type Awful
local awful = require('awful')


local widgets = {}

awful.screen.connect_for_each_screen(function(s)
    widgets[s.index] = require("ui.notificationCenter.popup")(s)
end)

local function toggle_popup()
    local current_screen_popup = widgets[awful.screen.focused().index]
    if current_screen_popup:isOpen() then
        current_screen_popup:close()
    else
        for v in screen do
            widgets[v.index]:close()
        end
        current_screen_popup:open()
    end
end

local function create_bar_widget()
    return notification_toggle(toggle_popup)
end

Keybinds.connectForGlobal(gears.table.join(
    Awful.key(
        { ModKey, "Shift", "Control" },
        "c",
        function()
            toggle_popup()
        end,
        { description = "panel", group = "notification center" }
    )))


return create_bar_widget
