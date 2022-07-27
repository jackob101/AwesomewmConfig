require("widgets.bar")
require("widgets.client_mover")

Awful.screen.connect_for_each_screen(function(s)

    s.wibar = StatusBar.new(s)

end)

ClientMover.new()
