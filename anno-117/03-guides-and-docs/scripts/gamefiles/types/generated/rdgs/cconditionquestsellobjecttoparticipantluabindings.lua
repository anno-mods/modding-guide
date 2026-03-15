---@meta rdgs.CConditionQuestSellObjectToParticipant
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CConditionQuestSellObjectToParticipant
---@field ConditionKey string		Returns a unique string identifier for this condition
---@field IsResolved boolean		Returns true if the condition and all subconditions are resolved
---@field IsResolvedSelf boolean		Returns true if this condition has ended
---@field Amount integer		Get the desired amount
---@field CurrentAmount integer		Get the current amount
---@field ShipHull integer		Get the ship hull
---@field FirstModule integer		Get first needed module
---@field TargetParticipant integer		Get the participant which the object needs to be sold to
local CConditionQuestSellObjectToParticipant = {}
---@see CCondition parent class
---Satisfies this condition and all subconditions
---@param self rdgs.CConditionQuestSellObjectToParticipant
function CConditionQuestSellObjectToParticipant.SatisfyRecursiveNet(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CConditionQuestSellObjectToParticipant.isValid() end
---@return boolean returns true if weak pointer holds a valid reference
function CConditionQuestSellObjectToParticipant.isValid() end

return CConditionQuestSellObjectToParticipant
