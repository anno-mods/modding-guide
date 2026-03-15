---@meta rdgs.CPropertyMaintenance
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CPropertyMaintenance
---@field ConsumerPriority integer		Consumer Priority
---@field ToggleConsumerPriorityAlarm rdgs.AbstractMessageID		
---@field DeltaInputSaturation number		Returns the current workforce productivity of the lowest satisfied input
---@field HomeAreaName string		
local CPropertyMaintenance = {}
---@param self rdgs.CPropertyMaintenance
---@param productGUID integer
---@return integer
function CPropertyMaintenance.GetMaintenanceCost(self, productGUID ) end
---@param self rdgs.CPropertyMaintenance
---@param productGUID integer
---@return integer
function CPropertyMaintenance.GetAvailableMaintenance(self, productGUID ) end
---@param self rdgs.CPropertyMaintenance
---@param productGUID integer
---@return number
function CPropertyMaintenance.GetAvailableMaintenanceFloat(self, productGUID ) end
---@param self rdgs.CPropertyMaintenance
---@param productGUID integer
---@return integer
function CPropertyMaintenance.GetStaticMaintenanceCost(self, productGUID ) end
---Returns the current workforce productivity
---@param self rdgs.CPropertyMaintenance
---@param productGUID integer
---@return number
function CPropertyMaintenance.GetDeltaInputSaturation(self, productGUID ) end
---changes home area to nearest island (tradebuilding nearby or unit on island)
---@param self rdgs.CPropertyMaintenance
function CPropertyMaintenance.SetHomeAreaNet(self) end
---@param self rdgs.CPropertyMaintenance
---@param areaID rdgs.AreaID
function CPropertyMaintenance.SetHomeAreaNet(self, areaID ) end
---@return boolean returns true if weak pointer holds a valid reference
function CPropertyMaintenance.isValid() end

return CPropertyMaintenance
