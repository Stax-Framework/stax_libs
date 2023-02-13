---@class UISingleton
local UI = {}

--- Enables the UI
--- Works only if you are using the UI Vue template
function UI.ShowUI()
  UI.SendMessage({ mutation = "Router/SHOW_UI" })
end

--- Disables the UI
--- Works only if you are using the UI Vue template
function UI.HideUI()
  UI.SendMessage({ mutation = "Router/HIDE_UI" })
end

--- Changes the UI Route
--- Works only if you are using the UI Vue template
function UI.ChangeRoute(route)
  UI.SendMessage({{ mutation = "Router/CHANGE_ROUTE", payload = { route = route } }})
end

--- Allows the UI to take over mouse controls and even add a cursor
--- Works only if you are using the UI Vue template
---@param hasFocus boolean
---@param hasCursor boolean
function UI.Focus(hasFocus, hasCursor)
  SetNuiFocus(hasFocus, hasCursor)
end

--- Sends an NUI Message
--- Works only if you are using the UI Vue template
function UI.SendMessage(data)
  SendNUIMessage(data)
end

--- Calls a migration inside the UI
--- Works only if you are using the UI Vue template
---@param module string
---@param migration string
---@param payload any
function UI.FireMigration(module, migration, payload)
  UI.SendMessage({ mutation = module .. "/" .. migration, payload = payload })
end

--- Registers an NUI Callback to get data from the UI
---@param type string
---@param callback fun(data: any, callback: function)
function UI.RegisterCallback(type, callback)
  RegisterNUICallback(type, callback);
end

Stax.ClientOnly(function()
  if not Stax.Singletons.UI then
    Stax.Singletons.UI = UI
  end
end)