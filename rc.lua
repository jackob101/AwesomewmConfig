-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

require("awful.autofocus")
require("class_definitions")
require("style_utils")
require("error_handling")
require("beautiful").init(os.getenv("HOME") .. "/.config/awesome/theme.lua")

CONFIG = {
  wallpaper_folder = os.getenv("HOME") .. "/Wallpapers",
  terminal = "alacritty",
  editor = "nvim",
  modkey = "Mod4",
}

require("signals")
require("icons")
require("configs")
require("services")
require("ui")

-- This is used later as the default terminal and editor to run.
terminal = CONFIG.terminal
editor = os.getenv("EDITOR") or CONFIG.editor
editor_cmd = terminal .. " -e " .. editor

require("menubar").utils.terminal = terminal -- Set the terminal for applications that require it
