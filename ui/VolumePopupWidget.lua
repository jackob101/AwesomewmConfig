--- @type Wibox
local wibox = require('wibox')
--- @type Awful
local awful = require('awful')
--- @type Beautiful
local beautiful = require('beautiful')
--- @type Gears
local gears = require('gears')
--- @type Helpers
local helpers = require("helpers")
--- @type Widgets
local widgets = require('widgets')
local dpi = beautiful.xresources.apply_dpi





local overlay_widgets = {}

local volumeHeader = widgets.text({
    text = "Volume",
    halign = "left",
    size = 15,
})
local volumeValue = widgets.text({
    text = "0%",
    size = 15
})

local volumeSlider = wibox.widget({
    id = "volume_slider",
    bar_shape = helpers.ui.rrect(),
    bar_height = dpi(5),
    bar_color = beautiful.light,
    bar_active_color = beautiful.accent,
    handle_color = beautiful.accent,
    handle_shape = gears.shape.circle,
    handle_width = dpi(20),
    handle_border_color = beautiful.accent,
    handle_border_width = 0,
    maximum = 100,
    widget = wibox.widget.slider,

})





local function update(newVolume, _, shouldDisplay)
    volumeSlider:set_value(newVolume)
    volumeValue:set_text(newVolume .. "%")

    if shouldDisplay then
        local overlay = overlay_widgets[awful.screen.focused().index]
        overlay.visible = true
        overlay.timer:again()
    end
end

--- @param s Screen
local function create(s)

    local overlay = awful.popup({
        widget = {
            {
                {
                    {
                        layout = wibox.layout.align.horizontal,
                        expand = "none",
                        volumeHeader,
                        nil,
                        volumeValue,
                    },
                    volumeSlider,
                    expand = "inside",
                    layout = wibox.layout.fixed.vertical,
                },
                left = dpi(24),
                right = dpi(24),
                top = dpi(24),
                bottom = dpi(0),
                widget = wibox.container.margin,
            },
            bg = beautiful.background,
            shape = helpers.ui.rrect(),
            border_width = beautiful.border_width,
            border_color = beautiful.border_color,
            widget = wibox.container.background,
        },
        ontop = true,
        visible = false,
        type = "notification",
        screen = s,
        height = dpi(120),
        width = dpi(300),
        maximum_height = dpi(120),
        maximum_width = dpi(300),
        bg = beautiful.transparent,
        preferred_anchors = "middle",
        preferred_positions = { "left", "right", "top", "bottom" },
    })

    awful.placement.bottom_right(overlay, {
        margins = {
            right = dpi(10),
            bottom = dpi(10),
            top = 0,
            left = 0,
        },
        honor_workarea = true,
    })

    overlay.timer = gears.timer({
        timeout = 2,
        autostart = false,
        single_shot = true,
        callback = function()
            overlay.visible = false
        end,
    })

    overlay:connect_signal("mouse::enter", function()
        overlay.timer:stop()
    end)

    overlay:connect_signal("mouse::leave", function()
        overlay.timer:again()
    end)

    overlay_widgets[s.index] = overlay

    return overlay
end




awesome.connect_signal(Signals.volume_update_widgets, update)

volumeSlider:connect_signal("property::value", function(_, newValue)
    awesome.emit_signal(Signals.volume_set, newValue, false)
end)




return create