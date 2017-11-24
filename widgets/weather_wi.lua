local awful 	= require("awful")
local lain 		= require("lain")
local read_pipe = require("lain.helpers").read_pipe

myweather = lain.widget.weather({
	city_id 				= 5391832,
	units					= "imperial",
	notification_text_fun 	= function(wn)
		--TOD Forecasted
	local day = string.gsub(read_pipe(string.format("date -u -d @%d +'%%A %%d'",
													wn["dt"])),"\n","")

	local desc 		= wn["weather"][1]["description"]
	
	--Temperature min,max; morning, day, evening, night
	local tmin 		= math.floor(wn["temp"]["min"])
	local tmax 		= math.floor(wn["temp"]["max"])
	local tmor 		= math.floor(wn["temp"]["morn"])
	local tday 		= math.floor(wn["temp"]["day"])
	local teve 		= math.floor(wn["temp"]["eve"])
	local tnig 		= math.floor(wn["temp"]["night"])
	
	local humidity 	= math.floor(wn["humidity"])
	local wspe		= math.floor(wn["speed"])
	-- Wind degreed (meteorological degrees)
	local wdeg		= math.floor(wn["deg"])
	local clou 		= math.floor(wn["clouds"])

	return string.format("<br><b>%s</b>: %s<br>Temperatures: Min: %d F - Max: %d F<br>Humidity: %d %<br>Wind: %d miles/hour at %d degrees.<br>Cloudiness: %d %<br>", day, desc, tmin, tmax, humidity, wspe, wdeg, clou)
	end,
	settings = function()
		units = math.floor(weather_now["main"]["temp"])
		widget:set_text(" " .. units .. " ")
	end
})
myweather.show(5)
function weather_show()
	weatherSD.show(5)
end
