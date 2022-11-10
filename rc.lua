-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

--- @type Naughty
local naughty = require("naughty")

require("awful.autofocus")
require("preInit")

-- Helper function to load modules
function load_all(path_to_folder, file_names)
  for i, v in ipairs(file_names) do
    require(path_to_folder .. "." .. v)
  end
end

-- Utility function to initialize styles for widgets. Must be used before widget is initialized. So before wibox.widget() is called.
--- @param tab table
--- @param styles? table|string
function Apply_styles(tab, styles)
  -- If passed argument is not a table then simply return because there is nothing to  do
  if type(tab) ~= "table" then
    return
  end

  -- Iterate over nested tables initializing them. Ignoring 'widget' fields because there is nothing to do for them
  -- tab.prevent_recursive_styles -> for some cases when you need to prevent appling nested styles. For example some part of widget already had applied styles
  for k, v in pairs(tab) do
    if k ~= "widget" and k ~= "layout" and type(v) == "table" and not tab.prevent_recursive_styles then
      Apply_styles(v, styles)
    end
  end

  local class = tab["class"]

  -- If class is not specified then return
  if tab.styles_applied or class == nil then
    return tab
  end

  local found_styles = nil

  -- Styles can be either as string or as table.
  if styles ~= nil and type(class) == "string" then
    found_styles = styles[class]
  elseif type(class) == "table" then
    found_styles = class
  end

  if found_styles == nil then
    return tab
  end

  -- Iterate over 'styles' table and insert fields into widget
  for key, value in pairs(found_styles) do
    tab[key] = value
  end

  tab.styles_applied = true

  -- Return tab so the root widget can be returned from function
  return tab
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
  modkey = "Mod4",
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
