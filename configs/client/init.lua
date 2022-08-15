--- @type Awful
local awful = require('awful')

load_all("configs.client", { "rules", "signals", "focus_flash" })

client.connect_signal("request::manage", function(c)
    function c:maximize()
        local sc = awful.screen.focused()
        if sc ~= nil then
            self.x = sc.geometry.x
            self.y = sc.geometry.y
            self.width = 1920
            self.height = 1080 - Beautiful.bar.barHeight
        end
    end

end)



