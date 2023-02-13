---@class PlayerManagerSingleton
local PlayerManager = {}

--- Gets the player from the player manager
---@param source number
---@return Player | nil
function PlayerManager.GetPlayer(source)
  return exports.stax_core:PlayerManager_GetPlayer(source)
end

--- Sets some data on the player instance
function PlayerManager.SetPlayerData(source, key, data)
  exports.stax_core:PlayerManager_SetPlayerData(source, key, data)
end

--- Gets some data from the player instance
function PlayerManager:GetPlayerData(source, key)
  return exports.stax_core:PlayerManager_GetPlayerData(source, key)
end

Stax.ServerOnly(function()
  if not Stax.Singletons.PlayerManager then
    Stax.Singletons.PlayerManager = PlayerManager
  end
end)