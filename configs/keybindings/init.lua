--- @type Awful
local awful = require('awful')


local global_keybinds = require("configs.keybindings.GlobalKeybinds")
local client_keybinds = require("configs.keybindings.ClientKeybinds")

awful.keyboard.append_global_keybindings(global_keybinds)
awful.keyboard.append_client_keybindings(client_keybinds)
