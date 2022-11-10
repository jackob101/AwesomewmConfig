--- @type Beautiful
local beautiful = require("beautiful")

--- @type Dpi
local dpi = beautiful.xresources.apply_dpi

--- @class BarStyles
local styles = {
  bar = {
    height = dpi(34),
    bg = beautiful.background .. "FF",
  },
  status_widgets_margin_container = {
    margins = (beautiful.bar_height - (beautiful.bar_height * 0.5)) / 3,
  },
}

return styles
