--- @type Wibox
local wibox = require 'wibox'

--- @type Beautiful
local beautiful = require 'beautiful'

--- @type Dpi
local dpi = beautiful.xresources.apply_dpi

--- @type Naughty
local naughty = require 'naughty'

--- @type Gears
local gears = require 'gears'

--- @type Awful
local awful = require 'awful'

--- @class NotificationListApi
local api = {
    is_list_empty = true
}

local notification_creator = require 'ui.notificationCenter.popup.notification.notification_creator' (api)

--- @type Widget
local empty_notification_list_widget = require("ui.notificationCenter.popup.notification.empty_notification_list_widget")

--- @type Header
local header = require'ui.notificationCenter.popup.notification.header'


local notification_list_layout = wibox.widget {
    layout = wibox.layout.fixed.vertical,
    spacing = dpi(10),
    empty_notification_list_widget,
}


notification_list_layout:buttons(gears.table.join(
    awful.button({}, 5, nil, function()
        if #notification_list_layout.children == 1 then
            return
        end
        notification_list_layout:insert(#notification_list_layout.children + 1, notification_list_layout.children[1])
        notification_list_layout:remove(1)
    end),
    awful.button({}, 4, nil, function()
        if #notification_list_layout.children == 1 then
            return
        end
        notification_list_layout:insert(1, notification_list_layout.children[#notification_list_layout.children])
        notification_list_layout:remove(#notification_list_layout.children)
    end)
))



local body_template = wibox.widget {
    widget = wibox.container.background,
    bg = beautiful.notification_center.panel_bg,
    {
        widget = wibox.container.margin,
        margins = dpi(20),
        {
            layout = wibox.layout.fixed.vertical,
            spacing = dpi(20),
            header.widget,
            notification_list_layout
        }
    }
}

function api.update()
    header.update(api.get_list_size(), api.is_list_empty)
end

function api.reset_list()
    notification_list_layout:reset()
    api.is_list_empty = true
    notification_list_layout:insert(1, empty_notification_list_widget)
    api.update()
end

function api.get_list_size()
    return #notification_list_layout.children
end

--- @param notification Widget
---@param b boolean
function api.remove_notification(notification, b)
    notification_list_layout:remove_widgets(notification, b)
    if #notification_list_layout.children == 0 then
        api.reset_list()
    end
end

function api.connect_count(counter)
    api.counter = counter
end

function api.get_widget()
    return body_template
end

naughty.connect_signal("destroyed", function(n)
    if n._private.args.store == nil or n._private.args.store then
        if #notification_list_layout.children == 1 and api.is_list_empty then
            notification_list_layout:reset()
            api.is_list_empty = false
        end
        local new_notif = notification_creator(n)
        notification_list_layout:insert(1, new_notif)
        api.update()
    end
end)

return api
