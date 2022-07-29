local awful = require("awful")
local wibox = require("wibox")

--- @class ClientMover : Initializable
--- @field isInitialized boolean Shows if ClientMover is initialized or new instance must be created
ClientMover = {
    isInitialized = false
}
ClientMover.__index = ClientMover

--- @return ClientMover
function ClientMover.new()

    if ClientMover.isInitialized then
        return
    end

    ClientMover._textBox = wibox.widget({
        widget = wibox.widget.textbox,
        align = "center",
        font = "Inter bold 36",
    })

    ClientMover._backdrop = awful.popup({
        visible = false,
        ontop = true,
        type = "dock",
        shape = Gears.shape.rectangle,
        bg = Beautiful.bg_normal .. "AA",
        widget = {
            widget = Wibox.container.place,
            valign = "center",
            halign = "center",
            ClientMover._textBox,
        },
    })

    if screen:count() == 2 then
        ClientMover._textBox.text = "Select tag [0-9]"
    end

    ClientMover.isInitialized = true

end


--
--- @param c Client
function ClientMover.start(c)
    ClientMover._backdrop.width = c.screen.geometry.width
    ClientMover._backdrop.height = c.screen.geometry.height
    ClientMover._backdrop.minimum_width = c.screen.geometry.width
    ClientMover._backdrop.minimum_height = c.screen.geometry.height

    --- @type number
    local tagIndex

    --- @type number
    local screenIndex

    if screen:count() == 2 then
        screenIndex = (Awful.screen.focused().index % 2) + 1
    end

    local keyGrabber = Awful.keygrabber{
        start_callback = function()
            ClientMover._backdrop.visible = true
        end,
        stop_callback = function()
            ClientMover._backdrop.visible = false
            ClientMover.move(tagIndex, screenIndex, c)
        end,
        keypressed_callback = function(grabber, mod, key)
            if key == "Escape" then
                grabber:stop()
            end
            -- If screen index is set skip this step. It provides easier way to switch between two screens
            if screenIndex == nil then
                local number = tonumber(key)
                -- Check if number is in range from 1 to screen amount
                if number and number > 0 and number <= screen:count() then
                    screenIndex = number
                    ClientMover._textBox.text = "Select tag [0-9]"
                else
                    -- TODO Implement some error hanndling
                    grabber:stop()
                end
            elseif screenIndex ~= nil then
                local number = tonumber(key)
                if number and number >= 0 and number <= 9 then
                    tagIndex = number
                end
                grabber:stop()
            end
        end,
    }

    keyGrabber:start()

end

--- @param tagIndex number Tag number to which move passed client
--- @param screenIndex number Screen index
--- @param c Client
function ClientMover.move(tagIndex, screenIndex, c)
    if tagIndex and screenIndex then
        local s = screen[screenIndex]
        c:move_to_screen(s)
        local tag = s.tags[tagIndex]

        for _, t in ipairs(s.tags) do
            t.selected = false
        end

        c:move_to_tag(tag)
        tag.selected = true
    end
end

