-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")
require("awful.autofocus")
Beautiful = require("beautiful")
Beautiful.init(os.getenv("HOME") .. "/.config/awesome/theme.lua")
require("utils")

--- @class Gears
Gears = require("gears")

--- @class Wibox
Wibox = require("wibox")

--- @class Awful
--- @field screen Screen
Awful = require("awful")

-- @class Naughty
Naughty = require("naughty")

-- Load libraries

Dpi = Beautiful.xresources.apply_dpi
ModKey = "Mod4"

local menubar = require("menubar")

function load(path_to_folder, file_name)
    require(path_to_folder .. "." .. file_name)
end

function load_all(path_to_folder, file_names)
    for i, v in ipairs(file_names) do
        load(path_to_folder, v)
    end
end

load_all("", {
    "configs",
    "layout",
    "errors",
})

-- require("modules.volume")
require("modules.volume.volume-popup")
require("modules.do-not-disturb-mode")
require("modules.dashboard")
require("widgets")

-- This is used later as the default terminal and editor to run.
terminal = "alacritty"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor

menubar.utils.terminal = terminal -- Set the terminal for applications that require it

--require("modules.autorun.init")

--- @class Client

--- @class Widget
local wid = {}

--- @class Screen
local screen = {}

--- @field public widget Widget
--- @class BaseWidget
local base = {}

--- @param s Screen
function base.new(s)
end

Volume.update()
