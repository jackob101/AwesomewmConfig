require("widgets.bar")
require("widgets.client_mover")
require("widgets.autorun")

Awful.screen.connect_for_each_screen(function(s)

    s.wibar = StatusBar.new(s)

end)

ClientMover.new()
