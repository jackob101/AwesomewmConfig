--- @type Utils
local utils = require("utils")

--- @type Gears
local gears = require("gears")

--- @type Awful
local awful = require("awful")

--- @type Beautiful
local beautiful = require("beautiful")

--- @type Wibox
local wibox = require("wibox")

--- @type Widgets
local widgets = require("widgets")

local icon_widget = widgets.text({
	size = beautiful.bar_icons_size,
	font = beautiful.icons_font,
})

local text_widget = widgets.text({
	size = beautiful.bar_font_size,
	text = "",
})

local volume_widget = wibox.widget({
	{
		{
			icon_widget,
			widget = wibox.container.margin,
			margins = beautiful.volumeBarWidget.barIconMargin,
		},
		text_widget,
		layout = wibox.layout.fixed.horizontal,
		spacing = beautiful.volumeBarWidget.barIconTextSpacing,
	},
	widget = wibox.container.background,
})

local tooltip = utils.generate_tooltip(volume_widget, "Click to mute")

local function setNewStyle(icon)
	icon_widget:set_text(icon)
end

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

awesome.connect_signal(Signals.volume_update_widgets, function(newVolume, isMute, _)
	if isMute then
		setNewStyle("")
		tooltip.text = "Click to unmute"
		text_widget.text = "Muted"
	else
		if newVolume >= 50 then
			setNewStyle("")
		elseif newVolume < 50 and newVolume > 0 then
			setNewStyle("")
		else
			setNewStyle("")
		end
		tooltip.text = "Click to mute"
		text_widget.text = newVolume .. "%"
	end
end)

return function()
	return volume_widget
end
