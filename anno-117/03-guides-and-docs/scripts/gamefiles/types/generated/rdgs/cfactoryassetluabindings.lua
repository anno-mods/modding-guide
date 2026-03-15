---@meta rdgs.CFactoryAsset
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CFactoryAsset
---@field Guid integer		
---@field Icon string		
---@field Text string		
---@field HasProduction boolean		
---@field Production rdgs.CTextSourceListValue[]		
---@field HasConsumption boolean		
---@field Consumption rdgs.CTextSourceListValue[]		
---@field IsRecipeFactory boolean		
local CFactoryAsset = {}
GetFactoryAssetData = CFactoryAsset
---@see CAsset parent class
---@param guid integer
---@return rdgs.CAsset
function CFactoryAsset.AssetData(guid ) end
---@param guid integer
---@return rdgs.CFactoryAsset
function CFactoryAsset.GetFactoryAssetData(guid ) end

return CFactoryAsset
