---@meta rdgs.CConditionQuestStatusQuo
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CConditionQuestStatusQuo
---@field ConditionKey string		Returns a unique string identifier for this condition
---@field IsResolved boolean		Returns true if the condition and all subconditions are resolved
---@field IsResolvedSelf boolean		Returns true if this condition has ended
---@field Context integer		Get / Set context GUID
local CConditionQuestStatusQuo = {}
---@see CCondition parent class
---Satisfies this condition and all subconditions
---@param self rdgs.CConditionQuestStatusQuo
function CConditionQuestStatusQuo.SatisfyRecursiveNet(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CConditionQuestStatusQuo.isValid() end
---@return boolean returns true if weak pointer holds a valid reference
function CConditionQuestStatusQuo.isValid() end

return CConditionQuestStatusQuo
