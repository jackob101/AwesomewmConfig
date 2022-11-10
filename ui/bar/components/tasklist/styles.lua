--- @type Beautiful
local beautiful = require("beautiful")

--- @type Dpi
local dpi = beautiful.xresources.apply_dpi

--- @class TasklistStyles
local styles = {
  text_size_limiter = {
    strategy = "max",
    width = dpi(160),
  },
  task_margins = {
    top = beautiful.task.top_margin,
    bottom = beautiful.task.bottom_margin,
    left = beautiful.task.left_margin,
    right = beautiful.task.right_margin,
  },
  layout = {
    spacing = dpi(10),
  },
  text_container = {
    fg = beautiful.black,
  },
  icon = {
    scaling_quality = "good",
  },
  symbols = {
    font = beautiful.icons_font .. (beautiful.bar_font_size + 2), -- Default plane icon is a little bit too small
  },
}

return styles
