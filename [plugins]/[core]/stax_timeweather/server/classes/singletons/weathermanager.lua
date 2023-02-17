---@class WeatherManagerSingleton
local WeatherManager = {}

--- Changes the weather to a specific weather or a random one
---@param weather WeatherType | nil If no value is passed it will change the weather to the next stage
function WeatherManager.ChangeWeather(weather)
  exports.stax_timeweather:WeatherManager_ChangeWeaher()
end

--- Sets the current blackout state
--- @param state boolean
function WeatherManager.SetBlackoutState(state)
  exports.stax_timeweather:WeatherManager_SetBlackoutState()
end

--- Gets the current weather stage
---@return WeatherType
function WeatherManager.GetCurrentWeather()
  return exports.stax_timeweather:WeatherManager_GetCurrentWeather()
end

Stax.ServerOnly(function()
  --- [ SERVER ]
  function Stax.WeatherManager()
    return WeatherManager
  end
end)