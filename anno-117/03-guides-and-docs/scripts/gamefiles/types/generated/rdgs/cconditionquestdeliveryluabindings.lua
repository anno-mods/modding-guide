---@meta rdgs.CConditionQuestDelivery
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CConditionQuestDelivery
---@field ConditionKey string		Returns a unique string identifier for this condition
---@field IsResolved boolean		Returns true if the condition and all subconditions are resolved
---@field IsResolvedSelf boolean		Returns true if this condition has ended
---@field DeliveryObjects rdgs.DemandedGood[]		Returns a list of all goods to be delivered
local CConditionQuestDelivery = {}
---@see CCondition parent class
---Satisfies this condition and all subconditions
---@param self rdgs.CConditionQuestDelivery
function CConditionQuestDelivery.SatisfyRecursiveNet(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CConditionQuestDelivery.isValid() end
---Tries to finish the quest. Only works if unit with goods is in range, used to confirm to finish this objective
---@param self rdgs.CConditionQuestDelivery
function CConditionQuestDelivery.TryComplete(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CConditionQuestDelivery.isValid() end

return CConditionQuestDelivery
