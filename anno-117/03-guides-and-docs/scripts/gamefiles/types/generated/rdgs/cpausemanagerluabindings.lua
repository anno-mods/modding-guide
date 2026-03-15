---@meta rdgs.CPauseManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CPauseManager
---@field IsPaused boolean		
---@field VoteForPausePeers datasets.Peer[]		
local CPauseManager = {}
Pause = CPauseManager
---Convenience Helpers
---@param self rdgs.CPauseManager
function CPauseManager.Toggle(self) end
---@param self rdgs.CPauseManager
function CPauseManager.IncreaseGameSpeed(self) end
---@param self rdgs.CPauseManager
function CPauseManager.DecreaseGameSpeed(self) end
---Singleplayer only pause
---@param self rdgs.CPauseManager
function CPauseManager.PausedInMenu(self) end
---@param self rdgs.CPauseManager
function CPauseManager.Continued(self) end
---Net messages (mostly kept for legacy TextSources)
---@param self rdgs.CPauseManager
function CPauseManager.Paused(self) end
---@param self rdgs.CPauseManager
function CPauseManager.Played(self) end
---@param self rdgs.CPauseManager
function CPauseManager.FastForward(self) end
---@param self rdgs.CPauseManager
function CPauseManager.TripleFastForward(self) end
---Debug: Calculate a single tick via textsource
---@param self rdgs.CPauseManager
function CPauseManager.UnpauseForOneTick(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CPauseManager.isValid() end

return CPauseManager
