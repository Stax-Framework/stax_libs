---@class BoxZone
local BoxZone = {}
BoxZone.__index = BoxZone

function BoxZone.Init()
  local newZone = {}
  setmetatable(newZone, BoxZone)

  return newZone
end

Stax.ClientOnly(function()
  Stax.BoxZone = BoxZone
end)