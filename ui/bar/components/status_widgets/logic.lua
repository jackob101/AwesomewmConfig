--- @type Awful
local awful = require("awful")

--- @class StatusWidgetsLogic
local M = {}

function M.volume_register_button_press(volume_widget)
  volume_widget:connect_signal("button::press", function(_, _, _, b)
    if b == 1 then
      awesome.emit_signal(Signals.volume_toggle, false)
    elseif b == 3 then
      awful.spawn("pavucontrol")
    elseif b == 4 then
      awesome.emit_signal(Signals.volume_increase, false)
    elseif b == 5 then
      awesome.emit_signal(Signals.volume_decrease, false)
    end
  end)
end

function M.volume_register_hover_effect(volume_widget)
  -- TODO Refactor after Utils are refactored
  local old_cursor, old_wibox
  volume_widget:connect_signal("mouse::enter", function()
    local w = mouse.current_wibox
    old_cursor, old_wibox = w.cursor, w
    w.cursor = "hand1"
  end)
  volume_widget:connect_signal("mouse::leave", function()
    if old_wibox then
      old_wibox.cursor = old_cursor
      old_wibox = nil
    end
  end)
end

function M.volume_register_volume_update(volume_icon, volume_text, tooltip)
  awesome.connect_signal(Signals.volume_update_widgets, function(newVolume, isMute, _)
    if isMute then
      volume_icon.text = ""
      tooltip.text = "Click to unmute"
      volume_text.text = "Muted"
    else
      if newVolume >= 50 then
        volume_icon.text = ""
      elseif newVolume < 50 and newVolume > 0 then
        volume_icon.text = ""
      else
        volume_icon.text = ""
      end
      tooltip.text = "Click to mute"
      volume_text.text = newVolume .. "%"
    end
  end)
end

return M
