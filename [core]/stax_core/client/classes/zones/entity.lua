---@class EntityZone
local EntityZone = {}
EntityZone.__index = EntityZone

function EntityZone.Init()
  local newZone = {}
  setmetatable(newZone, EntityZone)

  return newZone
end

Stax.ClientOnly(function()
  Stax.EntityZone = EntityZone
end)