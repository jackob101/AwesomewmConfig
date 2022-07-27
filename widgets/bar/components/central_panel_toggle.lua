local wibox = require("wibox")
local icons = require("icons")
local utils = require("utils")
local beautiful = require("beautiful")
local gears = require("gears")
local awful = require("awful")

--- @class  CentralPanelToggle : BaseWidget
CentralPanelToggle = {}
CentralPanelToggle.__index = CentralPanelToggle

--- @return  CentralPanelToggle
function CentralPanelToggle.new()
    --- @type TaskListWidget
    local newCentralPanelToggle = {}
    setmetatable(newCentralPanelToggle, CentralPanelToggle)

    local stylesheet = "*{fill:" .. beautiful.fg_normal .. ";}"

    local button = wibox.widget({
        widget = wibox.container.background,
        {
            stylesheet = stylesheet,
            widget = wibox.widget.imagebox,
            image = icons.bell,
            resize = true,
        },
    })
    utils.cursor_hover(button)
    utils.generate_tooltip(button, "Toggle notification center")

    button:buttons(gears.table.join(awful.button({}, 1, function()
        awful.screen.focused().central_panel:toggle()
    end)
    ))

    newCentralPanelToggle.widget = button

    return newCentralPanelToggle
end