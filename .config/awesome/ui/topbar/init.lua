--[[
 _____              _
|_   _|            | |
  | |  ___   _ __  | |__    __ _  _ __
  | | / _ \ | '_ \ | '_ \  / _` || '__|
  | || (_) || |_) || |_) || (_| || |
  \_/ \___/ | .__/ |_.__/  \__,_||_|
            | |
            |_|
--]]


-- Requirements :
-- ~~~~~~~~~~~~~~
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")
local xresources = require("beautiful.xresources")


require("ui.topbar.tasklist")

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()


-------------------------------------------------------------------------------
-----  WIBAR
-------------------------------------------------------------------------------

-- Create a textclock widget
mytextclock = wibox.widget.textclock()

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
	awful.button({}, 1, function(t) t:view_only() end),
	awful.button({ modkey }, 1, function(t)
		if client.focus then
			client.focus:move_to_tag(t)
		end
	end),
	awful.button({}, 3, awful.tag.viewtoggle),
	awful.button({ modkey }, 3, function(t)
		if client.focus then
			client.focus:toggle_tag(t)
		end
	end),
	awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
	awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
)

---- Create a launcher widget and a main menu
myawesomemenu = {
	{ "hotkeys",     function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
	{ "manual",      terminal .. " -e man awesome" },
	{ "edit config", editor_cmd .. " " .. awesome.conffile },
	{ "restart",     awesome.restart },
	{ "quit",        function() awesome.quit() end },
}

mymainmenu = awful.menu({
	items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
		{ "open terminal", terminal }
	}
})

launcher = awful.widget.launcher({
	image = beautiful.icon_arcolinux,
	menu  = mymainmenu,
})



awful.screen.connect_for_each_screen(function(s)
	-- Each screen has its own tag table.
	awful.tag({ "1", "2", "3", "4", "5" }, s, awful.layout.layouts[1])

	s.mylayoutbox = awful.widget.layoutbox(s)

	s.mylayoutbox:buttons(gears.table.join(
		awful.button({}, 1, function() awful.layout.inc(1) end),
		awful.button({}, 3, function() awful.layout.inc(-1) end),
		awful.button({}, 4, function() awful.layout.inc(1) end),
		awful.button({}, 5, function() awful.layout.inc(-1) end)))

	-- Create a taglist widget
	s.mytaglist = awful.widget.taglist {
		screen  = s,
		filter  = awful.widget.taglist.filter.all,
		buttons = taglist_buttons
	}

	s.tasklist = get_tasklist(s)

	-- Create the wibox
	s.wibar = awful.wibar({
		position = "bottom",
		screen = s,
		height = xresources.apply_dpi(40)
	})

	-- Add widgets to the wibox
	s.wibar:setup {
		layout = wibox.layout.align.horizontal,
		{
			-- Left widgets
			layout = wibox.layout.fixed.horizontal,
			wibox.container.margin(launcher, xresources.apply_dpi(4), xresources.apply_dpi(4), xresources.apply_dpi(4),
				xresources.apply_dpi(4)),
			wibox.container.margin(s.mylayoutbox, xresources.apply_dpi(4), xresources.apply_dpi(4),
				xresources.apply_dpi(4),
				xresources.apply_dpi(4)),
			s.mytaglist,
			spacing = xresources.apply_dpi(10)
		},
		{
			layout = wibox.container.place,
			s.tasklist
		},
		{
			-- Right widgets
			layout = wibox.layout.fixed.horizontal,
			mykeyboardlayout,
			wibox.widget.systray(),
			mytextclock
		},
	}
end)
