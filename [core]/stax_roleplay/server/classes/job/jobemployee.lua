---@class JobEmployee
local JobEmployee = {}
JobEmployee.__index = JobEmployee

function JobEmployee.Load()
  local newEmployee = {}
  setmetatable(newEmployee, JobEmployee)

  --- EMPLOYEE DATA

  return newEmployee
end

Stax.ServerOnly(function()
  --- [ SERVER ]
  function Stax.JobEmployee()
    return JobEmployee
  end
end)