---@meta rdgs.CRenovatabilityChecker
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CRenovatabilityChecker
---@field IsRenovatable boolean		
---@field Costs rdgs.CBuildCost		
---@field Reasons rdgs.CNotRenovatableContext[]		
local CRenovatabilityChecker = {}
---@return boolean returns true if weak pointer holds a valid reference
function CRenovatabilityChecker.isValid() end

return CRenovatabilityChecker
