--- @type Wibox
local wibox = require("wibox")

--- @type Awful
local awful = require("awful")

--- @type Beautiful
local beautiful = require("beautiful")

--- @type BarStyles
local styles = require(... .. ".styles")

local tilign_status = require(... .. ".components.TilingStatus")
local taglist = require(... .. ".components.taglist")
local tasklist = require(... .. ".components.tasklist")
local status_widgets = require(... .. ".components.status_widgets")

--- @param s Screen
local function create(s)
  -- Create the wibar
  local widget = awful.wibar({
    position = "bottom",
    screen = s,
    height = beautiful.bar.barHeight,
    bg = beautiful.black .. beautiful.bar_opacity,
  })

  -- Add widgets to the wibox
  widget:setup({
    layout = wibox.layout.stack,
    {
      layout = wibox.layout.align.horizontal,
      expand = "outside",
      widget = wibox.container.background,
      {
        layout = wibox.layout.align.horizontal,
        expand = "inside",
        {
          widget = wibox.container.margin,
          margins = beautiful.bar.leftPanelMargins,
          layout = wibox.layout.fixed.horizontal,
          tilign_status(s),
          taglist(s),
        },
        nil,
        {
          widget = wibox.container.margin,
          margins = beautiful.bar.rightPanelMargins,
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
  })
end

awful.screen.connect_for_each_screen(function(s)
  create(s)
end)
