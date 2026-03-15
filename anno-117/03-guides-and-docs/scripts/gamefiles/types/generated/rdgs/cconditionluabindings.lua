---@meta rdgs.CCondition
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CCondition
---@field ConditionKey string		Returns a unique string identifier for this condition
---@field IsResolved boolean		Returns true if the condition and all subconditions are resolved
---@field IsResolvedSelf boolean		Returns true if this condition has ended
local CCondition = {}
---Satisfies this condition and all subconditions
---@param self rdgs.CCondition
function CCondition.SatisfyRecursiveNet(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CCondition.isValid() end

return CCondition
