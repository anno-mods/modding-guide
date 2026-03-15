---@meta rdgs.CPropertyModuleOwner
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CPropertyModuleOwner
---@field ModuleLimit integer		returns count of unlocked building module slots
---@field MainModuleLimit integer		
---@field HasFertilizerModule boolean		
---@field FertilizerModule rdgs.CGameObject		
---@field HasAdditionalModule boolean		
---@field AdditionalModule rdgs.CGameObject		
---@field ModuleCount integer		this only includes working modules
---@field VillaModuleCount integer		
---@field AmountIrrigatedModules integer		
---@field AmountIrrigatedModules_CapAtLimit integer		
---@field AmountNotIrrigatedModules integer		
---@field ModuleCountIncludeNonWorking integer		
---@field ModuleCountIncludeNonWorking_CapAtLimit integer		
---@field CosmeticModuleCountIncludingPreview integer		
---@field CosmeticModuleLimit integer		
---@field HasNonIrrigatedModulesBelowLimit boolean		
---@field ModuleCountIncludingPreview integer		returns count of built building modules, only working ones (not irrigated tiles are considered)
---@field ModuleCountIncludingPreviewExcludingNonWorking integer		
---@field DefaultModuleGUID integer		
---@field RemainingVillaBuildRights integer		
local CPropertyModuleOwner = {}
---also counts blueprints and not working modules
---@param self rdgs.CPropertyModuleOwner
---@param guid integer
---@param excludeBlueprints boolean
---@return integer
function CPropertyModuleOwner.GetModuleCountForGUID(self, guid , excludeBlueprints ) end
---also counts blueprints and not working modules
---@param self rdgs.CPropertyModuleOwner
---@param guid integer
---@return integer
function CPropertyModuleOwner.GetModuleCountForGUID(self, guid ) end
---@param self rdgs.CPropertyModuleOwner
---@param guid integer
---@return integer
function CPropertyModuleOwner.GetModuleLimitForGUID(self, guid ) end
---@param self rdgs.CPropertyModuleOwner
---@param includeBlueprints boolean
---@return integer
function CPropertyModuleOwner.GetModuleCountBP(self, includeBlueprints ) end
---@param self rdgs.CPropertyModuleOwner
---@param moduleGuid integer
---@return integer
function CPropertyModuleOwner.RemainingBuildRights(self, moduleGuid ) end
---@return boolean returns true if weak pointer holds a valid reference
function CPropertyModuleOwner.isValid() end

return CPropertyModuleOwner
