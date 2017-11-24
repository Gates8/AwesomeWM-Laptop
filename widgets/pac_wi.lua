-------------------------------------------
---- Pacman widget that tells upgrades ----
---- 	and installed packages         ----
---- Author: Gates		               ----
---- Ver: 1.0                          ----
---- To do: 						   ----
----	Widget should work as expected ----
----	I pretty much rewrote this 	   ----
----	like 10 times.				   ----
-------------------------------------------


local awful 	= require("awful")
local wibox 	= require("wibox")
local beautiful = require("beautiful")
local vicious  	= require("vicious")
local naughty 	= require("naughty")
local markup	= require("lain.util.markup")

-------------------------------------
---- 			Colors			 ----
-------------------------------------
 




-------------------------------------
----			End Colors		 ----
-------------------------------------

pacicon = wibox.widget.imagebox()
pacicon:set_image(beautiful.widget_pac)
--
-- Upgrades
pacwidget = wibox.widget.textbox()
vicious.register(pacwidget, vicious.widgets.pkg, function(widget, args)
   if args[1] > 0 then
	    pacicon:set_image(beautiful.widget_pacnew)
   else
   		pacicon:set_image(beautiful.widget_pac)
   end

  return args[1]
  end, 240, "Arch S") -- Arch S for ignorepkg

  function popup_pac()
	 local pac_updates = ""
 	 local f = io.popen("pacman -Qu")
 	 if f then
  		pac_updates = pac_updates ..  f:read("*a")
  	 end
  
  	f:close()
  
	if pac_updates == "" then
		 pac_updates = "System is up to date"
  	end

	naughty.notify { text 	 = markup(green, pac_updates),
					 title	 = "Pacman Updates:",
					 fg 	 = white,
					 bg 	 = theme.naughty_bg,
					 timeout = 2}
  end

  function update_pac()
  	io.popen("sudo pacman -Sy --ignore-root")
  end
 -- changing this to a mouseover instead of button click because it's annoying as fuck
 -- 	having to click on pacman to see updates. Also changed icon to an arrow because
 --		it was hard to tell the difference between when you did/did not have updates.
 
  pacicon:buttons(awful.util.table.join(awful.button({ }, 1, function() popup_pac() end)))
--  pacicon:buttons(pacwidget:buttons())
--	pacicon:connect_signal("mouse::enter", function()
--		popup_pac()
--		end)
--	pacicon:connect_signal("mouse::leave", function()
--		naughty.destroy(notif)
--		end)
--
-- End Pacman }}}
