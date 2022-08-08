--- @type Wibox
local wibox = require 'wibox'

--- @type Beautiful
local beautiful = require 'beautiful'

--- @type Dpi
local dpi = beautiful.xresources.apply_dpi

--- @type Awful
local awful = require 'awful'

--- @class NotificationPopupWidget
--- @field panel Widget
local NotificationPopupWidget = {}
NotificationPopupWidget.__index = NotificationPopupWidget

local panels = wibox.widget {
    layout = Wibox.layout.ratio.vertical,
    spacing = dpi(beautiful.notification_center.panel_margin),
    require("widgets.notificationCenter.popup.calendar"),
    require("widgets.notificationCenter.popup.notification").get_widget(),
}

panels:set_ratio(1, 0.25)
panels:set_ratio(2, 0.75)



--- @param s Screen
--- @return NotificationPopupWidget
function NotificationPopupWidget.new(s)
    --- @type NotificationPopupWidget
    local newInstance = {}
    setmetatable(newInstance, NotificationPopupWidget)


    newInstance.panel = Awful.popup({
        widget = {
            widget = wibox.container.background,
            bg = beautiful.gray,
            {
                widget = wibox.container.margin,
                margins = dpi(beautiful.notification_center.panel_margin),
                forced_width = beautiful.notification_center.width,
                forced_height = s.geometry.height - Beautiful.bar.barHeight,
                panels,
            }
        },
        screen = s,
        ontop = true,
        placement = function(self)
            return awful.placement.bottom_right(self, {
                margins = {
                    bottom = beautiful.bar.barHeight
                }
            })
        end,
        visible = false,
    })


    return newInstance
end

function NotificationPopupWidget:close()
    self.panel.visible = false
end

function NotificationPopupWidget:open()
    self.panel.visible = true
end

function NotificationPopupWidget:isOpen()
    return self.panel.visible
end

function NotificationPopupWidget:toggle()
    self.panel.visible = not self.panel.visible
end

return NotificationPopupWidget
