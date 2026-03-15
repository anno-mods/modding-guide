---@meta rdgs.CLoadingPierManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CLoadingPierManager
local CLoadingPierManager = {}
LoadingPier = CLoadingPierManager
---@param self rdgs.CLoadingPierManager
---@param draw boolean
function CLoadingPierManager.SetDebugDrawing(self, draw ) end
---@param self rdgs.CLoadingPierManager
---@param pathPlannerLayer integer
---@param coastlineID integer
function CLoadingPierManager.UpdateHarborQueuePointsDebug(self, pathPlannerLayer , coastlineID ) end
---@return boolean returns true if weak pointer holds a valid reference
function CLoadingPierManager.isValid() end

return CLoadingPierManager
