--- @type Wibox
local wibox = require("wibox")

--- @type Beautiful
local beautiful = require("beautiful")

--- @type Dpi
local dpi = beautiful.xresources.apply_dpi

--- @type Naughty
local naughty = require("naughty")

--- @type Widgets
local widgets = require("widgets")

local ui_helper = require("helpers.ui")

--- @class NotificationListApi
local api = {}

local notification_creator = require("ui.notificationCenter.popup.notification.notification_creator")

local counter = widgets.text({
  text = "(0)",
})

-- The header part of notification scroller
local header = wibox.widget({
  layout = wibox.layout.fixed.horizontal,
  spacing = dpi(10),
  widgets.text({
    text = "Notifications",
  }),
  counter,
})

-- Widget that should be display when no notifications are present
local empty_notification_list_widget = wibox.widget({
  layout = wibox.layout.align.vertical,
  expand = "outside",
  nil,
  {
    {
      {
        layout = wibox.layout.fixed.vertical,
        spacing = dpi(5),
        {
          widget = wibox.container.place,
          halign = "center",
          valign = "center",
          widgets.text({
            font = beautiful.icons_font,
            text = "",
            size = 30,
          }),
        },
        widgets.text({
          text = "Wow, such empty.",
          size = 14,
        }),
        {
          widget = wibox.container.place,
          halign = "center",
          valign = "center",
          widgets.text({
            text = "Come back later.",
            size = 12,
          }),
        },
      },
      widget = wibox.container.place,
      halign = "center",
      valign = "center",
    },
    margins = dpi(20),
    widget = wibox.container.margin,
  },
  nil,
})

-- Layout that contains all notifications
local notification_list_layout = wibox.widget({
  layout = require("widgets").overflow.vertical,
  step = 50,
  spacing = dpi(10),
  scrollbar_widget = {
    widget = wibox.widget.separator,
    shape = ui_helper.rrect(beautiful.corner_radius),
  },
})

-- The main widgets
local body_template = wibox.widget({
  widget = wibox.container.background,
  bg = beautiful.notification_center.panel_bg,
  shape = ui_helper.rrect(),
  {
    widget = wibox.container.margin,
    margins = dpi(20),
    {
      layout = wibox.layout.align.vertical,
      expand = "inside",
      {
        layout = wibox.layout.align.horizontal,
        expand = "outside",
        nil,
        header,
      },
      {
        widget = wibox.container.margin,
        top = dpi(20),
        {
          layout = wibox.layout.stack,
          notification_list_layout,
          empty_notification_list_widget,
        },
      },
    },
  },
})

function api.update()
  local amount = #notification_list_layout.children
  if amount then
    if empty_notification_list_widget.visible then
      counter:set_text("(0)")
    else
      counter:set_text("(" .. amount .. ")")
    end
  end
end

function api.reset_list()
  notification_list_layout:reset()
  empty_notification_list_widget.visible = true
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

naughty.connect_signal("destroyed", function(n)
  if n._private.args.store == nil or n._private.args.store then
    if empty_notification_list_widget.visible then
      empty_notification_list_widget.visible = false
    end
    local new_notif = notification_creator(n, api)
    notification_list_layout:insert(1, new_notif)
    api.update()
  end
end)

return body_template
