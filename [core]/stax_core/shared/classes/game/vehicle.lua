---@class Vehicle
---@field public IsServer boolean Whether or not the class instance is on the client or server
---@field public Handle number Entity Id
---@field public NetworkHandle number Entity Network Id
local Vehicle = {}
Vehicle.__index = Vehicle

--- Create a new instance of StaxVehicle from already existing vehicle entity
---@param handle number
---@return Vehicle
function Vehicle.Init(handle)
  local newVehicle = {}
  setmetatable(newVehicle, Vehicle)
    
  newVehicle.IsServer = IsDuplicityVersion()

  newVehicle.Handle = handle
  newVehicle.NetworkHandle = nil

  if NetworkGetEntityIsNetworked(newVehicle.Handle) then
    self.NetworkHandle = NetworkGetNetworkIdFromEntity(newVehicle.Handle)
  end

  return newVehicle
end

--- Create a new instance of StaxVehicle and create vehicle entity
---@param model string | number
---@param position any
---@param heading any
---@param options any
---@return Vehicle | nil
function Vehicle.Create(model, position, heading, options)
  local newVehicle = {}
  setmetatable(newVehicle, Vehicle)

  local hash = GetHashKey(model)

  newVehicle.IsServer = IsDuplicityVersion()

  newVehicle.Handle = nil
  newVehicle.NetworkHandle = nil


  --- CREATING VEHICLE
  local networked = false
  local mission = false

  if type(options) == "table" then
    if options.networked then networked = options.networked end
    if options.mission then mission = options.mission end
  end

  if not IsModelInCdimage(hash) then
    local loadTimeCutoff = GetGameTimer() + 10000

    RequestModel(hash)
    while not HasModelLoaded(hash) do
      if GetGameTimer() > loadTimeCutoff then
        return nil
      end
      Citizen.Wait(0)
    end
  end

  local spawnedVehicle = CreateVehicle(hash, position.x, position.y, position.z, heading, networked, mission)

  if networked then
    newVehicle.NetworkHandle = NetworkGetNetworkIdFromEntity(spawnedVehicle)
  end

  return newVehicle
end

--- Deletes the vehicle entity
function Vehicle:Delete()
  DeleteVehicle(self.Handle)
end

--- Sets the entity as no longer needed and leave it for the game to remove on its own
function Vehicle:SetNotNeeded()
  SetEntityAsNoLongerNeeded(self.Handle)
end

--- Sets the vehicle entity position
function Vehicle:SetPosition(position, options)
  local clearArea = false

  if type(options) == "table" then
    if options.clearArea then clearArea = options.clearArea end
  end

  SetEntityCoords(self.Handle, position.x, position.y, position.z, false, false, false, clearArea)
end

if not Stax.Classes.Game.Vehicle then
  Stax.Classes.Game.Vehicle = Vehicle
end