---@meta rdgs.CIslandManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CIslandManager
---@field AllIslandIDs rdgs.IslandID[]		
local CIslandManager = {}
Island = CIslandManager
---@param self rdgs.CIslandManager
---@param islandID rdgs.IslandID
---@return rdgs.CIsland
function CIslandManager.GetIsland(self, islandID ) end
---@param self rdgs.CIslandManager
---@param x integer
---@param y integer
---@return rdgs.CIsland
function CIslandManager.GetIsland(self, x , y ) end
---@param self rdgs.CIslandManager
---@param x integer
---@param y integer
---@return rdgs.CIsland
function CIslandManager.GetNearestIsland(self, x , y ) end
---@param self rdgs.CIslandManager
---@param label string
---@return rdgs.CIsland
function CIslandManager.GetIslandByLabel(self, label ) end
---@return boolean returns true if weak pointer holds a valid reference
function CIslandManager.isValid() end

return CIslandManager
