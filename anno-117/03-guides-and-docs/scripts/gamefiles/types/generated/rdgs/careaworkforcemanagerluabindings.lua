---@meta rdgs.CAreaWorkforceManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CAreaWorkforceManager
---@field Workforces rdgs.CTextSourceListValue[]		Returns the assets for all workforces on this island. Skips types which provides 0 workforce.
local CAreaWorkforceManager = {}
AreaWorkforce = CAreaWorkforceManager
IsWorkforceMissing = CAreaWorkforceManager
---@param self rdgs.CAreaWorkforceManager
---@param productGUID rdgs.ProductGUID
---@param delta number
function CAreaWorkforceManager.CheatAddDelta(self, productGUID , delta ) end
---@param self rdgs.CAreaWorkforceManager
---@param increase boolean
function CAreaWorkforceManager.CheatChangeWorkforce(self, increase ) end
---@param self rdgs.CAreaWorkforceManager
---@param productGUID rdgs.ProductGUID
---@param includeBuffs boolean
---@return number
function CAreaWorkforceManager.Delta(self, productGUID , includeBuffs ) end
---returns the amount of population on that area that is linked to the this specific workforce
---@param self rdgs.CAreaWorkforceManager
---@param workforceGUID integer
---@return number
function CAreaWorkforceManager.GetPopulationCount(self, workforceGUID ) end
---returns the result of current population count for this workforce * workforce conversion factor
---@param self rdgs.CAreaWorkforceManager
---@param workforceGUID integer
---@return number
function CAreaWorkforceManager.GetWorkforceResultingFromPopulation(self, workforceGUID ) end
---Returns the total registered production for a delta product. Returned value is positive.
---@param self rdgs.CAreaWorkforceManager
---@param productGUID rdgs.ProductGUID
---@return number
function CAreaWorkforceManager.RegisteredDeltaProduction(self, productGUID ) end
---@param self rdgs.CAreaWorkforceManager
---@param filterGUID integer
---@param productGUID rdgs.ProductGUID
---@return number
function CAreaWorkforceManager.RegisteredDeltaProduction(self, filterGUID , productGUID ) end
---Returns the total registered consumption for a delta product. Returned value is negative.
---@param self rdgs.CAreaWorkforceManager
---@param productGUID rdgs.ProductGUID
---@return number
function CAreaWorkforceManager.RegisteredDeltaConsumption(self, productGUID ) end
---returns the registered consumption for the give filterGuid and productGuid
---@param self rdgs.CAreaWorkforceManager
---@param filterGUID integer
---@param productGUID rdgs.ProductGUID
---@return number
function CAreaWorkforceManager.RegisteredDeltaConsumption(self, filterGUID , productGUID ) end
---@param self rdgs.CAreaWorkforceManager
---@param productGUID rdgs.ProductGUID
---@return number
function CAreaWorkforceManager.DeltaSaturation(self, productGUID ) end
---@param self rdgs.CAreaWorkforceManager
---@param productGUID rdgs.ProductGUID
---@return number
function CAreaWorkforceManager.DeltaSaturationUncapped(self, productGUID ) end
---@param self rdgs.CAreaWorkforceManager
---@param productGUID rdgs.ProductGUID
---@return rdgs.CTextSourceListValue[]
function CAreaWorkforceManager.GetPositiveWorkforceDeltaPerCategory(self, productGUID ) end
---@param self rdgs.CAreaWorkforceManager
---@param productGUID rdgs.ProductGUID
---@return rdgs.CTextSourceListValue[]
function CAreaWorkforceManager.GetNegativeWorkforceDeltaPerCategory(self, productGUID ) end
---Returns true if we have  0 workforce of this type
---@param workforce rdgs.ProductGUID
---@param areaIDInt integer
---@return boolean
function CAreaWorkforceManager.IsWorkforceMissing(workforce , areaIDInt ) end
---@param self rdgs.CAreaWorkforceManager
---@param workforceGUID rdgs.ProductGUID
---@return number
function CAreaWorkforceManager.GetBuffedDelta(self, workforceGUID ) end
---@return boolean returns true if weak pointer holds a valid reference
function CAreaWorkforceManager.isValid() end

return CAreaWorkforceManager
