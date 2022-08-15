--- @type Wibox
local wibox = require('wibox')

--- @type Awful
local awful = require('awful')

--- @type Widgets
local widgets = require("widgets")

--- @type Gears
local gears = require('gears')

--- @type Beautiful
local beautiful = require('beautiful')



local textBox = widgets.text({
    size = 60
})

local backdrop = awful.popup({
    visible = false,
    ontop = true,
    type = "dock",
    shape = gears.shape.rectangle,
    bg = beautiful.black .. "AA",
    widget = {
        widget = wibox.container.place,
        valign = "center",
        halign = "center",
        textBox,
    },
})

if screen:count() == 2 then
    textBox.text = "Select tag [0-9]"
end


--- @param c Client
local function start(c)
    backdrop.width = c.screen.geometry.width
    backdrop.height = c.screen.geometry.height
    backdrop.minimum_width = c.screen.geometry.width
    backdrop.minimum_height = c.screen.geometry.height

    --- @type number
    local tagIndex

    --- @type number
    local screenIndex

    if screen:count() == 2 then
        screenIndex = (awful.screen.focused().index % 2) + 1
    end

    local keyGrabber = awful.keygrabber {
        start_callback = function()
            backdrop.visible = true
        end,
        stop_callback = function()
            backdrop.visible = false
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
                    textBox.text = "Select tag [0-9]"
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

awesome.connect_signal(Signals.client_mover_start, start)
