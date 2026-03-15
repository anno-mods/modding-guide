---@meta rdgs.IConditionEvent
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.IConditionEvent
---@field ConditionKey string		Returns a unique string identifier for this condition
---@field IsResolved boolean		Returns true if the condition and all subconditions are resolved
---@field IsResolvedSelf boolean		Returns true if this condition has ended
---@field Amount integer		Get / Set the call amount
---@field CurrentAmount integer		Get the current call amount
---@field Context integer		Returns the template event data as a string for the UI
local IConditionEvent = {}
---@see CCondition parent class
---Satisfies this condition and all subconditions
---@param self rdgs.IConditionEvent
function IConditionEvent.SatisfyRecursiveNet(self) end
---@return boolean returns true if weak pointer holds a valid reference
function IConditionEvent.isValid() end
---@return boolean returns true if weak pointer holds a valid reference
function IConditionEvent.isValid() end

return IConditionEvent
