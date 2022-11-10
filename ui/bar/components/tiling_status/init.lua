--- @type Wibox
local wibox = require("wibox")

--- @type Awful
local awful = require("awful")

--- @type TilingStatusStyles
local styles = require(... .. ".styles")

--- @type TilingStatusLogic
local logic = require(... .. ".logic")

local function create(s)
  local widget = wibox.widget(Apply_styles({
    widget = wibox.container.background,
    class = styles.background,
    {
      widget = wibox.container.margin,
      class = styles.margin,
      {
        widget = awful.widget.layoutbox,
        screen = s,
        buttons = logic.layoutbox_mouse_keybinds,
      },
    },
  }))
  return widget
end

return create
