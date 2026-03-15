---@meta rdgs.CUpgradabilityChecker
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CUpgradabilityChecker
---@field IsUpgradable boolean		
---@field UpgradeCosts rdgs.CBuildCost		Returns the total costs for the upgrades
---@field Reasons rdgs.CNotUpgradableContext[]		Returns the reasons and values why the building cannot be upgraded
---@field UpgradeTargetGUID integer		Returns the target upgrade guid
---@field IsTargetRegional boolean		
local CUpgradabilityChecker = {}
---@return boolean returns true if weak pointer holds a valid reference
function CUpgradabilityChecker.isValid() end

return CUpgradabilityChecker
