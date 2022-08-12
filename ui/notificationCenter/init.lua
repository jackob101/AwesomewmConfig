--- @type NotificationPopupWidget
local NotificationPopupWidget = require((...) .. ".popup")
--- @type NotificationToggle
local NotificationToggle = require((...) .. ".widget")

--- @class NotificationCenterWidget
--- @field popups NotificationPopupWidget[]
NotificationCenter = {
    are_keybinds_initialized = false,
    popups = {}
}
NotificationCenter.__index = NotificationCenter

--- @param s Screen
function NotificationCenter.new(s)
    --- @type NotificationPopupWidget
    NotificationCenter.popups[s.index] = NotificationPopupWidget.new(s)

    if not NotificationCenter.are_keybinds_initialized then
        NotificationCenter._init_keybinds()
        NotificationCenter.are_keybinds_initialized = true
    end

    return NotificationCenter
end

--- @param s Screen
--- @return NotificationToggle
function NotificationCenter.create_toggle_popup_widget(s)
    return NotificationToggle.new()
end

function NotificationCenter.toggle_popup()
    local current_screen_popup = NotificationCenter.popups[Awful.screen.focused().index]
    if current_screen_popup:isOpen() then
        current_screen_popup:close()
    else
        for v in screen do
            NotificationCenter.popups[v.index]:close()
        end
        current_screen_popup:open()
    end
end

function NotificationCenter._init_keybinds()
    Keybinds.connectForGlobal(Gears.table.join(
        Awful.key(
            { ModKey, "Shift", "Control" },
            "c",
            function()
                NotificationCenter.toggle_popup()
            end,
            { description = "panel", group = "notification center" }
        )))

end
