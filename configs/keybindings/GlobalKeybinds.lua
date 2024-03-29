--- @type Gears
local gears = require("gears")

--- @type Awful
local awful = require("awful")

local hotkeys_popup = require("awful.hotkeys_popup")
-- require("awful.hotkeys_popup.keys")

local keybinds = {

  --  █████╗ ██╗    ██╗███████╗███████╗ ██████╗ ███╗   ███╗███████╗
  -- ██╔══██╗██║    ██║██╔════╝██╔════╝██╔═══██╗████╗ ████║██╔════╝
  -- ███████║██║ █╗ ██║█████╗  ███████╗██║   ██║██╔████╔██║█████╗
  -- ██╔══██║██║███╗██║██╔══╝  ╚════██║██║   ██║██║╚██╔╝██║██╔══╝
  -- ██║  ██║╚███╔███╔╝███████╗███████║╚██████╔╝██║ ╚═╝ ██║███████╗
  -- ╚═╝  ╚═╝ ╚══╝╚══╝ ╚══════╝╚══════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝

  awful.key({ CONFIG.modkey }, "F1", function()
    hotkeys_popup.show_help(nil, awful.screen.focused())
  end, { description = "show help", group = "awesome" }),

  awful.key({ CONFIG.modkey, "Shift" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),

  awful.key(
    { CONFIG.modkey, "Shift", "Control" },
    "l",
    awesome.quit,
    { description = "quit awesome", group = "awesome" }
  ),

  --     ██╗   ██╗ ██████╗ ██╗     ██╗   ██╗███╗   ███╗███████╗
  --     ██║   ██║██╔═══██╗██║     ██║   ██║████╗ ████║██╔════╝
  --     ██║   ██║██║   ██║██║     ██║   ██║██╔████╔██║█████╗
  --     ╚██╗ ██╔╝██║   ██║██║     ██║   ██║██║╚██╔╝██║██╔══╝
  --      ╚████╔╝ ╚██████╔╝███████╗╚██████╔╝██║ ╚═╝ ██║███████╗
  --       ╚═══╝   ╚═════╝ ╚══════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝

  awful.key({}, "XF86AudioRaiseVolume", function()
    awesome.emit_signal(Signals.volume_increase, true)
  end, { description = "Increase volume", group = "audio" }),
  awful.key({}, "XF86AudioLowerVolume", function()
    awesome.emit_signal(Signals.volume_decrease, true)
  end, { description = "Decrease volume", group = "audio" }),
  awful.key({}, "XF86AudioMute", function()
    awesome.emit_signal(Signals.volume_toggle, false)
  end, { description = "Mute audio", group = "audio" }),

  -- ██████╗ ███╗   ██╗██████╗
  -- ██╔══██╗████╗  ██║██╔══██╗
  -- ██║  ██║██╔██╗ ██║██║  ██║
  -- ██║  ██║██║╚██╗██║██║  ██║
  -- ██████╔╝██║ ╚████║██████╔╝
  -- ╚═════╝ ╚═╝  ╚═══╝╚═════╝

  awful.key({ CONFIG.modkey, "Shift" }, "t", function()
    awesome.emit_signal(Signals.dnd_toggle)
  end, { description = "Toggle DND mode", group = "DND" }),

  --  ██████╗██╗     ██╗███████╗███╗   ██╗████████╗
  -- ██╔════╝██║     ██║██╔════╝████╗  ██║╚══██╔══╝
  -- ██║     ██║     ██║█████╗  ██╔██╗ ██║   ██║
  -- ██║     ██║     ██║██╔══╝  ██║╚██╗██║   ██║
  -- ╚██████╗███████╗██║███████╗██║ ╚████║   ██║
  --  ╚═════╝╚══════╝╚═╝╚══════╝╚═╝  ╚═══╝   ╚═╝

  awful.key({ CONFIG.modkey }, "k", function()
    awful.client.focus.byidx(1)
  end, { description = "focus next by index", group = "client" }),

  awful.key({ CONFIG.modkey }, "j", function()
    awful.client.focus.byidx(-1)
  end, { description = "focus previous by index", group = "client" }),

  awful.key({ CONFIG.modkey, "Shift" }, "k", function()
    awful.client.swap.byidx(1)
  end, { description = "swap with next client by index", group = "client" }),

  awful.key({ CONFIG.modkey, "Shift" }, "j", function()
    awful.client.swap.byidx(-1)
  end, { description = "swap with previous client by index", group = "client" }),

  awful.key(
    { CONFIG.modkey },
    "u",
    awful.client.urgent.jumpto,
    { description = "jump to urgent client", group = "client" }
  ),

  awful.key({ CONFIG.modkey }, "Tab", function()
    awful.client.focus.history.previous()
    if client.focus then
      client.focus:raise()
    end
  end, { description = "go back", group = "client" }),

  awful.key({ CONFIG.modkey, "Shift" }, "n", function()
    local c = awful.client.restore()
    -- Focus restored client
    if c then
      c:emit_signal("request::activate", "key.unminimize", { raise = true })
    end
  end, { description = "restore minimized", group = "client" }),

  -- ███████╗ ██████╗██████╗ ███████╗███████╗███╗   ██╗
  -- ██╔════╝██╔════╝██╔══██╗██╔════╝██╔════╝████╗  ██║
  -- ███████╗██║     ██████╔╝█████╗  █████╗  ██╔██╗ ██║
  -- ╚════██║██║     ██╔══██╗██╔══╝  ██╔══╝  ██║╚██╗██║
  -- ███████║╚██████╗██║  ██║███████╗███████╗██║ ╚████║
  -- ╚══════╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚══════╝╚═╝  ╚═══╝

  awful.key({ CONFIG.modkey, "Control" }, "j", function()
    awful.screen.focus_relative(1)
  end, { description = "focus the next screen", group = "screen" }),

  awful.key({ CONFIG.modkey, "Control" }, "k", function()
    awful.screen.focus_relative(-1)
  end, { description = "focus the previous screen", group = "screen" }),

  awful.key({}, "Print", function()
    awful.spawn("flameshot gui")
  end, { description = "Print screen", group = "screen" }),

  -- ████████╗ █████╗  ██████╗
  -- ╚══██╔══╝██╔══██╗██╔════╝
  --    ██║   ███████║██║  ███╗
  --    ██║   ██╔══██║██║   ██║
  --    ██║   ██║  ██║╚██████╔╝
  --    ╚═╝   ╚═╝  ╚═╝ ╚═════╝

  awful.key({ CONFIG.modkey }, "Left", awful.tag.viewprev, { description = "view previous", group = "Tag" }),

  awful.key({ CONFIG.modkey }, "Right", awful.tag.viewnext, { description = "view next", group = "Tag" }),

  awful.key({ CONFIG.modkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "Tag" }),
  awful.key({
    modifiers = { CONFIG.modkey },
    keygroup = "numrow",
    description = "only view tag",
    group = "Tag",
    on_press = function(index)
      if index == 0 then
        index = 10
      end
      local screen = awful.screen.focused()
      local tag = screen.tags[index]
      if tag then
        tag:view_only()
      end
    end,
  }),
  awful.key({
    modifiers = { CONFIG.modkey, "Control" },
    keygroup = "numrow",
    description = "toggle tag",
    group = "Tag",
    on_press = function(index)
      if index == 0 then
        index = 10
      end
      local screen = awful.screen.focused()
      local tag = screen.tags[index]
      if tag then
        awful.tag.viewtoggle(tag)
      end
    end,
  }),
  awful.key({
    modifiers = { CONFIG.modkey, "Shift" },
    keygroup = "numrow",
    description = "move focused client to tag",
    group = "Tag",
    on_press = function(index)
      if client.focus then
        local tag = client.focus.screen.tags[index]
        if tag then
          client.focus:move_to_tag(tag)
        end
      end
    end,
  }),
  awful.key({
    modifiers = { CONFIG.modkey, "Control", "Shift" },
    keygroup = "numrow",
    description = "toggle focused client on tag",
    group = "Tag",
    on_press = function(index)
      if client.focus then
        local tag = client.focus.screen.tags[index]
        if tag then
          client.focus:toggle_tag(tag)
        end
      end
    end,
  }),
  -- ██╗      █████╗ ██╗   ██╗ ██████╗ ██╗   ██╗████████╗
  -- ██║     ██╔══██╗╚██╗ ██╔╝██╔═══██╗██║   ██║╚══██╔══╝
  -- ██║     ███████║ ╚████╔╝ ██║   ██║██║   ██║   ██║
  -- ██║     ██╔══██║  ╚██╔╝  ██║   ██║██║   ██║   ██║
  -- ███████╗██║  ██║   ██║   ╚██████╔╝╚██████╔╝   ██║
  -- ╚══════╝╚═╝  ╚═╝   ╚═╝    ╚═════╝  ╚═════╝    ╚═╝

  awful.key({ CONFIG.modkey }, "l", function()
    awful.tag.incmwfact(0.05)
  end, { description = "increase master width factor", group = "layout" }),

  awful.key({ CONFIG.modkey }, "h", function()
    awful.tag.incmwfact(-0.05)
  end, { description = "decrease master width factor", group = "layout" }),

  awful.key({ CONFIG.modkey, "Shift" }, "h", function()
    awful.tag.incnmaster(1, nil, true)
  end, { description = "increase the number of master clients", group = "layout" }),

  awful.key({ CONFIG.modkey, "Shift" }, "l", function()
    awful.tag.incnmaster(-1, nil, true)
  end, { description = "decrease the number of master clients", group = "layout" }),

  awful.key({ CONFIG.modkey, "Control" }, "h", function()
    awful.tag.incncol(1, nil, true)
  end, { description = "increase the number of columns", group = "layout" }),

  awful.key({ CONFIG.modkey, "Control" }, "l", function()
    awful.tag.incncol(-1, nil, true)
  end, { description = "decrease the number of columns", group = "layout" }),

  awful.key({ CONFIG.modkey }, "space", function()
    awful.layout.inc(1)
  end, { description = "select next", group = "layout" }),

  awful.key({ CONFIG.modkey, "Shift" }, "space", function()
    awful.layout.inc(-1)
  end, { description = "select previous", group = "layout" }),

  -- ██╗      █████╗ ██╗   ██╗███╗   ██╗ ██████╗██╗  ██╗███████╗██████╗
  -- ██║     ██╔══██╗██║   ██║████╗  ██║██╔════╝██║  ██║██╔════╝██╔══██╗
  -- ██║     ███████║██║   ██║██╔██╗ ██║██║     ███████║█████╗  ██████╔╝
  -- ██║     ██╔══██║██║   ██║██║╚██╗██║██║     ██╔══██║██╔══╝  ██╔══██╗
  -- ███████╗██║  ██║╚██████╔╝██║ ╚████║╚██████╗██║  ██║███████╗██║  ██║
  -- ╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝

  awful.key({ CONFIG.modkey }, "Return", function()
    awful.spawn(terminal)
  end, { description = "open a terminal", group = "launcher" }),

  awful.key({ CONFIG.modkey }, "r", function()
    awful.screen.focused().mypromptbox:run()
  end, { description = "run prompt", group = "launcher" }),

  awful.key({ CONFIG.modkey }, "d", function()
    awful.spawn(os.getenv("HOME") .. "/.config/rofi/launcher.sh")
  end, { description = "Run rofi", group = "launcher" }),

  awful.key({ CONFIG.modkey, "Shift" }, "e", function()
    awesome.emit_signal("module::exit_screen:show")
  end, { description = "Run power menu", group = "launcher" }),

  awful.key({ CONFIG.modkey, "Shift" }, "c", function()
    awful.spawn(
      "rofi -show calc -modi calc -no-show-match -no-sort -theme "
      .. os.getenv("HOME")
      .. "/.config/rofi/calc.rasi"
    )
  end, { description = "Spawn calculator", group = "launcher" }),

  awful.key({ CONFIG.modkey }, "e", function()
    awful.spawn("emacsclient -c -a 'emacs'")
  end, { description = "Spawn emacs", group = "launcher" }),

  -- ██████╗  █████╗ ███╗   ██╗███████╗██╗     ███████╗
  -- ██╔══██╗██╔══██╗████╗  ██║██╔════╝██║     ██╔════╝
  -- ██████╔╝███████║██╔██╗ ██║█████╗  ██║     ███████╗
  -- ██╔═══╝ ██╔══██║██║╚██╗██║██╔══╝  ██║     ╚════██║
  -- ██║     ██║  ██║██║ ╚████║███████╗███████╗███████║
  -- ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚══════╝╚══════╝

  awful.key({ CONFIG.modkey }, "c", function()
    awesome.emit_signal(Signals.notification_panel_toggle)
  end, { description = "Toggle notification center", group = "Panels" }),
}

return keybinds
