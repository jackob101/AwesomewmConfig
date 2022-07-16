---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by jakub.
--- DateTime: 7/16/22 3:01 PM
---
local beautiful = require("beautiful")
local awful = require("awful")

client.connect_signal("request::manage", function(c)
    function c:maximize()
        print("self")
        local index = awful.screen.focused().index - 1
        self.x = 1920 * index
        self.y = 0
        self.width = 1920
        self.height = 1080 - beautiful.bar_height
    end

end)
