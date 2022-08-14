--- @type Wibox
local wibox = require("wibox")


local systray = wibox.widget({
    widget = wibox.widget.systray,
    screen = "primary",
})


--- @param s Screen
return function(s)
    if s.index == 1 then
        return systray
    end
end
