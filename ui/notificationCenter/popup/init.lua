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

local notification_scroller = require("ui.notificationCenter.popup.notification")

local panels = wibox.widget {
    layout = Wibox.layout.ratio.vertical,
    spacing = dpi(beautiful.notification_center.panel_margin),
    require("ui.notificationCenter.popup.calendar")(),
    notification_scroller,
}

panels:set_ratio(1, 0.35)
panels:set_ratio(2, 0.65)

local function create(s)
    local widget = awful.popup({
        widget = {
            widget = wibox.container.background,
            bg = beautiful.notification_center.bg,
            {
                widget = wibox.container.margin,
                margins = dpi(beautiful.notification_center.panel_margin),
                forced_width = beautiful.notification_center.width,
                forced_height = s.geometry.height - beautiful.bar.barHeight,
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

    function widget:close()
        self.visible = false
    end

    function widget:open()
        self.visible = true
    end

    function widget:isOpen()
        return self.visible
    end

    function widget:toggle()
        self.visible = not self.visible
    end

    return widget
end

return create
