--- @type Gears
local gears = require("gears")

--- @type Awful
local awful = require("awful")

--- @class VolumeWidgetPopupLogic
local M = {}
M.volume_slider = nil
M.volume_header = nil
M.volume_value = nil

function M.register_volume_header(volume_header)
  M.volume_header = volume_header
end

function M.register_volume_value(volume_value)
  M.volume_value = volume_value
end

function M.register_volume_slider(volume_slider)
  M.volume_slider = volume_slider

  M.volume_slider:connect_signal("property::value", function(_, newValue)
    awesome.emit_signal(Signals.volume_set, newValue, false)
  end)
end

function M.update(newVolume, _, shouldDisplay)
  M.volume_slider:set_value(newVolume)
  M.volume_value:set_text(newVolume .. "%")

  if shouldDisplay then
    local overlay = awful.screen.focused().volume_popup_widget
    overlay.visible = true
    overlay.timer:again()
  end
end

--- Register created popup, connects signals and add it to screen
--- @param widget Widget
--- @param s Screen
function M.register_complete_widget(widget, s)
  widget.timer = gears.timer({
    timeout = 2,
    autostart = false,
    single_shot = true,
    callback = function()
      widget.visible = false
    end,
  })

  widget:connect_signal("mouse::enter", function()
    widget.timer:stop()
  end)

  widget:connect_signal("mouse::leave", function()
    widget.timer:again()
  end)

  s.volume_popup_widget = widget
end

awesome.connect_signal(Signals.volume_update_widgets, M.update)

return M
