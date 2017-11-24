local awful = require("awful")
local wibox = require("wibox")
local lain 	= require("lain")

local bat = lain.widget.bat({
	battery = "BAT0"
	})
