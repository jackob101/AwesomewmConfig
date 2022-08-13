--- @type Wibox
local wibox = require 'wibox'

--- @type Beautiful
local beautiful = require 'beautiful'

--- @type Dpi
local dpi = beautiful.xresources.apply_dpi

--- @type Gears
local gears = require 'gears'


--- @class UiHelper
local m = {}


function m.rrect(radius)
    return function(cr, width, height)
        return gears.shape.rounded_rect(cr, width, height, radius or beautiful.corner_radius)
    end
end


return m