---@class Pickup
local Pickup = {}
Pickup.__index = Pickup

function Pickup.Init(handle)
  local newPickup = {}
  setmetatable(newPickup, Pickup)

  newPickup.Handle = handle

  return newPickup
end

if not Stax.Classes.Game then
  Stax.Classes.Game = {}
end

if not Stax.Classes.Game.Pickup then
  Stax.Classes.Game.Pickup = Pickup
end