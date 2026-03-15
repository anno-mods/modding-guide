---@meta rdgs.CShipModuleConfiguration
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CShipModuleConfiguration
---@field ShipGUID integer		
---@field ConfigurationName string		
---@field SlotCount integer		Returns the maximum amount of ship slots, including cargo and modular slots
---@field MaximumModificationCount integer		Returns the amount of modular slots, as in how many modules can this ship install
---@field CargoSlotCount integer		Returns the amount of cargo slots
---@field MaintenanceCosts rdgs.CProductAsset[]|nil		
---@field NavalMilitaryPoints integer		Returns the naval military strength
---@field ConstructionTime rdtime		
---@field ShipConfigurationStats rdgs.ShipConfigurationStats		
---@field ModuleGUIDs integer[]|nil		Returns guids of all installed modules
local CShipModuleConfiguration = {}
---Returns how many modules of the given module type \\param shipModuleType can be installed on the ship
---@param self rdgs.CShipModuleConfiguration
---@param shipModuleType datasets.ShipModuleType
---@return integer
function CShipModuleConfiguration.GetMaximumModuleCount(self, shipModuleType ) end
---Returns the current installed amount of modules with the type \\param shipModuleType
---@param self rdgs.CShipModuleConfiguration
---@param shipModuleType datasets.ShipModuleType
---@return integer
function CShipModuleConfiguration.GetCurrentModuleCount(self, shipModuleType ) end
---@return boolean returns true if weak pointer holds a valid reference
function CShipModuleConfiguration.isValid() end

return CShipModuleConfiguration
