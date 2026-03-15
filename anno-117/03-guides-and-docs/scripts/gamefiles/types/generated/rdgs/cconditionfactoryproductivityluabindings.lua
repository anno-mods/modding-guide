---@meta rdgs.CConditionFactoryProductivity
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CConditionFactoryProductivity
---@field ConditionKey string		Returns a unique string identifier for this condition
---@field IsResolved boolean		Returns true if the condition and all subconditions are resolved
---@field IsResolvedSelf boolean		Returns true if this condition has ended
---@field CurrentAmount rdgs.StatsValue		
---@field Amount rdgs.StatsValue		
---@field Context integer		
local CConditionFactoryProductivity = {}
---@see CCondition parent class
---Satisfies this condition and all subconditions
---@param self rdgs.CConditionFactoryProductivity
function CConditionFactoryProductivity.SatisfyRecursiveNet(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CConditionFactoryProductivity.isValid() end
---@return boolean returns true if weak pointer holds a valid reference
function CConditionFactoryProductivity.isValid() end

return CConditionFactoryProductivity
