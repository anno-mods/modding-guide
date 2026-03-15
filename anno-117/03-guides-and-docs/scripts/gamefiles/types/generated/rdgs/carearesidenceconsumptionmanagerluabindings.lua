---@meta rdgs.CAreaResidenceConsumptionManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CAreaResidenceConsumptionManager
local CAreaResidenceConsumptionManager = {}
AreaResidenceConsumption = CAreaResidenceConsumptionManager
---@param self rdgs.CAreaResidenceConsumptionManager
---@param productGUID rdgs.ProductGUID
---@param populationLevelGUID integer
---@return boolean
function CAreaResidenceConsumptionManager.GetIsDistributionPaused(self, productGUID , populationLevelGUID ) end
---@return boolean returns true if weak pointer holds a valid reference
function CAreaResidenceConsumptionManager.isValid() end

return CAreaResidenceConsumptionManager
