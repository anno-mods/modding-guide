---@meta rdgs.CConditionQuestGoTo
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CConditionQuestGoTo
---@field ConditionKey string		Returns a unique string identifier for this condition
---@field IsResolved boolean		Returns true if the condition and all subconditions are resolved
---@field IsResolvedSelf boolean		Returns true if this condition has ended
local CConditionQuestGoTo = {}
---@see CCondition parent class
---Satisfies this condition and all subconditions
---@param self rdgs.CConditionQuestGoTo
function CConditionQuestGoTo.SatisfyRecursiveNet(self) end
---Tries to finish the quest. Only works if unit is in range, used to confirm to finish this objective
---@param self rdgs.CConditionQuestGoTo
function CConditionQuestGoTo.TryComplete(self) end

return CConditionQuestGoTo
