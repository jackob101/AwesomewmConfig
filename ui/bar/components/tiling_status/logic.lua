--- @type Awful
local awful = require("awful")

--- @class TilingStatusLogic
local M = {}

M.layoutbox_mouse_keybinds = {
  awful.button({}, 1, function()
    awful.layout.inc(1)
  end),
  awful.button({}, 3, function()
    awful.layout.inc(-1)
  end),
  awful.button({}, 4, function()
    awful.layout.inc(1)
  end),
  awful.button({}, 5, function()
    awful.layout.inc(-1)
  end),
}

return M
