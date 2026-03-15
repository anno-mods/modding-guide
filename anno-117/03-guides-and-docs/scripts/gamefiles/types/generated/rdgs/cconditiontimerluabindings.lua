---@meta rdgs.CConditionTimer
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CConditionTimer
---@field ConditionKey string		Returns a unique string identifier for this condition
---@field IsResolved boolean		Returns true if the condition and all subconditions are resolved
---@field IsResolvedSelf boolean		Returns true if this condition has ended
---@field TimeLimit rdtime		\\see CConditionTimerBase::GetTimeLimit
local CConditionTimer = {}
---@see CCondition parent class
---Satisfies this condition and all subconditions
---@param self rdgs.CConditionTimer
function CConditionTimer.SatisfyRecursiveNet(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CConditionTimer.isValid() end
---@return boolean returns true if weak pointer holds a valid reference
function CConditionTimer.isValid() end

return CConditionTimer
