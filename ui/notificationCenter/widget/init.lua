
--- @type Utils
local utils = require("utils")

--- @type Gears
local gears = require("gears")

--- @type Awful
local awful = require('awful')

--- @type Beautiful
local beautiful = require('beautiful')

--- @type Widgets
local widgets  = require("widgets")

local function create(callback)

    local button = widgets.button({
        text = "",
        font_size = beautiful.bar_icons_size,
        bg = beautiful.transparent,
        border_color = beautiful.transparent,
        on_click = function()
            callback()
        end,
        -- IconsHandler.icons.bell.widget(beautiful.fg_normal)
    })

    utils.cursor_hover(button)
    utils.generate_tooltip(button, "Toggle notification center")

    return button
end

return create