local INC_VOLUME_CMD = "amixer -D pulse sset Master 5%+"
local DEC_VOLUME_CMD = "amixer -D pulse sset Master 5%-"
local TOG_VOLUME_CMD = "amixer -D pulse sset Master toggle"
local UPDATE_SIGNAL = "module::volume::widgets:update"

--- @class VolumeUpdatableWidget : BaseWidget
--- @field update fun(newVolume: number, isMute:boolean)


--- @class VolumeService : Initializable This class is a singletoon responsible for all things about handling Volume
--- @field toUpdate VolumeUpdatableWidget[]
VolumeService = {
    isInitialized = false,
    toUpdate = {}
}
VolumeService.__index = VolumeService

--- @return VolumeService
function VolumeService.init()

    if VolumeService.isInitialized then
        return
    end

    Gears.timer {
        timeout = 5,
        autostart = true,
        call_now = true,
        callback = VolumeService.update
    }

    VolumeService.isInitialized = true
end

function VolumeService.update()
    Awful.spawn.easy_async_with_shell("amixer -D pulse sget Master", function(out)

        local isMute = string.match(out, "%[(o%D%D?)%]") == "off"  -- \[(o\D\D?)\] - [on] or [off]
        local newVolume = tonumber(string.match(out, "(%d?%d?%d)%%"))

        for _, w in ipairs(VolumeService.toUpdate) do
            w:update(newVolume, isMute)
        end
    end)
end

--- @param widget VolumeUpdatableWidget
function VolumeService.connect(widget)
    table.insert(VolumeService.toUpdate, widget)
end

function VolumeService.increase()
    Awful.spawn.easy_async_with_shell(INC_VOLUME_CMD, function()
        VolumeService.update()
    end)
end

function VolumeService.decrease()
    Awful.spawn.easy_async_with_shell(DEC_VOLUME_CMD, function()
        VolumeService.update()
    end)
end

function VolumeService.toggle()
    Awful.spawn.easy_async_with_shell(TOG_VOLUME_CMD, function()
        VolumeService.update()
    end)
end

--- @param amount number Amount to set volume to
function VolumeService.set(amount)
    if amount and type(amount) == "number" then
        if amount >= 0 and amount <= 100 then
            Awful.spawn.easy_async_with_shell("amixer -D pulse sset Master " .. amount .. "%", function()
                VolumeService.update()
            end)
        end
    end
end

local function update()
    Awful.spawn.easy_async_with_shell("amixer -D pulse sget Master", function(out)
        awesome.emit_signal(UPDATE_SIGNAL, out)
    end)
end

awesome.connect_signal("module::volume:up", function()
    Awful.spawn.easy_async_with_shell(INC_VOLUME_CMD, function()
        update()
    end)
end)

awesome.connect_signal("module::volume:down", function()
    Awful.spawn.easy_async_with_shell(DEC_VOLUME_CMD, function()
        update()
    end)
end)

awesome.connect_signal("module::volume:set", function(volume)
    if volume and type(volume) == "number" then
        if volume >= 0 and volume <= 100 then
            Awful.spawn.easy_async_with_shell("amixer -D pulse sset Master " .. volume .. "%", function()
                update()
            end)
        end
    end
end)

awesome.connect_signal("module::volume:toggle", function()
    Awful.spawn.easy_async_with_shell(TOG_VOLUME_CMD, function()
        update()
    end)
end)
