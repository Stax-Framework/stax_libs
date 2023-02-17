---@class CharacterManager
local CharacterManager = {}

function CharacterManager.Add(character)
  exports.stax_roleplay:CharacterManager_Add(character)
end

function CharacterManager.Remove(character)
  exports.stax_roleplay:CharacterManager_Remove(character)
end

function CharacterManager.Get(handle)
  return exports.stax_roleplay:CharacterManager_Get(handle)
end

Stax.ServerOnly(function()
  --- [SERVER]
  function Stax.CharacterManager()
    return CharacterManager
  end
end)