require("widgets.bar")
require("widgets.client_mover")
require("widgets.autorun")
require("widgets.utils")
require("widgets.ExitScreen")

load_all("widgets", {
    "bar",
    "client_mover",
    "autorun",
    "utils",
    "ExitScreen",
    "PostureCheckNotificator"
})

Awful.screen.connect_for_each_screen(function(s)

    s.wibar = StatusBar.new(s)

end)

ClientMover.new()
PostureCheckNotificator.new()