--- @type Beautiful
local beautiful = require("beautiful")

--- @class TaglistStyles
local M = {
  hover_container = {
    opacity = 0,
    bg = beautiful.tag.hover_color,
  },
  text_margin = {
    margins = beautiful.tag.label_margins,
  },
  text = {
    align = "center",
    forced_width = beautiful.tag.label_forced_width,
  },
  tasks_margin = {
    top = beautiful.tag.tasks_top_margin or beautiful.tag.tasks_margins,
    bottom = beautiful.tag.tasks_bottom_margin or beautiful.tag.tasks_margins,
    right = beautiful.tag.tasks_right_margin or beautiful.tag.tasks_margins,
  },
  tasks_layout = {
    spacing = beautiful.tag.tasks_spacing,
  },
  underline_background = {
    forced_height = beautiful.tag.underline_height,
  },
}

return M
