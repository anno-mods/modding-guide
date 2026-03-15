---@meta rdgs.VirtualSpaceIncident
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.VirtualSpaceIncident
local VirtualSpaceIncident = {}
Static.StartIncident = VirtualSpaceIncident
Static.IsIncidentStillActive = VirtualSpaceIncident
Static.GetIncidentTypeName = VirtualSpaceIncident
Static.GetIncidentFluff = VirtualSpaceIncident
Static.GetAreasWithMajorIncidentsOfCategoryForCurrentPlayer = VirtualSpaceIncident
Static.GetIncidentCategory = VirtualSpaceIncident
Static.GetIncidentType = VirtualSpaceIncident
Static.ShortenIncidentSchedulerIntervalForMajorIncidents = VirtualSpaceIncident
---@param incidentGUID integer
function VirtualSpaceIncident.StartIncident(incidentGUID ) end
---@param area rdgs.AreaID
---@param incident rdgs.IncidentID
---@return boolean
function VirtualSpaceIncident.IsIncidentStillActive(area , incident ) end
---@param incidentGUID integer
---@return string
function VirtualSpaceIncident.GetIncidentTypeName(incidentGUID ) end
---@param incidentGUID integer
---@return string
function VirtualSpaceIncident.GetIncidentFluff(incidentGUID ) end
---@param category datasets.IncidentCategory
---@return rdgs.CConstructionArea[]
function VirtualSpaceIncident.GetAreasWithMajorIncidentsOfCategoryForCurrentPlayer(category ) end
---@param incidentGUID integer
---@return datasets.IncidentCategory
function VirtualSpaceIncident.GetIncidentCategory(incidentGUID ) end
---@param incidentGUID integer
---@return datasets.IncidentType
function VirtualSpaceIncident.GetIncidentType(incidentGUID ) end
---@param randomGUID integer
function VirtualSpaceIncident.ShortenIncidentSchedulerIntervalForMajorIncidents(randomGUID ) end

return VirtualSpaceIncident
