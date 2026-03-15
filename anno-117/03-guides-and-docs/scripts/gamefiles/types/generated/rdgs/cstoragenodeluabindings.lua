---@meta rdgs.CStorageNode
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CStorageNode
local CStorageNode = {}
---@param self rdgs.CStorageNode
---@param productGUID rdgs.ProductGUID
---@return rdgs.ProductAmount
function CStorageNode.GetStorageAmount(self, productGUID ) end
---@param self rdgs.CStorageNode
---@param productGUID rdgs.ProductGUID
---@return rdgs.ProductAmount
function CStorageNode.GetAvailableAmount(self, productGUID ) end
---@param self rdgs.CStorageNode
---@param productGUID rdgs.ProductGUID
---@return rdgs.ProductAmount
function CStorageNode.GetStorageCapacity(self, productGUID ) end
---@param self rdgs.CStorageNode
---@param productGUID rdgs.ProductGUID
---@return rdgs.ProductAmount
function CStorageNode.GetReservedStorageAmount(self, productGUID ) end
---@param self rdgs.CStorageNode
---@param productGUID integer
---@return integer
function CStorageNode.GetFreeSpace(self, productGUID ) end
---@param self rdgs.CStorageNode
---@param product integer
function CStorageNode.SelectStorageGoodDebug(self, product ) end

return CStorageNode
