-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")
require("awful.autofocus")
require("preInit")

Signals = require("signals")

require("utils")

require("configs.keybindings")

require("icons")
IconsHandler.init()

load_all("", {
    "configs",
    "errors",
})

require("services")


require("ui")

-- This is used later as the default terminal and editor to run.
terminal = "alacritty"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor

Menubar.utils.terminal = terminal -- Set the terminal for applications that require it



awesome.emit_signal(Signals.volume_update)

