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

local buttons = {
  awful.button({}, 1, function(c)
    if c == client.focus then
      c.minimized = true
    else
      c:emit_signal("request::activate", "tasklist", { raise = true })
    end
  end),
  awful.button({}, 2, function(c)
    c:kill()
  end),
  awful.button({}, 4, function()
    awful.client.focus.byidx(1)
  end),
  awful.button({}, 5, function()
    awful.client.focus.byidx(-1)
  end),
}

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
        class = styles.box_margin,
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
              widget = wibox.container.background,
              class = styles.text_container,
              {
                id = "text_role",
                widget = wibox.widget.textbox,
              },
            },
          },
        },
      },
      create_callback = function(self, c)
        utils.hover_effect(self)
        utils.generate_tooltip(self, c.class)
      end,
    }, styles),
    buttons = buttons,
  })

  return widget
end

return create
