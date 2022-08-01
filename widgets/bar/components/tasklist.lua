local awful = require("awful")
local wibox = require("wibox")
local utils = require("utils")
local beautiful = require("beautiful")
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
            icon = IconsHandler.icons.window_minimize.path,
        },
        {
            name = "Maximize",
            onclick = function()
                c.maximize()
            end,
            icon = IconsHandler.icons.window_maximize.path,
        },
        {
            name = "Fullscreen",
            onclick = function()
                c.fullscreen = not c.fullscreen
            end,
            icon = IconsHandler.icons.window_fullscreen.path,
        },
        {
            name = "Kill client",
            onclick = function()
                c:kill()
            end,
            icon = IconsHandler.icons.window_close.path,
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

