---@meta rdgs.ShipModuleConfiguration
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.ShipModuleConfiguration
---@field MaximumCapacity integer		
---@field MaximumModificationCount integer		
---@field MaintenanceCosts std.pair[]		
---@field ConstructionTime rdtime		
local ShipModuleConfiguration = {}
---@param self rdgs.ShipModuleConfiguration
---@param shipModuleType datasets.ShipModuleType
---@return integer
function ShipModuleConfiguration.GetMaximumModuleCount(self, shipModuleType ) end
---@param self rdgs.ShipModuleConfiguration
---@param shipModuleType datasets.ShipModuleType
---@return integer
function ShipModuleConfiguration.GetCurrentModuleCount(self, shipModuleType ) end
---@param self rdgs.ShipModuleConfiguration
---@param buildCostMode CBuildCost.CostPaymentMode
---@return rdgs.CBuildCost
function ShipModuleConfiguration.GetBuildCosts(self, buildCostMode ) end
---@param self rdgs.ShipModuleConfiguration
---@return rdgs.CBuildCost
function ShipModuleConfiguration.GetBuildCosts(self) end

return ShipModuleConfiguration
