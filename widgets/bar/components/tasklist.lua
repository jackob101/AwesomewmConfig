local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local dpi = require("beautiful").xresources.apply_dpi
local utils = require("utils")
local beautiful = require("beautiful")
local icons = require("icons")
local theme = beautiful.task

--- @class TaskListWidget : BaseWidget
TaskListWidget = {}
TaskListWidget.__index = TaskListWidget


----------------------------------------
-- Events that happens when clicking on task
----------------------------------------
local tasklist_buttons = {
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
    awful.button({}, 3, function(c)
        if c.popup.visible then
            c.popup.visible = not c.popup.visible
        else
            c.popup:move_next_to(mouse.current_widget_geometry)
        end
    end),
    awful.button({}, 4, function()
        awful.client.focus.byidx(1)
    end),
    awful.button({}, 5, function()
        awful.client.focus.byidx(-1)
    end)

}

local function widget_create_callback(self, c, index)
    utils.hover_effect(self)
    utils.generate_tooltip(self, c.class)

    local menu_items = {
        {
            name = "Minimize",
            onclick = function()
                c.minimized = not c.minimized
            end,
            icon = icons.window_minimize,
        },
        {
            name = "Maximize",
            onclick = function()
                c.maximize()
            end,
            icon = icons.window_maximize,
        },
        {
            name = "Fullscreen",
            onclick = function()
                c.fullscreen = not c.fullscreen
            end,
            icon = icons.window_fullscreen,
        },
        {
            name = "Kill client",
            onclick = function()
                c:kill()
            end,
            icon = icons.window_close,
        },
    }
    c.popup = require("widgets.menu")(menu_items)
    c.popup.offset = { x = 40 }

end

--- @return TaskListWidget
function TaskListWidget.new(s)
    --- @type TaskListWidget
    local newTaskListWidget = {}
    setmetatable(newTaskListWidget, TaskListWidget)

    newTaskListWidget.widget = awful.widget.tasklist({
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        layout = {
            spacing = theme.task_spacing,
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
                    top = theme.top_margin,
                    bottom = theme.bottom_margin,
                    left = theme.left_margin,
                    right = theme.right_margin,
                },
                layout = wibox.layout.align.horizontal,
                expand = "outside",
            },
            id = "background_role",
            widget = wibox.container.background,
            create_callback = widget_create_callback,
        },
        buttons = tasklist_buttons,
    })

    return newTaskListWidget
end

