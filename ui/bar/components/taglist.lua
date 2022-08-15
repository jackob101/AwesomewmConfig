--- @type Awful
local awful = require("awful")

--- @type Wibox
local wibox = require('wibox')

--- @type Beautiful
local beautiful = require("beautiful")


local buttons = {
    awful.button({}, 1, function(t)
        t:view_only()
    end),
    awful.button({ CONFIG.modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({}, 3, awful.tag.viewtoggle),
    awful.button({ CONFIG.modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({}, 4, function(t)
        awful.tag.viewnext(t.screen)
    end),
    awful.button({}, 5, function(t)
        awful.tag.viewprev(t.screen)
    end)

}

local function update_callback(widget, t)
    local clients = t:clients()
    local task_list = widget:get_children_by_id("task_list")[1]
    task_list:reset()
    if #clients > 0 then
        local tasks = wibox.widget {
            layout = wibox.layout.fixed.horizontal,
            spacing = beautiful.tag.tasks_spacing,
        }

        for _, client in ipairs(clients) do
            tasks:add(wibox.widget({
                widget = wibox.widget.imagebox,
                image = client.icon,
            }))
        end

        local task_list_container = wibox.widget {
            widget = wibox.container.margin,
            top = beautiful.tag.tasks_top_margin or beautiful.tag.tasks_margins,
            bottom = beautiful.tag.tasks_bottom_margin or beautiful.tag.tasks_margins,
            right = beautiful.tag.tasks_right_margin or beautiful.tag.tasks_margins,
            tasks,
        }

        task_list:add(task_list_container)
    end
end

--- @param s Screen
local function create(s)

    local widget = awful.widget.taglist({
        screen = s,
        filter = awful.widget.taglist.filter.noempty,
        buttons = buttons,
        widget_template = {
            {
                {
                    widget = wibox.container.background,
                    opacity = 0,
                    id = "hover_background",
                    bg = beautiful.tag.hover_color
                },
                {
                    {
                        widget = wibox.container.margin,
                        margins = beautiful.tag.label_margins,
                        {
                            widget = wibox.widget.textbox,
                            align = "center",
                            id = "text_role",
                            forced_width = beautiful.tag.label_forced_width,
                        },
                    },
                    {
                        id = "task_list",
                        layout = wibox.layout.fixed.horizontal,
                    },
                    layout = wibox.layout.fixed.horizontal,
                },
                {
                    layout = wibox.layout.align.vertical,
                    expand = "inside",
                    nil,
                    nil,
                    {
                        widget = wibox.container.background,
                        forced_height = beautiful.tag.underline_height,
                        id = "background_role",
                    }
                },
                layout = wibox.layout.stack,
            },
            widget = wibox.container.background,
            update_callback = update_callback,
            create_callback = function(self, t)
                local widget = self:get_children_by_id("hover_background")[1]
                widget:connect_signal("mouse::enter", function(self)
                    self.opacity = 1
                end)

                widget:connect_signal("mouse::leave", function(self)
                    self.opacity = 0
                end)
                Utils.cursor_hover(widget)
                update_callback(self, t)
            end,
        },
    })

    return widget
end

return create
