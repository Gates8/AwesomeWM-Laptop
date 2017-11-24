local awful 		= require("awful")
local beautiful 	= require("beautiful")
local vicious 		= require("vicious")

cpu_i = wibox.widget.imagebox(beautiful.widget_cpu)

cpu_w = wibox.widget.textbox()
vicious.register(cpu_w, vicious.widgets.cpi, "All: $1% | 1:$2% | 2:$3% | 3:$4% | 4:$5% | 5:$6% | 6:$7% | 7:$8% | 8:$9%", 2)


