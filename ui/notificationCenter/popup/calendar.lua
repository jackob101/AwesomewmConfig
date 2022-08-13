-- Big % of this code was taken from https://github.com/rxyhn/yoru


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

--- @type Widgets
local widgets = require 'widgets'

local calendar = { mt = {} }

local function day_name_widget(name)
	return wibox.widget({
		widget = wibox.container.background,
		forced_width = dpi(30),
		forced_height = dpi(30),
		widgets.text {
			halign = "center",
			size = 12,
			text = name,
			bold = true,
		},
	})
end

local function date_widget(date, is_current, is_another_month)
	local text_color = beautiful.light .. "CC"
	if is_current == true then
		text_color = beautiful.black
	elseif is_another_month == true then
		text_color = beautiful.light .. "33"
	end

	return wibox.widget({
		widget = wibox.container.background,
		forced_width = dpi(10),
		forced_height = dpi(10),
		bg = is_current and beautiful.accent,
		shape = gears.shape.circle,
		widgets.text({
			text = date,
			color = text_color,
			halign = "center",
			size = 12,
			bold = is_current,
		})
	})
end

function calendar:set_date(date)
	self.date = date

	self.days:reset()

	local current_date = os.date("*t")

	self.days:add(day_name_widget("Mon"))
	self.days:add(day_name_widget("Tue"))
	self.days:add(day_name_widget("Wen"))
	self.days:add(day_name_widget("Thu"))
	self.days:add(day_name_widget("Fri"))
	self.days:add(day_name_widget("Sat"))
	self.days:add(day_name_widget("Sun"))

	local first_day = os.date("*t", os.time({ year = date.year, month = date.month, day = 0 }))
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

	ret.month = widgets.button({
		bg = beautiful.transparent,
		border_color = beautiful.transparent,
		apply_hover = true,
		fg_hover = beautiful.accent,
		bg_hover = beautiful.transparent,
		on_click = function()
			ret:set_date_current()
		end
	})

	local month = wibox.widget({
		layout = wibox.layout.align.horizontal,
		widgets.button({
			font = "Material Icons",
			text = "",
			font_size = 25,
			width = dpi(33),
			bg = beautiful.transparent,
			border_color = beautiful.transparent,
			apply_hover = true,
			fg_hover = beautiful.accent,
			bg_hover = beautiful.transparent,
			on_click = function()
				ret:decrease_date()
			end
		}),
		{
			widget = wibox.container.place,
			valign = "center",
			halign = "center",
			ret.month,
		},
		widgets.button({
			font = "Material Icons",
			text = "",
			font_size = 25,
			width = dpi(33),
			bg = beautiful.transparent,
			border_color = beautiful.transparent,
			apply_hover = true,
			fg_hover = beautiful.accent,
			bg_hover = beautiful.transparent,
			on_click = function()
				ret:increase_date()
			end
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
		widget = wibox.container.background,
		bg = beautiful.notification_center.panel_bg,
		shape = function (cr, width, height)
			return gears.shape.rounded_rect(cr, width, height, beautiful.corner_radius)
		end,
		{
			widget = wibox.container.margin,
			margins = dpi(15),
			{
				layout = wibox.layout.fixed.vertical,
				spacing = dpi(20),
				month,
				ret.days,
			}
		}

	})

	ret:set_date(os.date("*t"))

	gears.table.crush(widget, calendar, true)
	return widget
end

function calendar.mt:__call(...)
	return new(...)
end

return new
