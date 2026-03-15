---@meta rdgs.CConditionIslandsWithFertility
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CConditionIslandsWithFertility
---@field ConditionKey string		Returns a unique string identifier for this condition
---@field IsResolved boolean		Returns true if the condition and all subconditions are resolved
---@field IsResolvedSelf boolean		Returns true if this condition has ended
---@field CurrentAmount integer		
---@field Amount integer		
---@field Context integer		
local CConditionIslandsWithFertility = {}
---@see CCondition parent class
---Satisfies this condition and all subconditions
---@param self rdgs.CConditionIslandsWithFertility
function CConditionIslandsWithFertility.SatisfyRecursiveNet(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CConditionIslandsWithFertility.isValid() end
---@return boolean returns true if weak pointer holds a valid reference
function CConditionIslandsWithFertility.isValid() end

return CConditionIslandsWithFertility
