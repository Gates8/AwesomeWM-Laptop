local wibox			= require("wibox")
local vicious 		= require("vicious")
local awful 		= require("awful")
local beautiful 	= require("beautiful")

vicious.cache(vicious.widgets.volume)

--vol percent
volicion = wibox.widget.imagebox(beautiful.widget_vol)

volpct = wibox.widget.textbox()
vicious.register(volpct, vicious.widgets.volume, "$1", nil, "Master")

volicon:buttons(awful.util.table.join(awful.button({ }, 3, function() awful.spawn("pavucontrol") end)))
volpct:buttons(volicon:buttons())

-- Making the manual buttons appear on a click rather than mouseover
volicon:buttons(awful.util.table.join(awful.button({ }, 1, function()
	if not vup_img.visible and not vdo_img.visible then
		vup_img.visible = true
		vdo_img.visible = true 
	elseif vup_img.visible and vdo_img.visible then
		vup_img.visible = false
		vdo_img.visible = false
	end
end)))

-- For now these are just placeholders until I get the actual image that I want for the buttons

--volume up image
vup_img = wibox.widget{image 	= theme.vup_img,
					   widget 	= wibox.widget.imagebox,
					   visible	= false}

-- Add button functionality here for volume up
vup_img:buttons(awful.util.table.join(
	awful.button({ }, 1, function() awful.util.spawn("amixer set Master 2%+") end))
	)

--volume down image
vdo_img = wibox.widget{ image 	= theme.vdo_img,
						widget 	= wibox.widget.imagebox,
						visible	= false}

-- Add button functionality for volume down here
vdo_img:buttons(awful.util.table.join(
	awful.button({ }, 1, function() awful.util.spawn("amixer set Master 2%-") end))
	)

-- Do I really want this tooltip?
vol_t = awful.tooltip({text = "Volume Control",
						objects = {volicon, vup_img} })

