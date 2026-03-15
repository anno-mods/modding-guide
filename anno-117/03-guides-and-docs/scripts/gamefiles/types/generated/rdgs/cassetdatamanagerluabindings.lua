---@meta rdgs.CAssetDataManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CAssetDataManager
local CAssetDataManager = {}
AssetDataManager = CAssetDataManager
---@param self rdgs.CAssetDataManager
---@param guid integer
function CAssetDataManager.TriggerScenarioTest(self, guid ) end
---@param self rdgs.CAssetDataManager
function CAssetDataManager.TriggerRevertScenarios(self) end
---@param self rdgs.CAssetDataManager
function CAssetDataManager.TriggerScenarioTest(self) end
---@param self rdgs.CAssetDataManager
---@param guid integer
function CAssetDataManager.AddToFilter(self, guid ) end
---@param self rdgs.CAssetDataManager
function CAssetDataManager.ExecuteFilter(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CAssetDataManager.isValid() end

return CAssetDataManager
