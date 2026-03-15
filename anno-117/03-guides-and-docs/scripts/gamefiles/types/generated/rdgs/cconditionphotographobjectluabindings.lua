---@meta rdgs.CConditionPhotographObject
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CConditionPhotographObject
---@field ConditionKey string		Returns a unique string identifier for this condition
---@field IsResolved boolean		Returns true if the condition and all subconditions are resolved
---@field IsResolvedSelf boolean		Returns true if this condition has ended
---@field Context integer		Returns the GUID of one photograph objects
local CConditionPhotographObject = {}
---@see CCondition parent class
---Satisfies this condition and all subconditions
---@param self rdgs.CConditionPhotographObject
function CConditionPhotographObject.SatisfyRecursiveNet(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CConditionPhotographObject.isValid() end
---@return boolean returns true if weak pointer holds a valid reference
function CConditionPhotographObject.isValid() end

return CConditionPhotographObject
