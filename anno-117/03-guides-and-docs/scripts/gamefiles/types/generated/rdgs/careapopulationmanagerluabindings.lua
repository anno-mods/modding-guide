---@meta rdgs.CAreaPopulationManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CAreaPopulationManager
---@field PopulationCount number		
---@field PopulationLevels rdgs.CPopulationAsset[]		Returns the assets for all settled population levels on this island. Skips populations with 0 residents.
---@field CityStatus integer		returns the current city status shown. Including drop down prevention
---@field CityStatusName string		
---@field CityStatusIcon string		
---@field CityStatusLevel integer		
---@field AmountOfResidences integer		
---@field ProgressionTowardsNextCityStatus number		Returns the progression towards the next city city status based on the dominant population
---@field NextCityStatusPopulationThresholdForDominatingPopulation integer		Returns the population threshold of the dominant population for the next city status level
---@field PopulationAmountForDominatingPopulation number		Returns the population amount of the dominant population
---@field DominantPopulationOrPopulationGroup integer		Returns the guid of the dominant population or the population group if the total population is dominant
local CAreaPopulationManager = {}
AreaPopulation = CAreaPopulationManager
---@param self rdgs.CAreaPopulationManager
---@param populationLevelGUID integer
---@return number
function CAreaPopulationManager.GetPopulationCount(self, populationLevelGUID ) end
---@param self rdgs.CAreaPopulationManager
---@param increase boolean
function CAreaPopulationManager.CheatChangePopulation(self, increase ) end
---@param self rdgs.CAreaPopulationManager
---@param populationGUID integer
---@return number
function CAreaPopulationManager.GetSatisfaction(self, populationGUID ) end
---@param self rdgs.CAreaPopulationManager
---@param populationGUID integer
---@param productGUID rdgs.ProductGUID
---@return number
function CAreaPopulationManager.GetSatisfaction(self, populationGUID , productGUID ) end
---@return boolean returns true if weak pointer holds a valid reference
function CAreaPopulationManager.isValid() end

return CAreaPopulationManager
