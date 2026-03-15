---@meta rdgs.CIsland
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CIsland
---@field BoundingRect rdsdk.CRDRect		Returns the bounding rect of the map file which contains this island. This is usually bigger than the island itself and contains some water
---@field ActiveRect rdsdk.CRDRect		Returns the actual bounding box of the island which is covered by the ActiveGrid
---@field IslandLabel string		name of the island
---@field IsPirateIsland boolean		
---@field IsStarterIsland boolean		
---@field IsReservedForPlayer boolean		
---@field IslandFilename string		
local CIsland = {}
---@param self rdgs.CIsland
---@param worldX integer
---@param worldY integer
---@return boolean
function CIsland.ContainsPoint(self, worldX , worldY ) end
---@return boolean returns true if weak pointer holds a valid reference
function CIsland.isValid() end

return CIsland
