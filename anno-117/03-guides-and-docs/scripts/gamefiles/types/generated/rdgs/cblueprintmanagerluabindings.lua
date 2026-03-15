---@meta rdgs.CBlueprintManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CBlueprintManager
---@field UpgradeCostSelectedMainBuildingOnly rdgs.CBuildCost		
---@field UpgradeCostPickedMainBuildingOnly rdgs.CBuildCost		
---@field UpgradeCostSelected rdgs.CBuildCost		
---@field UpgradeCostPicked rdgs.CBuildCost		
---@field UpgradeCanBeBuiltSelected boolean		
---@field UpgradeCanBeBuiltPicked boolean		
---@field UpgradeCantBeBuiltBecauseOfAdjacencySelected boolean		
---@field UpgradeCantBeBuiltBecauseOfAdjacencyPicked boolean		
local CBlueprintManager = {}
Blueprint = CBlueprintManager
---@return boolean returns true if weak pointer holds a valid reference
function CBlueprintManager.isValid() end

return CBlueprintManager
