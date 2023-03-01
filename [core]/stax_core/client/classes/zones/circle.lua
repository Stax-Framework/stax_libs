---@class CircleZone
local CircleZone = {}
CircleZone.__index = CircleZone

function CircleZone.Init()
  local newZone = {}
  setmetatable(newZone, CircleZone)

  return newZone
end

Stax.ClientOnly(function()
  Stax.CircleZone = CircleZone
end)