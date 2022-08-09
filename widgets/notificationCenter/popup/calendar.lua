--- @type Wibox
local wibox = require 'wibox'

--- @type Beautiful
local beautiful = require 'beautiful'

--- @type Dpi
local dpi = beautiful.xresources.apply_dpi

--- @type Naughty
local naughty = require 'naughty'

--- @type Gears
local gears = require 'gears'

--- @type Awful
local awful = require 'awful'

local calendar = { mt = {} }

local function day_name_widget(name)
    return wibox.widget({
        widget = wibox.container.background,
        forced_width = dpi(30),
        forced_height = dpi(30),
        {
            widget = wibox.widget.textbox,
            align = "center",
            text = name
        },
    })
end

local function date_widget(date, is_current, is_another_month)
	local text_color = beautiful.light
	if is_current == true then
		text_color = beautiful.green
	elseif is_another_month == true then
		text_color = beautiful.light .. "00"
	end

	return wibox.widget({
		widget = wibox.container.background,
		forced_width = dpi(10),
		forced_height = dpi(10),
		bg = is_current and beautiful.accent,
        {
            widget = wibox.widget.textbox,
            text = date,
            color = text_color,
            align = "center",
        }
	})
end


function calendar:set_date(date)
	self.date = date

	self.days:reset()

	local current_date = os.date("*t")

	self.days:add(day_name_widget("Sun"))
	self.days:add(day_name_widget("Mon"))
	self.days:add(day_name_widget("Tue"))
	self.days:add(day_name_widget("Wen"))
	self.days:add(day_name_widget("Thu"))
	self.days:add(day_name_widget("Fri"))
	self.days:add(day_name_widget("Sat"))

	local first_day = os.date("*t", os.time({ year = date.year, month = date.month, day = 1 }))
	local last_day = os.date("*t", os.time({ year = date.year, month = date.month + 1, day = 0 }))
	local month_days = last_day.day

	local time = os.time({ year = date.year, month = date.month, day = 1 })
	self.month:set_text(os.date("%B %Y", time))

	local days_to_add_at_month_start = first_day.wday - 1
	local days_to_add_at_month_end = 42 - last_day.day - days_to_add_at_month_start

	local previous_month_last_day = os.date("*t", os.time({ year = date.year, month = date.month, day = 0 })).day
	for day = previous_month_last_day - days_to_add_at_month_start, previous_month_last_day - 1, 1 do
		self.days:add(date_widget(day, false, true))
	end

	for day = 1, month_days do
		local is_current = day == current_date.day and date.month == current_date.month
		self.days:add(date_widget(day, is_current, false))
	end

	for day = 1, days_to_add_at_month_end do
		self.days:add(date_widget(day, false, true))
	end
end


function calendar:set_date_current()
	self:set_date(os.date("*t"))
end

function calendar:increase_date()
	local new_calendar_month = self.date.month + 1
	self:set_date({ year = self.date.year, month = new_calendar_month, day = self.date.day })
end

function calendar:decrease_date()
	local new_calendar_month = self.date.month - 1
	self:set_date({ year = self.date.year, month = new_calendar_month, day = self.date.day })
end

local function new()
	local ret = gears.object({})
	gears.table.crush(ret, calendar, true)

    ret.month = wibox.widget ({
        widget = wibox.widget.textbox,
        text = os.date("%B %Y")
    })

	-- ret.month = widgets.button.text.normal({
	-- 	animate_size = false,
	-- 	text = os.date("%B %Y"),
	-- 	size = 16,
	-- 	bold = true,
	-- 	text_normal_bg = beautiful.accent,
	-- 	normal_bg = beautiful.widget_bg,
	-- 	on_release = function()
	-- 		ret:set_date_current()
	-- 	end,
	-- })

	local month = wibox.widget({
		layout = wibox.layout.align.horizontal,
		wibox.widget({
            widget = wibox.widget.textbox,
			font = "Material Icons Round ",
			fg= beautiful.light,
			-- normal_bg = beautiful.g,
			text = "",
			-- on_release = function()
			-- 	ret:decrease_date()
			-- end,
		}),
		ret.month,
		wibox.widget({
            widget = wibox.widget.textbox,
			font = "Material Icons Round ",
			fg= beautiful.light,
			-- normal_bg = beautiful.g,
			text = "",
			-- on_release = function()
			-- 	ret:decrease_date()
			-- end,
		}),
	})

	ret.days = wibox.widget({
		layout = wibox.layout.grid,
		forced_num_rows = 6,
		forced_num_cols = 7,
		spacing = dpi(5),
		expand = true,
	})

	local widget = wibox.widget({
		layout = wibox.layout.fixed.vertical,
		spacing = dpi(15),
		month,
		ret.days,
	})

	ret:set_date(os.date("*t"))

	gears.table.crush(widget, calendar, true)
	return widget
end

function calendar.mt:__call(...)
	return new(...)
end

return setmetatable(calendar, calendar.mt)


-- local styles = {}

-- styles.month = {
--     -- padding = 10,
--     padding = 0,
--     fg_color = beautiful.notification_center.calendar_header_fg
-- }

-- styles.normal = {
--     padding = 0,
-- }

-- styles.focus = {
--     padding = 0,
--     fg_color = beautiful.notification_center.calendar_current_day_fg,
-- }

-- styles.header = {
--     padding = dpi(2),
--     fg_color = beautiful.notification_center.calendar_header_fg
-- }

-- styles.weekday = {
--     padding = 0;
--     fg_color = beautiful.notification_center.calendar_weekday_header_fg
-- }

-- local function decorate_cell(widget, flag, date)
--     if flag == "monthheader" and not styles.monthheader then
--         flag = "header"
--     end
--     local props = styles[flag] or {}
--     print("Padding : " .. (props.padding or 0) .. " Part: " .. flag)
--     if props.markup and widget.get_text and widget.set_markup then
--         widget:set_markup(props.markup(widget:get_text()))
--     end
--     -- Change bg color for weekends
--     local d = { year = date.year, month = (date.month or 1), day = (date.day or 1) }
--     local weekday = tonumber(os.date("%w", os.time(d)))
--     local default_fg = (weekday == 0 or weekday == 6) and beautiful.notification_center.calendar_weekend_day_color or
--         beautiful.notification_center.calendar_normal_day
--     local ret = wibox.widget {
--         {
--             widget,
--             margins = (props.padding or 2) + (props.border_width or 0),
--             widget  = wibox.container.margin
--         },
--         fg     = props.fg_color or default_fg,
--         bg     = props.bg_color,
--         widget = wibox.container.background
--     }
--     return ret
-- end

-- local calendar = Wibox.widget {
--     widget = wibox.container.background,
--     bg = beautiful.notification_center.panel_bg,
--     {
--         layout = wibox.container.place,
--         valign = "center",
--         halign = "center",
--         {
--             widget = wibox.container.margin,
--             margins = Dpi(10),
--             layout = wibox.layout.fixed.vertical,
--             {
--                 widget = wibox.widget.calendar.month,
--                 date = os.date("*t"),
--                 long_weekdays = true,
--                 fn_embed = decorate_cell
--             }
--         }
--     }
-- }


-- return calendar
