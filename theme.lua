---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local xrdb = xresources.get_current_theme()
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

awesome.set_preferred_icon_size(128)

--- @class Beautiful
--- @field xresources Xresources
local theme = {}

--  Theme font
theme.font_name = "Ubuntu "
theme.font_size = 10
theme.icons_font = "Material icons "
theme.font = theme.font_name .. " " .. theme.font_size

theme.green = "#9ece6a"
theme.red = "#f7768e"
theme.aqua = "#73daca"
theme.orange = "#ff9e64"
theme.blue = "#2ac3de"
theme.black = "#24283b"
theme.gray = "#414868"
theme.light_gray = "#565f89"
theme.light = "#a9b1d6"

-- Default values

theme.accent = theme.green
theme.background = theme.black
theme.foreground = theme.light
theme.corner_radius = 10
theme.border_width = dpi(1)
theme.border_color = theme.gray

-- Status bar
theme.bar_font_size = 10
theme.bar_icons_size = 14
theme.bar_height = dpi(32)

-- Default values for button widgets
theme.button_bg = theme.gray
theme.button_fg = theme.light
theme.button_border_width = dpi(1)
theme.button_border_color = theme.light_gray
theme.button_width = dpi(20)
theme.button_height = dpi(20)
theme.button_hover_fg = theme.black
theme.button_hover_bg = theme.accent

theme.useless_gap = dpi(5)
theme.gap_single_client = true

theme.bg_normal = theme.black

theme.bg_overlay = "#414868"
theme.bg_transparent = theme.black .. "AA"
theme.bg_focus = theme.gray
theme.bg_overlay_transparent = theme.bg_overlay .. "EE"
theme.bg_hover = theme.light_gray
theme.bg_hover_transparent = theme.bg_hover .. "AA"
theme.bg_urgent = theme.red
theme.bg_minimize = xrdb.color8 or "#3B4252"

theme.fg_normal = xrdb.foreground or "#8DEE9"
theme.fg_focus = xrdb.foreground or "#ECEFF4"
theme.fg_urgent = xrdb.color9 or "#D08770"
theme.fg_minimize = xrdb.foreground or "#D8DEE9"

theme.groups_bg = xrdb.color2 .. "77"

-- Generate taglist squares:
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(dpi(0), theme.fg_focus)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(dpi(0), theme.fg_normal)
theme.taglist_fg_focus = theme.foreground
theme.taglist_fg_urgent = theme.fg_normal
theme.taglist_bg_focus = theme.accent
theme.taglist_bg_urgent = theme.red
theme.taglist_bg_occupied = theme.bg_overlay_transparent
theme.taglist_fg_occupied = theme.foreground
theme.taglist_font = theme.font_name .. "13"

theme.calendar_font = theme.font_name .. theme.font_size

theme.exit_screen = {
    bg = theme.black .. "CC",
    fg = theme.light,
    groups_bg = theme.gray,
}

theme.notification = {
    bg = theme.gray .. "99",
    position = "top_right",
    width = dpi(320),
    borderPadding = dpi(10),
    borderWidth = dpi(2),
    borderNormal = theme.light_gray,
    borderUrgent = theme.red,
    iconRightMargin = dpi(10),
    messageHeight = dpi(40),
    titleHeight = dpi(20),
    titleFont = "inter medium 11",
}

theme.tooltip = {
    bg = theme.gray,
    margins = dpi(10),
    font = "Inter 10",
    border_width = dpi(1),
    border_color = theme.light_gray,
}

theme.notification_center = {
    bg = theme.black,
    panel_bg = theme.gray .. "33",
    panel_margin = dpi(10),
    width = dpi(400),
    border_width = dpi(3),
    border_color = theme.gray,
    notification_bg = theme.gray .. "44",
    notification_bg_hover = theme.gray .. "AA",
    bottomMargin = dpi(10),
    rightMargin = dpi(10),
    calendar_current_day_fg = theme.accent,
    calendar_weekend_day_color = theme.light,
    calendar_normal_day = theme.light .. "CC",
    calendar_weekday_header_fg = theme.light,
    calendar_header_fg = theme.orange,
}

-- Bling configs
theme.flash_focus_start_opacity = 0.7
theme.flash_focus_step = 0.02

theme.transparent = "#FFFFFF00"

theme.border_normal = theme.gray or "#000000"
theme.border_focus = theme.accent or "#535d6c"
theme.border_marked = xrdb.color10 or "#91231c"

theme.hotkeys_font = "Ubuntu 10"
theme.hotkeys_description_font = "Ubuntu 10"
theme.hotkeys_border_color = theme.border_color
theme.hotkeys_modifiers_fg = theme.orange
theme.hotkeys_label_bg = theme.aqua

theme.tooltip_font = theme.tooltip.font
theme.tooltip_border_width = theme.tooltip.border_width
theme.tooltip_border_color = theme.tooltip.border_color

theme.tasklist_fg_normal = theme.foreground
theme.tasklist_fg_focus = theme.foreground
theme.tasklist_fg_urgent = theme.background
theme.tasklist_bg_focus = theme.bg_focus
theme.tasklist_black = theme.transparent
theme.tasklist_disable_task_name = false
theme.tasklist_plain_task_name = true

theme.notification_icon_size = dpi(50)
--theme.notification_max_width = dpi(400)
-- theme.notification_height = 150
theme.notification_spacing = dpi(20)
--theme.notification_box_margin = 10

theme.notification_title_font = "inter medium 11"

theme.systray_icon_spacing = 5

theme.notification_center_opacity = "FF"
theme.notification_center_width = dpi(350)
theme.notification_center_border_width = dpi(5)

theme.dashboard_border_width = dpi(2)
theme.dashboard_border_color = theme.bg_focus
theme.dashboard_margin = dpi(20)

theme.central_panel_max_width = dpi(400)
theme.central_panel_max_height = dpi(700)

theme.menu_icon_size = dpi(16)
theme.menu_icon_color = theme.fg_normal
-- Some default values

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path .. "default/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

theme.titlebar_bg_normal = theme.black
theme.titlebar_bg = theme.black
theme.titlebar_bg_focus = theme.black
theme.titlebar_controls_spacing = dpi(25)
theme.titlebar_left_edge_padding = dpi(8)
theme.titlebar_right_edge_padding = dpi(15)
theme.titlebar_icon_padding = dpi(3)
theme.titlebar_top_edge_padding = dpi(3)
theme.titlebar_bottom_edge_padding = dpi(3)
theme.titlebar_controls_hover_overlay = "#FFFFFF22"
-- Define the image to load
theme.titlebar_close_button_normal = themes_path .. "default/titlebar/close_normal.png"
theme.titlebar_close_button_focus = themes_path .. "default/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = themes_path .. "default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus = themes_path .. "default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = themes_path .. "default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive = themes_path .. "default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path .. "default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active = themes_path .. "default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path .. "default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive = themes_path .. "default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path .. "default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active = themes_path .. "default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path .. "default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive = themes_path .. "default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path .. "default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active = themes_path .. "default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path .. "default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive = themes_path .. "default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themes_path .. "default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active = themes_path .. "default/titlebar/maximized_focus_active.png"

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path .. "default/layouts/fairh.png"
theme.layout_fairv = themes_path .. "default/layouts/fairv.png"
theme.layout_floating = themes_path .. "default/layouts/floating.png"
theme.layout_magnifier = themes_path .. "default/layouts/magnifier.png"
theme.layout_max = themes_path .. "default/layouts/max.png"
theme.layout_fullscreen = themes_path .. "default/layouts/fullscreen.png"
theme.layout_tilebottom = themes_path .. "default/layouts/tilebottom.png"
theme.layout_tileleft = themes_path .. "default/layouts/tileleft.png"
theme.layout_tile = themes_path .. "default/layouts/tile.png"
theme.layout_tiletop = themes_path .. "default/layouts/tiletop.png"
theme.layout_spiral = themes_path .. "default/layouts/spiral.png"
theme.layout_dwindle = themes_path .. "default/layouts/dwindle.png"
theme.layout_cornernw = themes_path .. "default/layouts/cornernw.png"
theme.layout_cornerne = themes_path .. "default/layouts/cornerne.png"
theme.layout_cornersw = themes_path .. "default/layouts/cornersw.png"
theme.layout_cornerse = themes_path .. "default/layouts/cornerse.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(theme.menu_height, theme.bg_focus, theme.fg_focus)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = "gnome"

--- @return Beautiful
return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
