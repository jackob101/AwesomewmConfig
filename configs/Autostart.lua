local awful = require("awful")

local applications = {
	"picom --experimental-backends --config ~/.config/picom/config",
	"xinput | grep -i wacom | awk '{print $9}' | awk -F'=' '{print $2}' | xargs -I % sh -c 'xinput map-to-output % DP-1'",
	--"/usr/bin/gnome-keyring-daemon --start --components=ssh,secrets,pkcs11",
	"easyeffects -l Bass Boosted --gapplication-service",
	"xset r rate 200 20",
	"aw-server",
	"aw-watcher-afk",
	"aw-watcher-window",
	"discord",
	"telegram-desktop",
	"flameshot",
	"exec --no-startup-id /usr/lib/pam_kwallet_init",
}

for app = 1, #applications do
	awful.spawn.easy_async_with_shell(applications[app], function() end)
end
