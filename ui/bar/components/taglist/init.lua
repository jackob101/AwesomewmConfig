--- @type Awful
local awful = require("awful")

--- @type Wibox
local wibox = require("wibox")

--- @type TaglistStyles
local styles = require(... .. ".styles")

--- @type TaglistLogic
local logic = require(... .. ".logic")(styles)

--- @param s Screen
local function create(s)
  local widget = awful.widget.taglist({
    screen = s,
    filter = awful.widget.taglist.filter.noempty,
    buttons = logic.buttons,
    widget_template = Apply_styles({
      {
        {
          widget = wibox.container.background,
          id = "hover_background",
          class = styles.hover_container,
        },
        {
          {
            widget = wibox.container.margin,
            class = styles.text_margin,
            {
              widget = wibox.widget.textbox,
              class = styles.text,
              id = "text_role",
            },
          },
          {
            id = "task_list",
            layout = wibox.layout.fixed.horizontal,
          },
          layout = wibox.layout.fixed.horizontal,
        },
        {
          layout = wibox.layout.align.vertical,
          expand = "inside",
          nil,
          nil,
          {
            widget = wibox.container.background,
            class = styles.underline_background,
            id = "background_role",
          },
        },
        layout = wibox.layout.stack,
      },
      widget = wibox.container.background,
      update_callback = logic.update_callback,
      create_callback = logic.create_callback,
    }),
  })

  return widget
end

return create
