---@meta rdgs.CConditionInStorage
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CConditionInStorage
---@field ConditionKey string		Returns a unique string identifier for this condition
---@field IsResolved boolean		Returns true if the condition and all subconditions are resolved
---@field IsResolvedSelf boolean		Returns true if this condition has ended
---@field Context integer		Get the guid of the current object
---@field CurrentAmount integer		
---@field Amount integer		
local CConditionInStorage = {}
---@see CCondition parent class
---Satisfies this condition and all subconditions
---@param self rdgs.CConditionInStorage
function CConditionInStorage.SatisfyRecursiveNet(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CConditionInStorage.isValid() end
---@return boolean returns true if weak pointer holds a valid reference
function CConditionInStorage.isValid() end

return CConditionInStorage
