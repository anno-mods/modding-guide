---@meta rdgs.CTextSourceUnlockDataEntry
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CTextSourceUnlockDataEntry
---@field Guid integer		
---@field Icon string		
---@field Text string		
---@field HasOperatorAnd boolean		
---@field HasOperatorOr boolean		
---@field CurrentAmount integer		
---@field TargetAmount integer		
---@field TechGUID integer		
---@field CityStatusGUID integer		
local CTextSourceUnlockDataEntry = {}
---@see CAsset parent class
---@param guid integer
---@return rdgs.CAsset
function CTextSourceUnlockDataEntry.AssetData(guid ) end

return CTextSourceUnlockDataEntry
