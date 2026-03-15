---@meta rdgs.VirtualSpaceProduct
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.VirtualSpaceProduct
local VirtualSpaceProduct = {}
Static.HasObtainHint = VirtualSpaceProduct
Static.GetObtainHint = VirtualSpaceProduct
---@param productGuid integer
---@return boolean
function VirtualSpaceProduct.HasObtainHint(productGuid ) end
---@param productGuid integer
---@return rdsdk.TextId
function VirtualSpaceProduct.GetObtainHint(productGuid ) end

return VirtualSpaceProduct
