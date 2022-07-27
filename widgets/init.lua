require("widgets.bar")

Awful.screen.connect_for_each_screen(function(s)

    s.wibar = StatusBar.new(s)

end)
