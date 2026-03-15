---@meta rdgs.CConditionItemActionCompleted
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CConditionItemActionCompleted
---@field ConditionKey string		Returns a unique string identifier for this condition
---@field IsResolved boolean		Returns true if the condition and all subconditions are resolved
---@field IsResolvedSelf boolean		Returns true if this condition has ended
---@field Context string		Get the name of the item to use
local CConditionItemActionCompleted = {}
---@see CCondition parent class
---Satisfies this condition and all subconditions
---@param self rdgs.CConditionItemActionCompleted
function CConditionItemActionCompleted.SatisfyRecursiveNet(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CConditionItemActionCompleted.isValid() end
---@return boolean returns true if weak pointer holds a valid reference
function CConditionItemActionCompleted.isValid() end

return CConditionItemActionCompleted
