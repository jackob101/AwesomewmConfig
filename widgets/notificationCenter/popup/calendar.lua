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

local styles = {}

styles.month   = { 
    padding = 5,
    -- bg_color     = "#555555",
    border_width = 2,
}

styles.normal  = {}

styles.focus   = { 
    fg_color = beautiful.notification_center.calendar_current_day_fg,
}

styles.header  = {
    -- fg_color = beautiful.light
}

styles.weekday = {
    fg_color = beautiful.notification_center.calendar_weekday_header_fg
}

local function decorate_cell(widget, flag, date)
    if flag == "monthheader" and not styles.monthheader then
        flag = "header"
    end
    local props = styles[flag] or {}
    if props.markup and widget.get_text and widget.set_markup then
        widget:set_markup(props.markup(widget:get_text()))
    end
    -- Change bg color for weekends
    local d = { year = date.year, month = (date.month or 1), day = (date.day or 1) }
    local weekday = tonumber(os.date("%w", os.time(d)))
    local default_fg = (weekday == 0 or weekday == 6) and beautiful.notification_center.calendar_weekend_day_color or beautiful.notification_center.calendar_normal_day
    local ret = wibox.widget {
        {
            widget,
            margins = (props.padding or 2) + (props.border_width or 0),
            widget  = wibox.container.margin
        },
        fg           = props.fg_color or default_fg,
        bg           = props.bg_color,
        widget       = wibox.container.background
    }
    return ret
end

local calendar = Wibox.widget {
    widget = wibox.container.background,
    bg = beautiful.notification_center.panel_bg,
    {
        layout = wibox.container.place,
        valign = "center",
        halign = "center",
        {
            widget = wibox.container.margin,
            margins = Dpi(10),
            {
                widget = wibox.widget.calendar.month,
                date = os.date("*t"),
                long_weekdays = true,
                fn_embed = decorate_cell
            }
        }
    }
}


return calendar
