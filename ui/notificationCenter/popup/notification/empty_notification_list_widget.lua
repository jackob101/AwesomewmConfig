local empty_notification_list_widget = Wibox.widget({
    {
        layout = Wibox.layout.fixed.vertical,
        spacing = Dpi(5),
        {
            expand = "none",
            layout = Wibox.layout.align.horizontal,
            nil,
            {
                stylesheet = stylesheet,
                image = IconsHandler.icons.bell.path,
                resize = true,
                forced_height = Dpi(35),
                forced_width = Dpi(35),
                widget = Wibox.widget.imagebox,
            },
            nil,
        },
        {
            text = "Wow, such empty.",
            font = "Inter Bold 14",
            align = "center",
            valign = "center",
            widget = Wibox.widget.textbox,
        },
        {
            text = "Come back later.",
            font = "Inter Regular 10",
            align = "center",
            valign = "center",
            widget = Wibox.widget.textbox,
        },
    },
    margins = Dpi(20),
    widget = Wibox.container.margin,
})

local separator_for_empty_msg = Wibox.widget({
    orientation = "vertical",
    opacity = 0.0,
    widget = Wibox.widget.separator,
})

-- Make empty_notifbox center
local centered_empty_notifbox = Wibox.widget({
    layout = Wibox.layout.align.vertical,
    forced_height = Dpi(500),
    expand = "none",
    separator_for_empty_msg,
    empty_notification_list_widget,
    separator_for_empty_msg,
})

return centered_empty_notifbox