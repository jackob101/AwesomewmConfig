--- @type Wibox
local wibox = require("wibox")

--- @type Beautiful
local beautiful = require("beautiful")

--- @type Dpi
local dpi = beautiful.xresources.apply_dpi

--- @type Awful
local awful = require("awful")

--- @class NotificationPopupWidget
--- @field panel Widget

local notification_scroller = require("ui.notificationCenter.popup.notification")
local calendar = require("ui.notificationCenter.popup.calendar")()

--- @type Helpers
local helpers = require("helpers")

local panels = wibox.widget({
  layout = wibox.layout.fixed.vertical,
  fill_space = true,
  spacing = beautiful.notification_center.panel_margin,
  expand = "inside",
  calendar,
  notification_scroller,
})

local function create(s)
  local widget = awful.popup({
    widget = {
      widget = wibox.container.background,
      bg = beautiful.notification_center.bg,
      shape = helpers.ui.rrect(),
      forced_height = s.geometry.height - beautiful.bar_height - dpi(10),
      forced_width = beautiful.notification_center.width,
      {
        widget = wibox.container.margin,
        margins = dpi(beautiful.notification_center.panel_margin),
        panels,
      },
    },
    screen = s,
    ontop = true,
    bg = beautiful.transparent,
    placement = function(self)
      return awful.placement.bottom_right(self, {
        margins = {
          bottom = beautiful.bar_height + dpi(5),
          right = dpi(5),
          top = dpi(5),
        },
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
