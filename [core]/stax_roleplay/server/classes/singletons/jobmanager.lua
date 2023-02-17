---@class JobManagerSingleton
local JobsManager = {}

--- Adds a job into the jobs manager
---@param job Job
function JobsManager.AddJob(job)
  exports.stax_roleplay:JobsManager_AddJob(job)
end

--- Removes job from the jobs manager
---@param job Job
function JobsManager.RemoveJob(job)
  exports.stax_roleplay:JobsManager_RemoveJob(job)
end

--- Gets a job from the jobs manager
---@param key string
function JobsManager.GetJob(key)
  return exports.stax_roleplay:JobsManager_GetJob(key)
end

Stax.ServerOnly(function()
  --- [ SERVER ]
  function Stax.JobsManager()
    return JobsManager
  end
end)