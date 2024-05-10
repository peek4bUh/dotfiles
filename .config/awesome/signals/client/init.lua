local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")

client.connect_signal("request::titlebars", function(c)
	local bottom_titlebar = awful.titlebar(c, {
		size = 30,
	})

	-- buttons for the titlebar
	local buttons = {
		awful.button({
			modifiers = {},
			button = 1,
			on_press = function()
				c:activate({ context = "titlebar", action = "mouse_move" })
			end,
		}),
		awful.button({
			modifiers = {},
			button = 3,
			on_press = function()
				c:activate({ context = "titlebar", action = "mouse_resize" })
			end,
		}),
	}

	bottom_titlebar.widget = {
		{ -- Left
			buttons = buttons,
			layout = wibox.layout.fixed.horizontal,
		},
		{ -- Middle
			{ -- Title
				align = "center",
				widget = awful.titlebar.widget.titlewidget(c),
			},
			buttons = buttons,
			layout = wibox.layout.flex.horizontal,
		},
		{ -- Right
			awful.titlebar.widget.floatingbutton(c),
			awful.titlebar.widget.maximizedbutton(c),
			awful.titlebar.widget.stickybutton(c),
			awful.titlebar.widget.ontopbutton(c),
			awful.titlebar.widget.closebutton(c),
			layout = wibox.layout.fixed.horizontal(),
		},
		layout = wibox.layout.align.horizontal,
	}
end)
