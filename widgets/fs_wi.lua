--===========================================-
--==== This is for the filesytem widgets ====-
--==== Author: Gates                     ====-
--==== Ver: 1.0                          ====-
--==== To do:                            ====-
--====    Finish writing the other fs'   ====-
--====	  Figure out the mouseover stuff ====-
--====		for a cleaner widget.        ====-
--===========================================-

local bling = require("blingbling")
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local lain = require("lain")
local vicious = require("vicious")
local wibox = require("wibox")
--init
local fs = {}
local capi = {
	mouse = mouse,
	screen = screen
}

-----------------------------------
----        Colors             ----
-----------------------------------

white  = "#FFFFFF" 
black  = "#000000"
orange = "#FF7700"
d_red  = "#704949"
l_red  = "#EE2222"


-- Transparency Values

t0   = "AA"
t85  = "55"
t95  = "5F"
t100 = "00"

------------------------------------
----          End Colors        ----
------------------------------------

------------------------------------
---- Start Constructing widget  ----
------------------------------------

--root stuff
--	possibly add this to a mouseover????

--used percentage
percent = bling.value_text_box({height = 20     	 ,
							width      = 50          ,
							v_margin   = 2           ,
							horizontal = true        ,
							show_text  = true        ,
							font       = "Droid Sans",
							font_size  = "12"        ,
							text_color = orange      ,
							label      = "/root     $percent % used"
							})
vicious.register(percent, vicious.widgets.fs, "${/ used_p}")

--used gb
u_gb = bling.value_text_box({height = 20          	 ,
							width      = 50          ,
							v_margin   = 2           ,
							horizontal = true        ,
							show_text  = true        ,
							font       = "Droid Sans",
							font_size  = "12"        ,
							text_color = orange      ,
							label      = "             $percent gb used "
							})
vicious.register(u_gb, vicious.widgets.fs, "${/ used_gb}")

--available gb
a_gb = bling.value_text_box({height = 20          	 ,
							width      = 50          ,
							v_margin   = 2           ,
							horizontal = true        ,
							show_text  = true        ,
							font       = "Droid Sans",
							font_size  = "12"        ,
							text_color = orange      ,
							label      = "  $percent gb available"
							})
vicious.register(a_gb, vicious.widgets.fs, "${/ avail_gb}")

-- attempt at the mouseover 
root_graph = bling.progress_graph({height 			  = 20					,
								width 				  = 70					,
								v_margin 			  = 5					,
								horizontal 			  = true				,
								show_text 			  = false	    		,
								font 				  = "Droid Sans"		,
								font_size             = "12"				,
								text_color            = orange				,
								label                 = " $percent %"		,
								rounded_size          = 0.3					,
								graph_color           = white				,
								graph_background_color = d_red				,
								graph_line_color      = white
								})
vicious.register(root_graph, vicious.widgets.fs, "${/ used_p}", 10) 

--bling.popups.htop(root_graph, { terminal = terminal })
--local notification

-- home filesystem

-- percentage used - home
h_percentage = bling.value_text_box({height = 25,
							width = 70,
							v_margin = 2,
							horizontal = true,
							show_text = true,
							font = "Droid Sans",
							font_size = "12",
							text_color = l_red,
							label = "/home $percent % used"
							})
vicious.register(h_percentage, vicious.widgets.fs, "${/home used_p}", 120)

--used gb
h_ugb = bling.value_text_box({height = 25,
							width = 70,
							v_margin = 2,
							horizontal = true,
							show_text = true,
							font = "Droid Sans",
							font_size = "12",
							text_color = l_red,
							label = "            $percent gb used"
							})
vicious.register(h_ugb, vicious.widgets.fs, "${/home used_gb}", 10)

--available gb
h_agb = bling.value_text_box({height = 25,
							width = 70,
							v_margin = 2,
							horizontal = true,
							show_text = true,
							font = "Droid Sans",
							font_size = "12",
							text_color = l_red,
							label = "     $percent gb available"
							})
vicious.register(h_agb, vicious.widgets.fs, "${/home avail_gb}", 10)

--home graph
home_graph = bling.progress_graph({height 			  = 20					,
								width 				  = 70					,
								v_margin 			  = 5					,
								horizontal 			  = true				,
								show_text 			  = false	    		,
								font 				  = "Droid Sans"		,
								font_size             = "12"				,
								text_color            = orange				,
								label                 = "/home $percent %"	,
								rounded_size          = 0.3					,
								graph_color           = white				,
								graph_background_color = d_red				,
								graph_line_color      = white })
vicious.register(home_graph, vicious.widgets.fs, "${/home used_p}", 10) 

--these might help with mouseovers?
local function display()
	local lines = "<u>Root Fs</u>"
	local f = r_ugb
	local s = f:read("*all")
	line = lines .. "\n" .. s .. "\n"
	f:close()
	return line
end

root_text = wibox.widget.textbox()
root_text:set_text("Root FS")
root_tt = awful.tooltip({ 
	{objects = root_text} })

--root_text:connect_signal("mouse::enter", root_tt)
--root_text:connect_signal("mouse::leave", function() naughty.destroy(notif) end)
--root_graph.connect_signal("mouse::enter", function()
--	notification = naughty.notify{
--			text = "test",
--			title = "test ",
--			timeout = 5,
--			hover_timeout = .5,
--			width = 40,
--			bg = white .. t95,
--			fg = black
--	}
--	end
--)
--root_graph:connect_signal("mouse::leave", function() naughty.destroy(notification) end)
