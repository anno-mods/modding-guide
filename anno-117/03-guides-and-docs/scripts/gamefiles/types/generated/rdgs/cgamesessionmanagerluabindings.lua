---@meta rdgs.CGameSessionManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CGameSessionManager
---@field AreaFromContext rdgs.CConstructionArea		
---@field Current rdgs.CConstructionArea		
---@field CurrentSelectedArea rdgs.CConstructionArea		
---@field IsCurrentAreaValidIsland boolean		Returns false if the \'Current\' Textsource will return nothing which is the case when camera hovers over the ocean or deco islands
---@field SessionGUID integer		Current Session Data
---@field RegionGUID integer		Returns the guid of the currently selected region
local CGameSessionManager = {}
GameSession = CGameSessionManager
---@see CAreaLoader parent class
---@param self rdgs.CGameSessionManager
---@param id rdgs.AreaID
---@return rdgs.CConstructionArea
function CGameSessionManager.AreaFromID(self, id ) end
---@param self rdgs.CGameSessionManager
---@param id rdgs.AreaID
---@return rdgs.CConstructionArea
function CGameSessionManager.GetArea(self, id ) end
---@return boolean returns true if weak pointer holds a valid reference
function CGameSessionManager.isValid() end
---Cheat to enable all construction areas for the current player
---@param self rdgs.CGameSessionManager
function CGameSessionManager.EnableAllConstructionAreas(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CGameSessionManager.isValid() end

return CGameSessionManager
