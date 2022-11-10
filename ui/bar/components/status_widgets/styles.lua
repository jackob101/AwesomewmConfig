--- @type Beautiful
local beautiful = require("beautiful")

--- @type Dpi
local dpi = beautiful.xresources.apply_dpi

local bar_icon_text_spacing = dpi(3)

--- @class StatusWidgetsStyles
local styles = {
  clock = {
    container = {
      fg = beautiful.foreground,
    },
    layout = {
      spacing = bar_icon_text_spacing,
    },
    icon = {
      text = "",
      font = beautiful.icons_font .. beautiful.bar_icons_size,
    },
    text = {
      format = "%H:%M",
      font = beautiful.font_name .. beautiful.bar_font_size,
    },
  },
  calendar = {
    container = {
      fg = beautiful.foreground,
    },
    layout = {
      spacing = bar_icon_text_spacing,
    },
    icon = {
      text = "",
      font = beautiful.icons_font .. beautiful.bar_icons_size,
    },
    text = {
      font = beautiful.font_name .. beautiful.bar_font_size,
      format = "%a %b %d",
    },
  },
  volume = {
    container = {
      fg = beautiful.foreground,
    },
    layout = {
      spacing = bar_icon_text_spacing,
    },
    icon = {
      font = beautiful.icons_font .. beautiful.bar_icons_size,
    },
    text = {
      font = beautiful.font_name .. beautiful.bar_font_size,
    },
  },
  container = {
    spacing = dpi(10),
  },
}

return styles
