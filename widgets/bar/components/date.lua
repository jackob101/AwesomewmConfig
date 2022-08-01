local wibox = require("wibox")
local beautiful = require("beautiful")

--- @class DateBarWidget
DateBarWidget = {}
DateBarWidget.__index = DateBarWidget

--- @return DateBarWidget
function DateBarWidget.new()
    local newDateWidget = {}
    setmetatable(newDateWidget, DateBarWidget)

    local calendar = wibox.widget({
        widget = wibox.widget.textclock,
        format = "%a %b %d",
        font = beautiful.bar_font,
    })

    newDateWidget.widget = wibox.widget({
        IconsHandler.icons.calendar.widget(),
        calendar,
        layout = wibox.layout.fixed.horizontal,
        spacing = beautiful.bar_icon_text_spacing,
    })

    return newDateWidget
end