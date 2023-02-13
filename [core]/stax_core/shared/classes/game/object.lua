---@class Object
local Object = {}
Object.__index = Object

---
function Object.Init(handle)
  local newObject = {}
  setmetatable(newObject, Object)

  newObject.Handle = handle

  return newObject
end

if not Stax.Classes.Game then
  Stax.Classes.Game = {}
end

function Stax.Object()
  return Object
end