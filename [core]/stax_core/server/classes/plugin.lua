local Logger = Stax.Logger()
local Events = Stax.Events()
local Directory = Stax.Directory()
local Config = Stax.Config()
local Locale = Stax.Locale()
local PluginManager = Stax.PluginManager()
local Database = Stax.Database()
local Class = Stax.Class()

---@class Plugin
---@field public ResourceName string Plugin resource folder name
---@field public Key string Plugin defined key
---@field public Name string Plugin defined name
---@field public Description string Plugin defined description
---@field public Dependencies table<string> Plugin defined dependencies
---@field public Config Config Plugin configurations
---@field public Locale Locale Plugin localization
---@field public Mounted boolean Plugin is mounted
local Plugin = {}
Plugin.__index = Plugin


--- Create new instance of Plugin
---@param resource string
---@return Plugin
function Plugin.New(resource)
  local newPlugin = {}
  setmetatable(newPlugin, Plugin)

  newPlugin.ResourceName = resource
  newPlugin.Key = nil
  newPlugin.Name = nil
  newPlugin.Description = nil
  newPlugin.Dependencies = nil
  newPlugin.Config = nil
  newPlugin.Locale = nil

  newPlugin.Mounted = false

  return newPlugin
end

--- Preinit Function
---@param callback function Calls the Initialize Function
function Plugin:PreInit(callback)
  local hasPluginInfo = self:GetPluginInfo()

  if not hasPluginInfo then
    return false
  end

  callback(function()
    self:Init(function()
      self:Mount()
    end)
  end)

  return true
end

--- Initializes the plugins
---@param mount function Calls for the plugin to mount
function Plugin:Init(mount)
  Citizen.CreateThread(function()
    self:LoadConfig()
    self:SendConfig()
    self:Migrate()

    mount()
  end)
end

--- Fires after the plugin has been mounted
function Plugin:Mount()
  Citizen.CreateThread(function()
    self:LoadLocale()
    self:SendLocale()

    self.Mounted = true
  
    Events.Fire("STAX::Core::Server::PluginMounted", self)
  end)
end

function Plugin:UnMount()
  self.Mounted = false

  Events.Fire("STAX::Core::Server::PluginUnMounted", self)
end

--- Get plugin name
function Plugin:GetPluginInfo()
  local data = self:GetAllByKey("stax_plugin")

  if not data then return end
  if not data[1] then return end

  self.Key = data[1].value
  
  local extra = json.decode(data[1].extra)

  self.Name = extra.name
  self.Description = extra.description

  if extra.dependency then
    self.Dependencies = extra.dependency
    if not self.Name == "stax-core" then
      self.Dependencies[#self.Dependencies+1] = "stax-core"
    end
  else
    if not self.Name == "stax-core" then
      self.Dependencies = { "stax-core" }
    end
  end
 
  if self.Key and self.Name and self.Description then
    return true
  end

  return false
end

--- Gets the migratiosn from the path and executes the plugins
function Plugin:Migrate()
  local p = promise.new()

  Logger.Success("Starting Migrations", "[(" .. self.ResourceName .. ") " .. self.Name .. "]")

  local pluginDirectory = GetResourcePath(self.ResourceName) .. "/sql/"

  local files = Directory.Scan(pluginDirectory)

  if not files then
    return false
  end

  if #files < 1 then
    Logger.Warning("Didn't find any sql files", "[(" .. self.ResourceName .. ") " .. self.Name .. "]")
    return false
  end

  for a = 1, #files do
    local sql = LoadResourceFile(self.ResourceName, "/sql/" .. files[a])
    
    Logger.Success("Executing Query", "[(" .. self.ResourceName .. ") " .. self.Name .. "] :: " .. files[a])

    local results = Database.AsyncQuery(sql)

    if results then
      if not results.Ok then
        p:reject(false)
      end
    end

    Logger.Success("Executed Query", "[(" .. self.ResourceName .. ") " .. self.Name .. "] :: " .. files[a])
  end

  Logger.Success("Migration Complete", "[(" .. self.ResourceName .. ") " .. self.Name .. "]")

  p:resolve()

  return Citizen.Await(p)
end

--- Loads the plugins config
---@return Config | nil
function Plugin:LoadConfig()
  local p = promise.new()

  local pluginDirectory = GetResourcePath(self.ResourceName) .. "/configs/"

  local files = Directory.Scan(pluginDirectory)

  if not files then
    Logger.Warning("Couldn't load any of your config files", "[(" .. self.ResourceName .. ") " .. self.Name .. "]")
    return nil
  end

  if #files < 1 then
    Logger.Warning("Didn't find any config files", "[(" .. self.ResourceName .. ") " .. self.Name .. "]")
    return nil
  end

  local config = { client = {}, server = {}, shared = {} }

  for a = 1, #files do
    if not string.find(files[a], ".json") then
      break
    end

    local boundary = nil
    local configKey = nil
    local data = LoadResourceFile(self.ResourceName, "/configs/" .. files[a])
    local cfg = json.decode(data)

    if string.find(files[a], ".client.") then
      boundary = "client"
      configKey = string.gsub(files[a], ".client.json", "")
    elseif string.find(files[a], ".server.") then
      boundary = "server"
      configKey = string.gsub(files[a], ".server.json", "")
    else
      boundary = "shared"
      configKey = string.gsub(files[a], ".json", "")
    end

    if not config[boundary][configKey] then
      config[boundary][configKey] = cfg
    else
      for l, p in pairs(cfg) do
        config[boundary][configKey][l] = p
      end
    end
  end

  local serverConfig = Config.Generate({ config.client, config.server, config.shared })

  self.Config = Config.Load(serverConfig)
  self.Config.Server = config.server
  self.Config.Client = config.client
  self.Config.Shared = config.shared

  Logger.Success("Loaded Config", "[(" .. self.ResourceName .. ") " .. self.Name .. "]")

  p:resolve()

  return Citizen.Await(p)
end

--- Sends the config to the server side
function Plugin:SendConfig()
  Events.Fire("STAX::Core::Shared::ConfigListener", self.ResourceName, self.Config)
end

--- Sends the client config to the players client
---@param player Player
function Plugin:SendConfigPlayer(player)
  local generatedClientConfig = Config.Generate({ self.Config.Shared, self.Config.Client })
  local clientConfig = Config.Load(generatedClientConfig)
  player:FireEvent("STAX::Core::Shared::ConfigListener", self.ResourceName, clientConfig)
end

--- Loads the plugins locale language file
function Plugin:LoadLocale()
  local p = promise.new()

  local corePlugin = PluginManager.GetPlugin("stax-core")

  if not corePlugin then
    Logger.Error("Couldn't get core plugin", "[(" .. self.ResourceName .. ") " .. self.Name .. "]")
    return
  end

  local coreConfig = Class.Init(corePlugin.Config, Config)

  local lang = coreConfig:Get("framework.locale")

  if not lang then
    Logger.Error("Couldn't get language from core config", "[(" .. self.ResourceName .. ") " .. self.Name .. "]")
    return
  end

  local locale = LoadResourceFile(self.ResourceName, "/locales/" .. lang .. ".json")

  if not locale then
    Logger.Warning("Couldn't get locale file", "[(" .. self.ResourceName .. ") " .. self.Name .. "] :: [LANGUAGE]: " .. lang)
    return
  end

  local decodedLocale = json.decode(locale)

  self.Locale = Locale.New(decodedLocale)

  Logger.Success("Loaded Locale", "[(" .. self.ResourceName .. ") " .. self.Name .. "]")

  p:resolve()

  return Citizen.Await(p)
end

--- Sends the locale to the server side
function Plugin:SendLocale()
  Events.Fire("STAX::Core::Shared::LocaleListener", self.ResourceName, self.Locale)
end

--- Sends the locale to the players client
---@param player Player
function Plugin:SendLocalePlayer(player)
  player:FireEvent("STAX::Core::Shared::LocaleListener", self.ResourceName, self.Locale)
end

--- Checks if the plugin has metadata key
---@param key string
---@return boolean
function Plugin:HasKey(key)
  return GetNumResourceMetadata(self.ResourceName, key) > 0
end

--- Gets all metadata by key
---@param key string
---@return table | nil
function Plugin:GetAllByKey(key)
  if not self:HasKey(key) then
    return nil
  end

  local count = GetNumResourceMetadata(self.ResourceName, key)

  local values = {}

  for a = 0, count do
    values[#values + 1] = {
      value = GetResourceMetadata(self.ResourceName, key, a),
      extra = GetResourceMetadata(self.ResourceName, key .. "_extra", a)
    }
  end

  return values
end

--- Checks if the plugin has metadata key
---@param key string
---@return table | nil
function Plugin:GetFirstByKey(key)
  return self:GetAllByKey(key)[1]
end

Stax.ServerOnly(function()
  --- [ SERVER ]
  function Stax.Plugin()
    return Plugin
  end
end)