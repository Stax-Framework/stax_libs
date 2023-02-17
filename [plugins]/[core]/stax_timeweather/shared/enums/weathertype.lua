---@enum WeatherType
local WeatherType = {
  ExtraSunny = "EXTRASUNNY",
  Clear = "CLEAR",
  Neutral = "NEUTRAL",
  Smog = "SMOG",
  Foggy = "FOGGY",
  Overcast = "OVERCAST",
  Clouds = "CLOUDS",
  Clearing = "CLEARING",
  Rain = "RAIN",
  Thunder = "THUNDER",
  Snow = "SNOW",
  Blizzard = "BLIZZARD",
  Snowlight = "SNOWLIGHT",
  Xmas = "XMAS",
  Halloween = "HALLOWEEN"
}

--- [ SHARED ]
function Stax.WeatherType()
  return WeatherType
end