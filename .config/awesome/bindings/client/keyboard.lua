local awful = require("awful")
local gears = require("gears")

local mod = require("bindings.modifiers")

clientkeys = gears.table.join(
	awful.key({ mod.super }, "f", function(c)
		c.fullscreen = not c.fullscreen
		c:raise()
	end, { description = "toggle fullscreen", group = "client" }),
	awful.key({ mod.super }, "w", function(c)
		c:kill()
	end, { description = "close", group = "client" }),
	awful.key(
		{ mod.super, mod.ctrl },
		"r",
		awful.client.floating.toggle,
		{ description = "toggle floating", group = "client" }
	),
	awful.key({ mod.super, mod.ctrl }, "Return", function(c)
		c:swap(awful.client.getmaster())
	end, { description = "move to master", group = "client" }),
	awful.key({ mod.super }, "o", function(c)
		c:move_to_screen()
	end, { description = "move to screen", group = "client" }),
	awful.key({ mod.super }, "t", function(c)
		c.ontop = not c.ontop
	end, { description = "toggle keep on top", group = "client" }),
	awful.key({ mod.super }, "n", function(c)
		-- The client currently has the input focus, so it cannot be
		-- minimized, since minimized clients can't have the focus.
		c.minimized = true
	end, { description = "minimize", group = "client" }),
	awful.key({ mod.super }, "m", function(c)
		c.maximized = not c.maximized
		c:raise()
	end, { description = "(un)maximize", group = "client" }),
	awful.key({ mod.super, mod.ctrl }, "m", function(c)
		c.maximized_vertical = not c.maximized_vertical
		c:raise()
	end, { description = "(un)maximize vertically", group = "client" }),
	awful.key({ mod.super, mod.shift }, "m", function(c)
		c.maximized_horizontal = not c.maximized_horizontal
		c:raise()
	end, { description = "(un)maximize horizontally", group = "client" })
)

clientbuttons = gears.table.join(
	awful.button({}, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
	end),
	awful.button({ mod.super }, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.move(c)
	end),
	awful.button({ mod.super }, 3, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.resize(c)
	end)
)
