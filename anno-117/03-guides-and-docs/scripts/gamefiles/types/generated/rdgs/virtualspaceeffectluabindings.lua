---@meta rdgs.VirtualSpaceEffect
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.VirtualSpaceEffect
local VirtualSpaceEffect = {}
Static.InvalidEffectID = VirtualSpaceEffect
Static.GetBuffsFromEffect = VirtualSpaceEffect
Static.GetSourceCategoryFromEffect = VirtualSpaceEffect
Static.IsBuffResidentNeed = VirtualSpaceEffect
Static.GetScope = VirtualSpaceEffect
---@param effectGUID integer
---@return rdgs.CTextSourceListValue[]
function VirtualSpaceEffect.GetBuffsFromEffect(effectGUID ) end
---@param effectGUID integer
---@return datasets.BuffCategory
function VirtualSpaceEffect.GetSourceCategoryFromEffect(effectGUID ) end
---@param buffGUID integer
---@return boolean
function VirtualSpaceEffect.IsBuffResidentNeed(buffGUID ) end
---@param effectGUID integer
---@return datasets.Scope
function VirtualSpaceEffect.GetScope(effectGUID ) end

return VirtualSpaceEffect
