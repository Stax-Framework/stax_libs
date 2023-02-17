---@class RPCharacter
---@field public Id number
---@field public Firstname string
---@field public Lastname string
---@field public Dob DateTime
---@field public Gender string
---@field public Model string
---@field public UserId string
local RPCharacter = {}
RPCharacter.__index = RPCharacter

--- Creates a new instance of StaxCharacter
---@param player Player
---@param characterId number
---@return RPCharacter
function RPCharacter.New(player, characterId)
  local newCharacter = {}

  newCharacter.Id = nil
  newCharacter.Firstname = nil
  newCharacter.Lastname = nil
  newCharacter.Dob = nil
  newCharacter.Gender = nil
  newCharacter.Model = nil
  newCharacter.UserId = nil

  return newCharacter
end

function RPCharacter:Load()

end

Stax.ServerOnly(function()
  function Stax.Roleplay.Character()
    return RPCharacter
  end
end)