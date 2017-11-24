local awful = require("awful")
local gears = require("gears")

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),
	
	-- hide and view wiboxes
	awful.key({ modkey, altkey    }, "r", function()
		myrightwibox[mouse.screen.index].visible = not myrightwibox[mouse.screen.index].visible
		end
		),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ }, "Print", function () awful.util.spawn("upload_screens scr") end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey, "Control" }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),


-- On the fly useless gaps change
    awful.key({ altkey, "Control" }, "+", function () lain.util.useless_gaps_resize(1) end),
    awful.key({ altkey, "Control" }, "-", function () lain.util.useless_gaps_resize(-1) end),
 	
-- On the fly useless gaps change
    awful.key({ altkey, "Control" }, "+", function () lain.util.useless_gaps_resize(1) end),
    awful.key({ altkey, "Control" }, "-", function () lain.util.useless_gaps_resize(-1) end),

-- Custome key bindings
  	awful.key({ }, "XF86MonBrightnessUp", function ()
	awful.util.spawn("xbacklight -inc 2") end),
	awful.key({ }, "XF86MonBrightnessDown", function ()
	awful.util.spawn("xbacklight -dec 2") end),
	awful.key({ }, "XF86AudioRaiseVolume", function ()
	awful.util.spawn("amixer set Master 5%+", false) end),
	awful.key({ }, "XF86AudioLowerVolume", function ()
	awful.util.spawn("amixer set Master 5%-", false) end),
	awful.key({ }, "XF86AudioMute", function ()
	awful.util.spawn("amixer set Master toggle", false) end),

--    awful.key({  }, "F5", function ()
  	awful.key({ modkey, "Control" }, "Up", function ()
    awful.util.spawn("mpc toggle", false) end),
--    awful.key({  }, "F6", function ()
  	awful.key({ modkey, "Control" }, "Right", function ()
  	awful.util.spawn("mpc next", false) end),
--    awful.key({  }, "F4", function ()
  	awful.key({ modkey, "Control" }, "Left", function ()
    awful.util.spawn("mpc prev", false) end),
	
--Pianobar
       awful.key({ altkey }, "p", function () awful.util.spawn_with_shell( "urxvt -e ~/.config/pianobar/pianobar_headless.sh") end),
       awful.key({ }, "XF86AudioPlay", function () awful.util.spawn_with_shell( "~/.config/pianobar/pianobar-scripts/toggle.sh") end),
       awful.key({ }, "XF86AudioNext", function () awful.util.spawn_with_shell( "~/.config/pianobar/pianobar-scripts/next.sh") end),
       awful.key({ altkey }, "=", function () awful.util.spawn_with_shell( "~/.config/pianobar/pianobar-scripts/love.sh") end),
       awful.key({ altkey }, "-", function () awful.util.spawn_with_shell( "~/.config/pianobar/pianobar-scripts/ban.sh") end),
       awful.key({ altkey }, "i", function () awful.util.spawn_with_shell( "~/.config/pianobar/pianobar-scripts/status.sh") end),
--       awful.key({ altkey }, "x", function () awful.util.spawn_with_shell( "~/.config/pianobar/pianobar-scripts/stop.sh") end),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

	awful.key({ modkey, "Shift" }, "Delete", function() awful.util.spawn("oblogout") end),
	awful.key({ modkey }, "Escape", function() awful.util.spawn("poweroff") end),
	awful.key({ altkey }, "m", function () awful.util.spawn_with_shell( "urxvt -e htop -s PERCENT_MEM") end),
	awful.key({ altkey }, "s", function () awful.util.spawn_with_shell( "urxvt -e glances") end),
	awful.key({ modkey }, "b", function () awful.util.spawn( "qutebrowser") end),
	awful.key({ modkey }, "o", function () awful.util.spawn( "opera") end),
	awful.key({ modkey, "Shift" }, "b", function () awful.util.spawn( "firefox-developer") end),
	awful.key({ modkey }, "w", function () awful.util.spawn( "nmcli_dmenu") end),
	awful.key({ modkey }, "v", function () awful.util.spawn( "kodi") end),
	awful.key({ modkey }, "t", function () awful.util.spawn( "turpial") end),
	awful.key({ modkey }, "o", function () awful.util.spawn( "opera") end),
	awful.key({ modkey }, "c", function () awful.util.spawn( "chromium") end),
	awful.key({ modkey }, "p", function () awful.util.spawn( "pavucontrol") end),
	awful.key({ modkey }, "s", function () awful.util.spawn( "steam") end),
	awful.key({ modkey }, "T", function () awful.util.spawn( "tor-browser-en") end),
	awful.key({ modkey }, "e", function () awful.util.spawn( "thunar") end),
	awful.key({ modkey }, "g", function () awful.util.spawn( "gvim") end),
	awful.key({ altkey }, "z", function () awful.util.spawn( "pkill youtube-viewer") end),
	awful.key({ altkey }, "x", function () awful.util.spawn( "pkill mpv") end),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen.index]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),
    -- Menubar
    awful.key({ modkey }, "a", function() menubar.show() end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
--keynumber = 0
--for s = 1, screen.count() do
--   keynumber = math.min(9, math.max(#tags[s], keynumber))
--end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused() 
                        local tag = screen.tags[i]
						if tag then
							tag:view_only()
						end
                  end),
		 -------------------------------------------
		 -- Toggle tag display---------------------- 
		 ------------------------------------------- 
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
					  local tag = screen.tags[i]
					  if tag then 
					  	awful.tag.viewtoggle(tag)
                      end
                  end),
		-- Move client to tag #
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                     if client.focus then
					 	local tag = client.focus.screen.tags[i]
						if tag then
							client.focus:move_to_tag(tag)
						end
					end
                  end),
		-- Toggle tag on focused client
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
					if client.focus then
						local tag = client.focus.screen.tags[i]
						if tag then
							client.focus:toggle_tag(tag)
						end 
				  	end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}
