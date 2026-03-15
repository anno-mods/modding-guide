---@meta rdgs.CConditionQuestEscort
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CConditionQuestEscort
---@field ConditionKey string		Returns a unique string identifier for this condition
---@field IsResolved boolean		Returns true if the condition and all subconditions are resolved
---@field IsResolvedSelf boolean		Returns true if this condition has ended
---@field Survivors integer		Returns the number of survivors needed to fulfill this quest
---@field CurrentSurvivors integer		Returns the current number of survivors
---@field EscortTarget integer		Returns the guid of the move target object of the escort objects
---@field Context string		Returns the current number of survivors
local CConditionQuestEscort = {}
---@see CCondition parent class
---Satisfies this condition and all subconditions
---@param self rdgs.CConditionQuestEscort
function CConditionQuestEscort.SatisfyRecursiveNet(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CConditionQuestEscort.isValid() end
---Starts the actual escort
---@param self rdgs.CConditionQuestEscort
function CConditionQuestEscort.ActivateEscortNet(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CConditionQuestEscort.isValid() end

return CConditionQuestEscort
