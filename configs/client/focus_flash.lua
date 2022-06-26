
local rubato = require("lib.rubato")

client.connect_signal("focus", function(c)
    local timed = rubato.timed {
        intro = 0.1,
        duration = 0.3,
        pos = 0.7,
        subscribed = function(pos)
            c.opacity = pos
        end
    }
    timed.target = 1

end)
