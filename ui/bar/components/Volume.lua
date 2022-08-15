--- @type Utils
local utils = require("utils")

--- @type Gears
local gears = require("gears")

--- @type Awful
local awful = require('awful')

--- @type Beautiful
local beautiful = require('beautiful')

--- @type Wibox
local wibox = require("wibox")



local icon_widget = wibox.widget({
    resize = true,
    widget = wibox.widget.imagebox,
})

local text_widget = wibox.widget({
    text = "",
    widget = wibox.widget.textbox,
})

local volume_widget = wibox.widget({
    {
        {
            icon_widget,
            widget = wibox.container.margin,
            margins = beautiful.volumeBarWidget.barIconMargin
        },
        text_widget,
        layout = wibox.layout.fixed.horizontal,
        spacing = beautiful.volumeBarWidget.barIconTextSpacing
    },
    widget = wibox.container.background,
})

local tooltip = utils.generate_tooltip(volume_widget, "Click to mute")

local function setNewStyle(icon, color)
    icon_widget.image = icon
    icon_widget.stylesheet = "#image{fill: " .. color .. ";}"
    volume_widget.fg = color
end

volume_widget:connect_signal("button::press", function(_, _, _, b)
    if b == 1 then
        VolumeService.toggle()
    elseif b == 3 then
        awful.spawn("pavucontrol")
    elseif b == 4 then
        VolumeService.increase()
    elseif b == 5 then
        VolumeService.decrease()
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
        setNewStyle(IconsHandler.icons.volume_mute.path, beautiful.volumeBarWidget.mutedFg)
        tooltip.text = "Click to unmute"
        text_widget.text = "Muted"
    else
        if newVolume >= 75 then
            setNewStyle(IconsHandler.icons.volume_high.path, beautiful.volumeBarWidget.highFg)
        elseif newVolume < 75 and newVolume >= 35 then
            setNewStyle(IconsHandler.icons.volume_medium.path, beautiful.volumeBarWidget.highFg)
        else
            setNewStyle(IconsHandler.icons.volume_low.path, beautiful.volumeBarWidget.highFg)
        end
        tooltip.text = "Click to mute"
        text_widget.text = newVolume .. "%"
    end
end)

return function()
    return volume_widget
end
