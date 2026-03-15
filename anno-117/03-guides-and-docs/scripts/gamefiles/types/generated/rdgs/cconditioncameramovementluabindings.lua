---@meta rdgs.CConditionCameraMovement
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CConditionCameraMovement
---@field ConditionKey string		Returns a unique string identifier for this condition
---@field IsResolved boolean		Returns true if the condition and all subconditions are resolved
---@field IsResolvedSelf boolean		Returns true if this condition has ended
---@field AchievedPercentage rdgs.StatsValue		
local CConditionCameraMovement = {}
---@see CCondition parent class
---Satisfies this condition and all subconditions
---@param self rdgs.CConditionCameraMovement
function CConditionCameraMovement.SatisfyRecursiveNet(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CConditionCameraMovement.isValid() end
---@return boolean returns true if weak pointer holds a valid reference
function CConditionCameraMovement.isValid() end

return CConditionCameraMovement
