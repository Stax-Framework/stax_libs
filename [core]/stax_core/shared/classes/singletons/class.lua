---@class ClassSingleton
local Class = {}

--- Reinitializes class from its data
---@generic T
---@param data table
---@param class T
---@return T
function Class.Init(data, class)
  return setmetatable(data, class)
end

function Stax.Class()
  return Class
end