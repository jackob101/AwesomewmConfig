--- @type Utils
local utils = require("utils")

--- @type Awful
local awful = require('awful')

--- @type Beautiful
local beautiful = require('beautiful')

--- @type Wibox
local wibox = require("wibox")




local buttons = {
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
    end)
}


local function create(s)

    local widget = awful.widget.tasklist({
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        layout = {
            spacing = beautiful.task_spacing,
            layout = wibox.layout.fixed.horizontal,
        },
        widget_template = {
            {
                nil,
                {
                    {
                        id = "icon_role",
                        widget = wibox.widget.imagebox,
                        scaling_quality = "good",
                    },
                    widget = wibox.container.margin,
                    top = beautiful.task.top_margin,
                    bottom = beautiful.task.bottom_margin,
                    left = beautiful.task.left_margin,
                    right = beautiful.task.right_margin,
                },
                layout = wibox.layout.align.horizontal,
                expand = "outside",
            },
            id = "background_role",
            widget = wibox.container.background,
            create_callback = function(self, c)
                utils.hover_effect(self)
                utils.generate_tooltip(self, c.class)
            end,
        },
        buttons = buttons,
    })

    return widget
end

return create
