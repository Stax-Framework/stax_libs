---@class CharacterManager
local CharacterManager = {}

--- Adds a character to the character manager
---@param character RPCharacter
function CharacterManager.Add(character)
  exports.stax_roleplay:CharacterManager_Add(character)
end

--- Removes a character from the character manager
---@param character RPCharacter
function CharacterManager.Remove(character)
  exports.stax_roleplay:CharacterManager_Remove(character)
end

--- Gets a character from the character manager
---@param handle number
---@return RPCharacter
function CharacterManager.Get(handle)
  return exports.stax_roleplay:CharacterManager_Get(handle)
end

Stax.ServerOnly(function()
  --- [SERVER]
  function Stax.CharacterManager()
    return CharacterManager
  end
end)