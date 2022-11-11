--- @type Awful
local awful = require("awful")

--- @class TasklistLogic
local M = {}

M.buttons = {
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

--- @param task_widget Widget
--- @param c Client
function M.update_symbol(task_widget, c)
  if c and c.floating then
    task_widget:get_children_by_id("symbols_role")[1].text = "✈"
  else
    task_widget:get_children_by_id("symbols_role")[1].text = ""
  end
end

return M
