---@class ComboZone
local ComboZone = {}
ComboZone.__index = ComboZone

function ComboZone.Init()
  local newZone = {}
  setmetatable(newZone, ComboZone)

  return newZone
end

Stax.ClientOnly(function()
  Stax.ComboZone = ComboZone
end)