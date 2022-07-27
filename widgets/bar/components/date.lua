local wibox = require("wibox")
local beautiful = require("beautiful")
local icons = require("icons")

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
        icons.calendar.widget(),
        calendar,
        layout = wibox.layout.fixed.horizontal,
        spacing = beautiful.bar_icon_text_spacing,
    })

    print("What")
    return newDateWidget
end