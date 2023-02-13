local String = Stax.Singletons.String
local Table = Stax.Singletons.Table
local Class = Stax.Singletons.Class
local Events = Stax.Singletons.Events

---@class Config
---@field private Storage table
---@field public Shared table
---@field public Server table
---@field public Client table
local Config = {}
Config.__index = Config

--- Create a new instance of StaxConfig but loads the config directly
---@param cfg table
---@return Config
function Config.Load(cfg)
  local config = {}
  setmetatable(config, Stax.Classes.Config)

  config.Storage = cfg

  return config
end

--- Gets a config from a keys path
---@param key string | nil
---@return any
function Config:Get(key)
  if not key then return self.Storage end

  local path = String.Split(key, ".")
  local storage = Table.Copy(self.Storage)

  if not storage then return nil end

  for _, v in pairs(path) do
    storage = storage[v]
  end

  return storage
end

function Config.Generate(scopes)
  local storage = {}

  for _, scope in pairs(scopes) do
    for key, data in pairs(scope) do
      if storage[key] then
        for dataKey, dataValue in pairs(data) do
          storage[key][dataKey] = dataValue
        end
        break
      end

      storage[key] = data
    end
  end

  return storage
end

--- Creates a listener for the locales that the framework pushes to the plugins client and server
---@param callback fun(config: Config)
function Config.Listen(callback)
  local currentResource = GetCurrentResourceName()
  local isServer = IsDuplicityVersion()

  if isServer then
    Events.CreateEvent("STAX::Core::Shared::ConfigListener", function(resource, config)
      if currentResource ~= resource then return end
      callback(Class.Init(config, Stax.Classes.Config))
    end)
  else
    Events.CreateNetEvent("STAX::Core::Shared::ConfigListener", function(resource, config)
      if currentResource ~= resource then return end
      callback(Class.Init(config, Stax.Classes.Config))
    end)
  end
end

if not Stax.Classes.Config then
  Stax.Classes.Config = Config
end