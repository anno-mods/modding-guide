---@meta rdgs.CConditionGoodsInRangeBase
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CConditionGoodsInRangeBase
---@field ConditionKey string		Returns a unique string identifier for this condition
---@field IsResolved boolean		Returns true if the condition and all subconditions are resolved
---@field IsResolvedSelf boolean		Returns true if this condition has ended
local CConditionGoodsInRangeBase = {}
---@see rdgs.CCondition parent class
---Satisfies this condition and all subconditions
---@param self rdgs.CConditionGoodsInRangeBase
function CConditionGoodsInRangeBase.SatisfyRecursiveNet(self) end
---@param self rdgs.CConditionGoodsInRangeBase
function CConditionGoodsInRangeBase.IDontHaveAPurposeAndAmOnlyNeededForTextSourceInheritance(self) end

return CConditionGoodsInRangeBase
