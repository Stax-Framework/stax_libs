local Exports = Stax.Singletons.Exports

---@class PluginManager
local PluginManager = {}

--- Gets the plugin using its key
---@param key string
---@return Plugin
function PluginManager.GetPlugin(key)
  return exports.stax_core:PluginManager_GetPlugin(key)
end

--- Gets the plugins key
---@param resource string
---@return string
function PluginManager.GetPluginKey(resource)
  return exports.stax_core:PluginManager_GetPluginKey(resource)
end

Stax.ServerOnly(function()
  if not Stax.Singletons.PluginManager then
    Stax.Singletons.PluginManager = PluginManager
  end
end)