---@meta rdgs.CConditionQuestFollowShip
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CConditionQuestFollowShip
---@field ConditionKey string		Returns a unique string identifier for this condition
---@field IsResolved boolean		Returns true if the condition and all subconditions are resolved
---@field IsResolvedSelf boolean		Returns true if this condition has ended
---@field WarningCountdown rdtime		Returns the time left until the quest fails
local CConditionQuestFollowShip = {}
---@see CCondition parent class
---Satisfies this condition and all subconditions
---@param self rdgs.CConditionQuestFollowShip
function CConditionQuestFollowShip.SatisfyRecursiveNet(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CConditionQuestFollowShip.isValid() end
---Starts the actual escort
---@param self rdgs.CConditionQuestFollowShip
function CConditionQuestFollowShip.ActivateFollowShipNet(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CConditionQuestFollowShip.isValid() end

return CConditionQuestFollowShip
