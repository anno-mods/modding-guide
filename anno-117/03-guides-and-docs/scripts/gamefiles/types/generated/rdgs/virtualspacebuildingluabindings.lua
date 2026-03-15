---@meta rdgs.VirtualSpaceBuilding
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.VirtualSpaceBuilding
local VirtualSpaceBuilding = {}
Static.IsCoastalBuilding = VirtualSpaceBuilding
Static.IsWaterBuilding = VirtualSpaceBuilding
Static.IsAllowedInCurrentRegion = VirtualSpaceBuilding
Static.GetAllowedRegion = VirtualSpaceBuilding
Static.DoesRequireAccessToSea = VirtualSpaceBuilding
Static.DoesRequireVillaOnArea = VirtualSpaceBuilding
Static.GetNeededSlotType = VirtualSpaceBuilding
Static.GetTerrainType = VirtualSpaceBuilding
Static.IsMeshGraph = VirtualSpaceBuilding
Static.IsUnique = VirtualSpaceBuilding
Static.GetHideCount = VirtualSpaceBuilding
Static.GetEffectsFromBuilding = VirtualSpaceBuilding
---Returns true, if this building has to be placed at the coast
---@param guid integer
---@return boolean
function VirtualSpaceBuilding.IsCoastalBuilding(guid ) end
---Returns true if the building can be placed anywhere within the harbor water area.
---@param guid integer
---@return boolean
function VirtualSpaceBuilding.IsWaterBuilding(guid ) end
---returns true if the user is allowed to build the given building in the region of the active session
---@param guid integer
---@return boolean
function VirtualSpaceBuilding.IsAllowedInCurrentRegion(guid ) end
---Returns the hint text in which region this building is constructable
---@param guid integer
---@return rdgs.CAsset
function VirtualSpaceBuilding.GetAllowedRegion(guid ) end
---Returns true if the Building does need access to the sea so a ship can travel to the building
---@param guid integer
---@return boolean
function VirtualSpaceBuilding.DoesRequireAccessToSea(guid ) end
---Returns true if the Building does need a villa on the island to be placed
---@param guid integer
---@return boolean
function VirtualSpaceBuilding.DoesRequireVillaOnArea(guid ) end
---returns slot type to which the given building guid needs to snap to
---@param guid integer
---@return integer
function VirtualSpaceBuilding.GetNeededSlotType(guid ) end
---returns terrain type of the given building guid
---@param guid integer
---@return integer
function VirtualSpaceBuilding.GetTerrainType(guid ) end
---checks if given guid is a meshgraph asset
---@param guid integer
---@return boolean
function VirtualSpaceBuilding.IsMeshGraph(guid ) end
---checks if unique data is available
---@param guid integer
---@return boolean
function VirtualSpaceBuilding.IsUnique(guid ) end
---checks if building should show count in build menu infotip
---@param guid integer
---@return boolean
function VirtualSpaceBuilding.GetHideCount(guid ) end
---@param guid integer
---@param includePublicServiceEffects boolean
---@return rdgs.CTextSourceListValue[]
function VirtualSpaceBuilding.GetEffectsFromBuilding(guid , includePublicServiceEffects ) end

return VirtualSpaceBuilding
