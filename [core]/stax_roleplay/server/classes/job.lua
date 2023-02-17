local Database = Stax.Database()

---@class RPJob
---@field public Key string The unique key defined for this job
---@field public Name string Name of the job
---@field public Type string Type of job it is
---@field public Public boolean If the job is open to anyone or not hire only
---@field public Roles string[] All the roles that are on this job
---@field public Employees table All employees currently employed in this job
local Job = {}
Job.__index = Job

--- Registers a job into the jobs manager
function Job.Register(key, name, roles)
  local newJob = {}
  setmetatable(newJob, Job)

  newJob.Key = key
  newJob.Name = name
  newJob.Type = nil
  newJob.Public = nil
  newJob.Roles = nil
  newJob.Employees = nil

  return newJob
end

function Job:Init(callback)
  --- Run Job Init

  ---@param roles table
  ---@param employees table
  callback(function(roles, employees)
    
  end)
end

function Job:HirePlayer()

end

function Job:FirePlayer()

end

function Job:GetEmployees()

end

function Job:GetEmployee()

end

---@class RPJobEmployee
local JobEmployee = {}
JobEmployee.__index = JobEmployee

function JobEmployee.Load()

end

---@class RPJobRole
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
---@param role RPJobRole
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

Stax.ServerOnly(function()
  function Stax.Roleplay.Job()
    return Job
  end

  function Stax.Roleplay.JobEmployee()
    return JobEmployee
  end

  function Stax.Roleplay.JobRole()
    return JobRole
  end
end)