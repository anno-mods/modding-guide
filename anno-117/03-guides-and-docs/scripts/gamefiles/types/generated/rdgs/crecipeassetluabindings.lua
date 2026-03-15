---@meta rdgs.CRecipeAsset
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CRecipeAsset
---@field Guid integer		
---@field Icon string		
---@field Text string		
---@field HasUnlockConditionFluffUnlockText boolean		Returns true, if the special fluff condition texts should be displayed for the given recipe
---@field UnlockConditionFluffText rdgs.CAsset		Returns the Asset that contains the set up unlock condition fluff text
local CRecipeAsset = {}
GetRecipeAssetData = CRecipeAsset
---@see CAsset parent class
---@param guid integer
---@return rdgs.CAsset
function CRecipeAsset.AssetData(guid ) end
---@param guid integer
---@return rdgs.CRecipeAsset
function CRecipeAsset.GetRecipeAssetData(guid ) end

return CRecipeAsset
