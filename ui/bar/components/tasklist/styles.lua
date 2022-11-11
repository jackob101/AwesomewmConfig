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
    top = dpi(4),
    bottom = dpi(4),
    left = dpi(8),
    right = dpi(8),
  },
  layout = {
    spacing = dpi(10),
  },
  icon = {
    scaling_quality = "good",
  },
  symbols = {
    font = beautiful.icons_font .. (beautiful.bar_font_size + 2), -- Default plane icon is a little bit too small
  },
}

return styles
