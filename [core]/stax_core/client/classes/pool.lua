---@class Pool
---@field private Pool any
local Pool = {}

--- Gets the current vehicle pool
---@return Pool
function Pool.Vehicle()
  local newPool = {}

  ---@type table<number, Vehicle>
  newPool.Pool = {}

  local data = GetGamePool("CVehicle")

  for _, v in pairs(data) do
    newPool[v] = Stax.Classes.Game.Vehicle.Init(v)
  end

  return newPool
end

--- Gets the current ped pool
---@return Pool
function Pool.Ped()
  local newPool = {}

  ---@type table<number, Ped>
  newPool.Pool = {}

  local data = GetGamePool("CPed")

  for _, v in pairs(data) do
    newPool[v] = Stax.Classes.Game.Ped.Init(v)
  end

  return newPool
end

--- Gets the current pickup pool
---@return Pool
function Pool.Pickup()
  local newPool = {}

  ---@type table<number, Pickup>
  newPool.Pool = {}

  local data = GetGamePool("CPickup")

  for _, v in pairs(data) do
    newPool[v] = Stax.Classes.Game.Pickup.Init(v)
  end

  return newPool
end

--- Gets the current object pool
---@return Pool
function Pool.Object()
  local newPool = {}

  ---@type table<number, Pickup>
  newPool.Pool = {}

  local data = GetGamePool("CObject")

  for _, v in pairs(data) do
    newPool[v] = Stax.Classes.Game.Object.Init(v)
  end

  return newPool
end

--- Gets a single instance from the pool
---@generic T
---@return T
function Pool:Get(handle)
  if not handle then
    return self.Pool
  end

  return self.Pool[handle]
end

--- Gets all of the instances from the pool
---@generic T
---@return { [number]: T }
function Pool:GetAll()
  return self.Pool
end

Stax.ClientOnly(function()
  if not Stax.Classes.Pool then
    Stax.Classes.Pool = Pool
  end
end)