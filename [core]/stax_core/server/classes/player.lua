local Events = Stax.Events()
local String = Stax.String()
local Table = Stax.Table()
local User = Stax.User()

---@class Player
---@field public Handle number Players server id
---@field public Name string Players server name
---@field public Identifiers table<number, string> Table of players available identifiers
---@field public User User User instance for this player
---@field public Data table<string, any>
local Player = {}
Player.__index = Player

--- Creates new instance of Player
---@param handle string
---@return Player
function Player.New(handle)
  local newPlayer = {}
  local playerName = GetPlayerName(handle)
  local validatedName = String.StripInvalid(playerName)

  setmetatable(newPlayer, Player)

  newPlayer.Handle = handle
  newPlayer.Name = validatedName
  newPlayer.Identifiers = newPlayer:GetIdentifiers()
  newPlayer.User = nil
  newPlayer.Data = {}

  return newPlayer
end

--- Reinitialized instance of Player
---@param player Player
---@return Player
function Player.Class(player)
  return setmetatable(player, Player)
end

--- Loads the user into the player instance
---@return boolean
function Player:LoadUser()
  local user = User.Load(self)

  if not user then
    user = User.Create(self)
  end

  if user then
    self.User = user
    return true
  end

  return false
end

--- Stores some data inside of the Player instance
---@param keys string
---@param newData any
function Player:SetData(keys, newData)
  if not keys then return end

  local path = String.Split(keys, ".")
  local data = Table.Copy(self.Data)

  for index, v in pairs(path) do
    -- if index == #path then
    --   data[v] = newData
    --   return true
    -- end
    -- data = data[v]
    if data[v] then
      if index == #path then
        data[v] = newData
        break
      end
      data = data[v]
    else
      data[v] = {}
    end
  end

  exports.stax_core:PlayerManager_SetPlayerData(self, self.Data)
end

--- Gets some data stored inside of the Player instance
---@param keys string
---@return any
function Player:GetData(keys)
  if not keys then
    return self.Data
  end

  local path = String.Split(keys, ".")
  local data = Table.Copy(self.Data)

  for _, v in pairs(path) do
    data = data[v]
  end

  return data
end

---@return table<number, string>
function Player:GetIdentifiers()
  local amount = GetNumPlayerIdentifiers(self.Handle)
  local identifiers = {}

  for a = 0, amount do
    identifiers[#identifiers + 1] = GetPlayerIdentifier(self.Handle, a)
  end

  return identifiers
end

--- Gets a specified type of player identifier if it exists
---@param identType string
---@return string | nil
function Player:GetIdentifier(identType)
  for a = 1, #self.Identifiers do
    if string.find(self.Identifiers[a], identType, 1) then
      return self.Identifiers[a]
    end
  end
  return nil
end

--- Kicks the player from the server
---@param admin Player
---@param reason string
function Player:Kick(admin, reason)
  DropPlayer(self.Handle, reason)
end

--- Bans the player from the server
---@param admin Player
---@param reason string
---@param time table
function Player:Ban(admin, reason, time)
  DropPlayer(self.Handle, reason)
end

--- Issues the player a warning
---@param admin Player
---@param reason string
function Player:Warn(admin, reason)

end

--- Fires an event on this player
---@param event string
---@param ... any
function Player:FireEvent(event, ...)
  Events.FireClient(event, self.Handle, ...)
end

Stax.ServerOnly(function()
  --- [ SERVER ]
  function Stax.Player()
    return Player
  end
end)