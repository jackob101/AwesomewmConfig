--- @class NotificationToggle : BaseWidget
local NotificationBoxToggle = {}
NotificationBoxToggle.__index = NotificationBoxToggle

--- @param popup NotificationPopupWidget
--- @return NotificationToggle 
function NotificationBoxToggle.new(popup)
    --- @type NotificationToggle 
    local newInstance = {}
    setmetatable(newInstance, NotificationBoxToggle)

    local button = Wibox.widget({
        widget = Wibox.container.background,
        IconsHandler.icons.bell.widget(Beautiful.fg_normal)
    })

    Utils.cursor_hover(button)
    Utils.generate_tooltip(button, "Toggle notification center")

    button:buttons(Gears.table.join(Awful.button({}, 1, function()
        NotificationCenter.toggle_popup()
    end)
    ))

    newInstance.widget = button

    return newInstance
end

return NotificationBoxToggle