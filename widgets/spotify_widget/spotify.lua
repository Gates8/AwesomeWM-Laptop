-----------------------------------------
---- 	Spotify Widget 	 			 ----
----	Author: Pavel Makhov		 ----
---- https://github.com/streetturtle ----
-----------------------------------------

local wibox = require("wibox")
local awful = require("awful")
local watch = require("awful.widget.watch")

local get_spotify_status_cmd = '/home/' .. os.getenv("USER") .. '/.config/awesome/Widgets/spotify_widget/spotify_stat.sh'
local get_current_song_cmd 	 = 'sp current'

spotify = wibox.widget {
	{
		id = "icon",
		widget = wibox.widget.imagebox,
	},
	{
		id 		= 'current_song',
		widget 	= wibox.widget.textbox,
		font = 'Play 9'
	},
	layout = wibox.layout.align.horizontal,
	set_image = function(self, path)
		self.icon.image = path
	end,
	set_text = function(self, path)
		self.current_song.text = path
	end,
}

local update_widget_icon = function(widget, stdout, _, _, _)
	stdout = string.gsub(stdout, "\n", "")
	if (stdout == 'RUNNING') then
		widget:set_image("~/.config/awesome/Widgets/spotify_widget/Icons/media-playback-start.svg")
	elseif (stdout == 'CORKED') then
		widget:set_image("~/.config/awesome/Widgets/spotify_widget/Icons/media-playback-pause.svg")
	else
		widget:set_image(nil)
	end
end

local update_widget_text = function(widget, stdout, _, _, _)
	if string.find(stdout, 'Error: Spotify is not running.') ~= nil then
		widget:set_text('')
		widget:set_visible(false)
	else
		widget:set_text(stdout)
		widget:set_visible(true)
	end
end

watch(get_spotify_status_cmd, 1, update_widget_icon, spotify)
watch(get_current_song_cmd, 1, update_widget_icon, spotify)

--Mouse control
spotify:connect_signal("button::press", function(_, _, _, button)
	if 		(button == 1) then awful.spawn("sp play", false) -- left click
	elseif	(button == 4) then awful.spawn("sp next", false) -- scroll up
	elseif 	(button == 5) then awful.spawn("sp prev", false) -- scroll down
	end
	awful.spawn.easy_async(get_spotify_status_cmd, function(stdout, stderr, exitreason, exitcode)
		update_widget_icon(spotify, stdout, stderr, exitreason, exitcode)
	end)
end) 
