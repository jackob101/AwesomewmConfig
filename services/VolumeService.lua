--- @type Gears
local gears = require("gears")

--- @type Awful
local awful = require('awful')

-- This is soo stupid but it works
local canServe = true


local INC_VOLUME_CMD = "amixer -D pulse sset Master 5%+"
local DEC_VOLUME_CMD = "amixer -D pulse sset Master 5%-"
local TOG_VOLUME_CMD = "amixer -D pulse sset Master toggle"

local function update(shouldDisplay)
    awful.spawn.easy_async_with_shell("amixer -D pulse sget Master", function(out)
        local isMute = string.match(out, "%[(o%D%D?)%]") == "off" -- \[(o\D\D?)\] - [on] or [off]
        local newVolume = tonumber(string.match(out, "(%d?%d?%d)%%"))
        local shouldDisplay = shouldDisplay or false

        awesome.emit_signal(Signals.volume_update_widgets, newVolume, isMute, shouldDisplay)

        canServe = true;
    end)
end
 
local function increase(shouldDisplay)
    if canServe then
        canServe = false
        awful.spawn.easy_async_with_shell(INC_VOLUME_CMD, function()
            update(shouldDisplay)
        end)
        return true
    end
    return false
end

local function decrease(shouldDisplay)
    if canServe then
        canServe = false
        awful.spawn.easy_async_with_shell(DEC_VOLUME_CMD, function()
            update(shouldDisplay)
        end)
        return true
    end
    return false
end

local function toggle(shouldDisplay)
    if canServe then
        canServe = false
        awful.spawn.easy_async_with_shell(TOG_VOLUME_CMD, function()
            update(shouldDisplay)
        end)
        return true
    end
    return false
end

--- @param amount number Amount to set volume to
local function set(amount, shouldDisplay)
    if canServe then
        if amount and type(amount) == "number" then
            if amount >= 0 and amount <= 100 then
                canServe = false
                awful.spawn.easy_async_with_shell("amixer -D pulse sset Master " .. amount .. "%", function()
                    update(shouldDisplay)
                end)
                return true
            end
        end
    end
    return false
end


awesome.connect_signal(Signals.volume_decrease, decrease)
awesome.connect_signal(Signals.volume_increase, increase)
awesome.connect_signal(Signals.volume_toggle, toggle)
awesome.connect_signal(Signals.volume_update, update)
awesome.connect_signal(Signals.volume_set, set)


gears.timer {
    timeout = 5,
    autostart = true,
    call_now = true,
    callback = function()
        update(false)
    end
}
