---@meta rdgs.CConditionPlayerCounter
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CConditionPlayerCounter
---@field ConditionKey string		Returns a unique string identifier for this condition
---@field IsResolved boolean		Returns true if the condition and all subconditions are resolved
---@field IsResolvedSelf boolean		Returns true if this condition has ended
---@field CurrentAmount rdgs.StatsValue		Returns the current value of the counter.
---@field Context integer		\\see CConditionPlayerCounterBase::GetContext
---@field Amount rdgs.StatsValue		Get amount
local CConditionPlayerCounter = {}
---@see CCondition parent class
---Satisfies this condition and all subconditions
---@param self rdgs.CConditionPlayerCounter
function CConditionPlayerCounter.SatisfyRecursiveNet(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CConditionPlayerCounter.isValid() end
---@return boolean returns true if weak pointer holds a valid reference
function CConditionPlayerCounter.isValid() end

return CConditionPlayerCounter
