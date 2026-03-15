---@meta rdgs.CConditionObjectSelected
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CConditionObjectSelected
---@field ConditionKey string		Returns a unique string identifier for this condition
---@field IsResolved boolean		Returns true if the condition and all subconditions are resolved
---@field IsResolvedSelf boolean		Returns true if this condition has ended
---@field Object integer		Get a GUID based on the current objectGUID or any objectID
local CConditionObjectSelected = {}
---@see CCondition parent class
---Satisfies this condition and all subconditions
---@param self rdgs.CConditionObjectSelected
function CConditionObjectSelected.SatisfyRecursiveNet(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CConditionObjectSelected.isValid() end
---@return boolean returns true if weak pointer holds a valid reference
function CConditionObjectSelected.isValid() end

return CConditionObjectSelected
