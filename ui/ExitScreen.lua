local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
--- @type Beautiful
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local naughty = require("naughty")
local theme = beautiful.exit_screen
--- @type Helpers
local helpers = require("helpers")

--- @type Widgets
local widgets = require("widgets")

local greeter_message = widgets.text({
    text = 'Choose wisely!',
    size = 48,
    halign = "center",
    valign = "center",
})



local build_power_button = function(name, icon, callback)
    local power_button_label = widgets.text{
        text = name,
        size = 14,
        halign = 'center',
        valign = 'center',
    }

    local power_button = wibox.widget {
        widget = wibox.container.margin,
        left = dpi(24),
        right = dpi(24),
        widgets.button({
            text = icon,
            font_size = 60,
            width = dpi(120),
            height = dpi(120),
            shape = helpers.ui.rrect(),
            bg_hover = beautiful.accent,
            border_color = beautiful.light_gray,
            apply_hover = true,
            on_click = callback,
            border_width = 0,
        })
    }


    local exit_screen_item = wibox.widget {
        layout = wibox.layout.fixed.vertical,
        spacing = dpi(5),
        power_button,
        power_button_label
    }

    return exit_screen_item

end

local suspend_command = function()
    awesome.emit_signal('module::exit_screen:hide')
    awful.spawn.with_shell('systemctl suspend')
end

local logout_command = function()
    awesome.quit()
end

local lock_command = function()
    awesome.emit_signal('module::exit_screen:hide')
    naughty.notification { title = "Warning", text = "Not yet implemented" }
end

local poweroff_command = function()
    print("Callback")
    awful.spawn.with_shell('poweroff')
    awesome.emit_signal('module::exit_screen:hide')
end

local reboot_command = function()
    awful.spawn.with_shell('reboot')
    awesome.emit_signal('module::exit_screen:hide')
end

local poweroff = build_power_button('Shutdown(p)', "", poweroff_command)
local reboot = build_power_button('Restart(r)', "", reboot_command)
local suspend = build_power_button('Sleep(s)', "", suspend_command)
local logout = build_power_button('Logout(e)', "", logout_command)
local lock = build_power_button('Lock', "", lock_command)


local create_exit_screen = function(s)
    s.exit_screen = wibox
    {
        screen = s,
        type = 'splash',
        visible = false,
        ontop = true,
        bg = theme.bg,
        fg = theme.fg,
        height = s.geometry.height,
        width = s.geometry.width,
        x = s.geometry.x,
        y = s.geometry.y
    }

    s.exit_screen:buttons(
        gears.table.join(
            awful.button(
                {},
                2,
                function()
                    awesome.emit_signal('module::exit_screen:hide')
                end
            ),
            awful.button(
                {},
                3,
                function()
                    awesome.emit_signal('module::exit_screen:hide')
                end
            )
        )
    )

    s.exit_screen:setup {
        layout = wibox.layout.align.vertical,
        expand = 'none',
        nil,
        {
            layout = wibox.layout.align.vertical,
            {
                layout = wibox.layout.align.horizontal,
                expand = 'none',
                nil,
                {
                    widget = wibox.container.margin,
                    margins = dpi(20),
                    greeter_message
                },
                nil
            },
            {
                layout = wibox.layout.align.horizontal,
                expand = 'none',
                nil,
                {
                    {
                        {
                            poweroff,
                            reboot,
                            suspend,
                            logout,
                            lock,
                            layout = wibox.layout.fixed.horizontal
                        },
                        spacing = dpi(30),
                        layout = wibox.layout.fixed.vertical
                    },
                    widget = wibox.container.margin,
                    margins = dpi(15)
                },
                nil
            }
        },
        nil
    }
end

screen.connect_signal(
    'request::desktop_decoration',
    function(s)
        create_exit_screen(s)
    end
)

screen.connect_signal(
    'removed',
    function(s)
        create_exit_screen(s)
    end
)

local exit_screen_grabber = awful.keygrabber {
    auto_start = true,
    stop_event = 'release',
    keypressed_callback = function(_, _, key, _)
        if key == 's' then
            suspend_command()

        elseif key == 'e' then
            logout_command()

        elseif key == 'l' then
            lock_command()

        elseif key == 'p' then
            poweroff_command()

        elseif key == 'r' then
            reboot_command()

        elseif key == 'Escape' or key == 'q' or key == 'x' then
            awesome.emit_signal('module::exit_screen:hide')
        end
    end
}

awesome.connect_signal(
    'module::exit_screen:show',
    function()
        for s in screen do
            s.exit_screen.visible = false
        end
        awful.screen.focused().exit_screen.visible = true
        exit_screen_grabber:start()
    end
)

awesome.connect_signal(
    'module::exit_screen:hide',
    function()
        exit_screen_grabber:stop()
        for s in screen do
            s.exit_screen.visible = false
        end
    end
)
