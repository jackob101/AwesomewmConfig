--- @type Beautiful
local beautiful = require("beautiful")

--- @type Dpi
local dpi = beautiful.xresources.apply_dpi

--- @class TaglistStyles
local M = {
  hover_container = {
    opacity = 0,
    bg = beautiful.foreground .. "33",
  },
  text_margin = {
    margins = dpi(5),
  },
  text = {
    align = "center",
    forced_width = dpi(25),
  },
  tasks_margin = {
    top = dpi(7),
    bottom = dpi(7),
    right = dpi(7),
  },
  tasks_layout = {
    spacing = dpi(7),
  },
  underline_background = {
    forced_height = dpi(3),
  },
}

return M
