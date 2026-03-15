---@meta rdgs.CConditionGoodsInRange
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CConditionGoodsInRange
---@field ConditionKey string		Returns a unique string identifier for this condition
---@field IsResolved boolean		Returns true if the condition and all subconditions are resolved
---@field IsResolvedSelf boolean		Returns true if this condition has ended
---@field CurrentDeliveryObject integer		Get the delivery object of the current internal objective
---@field ExecutionObject integer		Get the execution object
local CConditionGoodsInRange = {}
---@see CCondition parent class
---Satisfies this condition and all subconditions
---@param self rdgs.CConditionGoodsInRange
function CConditionGoodsInRange.SatisfyRecursiveNet(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CConditionGoodsInRange.isValid() end
---Get the delivery object
---@param self rdgs.CConditionGoodsInRange
---@param objectIndex integer
---@return integer
function CConditionGoodsInRange.GetAmount(self, objectIndex ) end
---Get the delivery object
---@param self rdgs.CConditionGoodsInRange
---@param objectIndex integer
---@return integer
function CConditionGoodsInRange.GetDeliveryObject(self, objectIndex ) end
---Get the objective text for the quest tracker
---@param self rdgs.CConditionGoodsInRange
---@param objectiveIndex integer
---@return string
function CConditionGoodsInRange.GetObjectiveText(self, objectiveIndex ) end
---@return boolean returns true if weak pointer holds a valid reference
function CConditionGoodsInRange.isValid() end

return CConditionGoodsInRange
