--- @type Wibox
local wibox = require("wibox")


local widget = wibox.widget({
    widget = wibox.widget.textbox,
    visible = false,
    text = "Macro on"
})

function widget:update(isOn)
    if isOn then
        self.visible = true
    else
        self.visible = false
    end
end


return function()
    return widget
end