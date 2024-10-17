local awful = require("awful")

local mod = require("bindings.modifiers")

client.connect_signal('request::default_mousebindings', function()
	awful.mouse.append_client_mousebindings {
		awful.button({}, 3, function()
			mymainmenu:toggle()
		end),
		awful.button({}, 4, awful.tag.viewnext),
		awful.button({}, 5, awful.tag.viewprev)
	}
end)
