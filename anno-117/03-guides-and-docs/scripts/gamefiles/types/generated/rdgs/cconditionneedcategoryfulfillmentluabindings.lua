---@meta rdgs.CConditionNeedCategoryFulfillment
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CConditionNeedCategoryFulfillment
---@field ConditionKey string		Returns a unique string identifier for this condition
---@field IsResolved boolean		Returns true if the condition and all subconditions are resolved
---@field IsResolvedSelf boolean		Returns true if this condition has ended
---@field PopulationLevel integer		Returns the first configured population level GUID
---@field TargetValue integer		Returns the target fulfillment value
---@field CurrentValue integer		Returns the current fulfillment value for the first configured need category
---@field NeedCategory string		Returns the name of the first configured need category
local CConditionNeedCategoryFulfillment = {}
---@see CCondition parent class
---Satisfies this condition and all subconditions
---@param self rdgs.CConditionNeedCategoryFulfillment
function CConditionNeedCategoryFulfillment.SatisfyRecursiveNet(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CConditionNeedCategoryFulfillment.isValid() end
---@return boolean returns true if weak pointer holds a valid reference
function CConditionNeedCategoryFulfillment.isValid() end

return CConditionNeedCategoryFulfillment
