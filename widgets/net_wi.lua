local awful 	= require("awful")
local wibox 	= require("wibox")
local beautiful = require("beautiful")
local vicious 	= require("vicious")

-- Starting the Network Widget

vicious.cache(vicious.widgets.net)

netup_i 	= wibox.widget.imagebox(beautiful.widget_up)
netu	   	= wibox.widget.textbox()

vicious.register(netu, vicious.widgets.net, "${wlp4s0 up_kb}", 3)

netdown_i 	= wibox.widget.imagebox(beautiful.widget_down)
netd 	 	= wibox.widget.textbox()

vicious.register(netd, vicious.widgets.net, "${wlp4s0 down_kb} - ", 3)

--WiFi
wifi_i 	= wibox.widget.imagebox(beautiful.widget_wifi)

wi_fi 	= wibox.widget.textbox()
vicious.register(wi_fi, vicious.widgets.wifi, "${ssid} -> Link: ${link}%", 3, "wlp4s0")

-- Done
