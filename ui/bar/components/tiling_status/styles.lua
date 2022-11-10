--- @type Beautiful
local beautiful = require("beautiful")

--- @type Dpi
local dpi = beautiful.xresources.apply_dpi

--- @class TilingStatusStyles
local styles = {
  background = {
    bg = beautiful.tilingStatus.bg,
    fg = beautiful.tilingStatus.fg,
  },
  margin = {
    left = dpi(10),
    right = dpi(10),
    top = dpi(6),
    bottom = dpi(6),
  },
}

return styles
