---@meta rdgs.CAchievementAsset
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CAchievementAsset
---@field Guid integer		
---@field Icon string		
---@field Text string		
---@field Title string		
local CAchievementAsset = {}
GetAchievementAssetData = CAchievementAsset
---@see CAsset parent class
---@param guid integer
---@return rdgs.CAsset
function CAchievementAsset.AssetData(guid ) end
---@param guid integer
---@return rdgs.CAchievementAsset
function CAchievementAsset.GetAchievementAssetData(guid ) end

return CAchievementAsset
