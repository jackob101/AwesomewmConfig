--- @type Utils
local utils = require("utils")

--- @type Wibox
local wibox = require("wibox")

--- @type Beautiful
local beautiful = require("beautiful")

--- @type StatusWidgetsStyles
local styles = require(... .. ".styles")

--- @type StatusWidgetsLogic
local logic = require(... .. ".logic")

local notification_center_toggle = require("ui.notificationCenter")

--
-- Clock
--
local clock_widget = {
  widget = wibox.container.background,
  class = styles.clock.container,
  {
    layout = wibox.layout.fixed.horizontal,
    class = styles.clock.layout,
    {
      class = styles.clock.icon,
      widget = wibox.widget.textbox,
    },
    {
      widget = wibox.widget.textclock,
      class = styles.clock.text,
    },
  },
}

--
-- Calendar
--
local calendar_widget = {
  widget = wibox.container.background,
  class = styles.calendar.container,
  {
    layout = wibox.layout.fixed.horizontal,
    class = styles.calendar.layout,
    {
      widget = wibox.widget.textbox,
      class = styles.calendar.icon,
    },
    {
      widget = wibox.widget.textclock,
      class = styles.calendar.text,
    },
  },
}

--
-- Systray
--
local systray_widget = wibox.widget({
  widget = wibox.widget.systray,
  screen = "primary",
})

--
-- Volume
--
local volume_icon = wibox.widget(Apply_styles({
  widget = wibox.widget.textbox,
  class = styles.volume.icon,
}))

local volume_text = wibox.widget(Apply_styles({
  widget = wibox.widget.textbox,
  class = styles.volume.text,
}))

local volume_widget = wibox.widget(Apply_styles({
  widget = wibox.container.background,
  class = styles.volume.container,
  {
    volume_icon,
    volume_text,
    layout = wibox.layout.fixed.horizontal,
    class = styles.volume.layout,
  },
}))

local volume_tooltip = utils.generate_tooltip(volume_widget, "Click to mute")
logic.volume_register_button_press(volume_widget)
logic.volume_register_hover_effect(volume_widget)
logic.volume_register_volume_update(volume_icon, volume_text, volume_tooltip)

return Apply_styles({
  layout = wibox.layout.fixed.horizontal,
  class = styles.container,
  volume_widget,
  clock_widget,
  calendar_widget,
  systray_widget,
  notification_center_toggle(),
}, styles)
