--- @type Wibox
local wibox = require("wibox")
--- @type Awful
local awful = require("awful")

--- @type VolumeWidgetPopupLogic
local logic = require(... .. ".logic")

--- @type VolumeWidgetPopupStyles
local styles = require(... .. ".styles")

local volumeHeader = wibox.widget(Apply_styles({
  widget = wibox.widget.textbox,
  class = styles.volume_header,
}))
local volumeValue = wibox.widget(Apply_styles({
  widget = wibox.widget.textbox,
  class = styles.volume_value,
}))

local volumeSlider = wibox.widget(Apply_styles({
  id = "volume_slider",
  class = styles.volume_slider,
  maximum = 100,
  widget = wibox.widget.slider,
}))

logic.register_volume_header(volumeHeader)
logic.register_volume_slider(volumeSlider)
logic.register_volume_value(volumeValue)

--- @param s Screen
local function create(s)
  local overlay = awful.popup(Apply_styles({
    ontop = true,
    visible = false,
    type = "notification",
    screen = s,
    class = styles.popup,
    widget = Apply_styles({
      widget = wibox.container.background,
      class = styles.popup_background,
      {
        class = styles.popup_margins,
        widget = wibox.container.margin,
        {
          prevent_recursive_styles = true,
          expand = "inside",
          layout = wibox.layout.fixed.vertical,
          {
            layout = wibox.layout.align.horizontal,
            expand = "none",
            volumeHeader,
            nil,
            volumeValue,
          },
          volumeSlider,
        },
      },
    }),
  }))

  awful.placement.bottom_right(overlay, {
    margins = styles.placement_margins,
    honor_workarea = true,
  })

  logic.register_complete_widget(overlay, s)

  return overlay
end

return create
