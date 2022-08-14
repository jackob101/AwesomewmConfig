--- @type Wibox
local wibox = require 'wibox'

--- @type Beautiful
local beautiful = require 'beautiful'

--- @type Awful
local awful = require("awful")



local widgets = {}

local function update_from_tag(t)
    local s = t.screen
    local w = widgets[s.index]
    if w then
        local tag_layout = awful.layout.getname(awful.layout.get(s))
        w:get_children_by_id("tag_layout")[1].text = firstToUpper(tag_layout)
    end
end

local function update_from_client()
    local c = client.focus
    if c then
        local w = widgets[c.screen.index]
        if w then
            local client_layout = w:get_children_by_id("client_layout")[1]
            if c.floating then
                client_layout.text = " : Floating"
            else
                client_layout.text = ""
            end
        end
    end
end



local function create(s)

    tag.connect_signal("property::selected", update_from_tag)
    tag.connect_signal("property::layout", update_from_tag)

    client.connect_signal("property::floating", update_from_client)
    client.connect_signal("request::activate", update_from_client)

    local tag_layout = {
        widget = wibox.widget.textbox,
        font = beautiful.font,
        id = "tag_layout"
    }

    local client_layout = {
        widget = wibox.widget.textbox,
        font = beautiful.font,
        id = "client_layout"
    }

    local widget = wibox.widget {
        widget = wibox.container.background,
        bg = beautiful.tilingStatus.bg,
        fg = beautiful.tilingStatus.fg,
        {
            widget = wibox.container.margin,
            left = beautiful.tilingStatus.leftMargin,
            right = beautiful.tilingStatus.rightMargin,
            {
                layout = wibox.layout.fixed.horizontal,
                tag_layout,
                client_layout
            }
        }
    }

    if widgets == nil then
        widgets = setmetatable({}, { __mode = "kv" })
    end

    widgets[s.index] = widget

    update_from_tag(s.selected_tag)

    return widget
end


return create