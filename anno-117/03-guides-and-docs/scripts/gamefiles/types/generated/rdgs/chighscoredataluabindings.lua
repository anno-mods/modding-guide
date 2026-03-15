---@meta rdgs.CHighscoreData
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CHighscoreData
---@field PopulationCategory integer		
---@field EconomicCategory integer		
---@field ProductionStorageCategory integer		
---@field FleetCategory integer		
---@field ItemCategory integer		
---@field DifficultyFactor number		
---@field ShipMaintenanceScore integer		
---@field TotalProductionScore integer		
---@field TotalStorageScore integer		
---@field SocketedItemsScore integer		
---@field DiscoveredItemsScore integer		
---@field MilitaryShipScore integer		
---@field TradeShipScore integer		
local CHighscoreData = {}
---Returns the total highscore, with or without the difficulty modifier
---@param self rdgs.CHighscoreData
---@param includeDifficultyModifier boolean
---@return integer
function CHighscoreData.GetHighscore(self, includeDifficultyModifier ) end
---@param self rdgs.CHighscoreData
---@param populationGuid integer
---@return integer
function CHighscoreData.GetPopulationScore(self, populationGuid ) end
---@param self rdgs.CHighscoreData
---@param sessionGuid integer
---@return integer
function CHighscoreData.GetSessionBalanceScore(self, sessionGuid ) end

return CHighscoreData
