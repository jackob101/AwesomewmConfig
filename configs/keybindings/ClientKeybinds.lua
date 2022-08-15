--- @type Awful
local awful = require('awful')

local keybinds = {
    awful.key({ CONFIG.modkey },
        "f",
        function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        { description = "toggle fullscreen", group = "client" }
    ),

    awful.key({ CONFIG.modkey, "Shift" },
        "q",
        function(c)
            c:kill()
        end,
        { description = "close", group = "client" }
    ),

    awful.key(
        { CONFIG.modkey, "Control" },
        "space",
        awful.client.floating.toggle,
        { description = "toggle floating", group = "client" }
    ),

    awful.key({ CONFIG.modkey, "Control" },
        "Return",
        function(c)
            c:swap(awful.client.getmaster())
        end,
        { description = "move to master", group = "client" }
    ),

    awful.key({ CONFIG.modkey },
        "s",
        function()
            local focused_screen = awful.screen.focused()
            local focused_screen_clients = focused_screen.selected_tag:clients()

            local next_screen_index = (focused_screen.index % 2) + 1
            local next_screen = screen[next_screen_index]
            local next_screen_clients = next_screen.selected_tag:clients()

            for _, c in ipairs(next_screen_clients) do
                c:move_to_screen(focused_screen)
            end

            for _, c in ipairs(focused_screen_clients) do
                c:move_to_screen(next_screen)
            end
        end,
        { description = "Switch currently focused clients between screens", group = "client" }
    ),

    awful.key({ CONFIG.modkey },
        "t",
        function(c)
            c.ontop = not c.ontop
        end,
        { description = "toggle keep on top", group = "client" }
    ),
    awful.key({ CONFIG.modkey },
        "n",
        function(c)
            c.minimized = true
        end,
        { description = "minimize", group = "client" }
    ),

    awful.key({ CONFIG.modkey },
        "m",
        function(c)
            c:maximize()
        end,
        { description = "(un)maximize", group = "client" }
    ),

    awful.key(
        { CONFIG.modkey },
        "o",
        function(c)
            awesome.emit_signal(Signals.client_mover_start, c)
        end,
        { description = "Move client", group = "client" }
    )
}

return keybinds
