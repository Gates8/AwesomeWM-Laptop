--Configure home path so you dont have too
home_path  = os.getenv('HOME') .. '/'

----------------------------------
---- Standard awesome library ----
----------------------------------
local lain 	= require("lain")
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")

----------------------------------

----------------------------------
-- Widget and layout library  ----
----------------------------------

local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")
beautiful.init( awful.util.getdir("config") .. "/themes/default/theme.lua" )

-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")

--FreeDesktop
require('widgets.freedesktop.utils')
require('widgets.freedesktop.menu')
freedesktop.utils.icon_theme = 'gnome'

-- LAin separators. Just dicking around with them 
local separator = lain.util.separators
-------------------------------------

-------------------------------------
----      Vicious + Widgets 	 ----
-------------------------------------

vicious 			= require("vicious"				)
local wi 			= require("wi"					)
local blingbling 	= require("blingbling"			)
local fs_wi 		= require("widgets.fs_wi"		)
local pac_wi 		= require("widgets.pac_wi"		)
local net_wi 		= require("widgets.net_wi"		)
local uptime_wi		= require("widgets.uptime_wi"	)
local vol_wi		= require("widgets.vol_wi"		)
local clock			= require("widgets.clock_wi"	)
local bat			= require("widgets.battery_wi"	)
--local weather		= require("widgets.weather_wi"	)

require("spotify")
-------------------------------------
-- Launchers
home 			= os.getenv("HOME")
confdir 		= home .. "/.config/awesome"
themes 			= confdir .. "/themes"
active_theme 	= themes .. "/default"
launcher_dir 	= active_theme .. "/icons/launchers/"

msjche_launcher	= awful.widget.launcher({ image =  launcher_dir .. "tux.png", command = home .. "/Scripts/Theming/msjche.sh" })

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup! \n Falling back to default RC.",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "You done fucked up!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- This is used later as the default terminal and editor to run.
terminal = "urxvt"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"
altkey = "Mod1"

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
--    awful.layout.suit.spiral.dwindle,
--    awful.layout.suit.max,
--    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
	lain.layout.centerwork
}
-- }}}

-- {{{ Naughty presets
naughty.config.defaults.timeout = 5
naughty.config.defaults.screen = 1
naughty.config.defaults.position = "top_right"
naughty.config.defaults.margin = 8
naughty.config.defaults.gap = 1
naughty.config.defaults.ontop = true
naughty.config.defaults.font = "terminus 12"
naughty.config.defaults.icon = nil
naughty.config.defaults.icon_size = 256
naughty.config.defaults.fg = beautiful.fg_tooltip
naughty.config.defaults.bg = beautiful.bg_tooltip
naughty.config.defaults.border_color = beautiful.border_tooltip
naughty.config.defaults.border_width = 2
naughty.config.defaults.hover_timeout = nil
-- -- }}}

-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {
 names  = { 
         '1 : Web',
         '2 : Portage', 
         '3 : News', 
         '4 : IRC',  
         '5 : Music', 
         '6 : Arrrg', 
         '7 : Multimedia',
           },
 layout = {
      layouts[2],	-- 1:web
      layouts[10],  	-- 2:portage
      layouts[2],	-- 3:news
      layouts[2],	-- 4:IRC
      layouts[2],	-- 5:music
      layouts[2],	-- 6:arrrg
      layouts[2],	-- 7:multimedia
          }
       }
for s = 1, screen.count() do
	-- Each screen has its own tag table.
 	tags[s] = awful.tag(tags.names, s, tags.layout)
end
-- }}}

-- Wallpaper Changer Based On 
-- menu icon menu pdq 07-02-2012
local wallmenu = {}
local function wall_load(wall)
	local f = io.popen('ln -sfn ' .. home_path .. '.config/awesome/wallpaper/' .. wall .. ' ' .. home_path .. '.config/awesome/themes/default/background.jpg')
	awesome.restart()
end

local function wall_menu()
local f = io.popen('ls -1 ' .. home_path .. '.config/awesome/wallpaper/')
for l in f:lines() do
	local item = { l, function () wall_load(l) end }
	table.insert(wallmenu, item)
end
f:close()
end
wall_menu()


--------------------------------------------
---- 			Widgets					----
----  These will be moved to own files  ----
--------------------------------------------


--------------------------------------------
----        Spacers                     ----
--------------------------------------------
blank  	= wibox.widget.textbox(' ')
bbl   	= wibox.widget.textbox('    ')
sep   	= wibox.widget.textbox(' | ')
arr_l	= separator.arrow_left(beautiful.fg_focus, "alpha")
arr_r	= separator.arrow_right(beautiful.fg_focus, "alpha")
--------------------------------------------

--Weather Widget
--weather = wibox.widget.textbox()
--vicious.register(weather, vicious.widgets.weather, "Weather: Sky: ${sky} - Temp: ${tempf}F - Humid: ${humid}% - Wind: ${windmph} mph", 1200, "KSAN")

--Battery Widget
batt = wibox.widget.textbox()
vicious.register(batt, vicious.widgets.bat, "Batt: $2% Rem: $3", 61, "BAT0")


-- {{{ Menu
-- Create a laucher widget and a main menu

--menu_items = freedesktop.menu.new()
--myawesomemenu = {
--   { "manual", terminal .. " -e man awesome", freedesktop.utils.lookup_icon({ icon = 'help' }) },
--   { "edit config", editor_cmd .. " " .. awesome.conffile, freedesktop.utils.lookup_icon({ icon = 'package_settings' }) },
--   { "restart", awesome.restart, freedesktop.utils.lookup_icon({ icon = 'system-shutdown' }) },
--   { "quit", awesome.quit, freedesktop.utils.lookup_icon({ icon = 'system-shutdown' }) }
--       }
--
--        table.insert(menu_items, { "Awesome", myawesomemenu, beautiful.awesome_icon })
--        table.insert(menu_items, { "Wallpaper", wallmenu, freedesktop.utils.lookup_icon({ icon = 'gnome-settings-background' })}) 
--
--        mymainmenu = awful.menu({ items = menu_items, width = 150 })
--
--mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
--                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

--------------------------------------------
----        blingbling widgets          ----
--------------------------------------------

--Labels
cpu_label = blingbling.text_box({ height = 35,
									widht = 70,
									v_margin = 5,
									font = "Droid Sans Bold",
									font_size = "20",
									text_color = "#DCDCCC",
									background_color = "#121212",
									background_text_bordr = "#FF0000",
									text_background_color = "#7A5ADA"
								})
cpu_label:set_text("CPU")


---------------------------------------------
----       End Bling                     ----
---------------------------------------------

-- Create a wibox for each screen and add it
mywibox = {}
myinfowibox = {}
mypromptbox = {}
mylayoutbox = {}
myrightwibox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s, height = 30 })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
--    left_layout:add(mylauncher)
    left_layout:add(mytaglist[s])
	left_layout:add(sep)
    left_layout:add(mypromptbox[s])

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then right_layout:add(wibox.widget.systray()) end
--    right_layout:add(sep)
--    right_layout:add(mailicon)
--	right_layout:add(mailwidget)
--    right_layout:add(spacer)
--    right_layout:add(baticon)
--    right_layout:add(batwidget)
--	right_layout:add(spotify_widget)
    right_layout:add(sep)
    right_layout:add(pacicon)
--	right_layout:add(pacwi)
--	right_layout:add(notification)
    right_layout:add(sep)
    right_layout:add(volicon)
    right_layout:add(volpct)
    right_layout:add(vup_img)
	right_layout:add(vdo_img)
   -- right_layout:add(vol_t)
--  right_layout:add(volspace)
    right_layout:add(sep)
    right_layout:add(mytextclock)
    right_layout:add(mylayoutbox[s])

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

   	mywibox[s]:set_widget(layout)
   
   -- Create the bottom wibox
     myinfowibox[s] = awful.wibox({ position = "bottom", screen = s, height = 30 })
   -- Widgets that are aligned to the bottom
    local bottom_left_layout = wibox.layout.fixed.horizontal()
--    bottom_left_layout:add(cpuicon)
--    bottom_left_layout:add(cpu)
    bottom_left_layout:add(sep)
--    bottom_left_layout:add(memicon)
    bottom_left_layout:add(mem)
	bottom_left_layout:add(sep)
    bottom_left_layout:add(wifi_i)
    bottom_left_layout:add(netdown_i)
    bottom_left_layout:add(netd)
    bottom_left_layout:add(netu)
    bottom_left_layout:add(netup_i)
    bottom_left_layout:add(sep)
    bottom_left_layout:add(wi_fi)
    bottom_left_layout:add(sep)
    --ottom_left_layout:add(weather)
	bottom_left_layout:add(batt)
    bottom_left_layout:add(sep)
	
	-- Widgets that are aligned to the right
    local bottom_right_layout = wibox.layout.fixed.horizontal()
	bottom_right_layout:add(spotify_widget)
    bottom_right_layout:add(sep)
    bottom_right_layout:add(uptime_i)
    bottom_right_layout:add(uptime_w)
    bottom_right_layout:add(sep)
    bottom_right_layout:add(msjche_launcher)
    
 	-- Now bring it all together 
    local bottom_layout = wibox.layout.align.horizontal()
	bottom_layout:set_right(bottom_right_layout)
    bottom_layout:set_left(bottom_left_layout)

    myinfowibox[s]:set_widget(bottom_layout)
	
	-- create wibox on right side of screen
	myrightwibox[s] = awful.wibar({ position = "right", screen = s, width = 100, bg = "#00000000" })
	local right_side_layout = wibox.layout.fixed.vertical()
	right_side_layout:add(root_text)
	right_side_layout:add(percent)
	right_side_layout:add(u_gb)
	right_side_layout:add(a_gb)
	right_side_layout:add(root_graph)
	right_side_layout:add(blank)
	right_side_layout:add(h_percentage)
	right_side_layout:add(h_ugb)
	right_side_layout:add(h_agb)
	right_side_layout:add(home_graph)

	vertical_layout = wibox.layout.align.vertical()
	vertical_layout:set_top(right_side_layout) 
	myrightwibox[s]:set_widget(vertical_layout)

	--make right wibox visible only on tag 1
	myrightwibox[s].visible = false
--	tags[1]:connect_signal("property::selected", function(tag)
--		myrightwibox[s].visible = tag.selected
--		end
--	)

end
-- }}}

--keybindings for layouts since layouts are dumb and don't like that it isnt in this file

--fuckyou_keys = awful.util.table.join(
--    awful.key({ modkey,           }, "space", function () awful.layout.inc(1) end),
--    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1) end)
--)
--root.keys(fuckyou_keys)

--do keybindings
dofile(awful.util.getdir("config") .. "/keybindings.lua")

--end do keybindings

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
    { rule = { class = "Chromium" },
      properties = { tag = tags[1][1] } },
    { rule = { class = "Vlc" },
      properties = { tag = tags[1][6] } },
    { rule = { class = "VirtualBox" },
      properties = { tag = tags[1][9] } },
    { rule = { class = "Gns3" },
      properties = { tag = tags[1][5] } },
    { rule = { class = "luakit" },
      properties = { tag = tags[1][1] } },
	{ rule = { class = "Spotify" },
	  properties = { tag = tags[1][7] } }, 
	{ rule = { class = "htop"	},
	  properties = { tag = tags[1][6] } },
	{ rule = { class = "glances"	},
	  properties = { tag = tags[1][6] } },
	{ rule = { class = "qutebrowser"},
	  properties = { tag = tags[1][1], 
	  				 maximized = false } }
    -- Set Firefox to always map on tags number 2 of screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { tag = tags[1][2] } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- The title goes in the middle
        local title = awful.titlebar.widget.titlewidget(c)
        title:buttons(awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                ))

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(title)

        awful.titlebar(c):set_widget(layout)
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- {{{ Run autostarting applications only once
function autostart(cmd, delay)
    delay = delay or 0
    awful.util.spawn_with_shell("pgrep -u $USER -x -f '" .. cmd .. "' || ( sleep " .. delay .. " && " .. cmd .. " )")
end

-- Autostart applications. The extra argument is optional, it means how long to
-- delay a command before starting it (in seconds).
autostart("pkill conky", 1)
--autostart("urxvtd -q -f -o", 1)
autostart("mpd", 1)
autostart("xscreensaver -no-splash", 1)
autostart("xflux -z 94596", 1)
--autostart("pkill nm-applet", 1)
--autostart("nm-applet", 5)
autostart("udiskie -2", 1)
autostart("compton -b", 1)
--autostart("hp-systray", 1)
--autostart("dropbox", 1)
--autostart("insync start", 1)
--autostart("megasync", 1)
autostart("~/Scripts/Theming/1080.sh", 1)
autostart("~/Scripts/up.sh", 1)
--autostart("~/Scripts/start_HUD.sh", 3)
autostart("~/Scripts/blanking.sh", 3)

-- }}}
