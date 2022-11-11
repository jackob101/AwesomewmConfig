--- @type Naughty
local naughty = require("naughty")

--- @type Gears
local gears = require("gears")

local function createNotification()
  naughty.notification({
    title = "Posture check",
    message = "Are you sitting properly?",
    icon = Icons.posture,
    urgency = "normal",
    store = false,
  })
end

gears.timer({
  timeout = 1800,
  autostart = true,
  call_now = false,
  callback = createNotification,
})
