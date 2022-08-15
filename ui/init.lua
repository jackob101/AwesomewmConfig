--- @type Awful
local awful = require('awful')

local volume_popup = require("ui.VolumePopupWidget")

load_all("ui", {
    "bar",
    "utils",
    "ExitScreen",
    "notificationCenter",
})

awful.screen.connect_for_each_screen(function(s)
    volume_popup(s)
end)
