--- @type Wibox
local wibox = require 'wibox'

--- @type Beautiful
local beautiful = require 'beautiful'

--- @type Dpi
local dpi = beautiful.xresources.apply_dpi

--- @type Naughty
local naughty = require 'naughty'

--- @type Gears
local gears = require 'gears'

--- @type Awful
local awful = require 'awful'


local text = wibox.widget({
    widget = wibox.widget.textbox,
    valign = "center",
    halign = "left",
    text = "Notification center",
    font = "Inter bold 16",
})

local count = wibox.widget({
    widget = wibox.widget.textbox,
    valign = "center",
    text = "(0)",
    font = "Inter bold 16",
})

local header = wibox.widget({
    layout = wibox.layout.fixed.horizontal,
    spacing = dpi(10),
    text,
    count,
})

--- @class Header
--- @field widget Widget 
local api = {
    widget = header,
}

function api.update(amount, is_list_empty)
    if amount then
        if is_list_empty then
            count.text = "(0)"
        else
            count.text = "(" .. amount .. ")"
        end
    end
end

return api
