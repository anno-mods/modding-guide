---@meta rdgs.CAreaEconomy
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CAreaEconomy
---@field PopulationCount number		
---@field PopulationLevels rdgs.CPopulationAsset[]		Returns the assets for all settled population levels on this island. Skips populations with 0 residents.
local CAreaEconomy = {}
---@see CStorageNode parent class
---@param self rdgs.CAreaEconomy
---@param productGUID rdgs.ProductGUID
---@return rdgs.ProductAmount
function CAreaEconomy.GetStorageAmount(self, productGUID ) end
---@param self rdgs.CAreaEconomy
---@param productGUID rdgs.ProductGUID
---@return rdgs.ProductAmount
function CAreaEconomy.GetAvailableAmount(self, productGUID ) end
---@param self rdgs.CAreaEconomy
---@param productGUID rdgs.ProductGUID
---@return rdgs.ProductAmount
function CAreaEconomy.GetStorageCapacity(self, productGUID ) end
---@param self rdgs.CAreaEconomy
---@param productGUID rdgs.ProductGUID
---@return rdgs.ProductAmount
function CAreaEconomy.GetReservedStorageAmount(self, productGUID ) end
---@param self rdgs.CAreaEconomy
---@param productGUID integer
---@return integer
function CAreaEconomy.GetFreeSpace(self, productGUID ) end
---@param self rdgs.CAreaEconomy
---@param product integer
function CAreaEconomy.SelectStorageGoodDebug(self, product ) end
---@return boolean returns true if weak pointer holds a valid reference
function CAreaEconomy.isValid() end
---See CLogisticNode::CheatAddStorageAmount
---@param self rdgs.CAreaEconomy
---@param productGUID rdgs.ProductGUID
---@param amount rdgs.ProductAmount
function CAreaEconomy.AddAmount(self, productGUID , amount ) end
---See CLogisticNode::CheatAddStorageAmountAll
---@param self rdgs.CAreaEconomy
---@param amount rdgs.ProductAmount
function CAreaEconomy.AddAmount(self, amount ) end
---Population Count
---@param self rdgs.CAreaEconomy
---@param populationLevelGUID integer
---@return number
function CAreaEconomy.GetPopulationCount(self, populationLevelGUID ) end
---@param self rdgs.CAreaEconomy
---@param productGUID rdgs.ProductGUID
---@param populationLevelGUID integer
---@return boolean
function CAreaEconomy.GetIsDistributionPaused(self, productGUID , populationLevelGUID ) end
---@param self rdgs.CAreaEconomy
---@param populationGUID integer
---@return number
function CAreaEconomy.GetSatisfaction(self, populationGUID ) end
---@param self rdgs.CAreaEconomy
---@param populationGUID integer
---@param productGUID rdgs.ProductGUID
---@return number
function CAreaEconomy.GetSatisfaction(self, populationGUID , productGUID ) end
---Item Container
---@param self rdgs.CAreaEconomy
---@param guid integer
function CAreaEconomy.CheatItem(self, guid ) end
---@param self rdgs.CAreaEconomy
---@param productGUID rdgs.ProductGUID
---@return rdgs.ProductAmount
function CAreaEconomy.GetStorageTrend(self, productGUID ) end
---@return boolean returns true if weak pointer holds a valid reference
function CAreaEconomy.isValid() end

return CAreaEconomy
