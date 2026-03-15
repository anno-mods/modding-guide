---@meta rdgs.CPropertyLogisticNode
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CPropertyLogisticNode
---@field LoadingSpeedWorkforceFactor number		returns a workforce factor that is applied to the loading speed
---@field TransporterQueue rdgs.CTransporterQueue|nil		
local CPropertyLogisticNode = {}
---@see CStorageNode parent class
---@param self rdgs.CPropertyLogisticNode
---@param productGUID rdgs.ProductGUID
---@return rdgs.ProductAmount
function CPropertyLogisticNode.GetStorageAmount(self, productGUID ) end
---@param self rdgs.CPropertyLogisticNode
---@param productGUID rdgs.ProductGUID
---@return rdgs.ProductAmount
function CPropertyLogisticNode.GetAvailableAmount(self, productGUID ) end
---@param self rdgs.CPropertyLogisticNode
---@param productGUID rdgs.ProductGUID
---@return rdgs.ProductAmount
function CPropertyLogisticNode.GetStorageCapacity(self, productGUID ) end
---@param self rdgs.CPropertyLogisticNode
---@param productGUID rdgs.ProductGUID
---@return rdgs.ProductAmount
function CPropertyLogisticNode.GetReservedStorageAmount(self, productGUID ) end
---@param self rdgs.CPropertyLogisticNode
---@param productGUID integer
---@return integer
function CPropertyLogisticNode.GetFreeSpace(self, productGUID ) end
---@param self rdgs.CPropertyLogisticNode
---@param product integer
function CPropertyLogisticNode.SelectStorageGoodDebug(self, product ) end
---@return boolean returns true if weak pointer holds a valid reference
function CPropertyLogisticNode.isValid() end
---@param self rdgs.CPropertyLogisticNode
---@param transporterType integer
---@return integer
function CPropertyLogisticNode.GetCurrentTransporterCount(self, transporterType ) end
---@param self rdgs.CPropertyLogisticNode
---@param transporterType integer
---@return integer
function CPropertyLogisticNode.GetMaxTransporterCount(self, transporterType ) end
---@param self rdgs.CPropertyLogisticNode
---@param transporterType integer
---@return integer
function CPropertyLogisticNode.GetAvailableTransporterCount(self, transporterType ) end
---returns the current transporter speed in tons / second
---@param self rdgs.CPropertyLogisticNode
---@param considerWorkforceFactor boolean
---@return number
function CPropertyLogisticNode.GetTransporterLoadingSpeed(self, considerWorkforceFactor ) end
---@return boolean returns true if weak pointer holds a valid reference
function CPropertyLogisticNode.isValid() end

return CPropertyLogisticNode
