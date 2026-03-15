---@meta rdgs.CLimitedLodeComponent
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CLimitedLodeComponent
---@field LimitedLodeFertilityGuids integer[]		
local CLimitedLodeComponent = {}
---@param self rdgs.CLimitedLodeComponent
---@param guid integer
---@return boolean
function CLimitedLodeComponent.HasLimitedLodeFertilityGuid(self, guid ) end
---@param self rdgs.CLimitedLodeComponent
---@param fertilityGuid integer
---@return integer
function CLimitedLodeComponent.GetCurrentLimitedLodeAmount(self, fertilityGuid ) end
---@param self rdgs.CLimitedLodeComponent
---@param fertilityGuid integer
---@return integer
function CLimitedLodeComponent.GetMaximumLimitedLodeAmount(self, fertilityGuid ) end

return CLimitedLodeComponent
