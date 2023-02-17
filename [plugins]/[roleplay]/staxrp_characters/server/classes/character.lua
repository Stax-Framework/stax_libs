---@class Character
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
  newCharacter.dob = nil
  newCharacter.gender = nil
  newCharacter.model = nil
  newCharacter.UserId = nil

  return newCharacter
end

function Character:Load()

end

Stax.ServerOnly(function()
  --- [ SERVER ]
  function Stax.Character()
    return Character
  end
end)