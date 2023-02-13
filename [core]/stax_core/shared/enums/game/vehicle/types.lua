---@enum VehicleType
local VehicleType = {
  automobile = "automobile",
  bike = "bike",
  boat = "boat",
  heli = "heli",
  plane = "plane",
  submarine = "submarine",
  trailer = "trailer",
  train = "train"
}

if not Stax.Enums.Game then
  Stax.Enums.Game = {}
end

if not Stax.Enums.Game.VehicleType then
  Stax.Enums.Game.VehicleType = VehicleType
end