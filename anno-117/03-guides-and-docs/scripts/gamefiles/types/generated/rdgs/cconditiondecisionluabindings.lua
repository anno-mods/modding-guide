---@meta rdgs.CConditionDecision
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CConditionDecision
---@field ConditionKey string		Returns a unique string identifier for this condition
---@field IsResolved boolean		Returns true if the condition and all subconditions are resolved
---@field IsResolvedSelf boolean		Returns true if this condition has ended
local CConditionDecision = {}
---@see rdgs.CCondition parent class
---Satisfies this condition and all subconditions
---@param self rdgs.CConditionDecision
function CConditionDecision.SatisfyRecursiveNet(self) end
---@param self rdgs.CConditionDecision
---@param decisionOptionIndex integer
function CConditionDecision.TakeDecision(self, decisionOptionIndex ) end

return CConditionDecision
