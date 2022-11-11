--- @type Awful
local awful = require("awful")

--- @type Beautiful
local beautiful = require("beautiful")

require(... .. ".rules")
require(... .. ".focus_flash")

client.connect_signal("manage", function(c)
  if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
    -- Prevent clients from being unreachable after screen count changes.
    awful.placement.no_offscreen(c)
  end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
  c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

client.connect_signal("focus", function(c)
  -- TODO Why is this here? And why border color does not change automatically?
  c.border_color = beautiful.border_focus

  -- TODO Need to add handling when multiple tags are present at the same time
  local tags = c:tags()
  local clients = tags[1]:clients()

  if #clients > 1 then
    for _, v in pairs(clients) do
      v.border_width = beautiful.border_width
    end
  elseif #clients <= 1 then
    for _, c in pairs(clients) do
      c.border_width = 0
    end
  end
end)

client.connect_signal("unfocus", function(c)
  c.border_color = beautiful.border_normal
end)

client.connect_signal("request::manage", function(c)
  -- Center dialogs over parent
  if c.transient_for then
    awful.placement.centered(c, {
      parent = c.transient_for,
    })
    awful.placement.no_offscreen(c)
  end
end)

-- Utility function to maximize client
client.connect_signal("request::manage", function(c)
  function c:maximize()
    local sc = awful.screen.focused()
    if sc ~= nil then
      self.x = sc.geometry.x
      self.y = sc.geometry.y
      self.width = 1920
      self.height = 1080 - beautiful.bar.barHeight
    end
  end
end)
