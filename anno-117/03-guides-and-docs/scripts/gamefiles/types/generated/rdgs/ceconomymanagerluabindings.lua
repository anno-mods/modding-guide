---@meta rdgs.CEconomyManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CEconomyManager
---@field MetaStorage rdgs.CMetaEconomy		
local CEconomyManager = {}
Economy = CEconomyManager
---@param self rdgs.CEconomyManager
---@param productGUID rdgs.ProductGUID
---@return number
function CEconomyManager.GetRegisteredDeltaProduction(self, productGUID ) end
---@param self rdgs.CEconomyManager
---@param filterGUID integer
---@param productGUID rdgs.ProductGUID
---@return number
function CEconomyManager.GetRegisteredDeltaProduction(self, filterGUID , productGUID ) end
---@param self rdgs.CEconomyManager
---@param productGUID rdgs.ProductGUID
---@return number
function CEconomyManager.GetRegisteredDeltaConsumption(self, productGUID ) end
---@param self rdgs.CEconomyManager
---@param filterGUID integer
---@param productGUID rdgs.ProductGUID
---@return number
function CEconomyManager.GetRegisteredDeltaConsumption(self, filterGUID , productGUID ) end
---@return boolean returns true if weak pointer holds a valid reference
function CEconomyManager.isValid() end

return CEconomyManager
