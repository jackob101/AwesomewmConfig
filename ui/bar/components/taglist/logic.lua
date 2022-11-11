--- @type Beautiful
local beautiful = require("beautiful")

--- @type Wibox
local wibox = require("wibox")

--- @type Awful
local awful = require("awful")

--- @type TaglistStyles
local styles = nil

--- @class TaglistLogic
local M = {}

M.buttons = {
  awful.button({}, 1, function(t)
    t:view_only()
  end),
  awful.button({ CONFIG.modkey }, 1, function(t)
    if client.focus then
      client.focus:move_to_tag(t)
    end
  end),
  awful.button({}, 3, awful.tag.viewtoggle),
  awful.button({ CONFIG.modkey }, 3, function(t)
    if client.focus then
      client.focus:toggle_tag(t)
    end
  end),
  awful.button({}, 4, function(t)
    awful.tag.viewnext(t.screen)
  end),
  awful.button({}, 5, function(t)
    awful.tag.viewprev(t.screen)
  end),
}

function M.update_callback(widget, t)
  local clients = t:clients()
  local task_list = widget:get_children_by_id("task_list")[1]
  task_list:reset()
  if #clients > 0 then
    local tasks = wibox.widget(Apply_styles({
      layout = wibox.layout.fixed.horizontal,
      class = styles.tasks_layout,
    }))

    for _, client in ipairs(clients) do
      tasks:add(wibox.widget({
        widget = wibox.widget.imagebox,
        image = client.icon,
      }))
    end

    local task_list_container = wibox.widget(Apply_styles({
      widget = wibox.container.margin,
      class = styles.tasks_margin,
      tasks,
    }))

    task_list:add(task_list_container)
  end
end

function M.create_callback(self, t)
  local widget = self:get_children_by_id("hover_background")[1]
  widget:connect_signal("mouse::enter", function(self)
    self.opacity = 1
  end)

  widget:connect_signal("mouse::leave", function(self)
    self.opacity = 0
  end)
  Utils.cursor_hover(widget)
  M.update_callback(self, t)
end

--- @param s TaglistStyles
return function(s)
  styles = s
  return M
end
