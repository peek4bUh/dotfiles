local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")


function get_tasklist(s)
	local tasklist_buttons = gears.table.join(
		awful.button({}, 1, function(c)
			if c == client.focus then
				c.minimized = true
			else
				c:emit_signal(
					"request::activate",
					"tasklist",
					{ raise = true }
				)
			end
		end),
		awful.button({}, 3, function()
			awful.menu.client_list({ theme = { width = 250 } })
		end),
		awful.button({}, 4, function()
			awful.client.focus.byidx(1)
		end),
		awful.button({}, 5, function()
			awful.client.focus.byidx(-1)
		end))

	local mytasklist = awful.widget.tasklist {
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = tasklist_buttons,
		style = { shape = gears.shape.rounded_rect },
		layout = wibox.layout.fixed.horizontal(),
		widget_template = {
			{
				{
					{
						id = "icon_role",
						widget = wibox.widget.imagebox,
					},
					layout = wibox.container.place,
				},
				top = 4,
				right = 4,
				bottom = 4,
				left = 4,
				widget = wibox.container.margin,
			},
			id = "background_role",
			forced_width = 48,
			widget = wibox.container.background,
		}
	}

	return mytasklist
end
