---@meta rdgs.CProductionStatistics
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CProductionStatistics
local CProductionStatistics = {}
---Returns the product generation per minute for the given product
---@param self rdgs.CProductionStatistics
---@param productGuid integer
---@return integer
function CProductionStatistics.ProductGeneration(self, productGuid ) end
---Returns the product consumption per minute for the given product
---@param self rdgs.CProductionStatistics
---@param productGuid integer
---@return integer
function CProductionStatistics.ProductConsumption(self, productGuid ) end
---Returns the product delta (production - consumption) per minute for the given product
---@param self rdgs.CProductionStatistics
---@param productGuid integer
---@return integer
function CProductionStatistics.ProductDelta(self, productGuid ) end
---Returns the potential product generation per minute for the given product
---@param self rdgs.CProductionStatistics
---@param productGuid integer
---@return integer
function CProductionStatistics.PerfectProductGeneration(self, productGuid ) end
---Returns the potential product consumption per minute for the given product
---@param self rdgs.CProductionStatistics
---@param productGuid integer
---@return integer
function CProductionStatistics.PerfectProductConsumption(self, productGuid ) end

return CProductionStatistics
