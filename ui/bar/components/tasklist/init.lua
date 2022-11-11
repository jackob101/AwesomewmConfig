--- @type Utils
local utils = require("utils")

--- @type Awful
local awful = require("awful")

--- @type Beautiful
local beautiful = require("beautiful")

--- @type Wibox
local wibox = require("wibox")

--- @type TasklistStyles
local styles = require(... .. ".styles")

--- @type TasklistLogic
local logic = require(... .. ".logic")

local function create(s)
  local widget = awful.widget.tasklist({
    screen = s,
    filter = awful.widget.tasklist.filter.currenttags,
    layout = {
      spacing = beautiful.task_spacing,
      layout = wibox.layout.fixed.horizontal,
    },
    widget_template = Apply_styles({
      id = "background_role",
      widget = wibox.container.background,
      {
        widget = wibox.container.margin,
        class = styles.task_margins,
        {
          layout = wibox.layout.fixed.horizontal,
          class = styles.layout,
          {
            id = "icon_role",
            widget = wibox.widget.imagebox,
            class = styles.icon,
          },
          {
            widget = wibox.container.constraint,
            class = styles.text_size_limiter,
            {
              id = "text_role",
              widget = wibox.widget.textbox,
            },
          },
          { -- Used to display some symbol when client is floating.
            widget = wibox.widget.textbox,
            class = styles.symbols,
            id = "symbols_role",
          },
        },
      },
      create_callback = function(self, c)
        utils.hover_effect(self)
        utils.generate_tooltip(self, c.class)
        c:connect_signal("property::floating", function(client_lambda)
          logic.update_symbol(self, client_lambda)
        end)
        logic.update_symbol(self, c)
      end,
    }, styles),
    buttons = logic.buttons,
  })

  return widget
end

return create
