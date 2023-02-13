---@class Database
local Database = {}

-- results.Ok = queryResults.ok
-- results.Results = queryResults.results

--- Fires an asynchronous database query
---@async
---@param query string
---@param data table<string, any> | nil
---@return { Ok: boolean, Results: table | nil }
function Database.AsyncQuery(query, data)
  if not query then
    return { Ok = false }
  end

  if not data then
    data = nil
  end

  local queryResults = exports["stax_database"]:AsyncQuery({
    query = query,
    data = data
  })

  if not queryResults.ok then
    return { Ok = false }
  end

  return { Ok = true, Results = queryResults.results }
end

Stax.ServerOnly(function()
  --- [ SERVER ]
  function Stax.Database()
    return Database
  end
end)