---@meta rdgs.VirtualSpaceMaintenance
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.VirtualSpaceMaintenance
local VirtualSpaceMaintenance = {}
Static.GetPopulationLevel = VirtualSpaceMaintenance
Static.GetWorkforce = VirtualSpaceMaintenance
Static.GetCosts = VirtualSpaceMaintenance
---@param assetGUID integer
---@return rdgs.CPopulationAsset
function VirtualSpaceMaintenance.GetPopulationLevel(assetGUID ) end
---@param assetGUID integer
---@return rdgs.CAsset
function VirtualSpaceMaintenance.GetWorkforce(assetGUID ) end
---only fills available data if current island is set (for buildings or buildmenu, but not usable in unit infotips)
---@param guid integer
---@return rdgs.CProductAsset[]|nil
function VirtualSpaceMaintenance.GetCosts(guid ) end

return VirtualSpaceMaintenance
