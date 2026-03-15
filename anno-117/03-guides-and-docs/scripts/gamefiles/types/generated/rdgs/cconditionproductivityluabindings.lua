---@meta rdgs.CConditionProductivity
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CConditionProductivity
---@field ConditionKey string		Returns a unique string identifier for this condition
---@field IsResolved boolean		Returns true if the condition and all subconditions are resolved
---@field IsResolvedSelf boolean		Returns true if this condition has ended
---@field Good integer		\\see CConditionProductivityBase::GetGood_CP
---@field ProductivityRequired number		\\see CConditionProductivityBase::GetProductivityRequired
---@field ProductionRequired number		\\see CConditionProductivityBase::GetProductionRequired
---@field Productivity number		Returns the last calculated productivity value
local CConditionProductivity = {}
---@see CCondition parent class
---Satisfies this condition and all subconditions
---@param self rdgs.CConditionProductivity
function CConditionProductivity.SatisfyRecursiveNet(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CConditionProductivity.isValid() end
---@return boolean returns true if weak pointer holds a valid reference
function CConditionProductivity.isValid() end

return CConditionProductivity
