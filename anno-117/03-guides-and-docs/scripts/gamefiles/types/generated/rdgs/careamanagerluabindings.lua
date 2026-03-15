---@meta rdgs.CAreaManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CAreaManager
---@field AreaObjects rdgs.CAreaObjectManager		
---@field AreaPopulation rdgs.CAreaPopulationManager		
---@field AreaMoney rdgs.CAreaMoneyManager		
---@field Walls rdgs.CAreaWallManager		
---@field Aqueduct rdgs.CAreaAqueductManager		
---@field Street rdgs.CAreaStreetManager		
---@field AreaIncidents rdgs.CAreaIncidentManager		
---@field Takeover rdgs.CAreaTakeoverManager		
---@field ConstructionArea rdgs.CConstructionArea		
local CAreaManager = {}
AreaManager = CAreaManager
GetAreaManagerByIslandGUID = CAreaManager
GetAreaManagerByID = CAreaManager
---@param islandGUID integer
---@return rdgs.CAreaManager
function CAreaManager.GetAreaManagerByIslandGUID(islandGUID ) end
---@param areaID rdgs.AreaID
---@return rdgs.CAreaManager
function CAreaManager.GetAreaManagerByID(areaID ) end
---@return boolean returns true if weak pointer holds a valid reference
function CAreaManager.isValid() end

return CAreaManager
