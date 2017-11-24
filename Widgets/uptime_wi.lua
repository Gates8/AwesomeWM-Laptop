local wibox 	= require("wibox")
local beautiful = require("beautiful")
local vicious 	= require("vicious")
local lain 		= require("lain")
local markup = lain.util.markup

-- Colors 
gold = "#FFE100"

vicious.cache(vicious.widgets.uptime)
uptime_i = wibox.widget.imagebox(beautiful.widget_uptime)

uptime_w = wibox.widget.textbox()
uptime_w:set_align("right")

vicious.register(uptime_w, vicious.widgets.uptime, markup(gold, "$1") .. markup(gold, " Days | ") .. markup(gold, "$2") .. markup(gold, " Hrs | ") .. markup(gold, "$3") .. markup(gold, " Min(s) "))  

