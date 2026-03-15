---@meta rdgs.CConditionMonumentProgress
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CConditionMonumentProgress
---@field ConditionKey string		Returns a unique string identifier for this condition
---@field IsResolved boolean		Returns true if the condition and all subconditions are resolved
---@field IsResolvedSelf boolean		Returns true if this condition has ended
---@field CurrentProgress integer		
---@field MonumentProgress integer		
local CConditionMonumentProgress = {}
---@see CCondition parent class
---Satisfies this condition and all subconditions
---@param self rdgs.CConditionMonumentProgress
function CConditionMonumentProgress.SatisfyRecursiveNet(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CConditionMonumentProgress.isValid() end
---@return boolean returns true if weak pointer holds a valid reference
function CConditionMonumentProgress.isValid() end

return CConditionMonumentProgress
