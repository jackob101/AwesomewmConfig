local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi
local utils = require("utils")
local icons = require("icons")

---Creates new button for title bar of client
---@param action function Action that will be applied
---@param color string color of button
---@param tooltip string text that should be displayed when hovering
---@param image table wrapped icon table that comes from icons utils
local function create_button(color, action, tooltip, image)

    local widget = wibox.widget {
        widget = wibox.container.background,
        forced_width = dpi(40),
        bg = "#ffffff00",
        {
            layout = wibox.layout.align.horizontal,
            expand = "outside",
            nil,
            {
                widget = wibox.container.margin,
                margins = dpi(6),
                image.widget(color),
            },
        }
    }

    utils.generate_tooltip(widget, tooltip)

    widget:connect_signal("button::release", action)
    widget:connect_signal("mouse::enter", function()
        widget.bg = beautiful.titlebar_controls_hover_overlay
    end)
    widget:connect_signal("mouse::leave", function()
        widget.bg = "#FFFFFF00"
    end)

    return widget
end

client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
            awful.button({}, 1, function()
                c:emit_signal("request::activate", "titlebar", { raise = true })
                awful.mouse.client.move(c)
            end),
            awful.button({}, 3, function()
                c:emit_signal("request::activate", "titlebar", { raise = true })
                awful.mouse.client.resize(c)
            end)
    )

    awful.titlebar(c):setup({
        layout = wibox.layout.flex.horizontal,
        {
            widget = wibox.container.margin,
            margins = beautiful.titlebar_icon_padding,
            {
                awful.titlebar.widget.iconwidget(c),
                buttons = buttons,
                layout = wibox.layout.fixed.horizontal,
            }
        },
        { -- Middle
            { -- Title
                align = "center",
                widget = awful.titlebar.widget.titlewidget(c),
            },
            buttons = buttons,
            layout = wibox.layout.flex.horizontal,
        },
        { -- Right
            create_button(beautiful.color11, function()
                c.minimized = not c.minimized
            end,
                    "Minimize", icons.window_minimize),
            create_button(beautiful.color10, function()
                c.maximized = not c.maximized
            end,
                    "Maximize", icons.window_maximize),
            create_button(beautiful.color9, function()
                c:kill()
            end,
                    "Kill application", icons.window_close),
            layout = wibox.layout.fixed.horizontal,
            spacing = dpi(1)
        },
        layout = wibox.layout.align.horizontal,
        spacing = dpi(10)

    })
end)
