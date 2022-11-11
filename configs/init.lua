--- @type Awful
local awful = require("awful")

--- @type Wibox
local wibox = require("wibox")

--- @type Gears
local gears = require("gears")

-- ██╗      █████╗ ██╗   ██╗ ██████╗ ██╗   ██╗████████╗███████╗
-- ██║     ██╔══██╗╚██╗ ██╔╝██╔═══██╗██║   ██║╚══██╔══╝██╔════╝
-- ██║     ███████║ ╚████╔╝ ██║   ██║██║   ██║   ██║   ███████╗
-- ██║     ██╔══██║  ╚██╔╝  ██║   ██║██║   ██║   ██║   ╚════██║
-- ███████╗██║  ██║   ██║   ╚██████╔╝╚██████╔╝   ██║   ███████║
-- ╚══════╝╚═╝  ╚═╝   ╚═╝    ╚═════╝  ╚═════╝    ╚═╝   ╚══════╝

awful.layout.remove_default_layout()
awful.layout.append_default_layouts({
  awful.layout.suit.tile,
  awful.layout.suit.floating,
})

-- ████████╗ █████╗  ██████╗ ███████╗
-- ╚══██╔══╝██╔══██╗██╔════╝ ██╔════╝
--    ██║   ███████║██║  ███╗███████╗
--    ██║   ██╔══██║██║   ██║╚════██║
--    ██║   ██║  ██║╚██████╔╝███████║
--    ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚══════╝

screen.connect_signal("request::desktop_decoration", function(s)
  awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9", "0" }, s, awful.layout.layouts[1])
end)

-- ██╗    ██╗ █████╗ ██╗     ██╗     ██████╗  █████╗ ██████╗ ███████╗██████╗
-- ██║    ██║██╔══██╗██║     ██║     ██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔══██╗
-- ██║ █╗ ██║███████║██║     ██║     ██████╔╝███████║██████╔╝█████╗  ██████╔╝
-- ██║███╗██║██╔══██║██║     ██║     ██╔═══╝ ██╔══██║██╔═══╝ ██╔══╝  ██╔══██╗
-- ╚███╔███╔╝██║  ██║███████╗███████╗██║     ██║  ██║██║     ███████╗██║  ██║
--  ╚══╝╚══╝ ╚═╝  ╚═╝╚══════╝╚══════╝╚═╝     ╚═╝  ╚═╝╚═╝     ╚══════╝╚═╝  ╚═╝

local wallpaper = gears.filesystem.get_random_file_from_dir(CONFIG.wallpaper_folder)
-- Create a wibox for each screen and add it
local function set_wallpaper(s)
  -- Wallpaper
  awful.wallpaper({
    screen = s,
    widget = {
      image = CONFIG.wallpaper_folder .. "/" .. wallpaper,
      resize = true,
      horizontal_fit_policy = "fit",
      vertical_fit_policy = "fit",
      widget = wibox.widget.imagebox,
    },
  })
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
  -- Wallpaper
  set_wallpaper(s)
end)

----------------------------------------
-- Initialize basic configs
----------------------------------------
require(... .. ".client")
require(... .. ".Autostart")
require(... .. ".keybindings")
