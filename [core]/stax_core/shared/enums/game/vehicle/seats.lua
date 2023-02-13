---@enum VehicleSeats
local VehicleSeats = {
  none = -3,
  any = -2,
  left_front = -1,
  right_front = 0,
  left_rear = 1,
  right_rear = 2,
  extra_1 = 3,
  extra_2 = 4,
  extra_3 = 5,
  extra_4 = 6,
  extra_5 = 7,
  extra_6 = 8,
  extra_7 = 9,
  extra_8 = 10,
  extra_9 = 11,
  extra_10 = 12,
  extra_11 = 13,
  extra_12 = 14
}

if not Stax.Enums.Game then
  Stax.Enums.Game = {}
end

if not Stax.Enums.Game.VehicleSeats then
  Stax.Enums.Game.VehicleSeats = VehicleSeats
end