--- @type Beautiful
local beautiful = require("beautiful")

--- @type Dpi
local dpi = beautiful.xresources.apply_dpi

--- @class Tasklist_styles
local styles = {
  text_size_limiter = {
    strategy = "max",
    width = dpi(160),
  },
  box_margin = {
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
}

return styles
