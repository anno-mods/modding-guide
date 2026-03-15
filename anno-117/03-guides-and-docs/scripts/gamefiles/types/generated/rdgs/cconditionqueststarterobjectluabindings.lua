---@meta rdgs.CConditionQuestStarterObject
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CConditionQuestStarterObject
---@field ConditionKey string		Returns a unique string identifier for this condition
---@field IsResolved boolean		Returns true if the condition and all subconditions are resolved
---@field IsResolvedSelf boolean		Returns true if this condition has ended
---@field Object integer		Gets the first guid from the starter objects
local CConditionQuestStarterObject = {}
---@see CCondition parent class
---Satisfies this condition and all subconditions
---@param self rdgs.CConditionQuestStarterObject
function CConditionQuestStarterObject.SatisfyRecursiveNet(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CConditionQuestStarterObject.isValid() end
---@return boolean returns true if weak pointer holds a valid reference
function CConditionQuestStarterObject.isValid() end

return CConditionQuestStarterObject
