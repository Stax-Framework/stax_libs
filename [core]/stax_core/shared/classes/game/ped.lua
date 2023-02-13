---@class Ped
local Ped = {}
Ped.__index = Ped

function Ped.Init(handle)
  local newPed = {}
  setmetatable(newPed, Ped)

  newPed.IsServer = IsDuplicityVersion()
  newPed.Handle = handle

  return newPed
end

if not Stax.Classes.Game then
  Stax.Classes.Game = {}
end

function Stax.Ped()
  return Ped
end