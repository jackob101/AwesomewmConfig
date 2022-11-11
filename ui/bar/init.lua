--- @type Wibox
local wibox = require("wibox")

--- @type Awful
local awful = require("awful")

--- @type Beautiful
local beautiful = require("beautiful")

--- @type BarStyles
local styles = require(... .. ".styles")

local tilign_status = require(... .. ".components.tiling_status")
local taglist = require(... .. ".components.taglist")
local tasklist = require(... .. ".components.tasklist")
local status_widgets = require(... .. ".components.status_widgets")

--- @param s Screen
local function create(s)
  -- Create the wibar
  local widget = awful.wibar(Apply_styles({
    position = "bottom",
    screen = s,
    class = styles.bar,
  }))

  -- Add widgets to the wibox
  widget:setup(Apply_styles({
    layout = wibox.layout.stack,
    {
      layout = wibox.layout.align.horizontal,
      expand = "outside",
      widget = wibox.container.background,
      {
        layout = wibox.layout.align.horizontal,
        expand = "inside",
        {
          layout = wibox.layout.fixed.horizontal,
          tilign_status(s),
          taglist(s),
        },
        nil,
        {
          widget = wibox.container.margin,
          class = styles.status_widgets_margin_container,
          status_widgets,
        },
      },
    },
    {
      layout = wibox.layout.align.horizontal,
      expand = "outside",
      nil,
      tasklist(s),
    },
  }))
end

awful.screen.connect_for_each_screen(function(s)
  create(s)
end)
