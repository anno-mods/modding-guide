---@meta rdgs.CPopulationManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CPopulationManager
---@field GlobalPopulationCount number		
---@field GlobalPopulationLevels rdgs.CAsset[]|nil		
local CPopulationManager = {}
Population = CPopulationManager
---@param self rdgs.CPopulationManager
---@param populationLevelGUID integer
---@return number
function CPopulationManager.GetGlobalPopulationCount(self, populationLevelGUID ) end
---Participant scope has to be set. Returns 0 for invalid populationLevelGUID
---@param self rdgs.CPopulationManager
---@param populationLevelGUID integer
---@return number
function CPopulationManager.GetMaxReachedGlobalPopulationCount(self, populationLevelGUID ) end
---@return boolean returns true if weak pointer holds a valid reference
function CPopulationManager.isValid() end

return CPopulationManager
