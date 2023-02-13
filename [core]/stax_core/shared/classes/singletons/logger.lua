local String = Stax.String()

---@class LoggerSingleton
local Logger = {}

---@param action string
---@param message string
function Logger.Success(action, message)
  local msg = String.Interpolate("^4[STAX] :: ^9SUCCESS ^0:: ^9{action}^0 :: ^3{message}^0", {
    action = action,
    message = message
  })

  print(msg)
end

---@param action string
---@param message string
function Logger.Error(action, message)
  local msg = String.Interpolate("^4[STAX] :: ^8ERROR ^0:: ^8{action}^0 :: ^3{message}^0", {
    action = action,
    message = message
  })

  print(msg)
end

---@param action string
---@param message string
function Logger.Warning(action, message)
  local msg = String.Interpolate("^4[STAX] :: ^1WARNING ^0:: ^1{action}^0 :: ^3{message}^0", {
    action = action,
    message = message
  })

  print(msg)
end

--- [ SHARED ]
function Stax.Logger()
  return Logger
end