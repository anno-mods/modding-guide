---@meta rdgs.CAreaLoader
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CAreaLoader
---@field AreaFromContext rdgs.CConstructionArea		
---@field Current rdgs.CConstructionArea		
---@field CurrentSelectedArea rdgs.CConstructionArea		
---@field IsCurrentAreaValidIsland boolean		Returns false if the \'Current\' Textsource will return nothing which is the case when camera hovers over the ocean or deco islands
local CAreaLoader = {}
Area = CAreaLoader
---@param self rdgs.CAreaLoader
---@param id rdgs.AreaID
---@return rdgs.CConstructionArea
function CAreaLoader.AreaFromID(self, id ) end
---@param self rdgs.CAreaLoader
---@param id rdgs.AreaID
---@return rdgs.CConstructionArea
function CAreaLoader.GetArea(self, id ) end
---@return boolean returns true if weak pointer holds a valid reference
function CAreaLoader.isValid() end

return CAreaLoader
