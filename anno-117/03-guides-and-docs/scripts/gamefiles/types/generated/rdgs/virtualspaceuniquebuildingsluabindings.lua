---@meta rdgs.VirtualSpaceUniqueBuildings
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.VirtualSpaceUniqueBuildings
local VirtualSpaceUniqueBuildings = {}
Static.IsUniqueBuilding = VirtualSpaceUniqueBuildings
Static.GetUniqueType = VirtualSpaceUniqueBuildings
Static.GetUniqueScope = VirtualSpaceUniqueBuildings
Static.GetDuplicateObjectText = VirtualSpaceUniqueBuildings
Static.IsUniquenessFulfilled = VirtualSpaceUniqueBuildings
Static.GetAllowedAmount = VirtualSpaceUniqueBuildings
Static.GetAllowedAmount = VirtualSpaceUniqueBuildings
Static.GetCurrentAmount = VirtualSpaceUniqueBuildings
Static.GetCurrentAmount = VirtualSpaceUniqueBuildings
Static.IsUniqueModuleParentMissing = VirtualSpaceUniqueBuildings
---@param guid integer
---@return boolean
function VirtualSpaceUniqueBuildings.IsUniqueBuilding(guid ) end
---@param guid integer
---@return datasets.UniqueType
function VirtualSpaceUniqueBuildings.GetUniqueType(guid ) end
---if a something has a unique type return its scope
---@param guid integer
---@return datasets.UniqueScope
function VirtualSpaceUniqueBuildings.GetUniqueScope(guid ) end
---returns the proper GUID for the Text to show when trying to build a unique building duplicate
---@param buildingGUID integer
---@param areaID rdgs.AreaID
---@param participantGUID rdgs.ParticipantGUID
---@return rdsdk.TextId
function VirtualSpaceUniqueBuildings.GetDuplicateObjectText(buildingGUID , areaID , participantGUID ) end
---checks if the unique requirements for this object are fulfilled. That means either the given object doesn\'t require uniqueness or it\'s uniquetype still has slots free on the area/session/world
---@param buildingGUID integer
---@param areaID rdgs.AreaID
---@return boolean
function VirtualSpaceUniqueBuildings.IsUniquenessFulfilled(buildingGUID , areaID ) end
---returns the max amount of buildings allowed in area, areaID is needed because the amount can be overridden
---@param buildingGUID integer
---@param areaID rdgs.AreaID
---@param participantGUID rdgs.ParticipantGUID
---@return integer
function VirtualSpaceUniqueBuildings.GetAllowedAmount(buildingGUID , areaID , participantGUID ) end
---returns the max amount of buildings allowed in area, areaID is needed because the amount can be overridden
---@param buildingGUID integer
---@param areaID rdgs.AreaID
---@return integer
function VirtualSpaceUniqueBuildings.GetAllowedAmount(buildingGUID , areaID ) end
---@param type datasets.UniqueType
---@param areaID rdgs.AreaID
---@param participantGUID rdgs.ParticipantGUID
---@return integer
function VirtualSpaceUniqueBuildings.GetCurrentAmount(type , areaID , participantGUID ) end
---@param type datasets.UniqueType
---@param areaID rdgs.AreaID
---@return integer
function VirtualSpaceUniqueBuildings.GetCurrentAmount(type , areaID ) end
---if a module is build from construction menu, this returns true if the main building is missing. Always returns false for non modules or modules that do not need a unique parent.
---@param moduleGUID integer
---@return boolean
function VirtualSpaceUniqueBuildings.IsUniqueModuleParentMissing(moduleGUID ) end

return VirtualSpaceUniqueBuildings
