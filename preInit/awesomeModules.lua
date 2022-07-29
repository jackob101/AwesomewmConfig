--- @type Beautiful
Beautiful = require("beautiful")
Beautiful.init(os.getenv("HOME") .. "/.config/awesome/theme.lua")

--- @type Gears
Gears = require("gears")

--- @type Wibox
Wibox = require("wibox")

--- @type Awful
Awful = require("awful")

--- @type Naughty
Naughty = require("naughty")

--- @type Ruled
Ruled = require("ruled")

--- @type Dpi
Dpi = Beautiful.xresources.apply_dpi

--- @type Menubar
Menubar = require("menubar")

ModKey = "Mod4"
