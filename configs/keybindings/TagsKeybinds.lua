return function()

    local newKeys = Gears.table.join(
            Awful.key(
                    { ModKey },
                    "Left",
                    Awful.tag.viewprev,
                    { description = "view previous", group = "tag" }
            ),

            Awful.key(
                    { ModKey },
                    "Right",
                    Awful.tag.viewnext,
                    { description = "view next", group = "tag" }
            ),

            Awful.key(
                    { ModKey },
                    "Escape",
                    Awful.tag.history.restore,
                    { description = "go back", group = "tag" }
            )

    )

    for i = 1, 10 do
        newKeys = Gears.table.join(
                newKeys,
                Awful.key({ ModKey }, "#" .. i + 9, function()
                    local screen = Awful.screen.focused()
                    local tag = screen.tags[i]
                    if tag then
                        tag:view_only()
                    end
                end, {
                    description = "view tag #" .. i,
                    group = "tag",
                }),
        -- Toggle tag display.
                Awful.key({ ModKey, "Control" }, "#" .. i + 9, function()
                    local screen = Awful.screen.focused()
                    local tag = screen.tags[i]
                    if tag then
                        Awful.tag.viewtoggle(tag)
                    end
                end, {
                    description = "toggle tag #" .. i,
                    group = "tag",
                }),
        -- Move client to tag.
                Awful.key({ ModKey, "Shift" }, "#" .. i + 9, function()
                    if client.focus then
                        local tag = client.focus.screen.tags[i]
                        if tag then
                            client.focus:move_to_tag(tag)
                        end
                    end
                end, {
                    description = "move focused client to tag #" .. i,
                    group = "tag",
                }),
        -- Toggle tag on focused client.
                Awful.key({ ModKey, "Control", "Shift" }, "#" .. i + 9, function()
                    if client.focus then
                        local tag = client.focus.screen.tags[i]
                        if tag then
                            client.focus:toggle_tag(tag)
                        end
                    end
                end, {
                    description = "toggle focused client on tag #" .. i,
                    group = "tag",
                })
        )
    end

 Keybinds.connectForGlobal(newKeys)
end
