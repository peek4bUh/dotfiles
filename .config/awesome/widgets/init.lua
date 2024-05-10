local gears = require("gears")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local beautiful = require("beautiful")
local wibox = require("wibox")
local xresources = require("beautiful.xresources")

local apps = require("config.apps")
local mod = require("bindings.mod")

local _M = {}

_M.awesomemenu = {
	{
		"hotkeys",
		function()
			hotkeys_popup.show_help(nil, awful.screen.focused())
		end,
	},
	{ "manual", apps.manual_cmd },
	{ "edit config", apps.editor_cmd .. " " .. awesome.conffile },
	{ "restart", awesome.restart },
	{
		"quit",
		function()
			awesome.quit()
		end,
	},
}

_M.mainmenu = awful.menu({
	items = {
		{ "awesome", _M.awesomemenu, beautiful.awesome_icon },
		{ "open terminal", apps.terminal },
	},
})

_M.launcher = awful.widget.launcher({
	image = beautiful.arcolinux_icon,
	menu = _M.mainmenu,
})

_M.keyboardlayout = awful.widget.keyboardlayout()
_M.textclock = wibox.widget.textclock()

function _M.create_layoutbox(s)
	return awful.widget.layoutbox({
		screen = s,
		buttons = {
			awful.button({
				modifiers = {},
				button = 1,
				on_press = function()
					awful.layout.inc(1)
				end,
			}),
			awful.button({
				modifiers = {},
				button = 3,
				on_press = function()
					awful.layout.inc(-1)
				end,
			}),
			awful.button({
				modifiers = {},
				button = 4,
				on_press = function()
					awful.layout.inc(-1)
				end,
			}),
			awful.button({
				modifiers = {},
				button = 5,
				on_press = function()
					awful.layout.inc(1)
				end,
			}),
		},
	})
end

function _M.create_taglist(s)
	return awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		buttons = {
			awful.button({
				modifiers = {},
				button = 1,
				on_press = function(t)
					t:view_only()
				end,
			}),
			awful.button({
				modifiers = { mod.super },
				button = 1,
				on_press = function(t)
					if client.focus then
						client.focus:move_to_tag(t)
					end
				end,
			}),
			awful.button({
				modifiers = {},
				button = 3,
				on_press = awful.tag.viewtoggle,
			}),
			awful.button({
				modifiers = { mod.super },
				button = 3,
				on_press = function(t)
					if client.focus then
						client.focus:toggle_tag(t)
					end
				end,
			}),
			awful.button({
				modifiers = {},
				button = 4,
				on_press = function(t)
					awful.tag.viewprev(t.screen)
				end,
			}),
			awful.button({
				modifiers = {},
				button = 5,
				on_press = function(t)
					awful.tag.viewnext(t.screen)
				end,
			}),
		},
	})
end

function _M.create_tasklist(s)
	local tasklist_buttons = {
		awful.button({
			modifiers = {},
			button = 1,
			on_press = function(c)
				c:activate({ context = "tasklist", action = "toggle_minimization" })
			end,
		}),
		awful.button({
			modifiers = {},
			button = 3,
			on_press = function()
				awful.menu.client_list({ theme = { width = 250 } })
			end,
		}),
		awful.button({
			modifiers = {},
			button = 4,
			on_press = function()
				awful.client.focus.byidx(-1)
			end,
		}),
		awful.button({
			modifiers = {},
			button = 5,
			on_press = function()
				awful.client.focus.byidx(1)
			end,
		}),
	}

	return awful.widget.tasklist({
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = tasklist_buttons,
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
				margins = xresources.apply_dpi(4),
				widget = wibox.container.margin,
			},
			id = "background_role",
			widget = wibox.container.background,
		},
	})
end

function _M.create_wibox(s)
	return awful.wibar({
		screen = s,
		position = "bottom",
		height = xresources.apply_dpi(40),
		widget = wibox.container.background({
			widget = wibox.container.margin({
				layout = wibox.layout.align.horizontal,
				expand = "none",
				{ -- Left widgets
					layout = wibox.layout.fixed.horizontal,
					_M.launcher,
					s.layoutbox,
					s.taglist,
					spacing = xresources.apply_dpi(10),
				},
				{ -- Middle widgets
					layout = wibox.layout.flex.horizontal,
					nil,
					s.tasklist,
					nil,
				},
				{ -- Right widgets
					layout = wibox.layout.fixed.horizontal,
					_M.keyboardlayout,
					wibox.widget.systray(),
					_M.textclock,
				},
			}),
			margins = xresources.apply_dpi(4),
		}),
	})
end

return _M
