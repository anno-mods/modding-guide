---@meta rdgs.CConditionQuestEvacuate
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CConditionQuestEvacuate
---@field ConditionKey string		Returns a unique string identifier for this condition
---@field IsResolved boolean		Returns true if the condition and all subconditions are resolved
---@field IsResolvedSelf boolean		Returns true if this condition has ended
---@field Amount integer		Get the desired amount of needed evacuations
---@field CurrentAmount integer		Get the current amount of evacuated buildings
local CConditionQuestEvacuate = {}
---@see CCondition parent class
---Satisfies this condition and all subconditions
---@param self rdgs.CConditionQuestEvacuate
function CConditionQuestEvacuate.SatisfyRecursiveNet(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CConditionQuestEvacuate.isValid() end
---@return boolean returns true if weak pointer holds a valid reference
function CConditionQuestEvacuate.isValid() end

return CConditionQuestEvacuate
