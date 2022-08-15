-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

--- @type Naughty
local naughty = require('naughty')

require("awful.autofocus")
require("preInit")

-- Helper function to load modules
function load_all(path_to_folder, file_names)
    for i, v in ipairs(file_names) do
        require(path_to_folder .. "." .. v)
    end
end

-- Error handling during startup
if awesome.startup_errors then
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors,
    })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function(err)
        -- Make sure we don't go into an ondless error loop
        if in_error then
            return
        end
        in_error = true

        naughty.notify({
            preset = naughty.config.presets.critical,
            title = "Oops, an error happened!",
            text = tostring(err),
        })
        in_error = false
    end)
end

require("beautiful").init(os.getenv("HOME") .. "/.config/awesome/theme.lua")

CONFIG = {
    wallpaper_folder = os.getenv("HOME") .. "/Wallpapers",
    terminal = "alacritty",
    editor = "nvim",
    modkey = "Mod4"
}

Signals = require("signals")

require("icons")
IconsHandler.init()

load_all("", {
    "configs",
})

require("services")


require("ui")

-- This is used later as the default terminal and editor to run.
terminal = CONFIG.terminal
editor = os.getenv("EDITOR") or CONFIG.editor
editor_cmd = terminal .. " -e " .. editor

require("menubar").utils.terminal = terminal -- Set the terminal for applications that require it