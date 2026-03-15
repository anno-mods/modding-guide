---@meta rdgs.CTextSourceUtility
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CTextSourceUtility
local CTextSourceUtility = {}
GetAssetForValue = CTextSourceUtility
And = CTextSourceUtility
Not = CTextSourceUtility
Greater = CTextSourceUtility
GreaterThanZero = CTextSourceUtility
---Utility
---@param mappingGUID integer
---@param value number
---@return rdgs.CAsset
function CTextSourceUtility.GetAssetForValue(mappingGUID , value ) end
---@param value1 boolean
---@param value2 boolean
---@return boolean
function CTextSourceUtility.And(value1 , value2 ) end
---@param value boolean
---@return boolean
function CTextSourceUtility.Not(value ) end
---@param greater number
---@param smaller number
---@return boolean
function CTextSourceUtility.Greater(greater , smaller ) end
---@param value integer
---@return boolean
function CTextSourceUtility.GreaterThanZero(value ) end

return CTextSourceUtility
