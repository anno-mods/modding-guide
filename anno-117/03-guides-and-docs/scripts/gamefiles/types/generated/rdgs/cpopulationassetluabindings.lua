---@meta rdgs.CPopulationAsset
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CPopulationAsset
---@field Guid integer		
---@field Icon string		
---@field Text string		
---@field Workforce rdgs.CAsset		
local CPopulationAsset = {}
GetPopulationAssetData = CPopulationAsset
---@see CAsset parent class
---@param guid integer
---@return rdgs.CAsset
function CPopulationAsset.AssetData(guid ) end
---@param guid integer
---@return rdgs.CPopulationAsset
function CPopulationAsset.GetPopulationAssetData(guid ) end

return CPopulationAsset
