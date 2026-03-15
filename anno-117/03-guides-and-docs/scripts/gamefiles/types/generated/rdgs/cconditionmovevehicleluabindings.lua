---@meta rdgs.CConditionMoveVehicle
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CConditionMoveVehicle
---@field ConditionKey string		Returns a unique string identifier for this condition
---@field IsResolved boolean		Returns true if the condition and all subconditions are resolved
---@field IsResolvedSelf boolean		Returns true if this condition has ended
---@field TargetShip integer		Get GUID of first Vehicle
local CConditionMoveVehicle = {}
---@see CCondition parent class
---Satisfies this condition and all subconditions
---@param self rdgs.CConditionMoveVehicle
function CConditionMoveVehicle.SatisfyRecursiveNet(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CConditionMoveVehicle.isValid() end
---@return boolean returns true if weak pointer holds a valid reference
function CConditionMoveVehicle.isValid() end

return CConditionMoveVehicle
