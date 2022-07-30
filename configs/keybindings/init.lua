--- @class Keybinds
--- @field global Key[]
--- @field client Key[]
Keybinds = {
    global = {},
    client = {},
    isInitialized = false
}

function Keybinds.init()

    if Keybinds.isInitialized then
        return
    end

    print("What")

    local keybindsToInit = {
        "AwesomeKeybinds",
        "ClientKeybinds",
        "LauncherKeybinds",
        "LayoutKeybinds",
        "TagsKeybinds",
        "ScreenKeybinds",
    }

    for _, v in ipairs(keybindsToInit) do
        require("configs.keybindings." .. v)()
    end

    root.keys(Keybinds.global)

    Keybinds.isInitialized = true
end

function Keybinds.connectForGlobal(keybinds)
    table.merge(Keybinds.global, keybinds)
end

function Keybinds.connectForClient(keybinds)
    table.merge(Keybinds.client, keybinds)
end
