---@meta rdgs.CProductAsset
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CProductAsset
---@field Guid integer		
---@field Icon string		
---@field Text string		
---@field IsWorkforce boolean		
---@field IsAbstract boolean		
---@field IsValid boolean		
---@field Amount integer		Has to be filled by code. Not filled when static accessed
---@field AmountPrecise number		Has to be filled by code. Not filled when static accessed
---@field AvailableAmount number		Has to be filled by code. Not filled when static accessed
---@field Available boolean		Invalid when static accessed
---@field AllowedInCurrentRegion boolean		Returns true if this product is associated with the current region
---@field ProducingRegions rdgs.CTextSourceListValue[]		Returns a list of region guid in which the product can be produced (based on ProductionRegions config in T1)
---@field CanBeProducedInCurrentRegion boolean		Returns if a good can be produced in the current region
---@field HasObtainHint boolean		
---@field ObtainHint rdsdk.TextId		
local CProductAsset = {}
GetProductAssetData = CProductAsset
IsProduct = CProductAsset
---@see CAsset parent class
---@param guid integer
---@return rdgs.CAsset
function CProductAsset.AssetData(guid ) end
---@param guid integer
---@return rdgs.CProductAsset
function CProductAsset.GetProductAssetData(guid ) end
---@param guid integer
---@return boolean
function CProductAsset.IsProduct(guid ) end
---Returns if a good can be produced in the given region
---@param self rdgs.CProductAsset
---@param regionIndex integer
---@return boolean
function CProductAsset.CanBeProducedInRegion(self, regionIndex ) end

return CProductAsset
