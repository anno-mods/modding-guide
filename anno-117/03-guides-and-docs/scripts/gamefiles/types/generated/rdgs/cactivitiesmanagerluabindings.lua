---@meta rdgs.CActivitiesManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CActivitiesManager
local CActivitiesManager = {}
Activities = CActivitiesManager
---@param self rdgs.CActivitiesManager
---@param activity datasets.PlaystationActivityState
---@return boolean
function CActivitiesManager.LaunchActivity(self, activity ) end
---@return boolean returns true if weak pointer holds a valid reference
function CActivitiesManager.isValid() end

return CActivitiesManager
