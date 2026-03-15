---@meta rdgs.CConditionTechResearched
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CConditionTechResearched
---@field ConditionKey string		Returns a unique string identifier for this condition
---@field IsResolved boolean		Returns true if the condition and all subconditions are resolved
---@field IsResolvedSelf boolean		Returns true if this condition has ended
---@field TechGUID integer		
local CConditionTechResearched = {}
---@see CCondition parent class
---Satisfies this condition and all subconditions
---@param self rdgs.CConditionTechResearched
function CConditionTechResearched.SatisfyRecursiveNet(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CConditionTechResearched.isValid() end
---@return boolean returns true if weak pointer holds a valid reference
function CConditionTechResearched.isValid() end

return CConditionTechResearched
