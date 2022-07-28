local awful = require("awful")
local gears = require("gears")

local INC_VOLUME_CMD = "amixer -D pulse sset Master 5%+"
local DEC_VOLUME_CMD = "amixer -D pulse sset Master 5%-"
local TOG_VOLUME_CMD = "amixer -D pulse sset Master toggle"
local UPDATE_SIGNAL = "module::volume::widgets:update"

--- @class VolumeUpdatableWidget : BaseWidget
local updateable = {
}

--- @param newVolume number
--- @param isMute boolean
function updateable:update(newVolume, isMute)
end

--- @class Volume This class is a singletoon responsible for all things about handling Volume
--- @field toUpdate VolumeUpdatableWidget[]
Volume = {
    isInitialized = false,
    toUpdate = {}
}
Volume.__index = Volume

--- @return Volume
function Volume.new()

    if Volume.isInitialized then
        return Volume
    end

    --- @type Volume
    local newVolume = {}
    setmetatable(newVolume, Volume)

    Gears.timer {
        timeout = 5,
        autostart = true,
        call_now = true,
        callback = Volume.update
    }

    newVolume.isInitialized = true
    return newVolume
end

function Volume.update()
    Awful.spawn.easy_async_with_shell("amixer -D pulse sget Master", function(out)

        local isMute = string.match(out, "%[(o%D%D?)%]") == "off"  -- \[(o\D\D?)\] - [on] or [off]
        local newVolume = tonumber(string.match(out, "(%d?%d?%d)%%"))

        for _, w in ipairs(Volume.toUpdate) do
            w:update(newVolume, isMute)
        end
    end)
end

--- @param widget VolumeUpdatableWidget
function Volume.connect(widget)
    table.insert(Volume.toUpdate, widget)
end

function Volume.increase()
    Awful.spawn.easy_async_with_shell(INC_VOLUME_CMD, function()
        Volume.update()
    end)
end

function Volume.decrease()
    Awful.spawn.easy_async_with_shell(DEC_VOLUME_CMD, function()
        Volume.update()
    end)
end

function Volume.toggle()
    Awful.spawn.easy_async_with_shell(TOG_VOLUME_CMD, function()
        Volume.update()
    end)
end

--- @param amount number Amount to set volume to
function Volume.set(amount)
    if amount and type(amount) == "number" then
        if amount >= 0 and amount <= 100 then
            Awful.spawn.easy_async_with_shell("amixer -D pulse sset Master " .. amount .. "%", function()
                Volume.update()
            end)
        end
    end
end

local function update()
    awful.spawn.easy_async_with_shell("amixer -D pulse sget Master", function(out)
        awesome.emit_signal(UPDATE_SIGNAL, out)
    end)
end

awesome.connect_signal("module::volume:up", function()
    awful.spawn.easy_async_with_shell(INC_VOLUME_CMD, function()
        update()
    end)
end)

awesome.connect_signal("module::volume:down", function()
    awful.spawn.easy_async_with_shell(DEC_VOLUME_CMD, function()
        update()
    end)
end)

awesome.connect_signal("module::volume:set", function(volume)
    if volume and type(volume) == "number" then
        if volume >= 0 and volume <= 100 then
            awful.spawn.easy_async_with_shell("amixer -D pulse sset Master " .. volume .. "%", function()
                update()
            end)
        end
    end
end)

awesome.connect_signal("module::volume:toggle", function()
    awful.spawn.easy_async_with_shell(TOG_VOLUME_CMD, function()
        update()
    end)
end)
