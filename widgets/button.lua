--- @type Wibox
local wibox = require("wibox")
--- @type Gears
local gears = require("gears")
--- @type Beautiful
local beautiful = require("beautiful")

local text_widget = require("widgets.text")

local function create(args)

    local args = args or {}
    args.font = args.font or beautiful.font_name
    args.size = args.font_size or beautiful.font_size
    args.valign = args.valign or "center"
    args.halign = args.halign or "center"
    args.bg = args.bg or beautiful.button_bg
    args.fg = args.fg or beautiful.button_fg
    args.fg_hover = args.fg_hover or beautiful.button_hover_fg
    args.bg_hover = args.bg_hover or beautiful.button_hover_bg
    args.text = args.text or ""
    args.forced_height = args.height or beautiful.button_height
    args.forced_width = args.width or beautiful.button_width
    args.border_color = args.border_color or beautiful.border_color
    args.border_width = args.border_width or beautiful.border_width
    args.apply_hover = args.apply_hover or false
    args.on_click = args.on_click or function() end
    args.on_release = args.on_release or function() end
    args.shape = args.shape or nil


    local text = text_widget({
        halign = args.halign,
        valign = args.valign,
        text = args.text,
        font = args.font,
        size = args.font_size,
        color = args.fg,
    })


    local container = wibox.widget({
        widget = wibox.container.background,
        forced_height = args.height,
        forced_width = args.width,
        bg = args.bg,
        border_color = args.border_color,
        border_width = args.border_width,
        shape = args.shape,
        {
            widget = wibox.container.margin,
            margins = 3,
            text,
        }
    })

    container:connect_signal("button::press", args.on_click)

    container:connect_signal("button::press", args.on_release)

    if args.apply_hover then
        container:connect_signal("mouse::enter", function(self)
            self.bg = args.bg_hover
            text:set_color(args.fg_hover)
        end)

        container:connect_signal("mouse::leave", function(self)
            self.bg = args.bg
            text:set_color(args.fg)
        end)

    end


    function container:set_width(width) text:set_width(width) end

    function container:set_height(height) text:set_height(height) end

    function container:set_halign(halign) text:set_halign(halign) end

    function container:set_font(font) text:set_font(font) end

    function container:set_bold(bold) text:set_bold(bold) end

    function container:set_italic(italic) text:set_italic(italic) end

    function container:set_size(size) text:set_size(size) end

    function container:set_color(color) text:set_color(color) end

    function container:set_text(value) text:set_text(value) end

    return container
end

return create
