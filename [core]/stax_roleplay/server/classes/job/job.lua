local JobRole = Stax.JobRole()

---@class Job
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

--- TEST

local JobManager = Stax.JobsManager()

local newJob = Job.Register("lspd", "Los Santos Police Department", {
  JobRole.Init("recruit", "Recruit", 0),
  JobRole.Init("patrol", "Patrol Officer", 10),
  JobRole.Init("detective", "Detective", 20),
  JobRole.Init("sergeant", "Sergeant", 30),
  JobRole.Init("lieutenant", "Lieutenant", 40),
  JobRole.Init("captain", "Captain", 50),
  JobRole.Init("chief", "Chief of Police", 100)
})

--- TEST

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

Stax.ServerOnly(function()
  --- [ SERVER ]
  function Stax.Job()
    return Job
  end
end)