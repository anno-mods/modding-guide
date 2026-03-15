---@meta rdgs.CConditionDecisionOption
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CConditionDecisionOption
---@field ConditionKey string		Returns a unique string identifier for this condition
---@field IsResolved boolean		Returns true if the condition and all subconditions are resolved
---@field IsResolvedSelf boolean		Returns true if this condition has ended
local CConditionDecisionOption = {}
---@see rdgs.CCondition parent class
---Satisfies this condition and all subconditions
---@param self rdgs.CConditionDecisionOption
function CConditionDecisionOption.SatisfyRecursiveNet(self) end
---Returns a list of goods that are needed to unlock this decision
---@param self rdgs.CConditionDecisionOption
---@param onlyMissingGoods boolean
---@return rdgs.DemandedGood[]|nil
function CConditionDecisionOption.GetRequiredCost(self, onlyMissingGoods ) end

return CConditionDecisionOption
