--- @type Ruled
local ruled = require('ruled')

--- @type Naughty
local naughty = require('naughty')

--- @type Wibox
local wibox = require('wibox')

--- @type Beautiful
local beautiful = require("beautiful")

--- @type Awful
local awful = require("awful")

--- @type Gears
local gears = require('gears')

--- @type Menubar
local menubar = require("menubar")

local isDndOn = false

local function toggle()

    if not isDndOn then
        naughty.notification({
            title = "Do not disturb",
            message = "Do not disturb has been turned on",
            icon = IconsHandler.icons.bell_slash.path,
            force_display = true,
            store = false,
        })
    else
        naughty.notification({
            title = "Do not disturb",
            message = "Do not disturb has been turned off",
            icon = IconsHandler.icons.bell.path,
            force_display = true,
            store = false,
        })
    end

    isDndOn = not isDndOn

    awesome.emit_signal(Signals.dnd_update)
end

ruled.notification.connect_signal("request::rules", function()
    ruled.notification.append_rule({
        rule = { urgency = "critical" },
        properties = {
            timeout = 0,
            border_color = beautiful.notification.borderUrgent
        },
    })

    ruled.notification.append_rule({
        rule = { urgency = "normal" },
        properties = {
            timeout = 5,
            implicit_timeout = 5,
            border_color = beautiful.notification.borderNormal
        },
    })
    ruled.notification.append_rule({
        rule = { urgency = "low" },
        properties = {
            implicit_timeout = 5,
            border_color = beautiful.notification.borderNormal
        },
    })
end)

-- Some magic that fixed missing icons
naughty.connect_signal("request::icon", function(n, context, hints)
    if context ~= "app_icon" then
        return
    end

    local path = menubar.utils.lookup_icon(hints.app_icon) or Menubar.utils.lookup_icon(hints.app_icon:lower())

    if path then
        n.icon = path
    end
end)



naughty.connect_signal("request::display", function(n)
    if not isDndOn or n._private.force_display then

        local action_buttons = wibox.widget({
            notification = n,
            base_layout = wibox.widget({
                spacing = dpi(0),
                layout = wibox.layout.flex.horizontal,
            }),
            widget_template = {
                {
                    {
                        {
                            {
                                id = "text_role",
                                font = "Inter Regular 10",
                                widget = wibox.widget.textbox,
                            },
                            widget = wibox.container.place,
                        },
                        widget = wibox.container.background,
                    },
                    bg = beautiful.groups_bg,
                    shape = gears.shape.rounded_rect,
                    forced_height = dpi(30),
                    widget = wibox.container.background,
                },
                margins = dpi(4),
                widget = wibox.container.margin,
            },
            style = { underline_normal = false, underline_selected = true },
            widget = naughty.list.actions,
        })

        local iconWidget = wibox.widget({
            widget = wibox.container.margin,
            right = beautiful.notification.iconRightMargin,
            {
                {
                    naughty.widget.icon,
                    widget = wibox.container.place,
                    valign = "center",
                    halign = "center",
                },
                widget = wibox.container.background,
            }
        })

        local textWidget = wibox.widget({
            {
                {
                    align = "center",
                    markup = "<b>" .. n.title .. "</b>",
                    font = beautiful.notification.titleFont,
                    ellipsize = "end",
                    widget = wibox.widget.textbox,
                    forced_height = beautiful.notification.titleHeight,
                },
                {
                    widget = wibox.container.background,
                    forced_height = beautiful.notification.messageHeight,
                    {
                        align = "center",
                        --valign = "top",
                        wrap = "char",
                        widget = naughty.widget.message,
                    }
                },
                action_buttons,
                expand = "inside",
                spacing = 5,
                layout = wibox.layout.align.vertical,
            },
            margins = beautiful.notification_box_margin,
            widget = wibox.container.margin,
        })

        naughty.layout.box({
            notification = n,
            type = "notification",
            screen = awful.screen.focused(),
            shape = gears.shape.rectangle,
            bg = beautiful.notification.bg,
            position = beautiful.notification.position,
            border_width = beautiful.notification.borderWidth,
            border_color = n.border_color,
            widget_template = {
                {
                    widget = wibox.container.margin,
                    margins = beautiful.notification.borderPadding,
                    {
                        iconWidget,
                        textWidget,
                        layout = wibox.layout.align.horizontal
                    },
                },

                widget = wibox.container.background,
                forced_width = beautiful.notification.width
            },
        })
    end
end)


awesome.connect_signal(Signals.dnd_toggle, toggle)
