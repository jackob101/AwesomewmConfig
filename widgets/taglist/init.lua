local awful = require("awful")
local gears = require("gears")
local modkey = require("configs.mod").modkey
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

----------------------------------------
-- Local configuration for taglist
----------------------------------------

local config = {}
config.tag_spacing = dpi(7)
config.tag_rounded_corners = dpi(0)

config.tasks_margins = dpi(6)
config.tasks_spacing = dpi(7)
config.tasks_right_margin = dpi(9) -- Optional fallback 'tasks_margins'
--config.tasks_top_margin
--config.tasks_bottom_margin

config.label_forced_width = dpi(25)
config.label_margins = dpi(5)

----------------------------------------
-- Mouse button binds for tags
----------------------------------------

local taglist_buttons = {
    awful.button({}, 1, function(t)
        t:view_only()
    end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({}, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
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

----------------------------------------
-- Responsible for creating preview of tasks on tag
----------------------------------------
local function create_task_list(clients)

    local task_list = wibox.widget {
        layout = wibox.layout.fixed.horizontal,
        spacing = config.tasks_spacing,
    }

    for _, client in ipairs(clients) do
        task_list:add(wibox.widget({
            widget = wibox.widget.imagebox,
            image = client.icon,
        }))
    end

    return wibox.widget {
        widget = wibox.container.margin,
        top = config.tasks_top_margin or config.tasks_margins,
        bottom = config.tasks_bottom_margin or config.tasks_margins,
        right = config.tasks_right_margin or config.tasks_margins,
        task_list
    }
end

----------------------------------------
-- Requests updates to tasks in tag
----------------------------------------
local function update_callback(self, t)
    local clients = t:clients()
    local task_list = self:get_children_by_id("task_list")[1]
    task_list:reset()
    if #clients > 0 then
        task_list:add(create_task_list(clients))
    end
end

local function create(s)
    return awful.widget.taglist({
        screen = s,
        filter = awful.widget.taglist.filter.noempty,
        style = {
            shape =  function(cr, width, height)
                return gears.shape.rounded_rect(cr, width, height, config.tag_rounded_corners)
            end,
        },
        layout = {
            spacing = config.tag_spacing,
            layout = wibox.layout.fixed.horizontal,
        },
        widget_template = {
            {
                {
                    widget = wibox.container.margin,
                    margins = config.label_margins,
                    {
                        widget = wibox.widget.textbox,
                        align = "center",
                        id = "text_role",
                        forced_width = config.label_forced_width,
                    },
                },
                {
                    id = "task_list",
                    layout = wibox.layout.fixed.horizontal,
                },
                layout = wibox.layout.fixed.horizontal,
            },
            widget = wibox.container.background,
            id = "background_role",
            update_callback = update_callback,
            create_callback = update_callback,
        },
        buttons = taglist_buttons,
    })
end

return create
