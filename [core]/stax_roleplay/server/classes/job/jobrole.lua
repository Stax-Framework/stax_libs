local Database = Stax.Database()

---@class JobRole
---@field public Key string
---@field public Name string
---@field public Power number
local JobRole = {}
JobRole.__index = JobRole

--- Initializes a role for jobs
---@param key string
---@param name string
---@param power number
function JobRole.Init(key, name, power)
  local newRole = {}
  setmetatable(newRole, JobRole)

  newRole.Key = string.lower(key)
  newRole.Name = name
  newRole.Power = power

  return newRole
end

function JobRole.Exists()
  local job = Database.AsyncQuery([[ SELECT * FROM `job_roles` WHERE ` ]], {
    
  })

  if not job.Ok then return false end

  if #job.Results > 0 then
    return true
  end

  return false
end

function JobRole.Load()
  local job = Database.AsyncQuery([[ SELECT * FROM `job_roles` WHERE ` ]], {
    
  })
end

function JobRole.Create()

end

--- Compares a job role's power to another job role
---@param role JobRole
---@return "<" | ">" | "=="
function JobRole:Compare(role)
  if self.Power > role.Power then
    return ">"
  end

  if self.Power < role.Power then
    return "<"
  end

  return "=="
end

-- local compare = JobRole:Compare(JobRole.Init("test", "name", 0))

-- if compare == "==" then
--   --- These roles share the same power
-- end

-- if compare == "<" then
--   --- The job role it was compared to has less power
-- end

-- if compare == ">" then
--   --- The job role it was compared to has more power
-- end

Stax.ServerOnly(function()
  --- [SERVER]
  function Stax.JobRole()
    return JobRole
  end
end)