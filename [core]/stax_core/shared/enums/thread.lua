---@enum ThreadState
local ThreadState = {
  Running = 0,
  Paused = 1,
  Destroyed = 2
}

if not Stax.Enums.ThreadState then
  Stax.Enums.ThreadState = ThreadState
end