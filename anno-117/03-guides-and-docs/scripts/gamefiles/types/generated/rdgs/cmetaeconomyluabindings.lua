---@meta rdgs.CMetaEconomy
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CMetaEconomy
---@field Knowledge number		
---@field Belief number		
---@field Prestige number		
---@field PrestigeText rdsdk.TextId		returns a configured text that represents the current prestige amount
local CMetaEconomy = {}
---@see CStorageNode parent class
---@param self rdgs.CMetaEconomy
---@param productGUID rdgs.ProductGUID
---@return rdgs.ProductAmount
function CMetaEconomy.GetStorageAmount(self, productGUID ) end
---@param self rdgs.CMetaEconomy
---@param productGUID rdgs.ProductGUID
---@return rdgs.ProductAmount
function CMetaEconomy.GetAvailableAmount(self, productGUID ) end
---@param self rdgs.CMetaEconomy
---@param productGUID rdgs.ProductGUID
---@return rdgs.ProductAmount
function CMetaEconomy.GetStorageCapacity(self, productGUID ) end
---@param self rdgs.CMetaEconomy
---@param productGUID rdgs.ProductGUID
---@return rdgs.ProductAmount
function CMetaEconomy.GetReservedStorageAmount(self, productGUID ) end
---@param self rdgs.CMetaEconomy
---@param productGUID integer
---@return integer
function CMetaEconomy.GetFreeSpace(self, productGUID ) end
---@param self rdgs.CMetaEconomy
---@param product integer
function CMetaEconomy.SelectStorageGoodDebug(self, product ) end
---@return boolean returns true if weak pointer holds a valid reference
function CMetaEconomy.isValid() end
---See CLogisticNode::CheatAddStorageAmount
---@param self rdgs.CMetaEconomy
---@param productGUID rdgs.ProductGUID
---@param amount rdgs.ProductAmount
function CMetaEconomy.AddAmount(self, productGUID , amount ) end
---See CLogisticNode::CheatAddStorageAmountAll
---@param self rdgs.CMetaEconomy
---@param amount rdgs.ProductAmount
function CMetaEconomy.AddAmount(self, amount ) end
---@return boolean returns true if weak pointer holds a valid reference
function CMetaEconomy.isValid() end

return CMetaEconomy
