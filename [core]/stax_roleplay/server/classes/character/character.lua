---@class Character
---@field public Id number
---@field public Firstname string
---@field public Lastname string
---@field public Dob DateTime
---@field public Gender string
---@field public Model string
---@field public UserId string
local Character = {}
Character.__index = Character

--- Creates a new instance of StaxCharacter
---@param player Player
---@param characterId number
---@return Character
function Character.New(player, characterId)
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

function Character:Load()

end

Stax.ServerOnly(function()
  function Stax.Character()
    return Character
  end
end)