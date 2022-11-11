--- @type Helpers
local helpers = require("helpers")

--- @type Beautiful
local beautiful = require("beautiful")

--- @type Gears
local gears = require("gears")

--- @type Dpi
local dpi = beautiful.xresources.apply_dpi

--- @class VolumeWidgetPopupStyles
local M = {
  volume_header = {
    text = "Volume",
    halign = "left",
    font = beautiful.font_name .. 15,
  },
  volume_value = {
    text = "0%",
    font = beautiful.font_name .. 15,
  },
  volume_slider = {
    bar_shape = helpers.ui.rrect(),
    bar_height = dpi(5),
    bar_color = beautiful.light,
    bar_active_color = beautiful.accent,
    handle_color = beautiful.accent,
    handle_shape = gears.shape.circle,
    handle_width = dpi(20),
    handle_border_color = beautiful.accent,
    handle_border_width = 0,
  },
  popup = {
    height = dpi(120),
    width = dpi(300),
    maximum_height = dpi(120),
    maximum_width = dpi(300),
    bg = beautiful.transparent,
    preferred_anchors = "middle",
    preferred_positions = { "left", "right", "top", "bottom" },
  },
  popup_background = {
    bg = beautiful.background,
    -- shape = helpers.ui.rrect(),
    border_width = dpi(2),
    border_color = beautiful.border_color,
  },
  popup_margins = {

    left = dpi(24),
    right = dpi(24),
    top = dpi(24),
    bottom = dpi(0),
  },
  placement_margins = {
    right = dpi(10),
    bottom = dpi(10),
    top = 0,
    left = 0,
  },
}

return M
