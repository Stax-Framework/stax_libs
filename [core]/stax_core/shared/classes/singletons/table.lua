---@class TableSingleton
local Table = {}

--- Copy's a table into a new table
---@param t table
---@return table
function Table.Copy(t)
  local newTable = {}

  for k, v in pairs(t) do
    newTable[k] = v
  end

  return newTable
end

--- [ SHARED ]
function Stax.Table()
  return Table
end