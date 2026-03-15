---@meta rdgs.VirtualSpaceWarehouse
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.VirtualSpaceWarehouse
local VirtualSpaceWarehouse = {}
Static.GetStorageIncreaseToPreviousTier = VirtualSpaceWarehouse
Static.GetStorageBonus = VirtualSpaceWarehouse
Static.GetStrategicGood = VirtualSpaceWarehouse
---Returns the base storage increase in comparison to the previous warehouse tier
---@param guid integer
---@return integer
function VirtualSpaceWarehouse.GetStorageIncreaseToPreviousTier(guid ) end
---@param guid integer
---@return integer
function VirtualSpaceWarehouse.GetStorageBonus(guid ) end
---@param buildingGUID integer
---@return integer
function VirtualSpaceWarehouse.GetStrategicGood(buildingGUID ) end

return VirtualSpaceWarehouse
