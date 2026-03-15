---@meta rdgs.CPropertyWarehouse
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CPropertyWarehouse
---@field StorageBonus integer		Returns the storage bonus this building provides. BasicIslandStorage is included on kontors
---@field StrategicGood integer		Returns the storable good if there is only one (coal/oil harbour)
---@field StorageBonusInclModules integer		Returns the storage bonus this building provides including its modules. BasicIslandStorage is included on kontors
local CPropertyWarehouse = {}
---Returns the difference between this buildings storage and the total island storage capacity
---@param self rdgs.CPropertyWarehouse
---@param includeModules boolean
---@return integer
function CPropertyWarehouse.GetStorageDifferenceToIslandStorage(self, includeModules ) end
---@return boolean returns true if weak pointer holds a valid reference
function CPropertyWarehouse.isValid() end

return CPropertyWarehouse
