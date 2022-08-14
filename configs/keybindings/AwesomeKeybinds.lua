local hotkeys_popup = require("awful.hotkeys_popup")

return function()

        Keybinds.connectForGlobal(Gears.table.join(
                Awful.key(
                        { ModKey },
                        "F1",
                        hotkeys_popup.show_help,
                        { description = "show help", group = "awesome" }
                ),

                Awful.key(
                        { ModKey, "Shift" },
                        "r",
                        awesome.restart,
                        { description = "reload awesome", group = "awesome" }
                ),

                Awful.key(
                        { ModKey, "Shift", "Control" },
                        "l",
                        awesome.quit,
                        { description = "quit awesome", group = "awesome" }
                ),

                --     ██╗   ██╗ ██████╗ ██╗     ██╗   ██╗███╗   ███╗███████╗
                --     ██║   ██║██╔═══██╗██║     ██║   ██║████╗ ████║██╔════╝
                --     ██║   ██║██║   ██║██║     ██║   ██║██╔████╔██║█████╗
                --     ╚██╗ ██╔╝██║   ██║██║     ██║   ██║██║╚██╔╝██║██╔══╝
                --      ╚████╔╝ ╚██████╔╝███████╗╚██████╔╝██║ ╚═╝ ██║███████╗
                --       ╚═══╝   ╚═════╝ ╚══════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝


                Awful.key(
                        {},
                        "XF86AudioRaiseVolume",
                        function()
                                awesome.emit_signal(Signals.volume_increase, true)
                        end,
                        { description = "Increase volume", group = "audio" }
                ),
                Awful.key(
                        {},
                        "XF86AudioLowerVolume",
                        function()
                                awesome.emit_signal(Signals.volume_decrease, true)
                        end,
                        { description = "Decrease volume", group = "audio" }
                ),
                Awful.key(
                        {},
                        "XF86AudioMute",
                        function()
                                awesome.emit_signal(Signals.volume_toggle, false)
                        end,
                        { description = "Mute audio", group = "audio" }
                )

        ))

end
