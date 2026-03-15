---@meta rdgs.CAreaStreetManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CAreaStreetManager
local CAreaStreetManager = {}
---@param self rdgs.CAreaStreetManager
---@param tile rdsdk.Tile
---@param touchingMeansIntersecting boolean
---@return boolean
function CAreaStreetManager.DoesTileIntersectEdge(self, tile , touchingMeansIntersecting ) end
---@param self rdgs.CAreaStreetManager
---@param position rdmath.Vector3|table|number[]
---@return boolean
function CAreaStreetManager.HasEdgeAt(self, position ) end
---@return boolean returns true if weak pointer holds a valid reference
function CAreaStreetManager.isValid() end

return CAreaStreetManager
