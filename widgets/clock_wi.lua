local awful = require("awful")
local lain 	= require("lain")


mytextclock = awful.widget.textclock()

--Uhhh not sure what this is gonna do, but here goes it
local calendar = lain.widget.calendar({
	attach_to = { mytextclock },
	notification_preset = {
		font = "Droid Sans Mono 10",
		fg = theme.fg_normal,
		bg = theme.bg_normal
		}
	})
